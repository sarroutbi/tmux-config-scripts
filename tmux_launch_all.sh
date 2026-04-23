#!/bin/bash
#
# Copyright (c) 2026, Sergio Arroutbi Braojos <sarroutbi (at) redhat.com>
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

REAL_TMUX=$(command -v tmux)
TMUXES_DIR="${HOME}/tmuxes"

# Create a temporary tmux wrapper that makes "attach" a no-op,
# allowing each session script to create its session without blocking
WRAPPER_DIR=$(mktemp -d)
trap 'rm -rf "${WRAPPER_DIR}"' EXIT

cat > "${WRAPPER_DIR}/tmux" << WRAPPER
#!/bin/sh
case "\$1" in
    attach|attach-session)
        exit 0
        ;;
esac
exec "${REAL_TMUX}" "\$@"
WRAPPER
chmod +x "${WRAPPER_DIR}/tmux"

export PATH="${WRAPPER_DIR}:${PATH}"

shopt -s expand_aliases
# shellcheck source=/dev/null
source "${TMUXES_DIR}/alias.sh"

echo "Creating tmux sessions..."

echo "  [0] GENERIC"
tmux_gen

echo "  [1] KEYLIME_WEBTOOL"
tmux_keylime_webtool

echo "  [2] KEYLIME"
tmux_keylime

echo "  [3] KEYLIME_MCP"
tmux_keylime_mcp

echo "  [4] NBDE_TANG_SERVER"
tmux_nbde

echo "  [5] CLEVIS"
tmux_clevis

echo "  [6] CLEVIS_TPM2"
tmux_clevis_tpm2

echo "  [7] URJC"
tmux_urjc

echo "  [8] INVEST"
tmux_invest

echo "  [9] PARFUMDB"
tmux_parfumdb

echo "All sessions created. Attaching to GENERIC..."
"${REAL_TMUX}" attach -t GENERIC
