#!/bin/sh

# fzf passes the full listed rows in $1, including category dividers.
digit=${FZF_KEY:-}
case "$digit" in
    [0-9]) ;;
    *) exit 1 ;;
esac

# Keep digits literal within searches and in the directory finder, whose rows
# are paths rather than icon-prefixed session names.
if [ -n "${FZF_QUERY:-}" ] || [ "${FZF_PROMPT:-}" = '  ' ]; then
    printf 'put(%s)\n' "$digit"
    exit 0
fi

# Only jump to a running tmux session in the current source list. Count each
# name once in case sesh also lists it as a configured session.
tmux list-sessions -F '#{session_name}' 2>/dev/null |
awk -v digit="$digit" '
    FILENAME == "-" { running[$0] = 1; next }
    {
        name = $0
        gsub(/\033\[[0-9;]*m/, "", name)
        sub(/^[^ ]+ /, "", name)
        if (substr(name, 1, 1) == digit && (name in running) && !seen[name]++) {
            position = FNR
            count++
        }
    }
    END {
        if (count == 1)
            printf "pos(%d)+print(__sesh_digit__)+accept\n", position
        else
            printf "put(%s)\n", digit
    }
' - "$1"
