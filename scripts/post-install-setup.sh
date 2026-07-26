#!/bin/bash

source "${BASH_SOURCE%/*}/shared.sh"

function print_setup_message() {
  print_message "🌟 ${YELLOW}$1${NOCOLOR}"
}

if command -v bat >/dev/null 2>&1; then
  print_setup_message "Build bat theme cache"
  bat cache --build
fi

print_setup_message "Install tmux plugins"
~/.tmux/plugins/tpm/bin/install_plugins

print_setup_message "Change to ZSH 🔥"
chsh -s $(which zsh)
