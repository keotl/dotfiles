"""
mitmproxy addon: stream Server-Sent Events responses instead of buffering them.

By default mitmproxy holds back response headers until the whole body has
arrived. For LLM streaming endpoints (text/event-stream) with a long
prompt-processing phase, that means the client never sees the `200` + headers
and eventually fails with a connection error when an idle timeout fires.

Marking the response as streamed in `responseheaders` forwards the headers
immediately and passes body chunks through as they arrive.

Note: `stream_large_bodies` alone is not enough, because for chunked responses
mitmproxy only decides to stream once body bytes arrive. Also make sure
`tcp_timeout` exceeds the longest silent phase (see podman-compose.yml).

To still see streamed bodies in mitmweb, add `--set store_streamed_bodies=true`.
"""

from mitmproxy import http


def responseheaders(flow: http.HTTPFlow) -> None:
    if "text/event-stream" in flow.response.headers.get("content-type", ""):
        flow.response.stream = True
