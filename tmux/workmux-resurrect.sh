#!/bin/sh

# Save exact Workmux conversation IDs into tmux-resurrect's existing snapshot.
# Server, pane PID and foreground command must still match the registration.
set -eu

snapshot=${1:?Usage: workmux-resurrect.sh SNAPSHOT}
temporary=$(mktemp "${snapshot}.workmux.XXXXXX")
trap 'rm -f "$temporary"' EXIT
trap 'exit 1' HUP INT TERM
cp -p "$snapshot" "$temporary"

socket=$(tmux display-message -p '#{socket_path}')
boot=$(tmux display-message -p '#{start_time}:#{pid}')
tab=$(printf '\t')
panes=$(tmux list-panes -a -F "#{session_name}${tab}#{window_index}${tab}#{pane_index}${tab}#{pane_id}${tab}#{pane_pid}${tab}#{pane_current_command}")
state_dir=${XDG_STATE_HOME:-$HOME/.local/state}/workmux/agents

{
    for file in "$state_dir"/*.json; do
        [ -f "$file" ] || continue
        jq -c . "$file" || :
    done
} | jq -sr --arg socket "$socket" --arg boot "$boot" --arg panes "$panes" '
    group_by(.pane_key)[] | select(length == 1) | .[0] as $state |
    select($state.pane_key.backend == "tmux" and $state.pane_key.instance == $socket and $state.boot_id == $boot) |
    $panes | split("\n")[] | split("\t") as $pane |
    select($state.pane_key.pane_id == $pane[3] and ($state.pane_pid | tostring) == $pane[4]) |
    select($state.agent_kind == $pane[5] and $state.command == $pane[5]) |
    select($state.agent_session_id | type == "string") |
    select($state.agent_session_id | test("^[A-Za-z0-9_][A-Za-z0-9_-]*\\z")) |
    (if $pane[5] == "claude" then "claude --resume " elif $pane[5] == "codex" then "codex resume " else empty end) as $command |
    [$pane[0], $pane[1], $pane[2], $pane[5], ($command + $state.agent_session_id)] | @tsv
' | awk -F '\t' '
    BEGIN { OFS = "\t" }
    FILENAME == "-" { resume[$1, $2, $3, $4] = $5; next }
    $1 == "pane" && NF != 11 { print "Unsupported resurrect pane format" > "/dev/stderr"; exit 1 }
    $1 == "pane" && ($10 == "claude" || $10 == "codex") {
        command = resume[$2, $3, $6, $10]
        if (command == "") print "Workmux: " $2 ":" $3 "." $6 " has no verified conversation; restoring a shell" > "/dev/stderr"
        $11 = ":" command
    }
    { print }
' - "$snapshot" > "$temporary"
mv -f "$temporary" "$snapshot"
