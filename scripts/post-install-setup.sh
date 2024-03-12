#!/bin/bash

source "${BASH_SOURCE%/*}/shared.sh"

function print_setup_message() {
  print_message "🌟 ${YELLOW}$1${NOCOLOR}"
}

print_setup_message "Change to ZSH 🔥"
chsh -s $(which zsh)