export EDITOR=nvim

# ZLE
# Use vim mode in ZLE.
bindkey -v

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history

# Append commands to the history file and share them between open shells.
setopt sharehistory
# Avoid storing or showing duplicate history entries.
setopt histignoredups
setopt histsavenodups
setopt histfindnodups
# Remove unnecessary whitespace from commands.
setopt histreduceblanks
# Do not beep when there is nowhere to go in history.
setopt nohistbeep

# General shell behaviour
setopt nobeep
setopt autocd
setopt correct
setopt globdots

# FZF
export FZF_DEFAULT_OPTS="
  --height 50% --layout=reverse --border --info inline --cycle --bind='ctrl-s:jump,alt-j:preview-down,alt-k:preview-up,ctrl-/:toggle-preview'
  --preview-window=hidden
  --color=fg:#cbccc6,hl:#707a8c
  --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
  --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
  --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff
"
export FZF_CTRL_T_OPTS="--preview='batcat --color=always --style=numbers {}'"

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' format '-- %d --'
zstyle ':fzf-tab:*' switch-group '<' '>'

# zsh-vi-mode
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VI_HIGHLIGHT_BACKGROUND=216
ZVM_VI_HIGHLIGHT_FOREGROUND=0

function vi_mode_init() {
  if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  fi
}

zvm_after_init_commands+=(vi_mode_init)

function zvm_after_lazy_keybindings() {
  bindkey -M vicmd 's' zce
  bindkey -M vicmd 'S' zce
}
