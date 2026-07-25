alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias md='mkdir -p'

alias l='eza --group-directories-first'
alias ls='l -l --git --icons' 
alias la='ls -a'

(( $+commands[batcat] )) && alias bat="batcat"
