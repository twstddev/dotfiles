#!/bin/sh

# Render a #rrggbb tmux theme colour as a bold truecolour ANSI escape.
ansi_colour() {
    hex=${1#\#}
    if [ ${#hex} -ne 6 ]; then
        printf '\033[1;33m'
        return
    fi
    middle=${hex#??}
    printf '\033[1;38;2;%d;%d;%dm' "0x${hex%????}" "0x${middle%??}" "0x${hex#????}"
}

# Keep the list and selection in the session that opened the popup.
session=$(tmux display-message -p '#{session_name}') || exit 1
windows=$(sesh window list --target "$session") || exit 1
[ -n "$windows" ] || exit 0
export SESH_WINDOW_SESSION="$session"

highlight=$(ansi_colour "$(tmux show -gv @theme_window_active 2>/dev/null)")
reset=$(printf '\033[0m')

# sesh lists windows in index order, so the active window's row matches tmux's.
row=$(tmux list-windows -t "=$session:" -F '#{window_active}' | awk '$1 == 1 { print NR; exit }')

# Highlight the current window; colour codes are stripped from fzf's output.
list=$(
    printf '%s\n' "$windows" | awk -v row="${row:-0}" -v hl="$highlight" -v reset="$reset" -v glyph="$(printf '\357\213\220')" '
        NR == row { print hl glyph " " $0 reset; next }
        { print glyph " " $0 }
    '
)

selection=$(
    printf '%s\n' "$list" | fzf \
        --sync --no-height --no-border --padding=1,2 --no-sort --no-multi --ansi \
        --prompt '  ' \
        --header '  enter select window · esc cancel' \
        --bind "start:pos(${row:-1})" \
        --bind 'tab:down,btab:up' \
        --preview-window 'right:55%' \
        --preview 'entry={}; window=${entry#* }; tmux capture-pane -ep -t "=$SESH_WINDOW_SESSION:=$window"'
) || exit 0

[ -n "$selection" ] || exit 0
sesh window connect --target "$session" -- "${selection#* }"
