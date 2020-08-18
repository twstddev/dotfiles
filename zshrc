####################
# PROMPT CONFIGURATION
####################
PS1='%~:%# '

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
# LOCAL
####################
if [[ -a ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi