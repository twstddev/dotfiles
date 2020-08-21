#!/bin/bash

source "${BASH_SOURCE%/*}/shared.sh"

function print_installation_message() {
  print_message "⚡ ${YELLOW}$1${NOCOLOR}"
}

function install_ubuntu_package() {
  sudo apt-get -qq install $1
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then

  if [[ $(lsb_release -si) == "Ubuntu" ]]; then
    print_installation_message "Install Vim"
    install_ubuntu_package vim
    
    print_installation_message "Install ZSH"
    install_ubuntu_package zsh

    print_installation_message "Install Unzip"
    install_ubuntu_package unzip

    print_installation_message "Install Python"
    install_ubuntu_package python
  fi

fi