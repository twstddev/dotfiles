#!/bin/sh

# Generate native bindings once at config load; saving and jumping need no shell.
# Session IDs stay valid across renames and are never reused within a server.
{
    for mark in a b c d e f g h i j k l m n o p q r s t u v w x y z \
                A B C D E F G H I J K L M N O P Q R S T U V W X Y Z \
                0 1 2 3 4 5 6 7 8 9; do
        cat <<EOF
bind-key -T session-mark $mark set-option -gF @session-mark-$mark '#{session_id}' \; display-message 'Session #S marked as $mark'
bind-key -T session-jump $mark if-shell -F '#{!=:#{@session-mark-$mark},}' { run-shell -C "switch-client -t '#{@session-mark-$mark}'" } { display-message 'No session marked as $mark' }
EOF
    done

    cat <<'EOF'
bind-key -T session-mark Escape display-message 'Session mark cancelled'
bind-key -T session-jump Escape display-message 'Session jump cancelled'
bind-key -T session-mark Any display-message 'Session marks use letters and digits'
bind-key -T session-jump Any display-message 'Session marks use letters and digits'
EOF
} | tmux source-file -
