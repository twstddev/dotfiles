alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias md='mkdir -p'

alias l='eza --group-directories-first'
alias ls='l -l --icons=always --header'
alias la='ls -a'

h() {
  "${@}" --help 2>&1 | bat --language=help --plain --color=always --theme=ansi --paging=always --pager='less -RFX'
}
zsh-defer compdef _precommand h

alias jv='jq . | nvim -R -n -c "setlocal filetype=json nomodifiable nomodified" -'
