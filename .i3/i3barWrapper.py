#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# This script is a simple wrapper which prefixes each i3status line with custom
# information. It is a python reimplementation of:
# http://code.stapelberg.de/git/i3status/tree/contrib/wrapper.pl
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.
#
# In its current version it will display the cpu frequency governor, but you
# are free to change it to display whatever you like, see the comment in the
# source code below.
#
# © 2012 Valentin Haenel <valentin.haenel@gmx.de>
#
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License (WTFPL), Version
# 2, as published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
# details.

import json
import subprocess
import sys
from typing import List

from jivago_streams import Stream

green = '#17de4c'
yellow = '#ffd212'
white = '#dbdfbc'


def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()


def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()


def get_window_names() -> List[str]:
    process = subprocess.Popen(f"wmctrl -l".split(" "),
                               stdin=subprocess.PIPE,
                               stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE)
    output, err = process.communicate()
    try:
        import socket
        hostname = socket.gethostname()
        lines = str(output.decode("utf-8")).split("\n")
        return Stream(lines) \
            .filter(lambda x: hostname in x) \
            .map(lambda x: x[x.index(hostname) + 1 + len(hostname)::]) \
            .toList()

    except Exception as e:
        return e


def fetch_prismarine_tab_name() -> str:
    try:
        return Stream(get_window_names()) \
            .firstMatch(lambda x: "Prismarine" in x and "Player" not in x) \
            .map(lambda x: x[:x.index(" - Prismarine")]) \
            .orElse("Not Playing")
    except Exception as e:
        return str(e)


def prismarine_status() -> dict:
    prismarine_tab_name = fetch_prismarine_tab_name()
    isPaused = "Paused" in prismarine_tab_name

    is_playing = "Not Playing" not in prismarine_tab_name

    if isPaused:
        prismarine_tab_name = prismarine_tab_name[:prismarine_tab_name.index(" - Paused")]

    colour_code = [
        (not is_playing, white),
        (isPaused, yellow),
        (True, green)  # case default
    ]

    return {
        'full_text': '%s' % prismarine_tab_name,
        'name': 'prismarine',
        'color': Stream(colour_code)
            .firstMatch(lambda b, _: b)
            .map(lambda x: x[1])
            .orElse("")
    }


if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        j.insert(0, prismarine_status())
        # and echo back new encoded json
        print_line(prefix + json.dumps(j))
