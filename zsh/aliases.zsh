alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias md='mkdir -p'

alias l='eza --group-directories-first'
alias ls='l -l --git --icons=always --header'
alias la='ls -a'

alias -g -- -h='-h 2>&1 | bat --language=help -p'
alias -g -- --help='--help 2>&1 | bat --language=help -p'
