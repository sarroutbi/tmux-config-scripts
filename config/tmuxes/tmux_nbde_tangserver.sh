#!/bin/sh
#
# Copyright (c) 2024, Sergio Arroutbi Braojos <sarroutbi (at) redhat.com>
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

cd "${1}" 2>/dev/null || {
	echo
	echo "Directory not found"
	echo
	exit 1
}
tmux new -s "${2}" -d
tmux source-file ~/tmuxes/tmux.common.conf
tmux rename-window 'compilation'
tmux new-window -t "${2}":1 -n 'edit'
tmux new-window -t "${2}":2 -n 'compile'
tmux new-window -t "${2}":3 -n '1mt00'
tmux new-window -t "${2}":4 -n '1mt01'
tmux new-window -t "${2}":5 -n 'tests'
tmux new-window -t "${2}":6 -n 'docker'
tmux new-window -t "${2}":7 -n 'minikube'
tmux new-window -t "${2}":8 -n 'DOC'
tmux new-window -t "${2}":9 -n 'misc'
tmux attach -t "${2}" 