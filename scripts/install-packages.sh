#!/bin/bash

source "${BASH_SOURCE%/*}/shared.sh"

function print_installation_message() {
  print_message "⚡ ${YELLOW}$1${NOCOLOR}"
}

function install_ubuntu_package() {
  sudo apt-get -qq install $1
}

function install_brew_package() {
  brew install $1
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then

  if [[ $(lsb_release -si) == "Ubuntu" ]]; then

    print_installation_message "Install neovim"
    install_ubuntu_package neovim

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

    print_installation_message "Install httpie"
    install_ubuntu_package httpie

    print_installation_message "Install eza"
    install_ubuntu_package eza
  fi

elif [[ "$OSTYPE" == "darwin"* ]]; then

    print_installation_message "Install neovim"
    install_brew_package neovim

    print_installation_message "Install tmux"
    install_brew_package tmux

    print_installation_message "Install fzf"
    install_brew_package fzf

    print_installation_message "Install htop"
    install_brew_package htop

    print_installation_message "Install ripgrep"
    install_brew_package ripgrep

    print_installation_message "Install bat"
    install_brew_package bat

    print_installation_message "Install ruby"
    install_brew_package ruby

    print_installation_message "Install httpie"
    install_brew_package httpie

    print_installation_message "Install eza"
    install_brew_package eza

fi
