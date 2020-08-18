#!/bin/bash

source "${BASH_SOURCE%/*}/shared.sh"

function print_setup_message() {
  print_message "🌟 ${YELLOW}$1${NOCOLOR}"
}

print_setup_message "Setup Vim"
vim +PlugInstall +qall

if [[ $(uname -r) =~ microsoft || $IS_WSL || $WSL_DISTRO_NAME ]]; then
  WINDOWS_LOCAL_APP_DATA="$(wslpath $(wslvar LOCALAPPDATA))"

  print_setup_message "Setup Windows Terminal"
  cp "${BASH_SOURCE%/*}/../wt-settings.json" "${WINDOWS_LOCAL_APP_DATA}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
fi

print_setup_message "Change to ZSH 🔥"
chsh -s $(which zsh)
# exec zsh