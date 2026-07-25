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
# export FZF_DEFAULT_OPTS="
#   --height 50% --layout=reverse --border --info inline --cycle --bind='ctrl-s:jump,alt-j:preview-down,alt-k:preview-up,ctrl-/:toggle-preview'
#   --preview-window=hidden
#   --color=fg:#cbccc6,hl:#707a8c
#   --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
#   --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
#   --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff
# "
# export FZF_CTRL_T_OPTS="--preview='batcat --color=always --style=numbers {}'"

# fzf-tab
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-pad 3

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${ZSH_THEME_MUTED}"

# zsh-vi-mode
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_VI_HIGHLIGHT_BACKGROUND=$ZSH_THEME_VISUAL_BACKGROUND
ZVM_VI_HIGHLIGHT_FOREGROUND=$ZSH_THEME_VISUAL_FOREGROUND
ZVM_VI_SURROUND_BINDKEY="s-prefix"

function zvm_gs_add_surround() {
  local keys=$(zvm_keys)
  local surround=${keys##*gsa}
  zvm_change_surround a "${surround//$ZVM_ESCAPE_SPACE/ }"
}

function zvm_gs_delete_surround() {
  local keys=$(zvm_keys)
  local surround=${keys##*gsd}
  zvm_change_surround d "${surround//$ZVM_ESCAPE_SPACE/ }"
}

function zvm_gs_replace_surround() {
  local keys=$(zvm_keys)
  local surround=${keys##*gsr}
  zvm_change_surround r "${surround//$ZVM_ESCAPE_SPACE/ }"
}

if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

function vi_mode_init() {
  if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  fi
}

zvm_after_init_commands+=(vi_mode_init)

function zvm_after_lazy_keybindings() {
  zle -N zvm_gs_add_surround
  zle -N zvm_gs_delete_surround
  zle -N zvm_gs_replace_surround

  local surround
  for surround in ${(s..)^:-'()[]{}<>'} \' \" \` ' '; do
    zvm_bindkey visual "gsa${surround}" zvm_gs_add_surround
    zvm_bindkey vicmd "gsd${surround}" zvm_gs_delete_surround
    zvm_bindkey vicmd "gsr${surround}" zvm_gs_replace_surround
  done

  bindkey -M vicmd 's' zce
  bindkey -M vicmd 'S' zce
}

# zce.zsh
zstyle ':zce:*' search-case smartcase
zstyle ':zce:*' fg "$ZSH_THEME_MOTION_LABEL_STYLE"
zstyle ':zce:*' bg "$ZSH_THEME_MOTION_DIM_STYLE"
