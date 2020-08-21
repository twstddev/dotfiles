# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=vim

####################
# PLUGINS
####################
source ~/.zinit/bin/zinit.zsh

# add commands to copy and paste to/from clipboard
zinit wait lucid for OMZL::clipboard.zsh

# add completion configuration from OMZ
zinit wait lucid for OMZL::completion.zsh

# Grep configuration from OMZ
zinit wait lucid for OMZL::grep.zsh

# Various settings from OMZ
zinit wait lucid for OMZL::functions.zsh
zinit wait lucid for OMZL::misc.zsh

# history settings from OMZ
zinit wait lucid for OMZL::history.zsh

# Completions for AWS CLI
zinit wait lucid for OMZP::aws

# Suggest pagckages for not found commands
zinit wait lucid for OMZP::command-not-found

# Enable colors in man pages
zinit wait lucid for OMZP::colored-man-pages

# Common aliases from OMZ
zinit wait lucid for OMZP::common-aliases

# some aliases from OMZ
zinit wait lucid for OMZL::directories.zsh

# docker completions from OMZ
zinit wait lucid for OMZP::docker/_docker
zinit wait lucid for OMZP::docker-compose

# git aliases
zinit wait lucid for OMZP::git

# terraform completions from OMZ
zinit wait lucid for OMZP::terraform

# better vi mode
zinit wait lucid for \
   atload"bindkey -M vicmd 'v' visual-mode" \
   OMZP::vi-mode

# npm completions from OMZ
zinit wait lucid for OMZP::npm

# remind about registered aliases when available
zinit wait lucid for djui/alias-tips

# file and direcgory colors for ls
zinit ice wait"0c" lucid reset \
    atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
            \${P}sed -i \
            '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
            \${P}dircolors -b LS_COLORS > c.zsh" \
    atpull'%atclone' pick"c.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# modern ls repalacement
zinit ice wait"2" lucid atload="alias ls=exa" from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa

# style the prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# fish-like syntax highlighting, completion and auto suggetsion
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start; bindkey '^e' autosuggest-accept" \
    zsh-users/zsh-autosuggestions

# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit

####################
# ZLE
####################
# use vim mode in zle
bindkey -v

####################
# HISTORY
####################
# history size of commands in memory
HISTSIZE=1000
# number of commands to save in history
SAVEHIST=1000
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

####################
# KEY BINDINGS
####################
bindkey '^R' history-incremental-search-backward

####################
# ALIASES
####################
alias ls="ls --color"
alias lah="ls -laFh"

####################
# LOCAL
####################
if [[ -a ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
