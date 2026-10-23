#!/bin/sh

# Match the session glyph in tmux's status line while retaining sesh's colours.
SESH_ICON_FILTER='s/^\([^ ]*\)/\1/'
SESH_SEPARATOR='────────────────────────'
SESH_PICKER_SCRIPT="$HOME/.config/tmux/sesh-picker.sh"
export SESH_ICON_FILTER SESH_SEPARATOR SESH_PICKER_SCRIPT

# Reuse the same list formatting for the initial list and source reloads.
if [ "${1:-}" = --list ]; then
    shift
    sesh list --icons "$@" | sed "$SESH_ICON_FILTER" | awk -v separator="$SESH_SEPARATOR" '
        {
            if (NR > 1 && $1 != previous_icon)
                printf "\033[90m%s\033[0m\n", separator
            previous_icon = $1
            print
        }
    '
    exit
fi

if [ "${1:-}" = --delete ]; then
    [ -n "$2" ] && [ "$2" != "$SESH_SEPARATOR" ] || exit 0
    exec tmux kill-session -t "=${2#* }"
fi

# Keep the digit bindings together; fzf supplies the current key and query to
# the helper, along with the full list so divider rows retain their positions.
set --
for digit in 0 1 2 3 4 5 6 7 8 9; do
    set -- "$@" --bind "$digit:transform:sh ~/.config/tmux/sesh-digit.sh {*f}"
done

selection=$(
    sh "$SESH_PICKER_SCRIPT" --list | fzf \
        --sync --no-height --no-border --padding=1,2 --no-sort --ansi --prompt '  ' \
        --header '  0–9 jump (empty query) · ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
        --bind 'tab:down,btab:up' \
        --bind 'alt-o:abort' \
        --bind 'focus:transform:if [ -z "$FZF_QUERY" ] && [ {} = "$SESH_SEPARATOR" ]; then case "$FZF_ACTION" in *up*|last) echo up ;; *) echo down ;; esac; fi' \
        --bind 'enter:transform:if [ {} != "$SESH_SEPARATOR" ]; then echo accept; fi' \
        --bind 'double-click:transform:if [ {} != "$SESH_SEPARATOR" ]; then echo accept; fi' \
        "$@" \
        --bind 'ctrl-a:change-prompt(  )+reload(sh "$SESH_PICKER_SCRIPT" --list)' \
        --bind 'ctrl-t:change-prompt(  )+reload(sh "$SESH_PICKER_SCRIPT" --list -t)' \
        --bind 'ctrl-g:change-prompt(  )+reload(sh "$SESH_PICKER_SCRIPT" --list -c)' \
        --bind 'ctrl-x:change-prompt(  )+reload(sh "$SESH_PICKER_SCRIPT" --list -z)' \
        --bind 'ctrl-f:change-prompt(  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
        --bind 'ctrl-d:execute(sh "$SESH_PICKER_SCRIPT" --delete {})+change-prompt(  )+reload(sh "$SESH_PICKER_SCRIPT" --list)' \
        --preview-window 'right:55%' \
        --preview 'entry={}; [ "$entry" = "$SESH_SEPARATOR" ] && exit 0; case "$entry" in " "*) entry=${entry#* };; esac; sesh preview "$entry"'
) || exit 0

[ -n "$selection" ] || exit 0
[ "$selection" != "$SESH_SEPARATOR" ] || exit 0

# Digit shortcuts emit a marker line before the selected icon-prefixed row.
digit_prefix='__sesh_digit__
'
case "$selection" in
    "$digit_prefix"*)
        selection=${selection#"$digit_prefix"}
        session=${selection#* }
        exec tmux switch-client -t "=$session"
esac

# Sesh does not recognise the replacement glyph, so pass its raw session name.
case "$selection" in
    ' '*) selection=${selection#* } ;;
esac
sesh connect "$selection"
