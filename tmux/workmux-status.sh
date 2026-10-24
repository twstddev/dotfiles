#!/bin/sh

# Called by tmux's status job. Query every repository in this tmux server,
# including agents in the detached popup sessions.
working_fg=${1:-cyan}
waiting_fg=${2:-black}
waiting_bg=${3:-red}
done_fg=${4:-green}

query_status() {
    if command -v workmux >/dev/null 2>&1; then
        workmux status --all --json
    else
        "$HOME/.local/bin/mise" exec -- workmux status --all --json
    fi
}

# An unavailable observation must not look like zero agents or retain old counts.
if ! observation=$(query_status 2>/dev/null) ||
   ! pane_markers=$(tmux list-panes -a -F '#{pane_id} #{?@workmux_pane_status,1,0}' 2>/dev/null) ||
   ! counts=$(printf '%s\n' "$observation" | jq -er --arg markers "$pane_markers" '
       # Workmux keeps lifecycle status in JSON after acknowledging its icon.
       # Only waiting/done panes with an uncleared per-pane marker need attention.
       ($markers | split("\n") | map(split(" ") | select(.[1] == "1") | .[0])) as $pending |
       .agents | select(type == "array") |
       map(select(.status == "working" or (.pane_id as $id | $pending | index($id)))) |
       map(.status) as $statuses |
       ["working", "waiting", "done"] |
       map(. as $status | [$statuses[] | select(. == $status)] | length) |
       @tsv
   ' 2>/dev/null); then
    printf '#[fg=%s]󱙺 ?#[default]\n' "$working_fg"
    exit 0
fi

IFS="$(printf '\t')" read -r working waiting done <<EOF
$counts
EOF

status=
if [ "$working" -gt 0 ]; then
    status="#[fg=$working_fg]󱙺 $working#[default]"
fi
if [ "$waiting" -gt 0 ]; then
    status="${status:+$status  }#[fg=$waiting_bg,bold]#[fg=$waiting_fg,bg=$waiting_bg,bold]󱙺 $waiting#[fg=$waiting_bg,bg=default,nobold]#[default]"
fi
if [ "$done" -gt 0 ]; then
    status="${status:+$status  }#[fg=$done_fg]󱜚 $done#[default]"
fi
printf '%s\n' "$status"
