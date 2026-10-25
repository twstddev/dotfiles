#!/bin/sh

set -eu

pane=${1:?Usage: scrollback.sh pane-id}
snapshot=$(mktemp "${TMPDIR:-/tmp}/tmux-scrollback.XXXXXX")
trap 'rm -f "$snapshot"' EXIT
trap 'exit 130' INT
trap 'exit 143' HUP TERM

# Preserve terminal colours and capture all history still held by tmux.
tmux capture-pane -p -e -J -S - -t "$pane" > "$snapshot"

nvim -n -i NONE \
    -c 'setlocal scrollback=100000' \
    -c 'call nvim_open_term(0, {})' \
    -c 'setlocal readonly nomodifiable bufhidden=wipe noswapfile' \
    -c 'nnoremap <buffer> q <Cmd>quit<CR>' \
    -c 'for key in ["i", "I", "a", "A", "o", "O"] | execute "nnoremap <buffer> " . key . " <Nop>" | endfor' \
    -c 'tnoremap <buffer> <Esc> <C-\><C-n>' \
    -c 'call timer_start(0, {-> execute("stopinsert | normal! G")})' \
    "$snapshot"
