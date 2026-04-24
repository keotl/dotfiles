"""
mitmproxy addon: allow/block-list filter for agent sandboxes.

Env vars:
    MITM_MODE   allowlist | blocklist | dryrun | disabled  (default: disabled)
    MITM_LIST   path to pattern file (default: /addons/allowlist.txt)

Pattern file: one host per line, '#' for comments, blank lines ignored.
    api.anthropic.com        # exact host match
    *.github.com             # subdomain wildcard (matches github.com too)

Behaviour:
    allowlist  default-deny; non-matching hosts get a 403.
    blocklist  default-allow; matching hosts get a 403.
    dryrun     never blocks, but logs would-be-blocked requests so you can
               seed an allowlist from a real session.
    disabled   no-op.

The pattern file is re-read when its mtime changes, so edits take effect
without restarting mitmproxy.
"""

import logging
import os
from pathlib import Path

from mitmproxy import http

MODE = os.environ.get("MITM_MODE", "disabled").lower()
LIST_PATH = Path(os.environ.get("MITM_LIST", "/addons/allowlist.txt"))

logger = logging.getLogger(__name__)

_patterns: list[str] = []
_mtime: float = 0.0


def _load_patterns() -> None:
    global _patterns, _mtime
    if not LIST_PATH.is_file():
        if _patterns:
            logger.warning("filter: pattern file %s disappeared", LIST_PATH)
        _patterns, _mtime = [], 0.0
        return
    mtime = LIST_PATH.stat().st_mtime
    if mtime == _mtime:
        return
    patterns: list[str] = []
    for raw in LIST_PATH.read_text().splitlines():
        line = raw.split("#", 1)[0].strip().lower()
        if line:
            patterns.append(line)
    _patterns, _mtime = patterns, mtime
    logger.info("filter: loaded %d pattern(s) from %s", len(patterns), LIST_PATH)


def _host_matches(host: str) -> bool:
    host = host.lower()
    for p in _patterns:
        if p.startswith("*."):
            base = p[2:]
            if host == base or host.endswith("." + base):
                return True
        elif host == p:
            return True
    return False


def _should_block(host: str) -> tuple[bool, str]:
    _load_patterns()
    hit = _host_matches(host)
    if MODE == "allowlist":
        return (not hit, "not in allowlist" if not hit else "allowed")
    if MODE == "blocklist":
        return (hit, "in blocklist" if hit else "not in blocklist")
    if MODE == "dryrun":
        return (False, "dryrun:would-block" if not hit else "dryrun:would-allow")
    return (False, "disabled")


def _deny(flow: http.HTTPFlow) -> None:
    flow.response = http.Response.make(
        403,
        b"Blocked by mitmproxy policy\n",
        {"Content-Type": "text/plain"},
    )


def load(loader) -> None:
    logger.info("filter: mode=%s list=%s", MODE, LIST_PATH)
    _load_patterns()


def http_connect(flow: http.HTTPFlow) -> None:
    host = flow.request.pretty_host
    block, reason = _should_block(host)
    if block:
        logger.warning("filter: BLOCK CONNECT %s (%s)", host, reason)
        _deny(flow)


def request(flow: http.HTTPFlow) -> None:
    host = flow.request.pretty_host
    block, reason = _should_block(host)
    if block:
        logger.warning(
            "filter: BLOCK %s %s%s (%s)",
            flow.request.method, host, flow.request.path, reason,
        )
        _deny(flow)
    elif MODE == "dryrun" and reason == "dryrun:would-block":
        logger.info(
            "filter: DRYRUN would-block %s %s%s",
            flow.request.method, host, flow.request.path,
        )
