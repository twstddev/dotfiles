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

function fzf-trigger-completion-widget() {
  local trigger=${FZF_COMPLETION_TRIGGER-'**'}
  local original_buffer=$BUFFER
  local original_cursor=$CURSOR

  # With no command context, fzf-completion falls back to normal glob
  # expansion. Use fzf's path insertion widget instead.
  if [[ -z ${BUFFER//[[:space:]]/} ]]; then
    zle fzf-file-widget
    return
  fi

  # A bare command needs an argument separator for ** completion.
  if [[ $LBUFFER != *[[:space:]]* ]]; then
    LBUFFER+=' '
  fi

  LBUFFER+=$trigger
  local triggered_buffer=$BUFFER
  zle fzf-completion

  # fzf-completion leaves its synthetic trigger behind on cancellation.
  if [[ $BUFFER == $triggered_buffer ]]; then
    BUFFER=$original_buffer
    CURSOR=$original_cursor
  fi
}

function fzf-ripgrep-widget() {
  local reload='reload:rg --column --line-number --no-heading --color=always --hidden --glob "!.git" --smart-case -- {q} || :'

  zle -I
  fzf --disabled --ansi \
    --bind "change:$reload" \
    --bind "start:$reload" \
    --bind 'enter:become:nvim +{2} {1}' \
    --bind 'ctrl-o:execute:nvim +{2} {1}' \
    --delimiter : \
    --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
    --preview-window '+{2}/2,<80(up)'
    </dev/tty
  zle reset-prompt
}

zle -N fzf-trigger-completion-widget
zle -N fzf-ripgrep-widget

bindkey '^[c' fzf-trigger-completion-widget
bindkey '^T' fzf-ripgrep-widget
