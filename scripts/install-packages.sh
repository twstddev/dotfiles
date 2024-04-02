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

    print_installation_message "Install fzf"
    install_ubuntu_package fzf

    print_installation_message "Install htop"
    install_ubuntu_package htop

    print_installation_message "Install ripgrep"
    install_ubuntu_package ripgrep

    print_installation_message "Install bat"
    install_ubuntu_package bat

    print_installation_message "Install ruby"
    install_ubuntu_package ruby

    if !(command -v http > /dev/null 2>&1;) then
      print_installation_message "Install httpie"
      curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg
      echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list > /dev/null
      sudo apt update
      install_ubuntu_package httpie
    fi
  fi

fi