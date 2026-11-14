#!/bin/sh

# Keep the list and selection in the session that opened the popup.
session=$(tmux display-message -p '#{session_name}') || exit 1
windows=$(sesh window list --target "$session") || exit 1
[ -n "$windows" ] || exit 0
export SESH_WINDOW_SESSION="$session"

selection=$(
    printf '%s\n' "$windows" | sed 's/^/ /' | fzf \
        --sync --no-height --no-border --padding=1,2 --no-sort --no-multi --ansi \
        --prompt '  ' \
        --header '  enter select window · esc cancel' \
        --bind 'tab:down,btab:up' \
        --preview-window 'right:55%' \
        --preview 'entry={}; window=${entry#* }; tmux capture-pane -ep -t "=$SESH_WINDOW_SESSION:=$window"'
) || exit 0

[ -n "$selection" ] || exit 0
sesh window connect --target "$session" -- "${selection#* }"
