# Navigate history with Ctrl-P and Ctrl-N.
bindkey '^P' up-history
bindkey '^N' down-history

# Standard character and word deletion bindings.
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

bindkey '^[;' autosuggest-accept

bindkey -M vicmd 's' zce
bindkey -M vicmd 'S' zce
