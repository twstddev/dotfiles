ZIM_HOME=~/.zim

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

source ${ZIM_HOME}/init.zsh

export EDITOR=nvim

####################
# ZLE
####################
# use vim mode in zle
bindkey -v

####################
# HISTORY
####################
# history size of commands in memory
HISTSIZE=10000
# number of commands to save in history
SAVEHIST=10000
# command history file
HISTFILE=~/.history
# append new commands to the ned of history file and make them available between all opened shells
setopt sharehistory
# don't store adjacent command duplicates
setopt histignoredups
setopt histsavenodups
setopt histfindnodups
# remove unnecessary blank symbols from commands
setopt histreduceblanks
# don't beep if there is nowhere to go in history
setopt nohistbeep

####################
# OTHER
####################
# disable annoying beeping sound
setopt nobeep
# navigate to a directory without need for cd
setopt autocd
# try to correct spelling mistakes
setopt correct
# match files names with . without need for specifying the dot
setopt globdots

####################
# KEY BINDINGS
####################
# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

bindkey '^e' autosuggest-accept

####################
# ALIASES
####################
alias l="eza"
alias ls="l -lhb --git"
alias la="ls -a"
alias bat="batcat"

####################
# FZF
####################
export FZF_DEFAULT_OPTS="
  --height 50% --layout=reverse --border --info inline --cycle --bind='ctrl-s:jump,alt-j:preview-down,alt-k:preview-up,ctrl-/:toggle-preview'
  --preview-window=hidden
  --color=fg:#cbccc6,hl:#707a8c
  --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
  --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
  --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff
"
export FZF_CTRL_T_OPTS="--preview='batcat --color=always --style=numbers {}'"


if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' format '-- %d --'
zstyle ':fzf-tab:*' switch-group '<' '>'

####################
# LOCAL
####################
if [[ -a ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
