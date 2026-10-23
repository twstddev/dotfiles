#!/bin/sh

# A popup attaches a client to a detached session, so hiding it leaves the
# terminal running. The owning window ID survives renames and renumbering.
is_popup_session() {
    case "$1" in
        __agent_popup_*) ;;
        *) return 1 ;;
    esac
    case "${1#__agent_popup_}" in
        ''|*[!0-9]*) return 1 ;;
        *) return 0 ;;
    esac
}

if [ "${1:-}" = --attach ]; then
    [ "$#" -eq 3 ] || exit 2
    session=$2
    socket=$3
    is_popup_session "$session" || exit 2
    popup_client=$(tty) || exit 1
    hook="session-closed[$$]"
    trap 'tmux -S "$socket" set-hook -gu "$hook" 2>/dev/null' 0
    trap 'exit 0' HUP INT TERM

    # Only this popup client should close when its session disappears. A main
    # client visiting the backing session must keep detach-on-destroy off.
    tmux -S "$socket" set-hook -g "$hook" \
        "if -F '#{==:#{hook_session_name},$session}' 'detach-client -t $popup_client'"
    env -u TMUX tmux -S "$socket" attach-session -t "=$session"
    exit
fi

if [ "${1:-}" = --cleanup ]; then
    [ "$#" -eq 1 ] || exit 2
    tmux list-sessions -F '#{session_name} #{@agent_popup_owner}' 2>/dev/null |
    while read -r session owner; do
        is_popup_session "$session" || continue
        [ "$owner" = "@${session#__agent_popup_}" ] || continue
        if ! tmux list-windows -a -F '#{window_id}' | grep -Fxq -- "$owner"; then
            tmux kill-session -t "=$session" 2>/dev/null
        fi
    done
    exit 0
fi

[ "$#" -eq 3 ] || exit 2
owner=$1
directory=$2
client=$3
session="__agent_popup_${owner#@}"
is_popup_session "$session" && [ "$owner" = "@${session#__agent_popup_}" ] || exit 2

if ! tmux has-session -t "=$session" 2>/dev/null; then
    # tmux expands formats (including command jobs) in -c and popup -d. Let
    # the tmux command client report its cwd instead of parsing a path as code.
    (cd -- "$directory" && tmux new-session -d -s "$session") || exit 1
    tmux set-option -t "=$session:" @agent_popup_owner "$owner"
    tmux set-option -t "=$session:" status off
fi
# Also remove the old override when reopening an existing popup session.
tmux set-option -u -t "=$session:" detach-on-destroy

# A close racing with the first keypress must not leave an orphan session.
if ! tmux list-windows -a -F '#{window_id}' | grep -Fxq -- "$owner"; then
    tmux kill-session -t "=$session"
    exit 0
fi

socket=$(tmux display-message -p '#{socket_path}') || exit 1
exec tmux display-popup -c "$client" -E -w 80% -h 80% \
    /bin/sh "$HOME/.config/tmux/agent-popup.sh" --attach "$session" "$socket"
