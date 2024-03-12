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

    if !(command -v nvim > /dev/null 2>&1;) then
      print_installation_message "Install Neovim"

      sudo add-apt-repository -y ppa:neovim-ppa/unstable
      sudo apt-get update

      install_ubuntu_package neovim
    fi


    print_installation_message "Install ZSH"
    install_ubuntu_package zsh

    print_installation_message "Install tmux"
    install_ubuntu_package tmux
  fi

fi