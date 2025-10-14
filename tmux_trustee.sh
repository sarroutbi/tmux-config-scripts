#!/bin/sh
#
# Copyright (c) 2025, Sergio Arroutbi Braojos <sarroutbi (at) redhat.com>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
DEFAULT_SESSION_NAME="TRUSTEE"
SESSION_NAME="${DEFAULT_SESSION_NAME}"
cd "${1}" 2>/dev/null || {
	echo
	echo "Directory not found"
	echo
	exit 1
}
test -z "${2}" 2>/dev/null || {
	SESSION_NAME="${2}"
}
tmux new -s "${SESSION_NAME}" -d
tmux source-file ~/tmuxes/tmux.common.conf
tmux rename-window 'claude'
tmux new-window -t "${2}":1 -n 'compile'
tmux new-window -t "${2}":2 -n 'console'
tmux new-window -t "${2}":3 -n 'edit'
tmux new-window -t "${2}":4 -n 'kbs'
tmux new-window -t "${2}":5 -n 'rvps'
tmux new-window -t "${2}":6 -n 'DOC'
tmux new-window -t "${2}":7 -n 'tests'
tmux new-window -t "${2}":8 -n 'tmt'
tmux new-window -t "${2}":9 -n 'misc'
tmux attach -t "${2}"
