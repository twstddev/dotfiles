#!/bin/bash

source "${BASH_SOURCE%/*}/shared.sh"

function print_installation_message() {
  print_message "⚡ ${YELLOW}$1${NOCOLOR}"
}

function install_ubuntu_package() {
  sudo apt-get install $1 -yqq
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then

  if [[ $(lsb_release -si) == "Ubuntu" ]]; then
    print_installation_message "Install Vim"
    install_ubuntu_package vim
  fi

fi