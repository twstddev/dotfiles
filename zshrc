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
zinit snippet OMZP::common-aliases

# some aliases from OMZ
zinit snippet OMZL::directories.zsh

# docker completions from OMZ
zinit wait lucid for OMZP::docker/_docker
zinit wait lucid for OMZP::docker-compose

# git aliases
zinit wait lucid for OMZP::git

# terraform completions from OMZ
zinit wait lucid for OMZP::terraform

# npm completions from OMZ
zinit wait lucid for OMZP::npm

# fd completions from OMZ
zinit wait lucid as"completion" for OMZP::fd/_fd

# ripgrep completions from OMZ
zinit wait lucid as"completion" for OMZP::ripgrep/_ripgrep

# httpie completions from OMZ
zinit wait lucid as"completion" for OMZP::httpie

# git extras completions from OMZ
zinit wait lucid for OMZP::git-extras

# nvm completions from OMZ
zinit wait lucid for OMZP::nvm

# remind about registered aliases when available
zinit wait lucid for djui/alias-tips

# add more efficient navigation between folders
zinit wait lucid for rupa/z

# add nvm
export NVM_LAZY_LOAD=true
zinit light lukechilds/zsh-nvm

# file and direcgory colors for ls
zinit ice wait"0c" lucid reset \
    atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
            \${P}sed -i \
            '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
            \${P}dircolors -b LS_COLORS > c.zsh" \
    atpull'%atclone' pick"c.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}'
zinit light trapd00r/LS_COLORS

# modern ls repalacement
zinit ice lucid from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa

# style the prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# enable tab completions with fzf
zinit wait lucid for Aloxaf/fzf-tab

# git utils using fzf
zinit wait lucid for wfxr/forgit

# add command that allows to open github page for specific repo and branch
zinit wait lucid for paulirish/git-open

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

bindkey '^a' fzf-file-widget

####################
# ALIASES
####################
alias l="exa"
alias ls="exa -lhb --git"
alias la="ls -a"
alias j="z"
alias f="fdfind"
alias bat="batcat"
alias ci="code-insiders"

####################
# FUNCTIONS
####################
function doc() {
   tldr $1 | bat
}

function fif() {
  if [ ! "$#" -gt 0 ]; then echo
    "Need a string to search for!"
    return 1
  fi

  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

####################
# FZF
####################
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --info inline"

if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

####################
# Z
####################
if [[ ! -f ~/.z ]]; then
   touch ~/.z
fi

####################
# LOCAL
####################
if [[ -a ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
