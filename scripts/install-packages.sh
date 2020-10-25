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

    print_installation_message "Install fzf"
    install_ubuntu_package fzf

    print_installation_message "Install tldr"
    install_ubuntu_package tldr

    print_installation_message "Install htop"
    install_ubuntu_package htop

    print_installation_message "Install fd"
    install_ubuntu_package fd-find

    print_installation_message "Install ripgrep"
    install_ubuntu_package ripgrep

    print_installation_message "Install progress"
    install_ubuntu_package progress

    print_installation_message "Install bat"
    sudo apt-get -qq -o Dpkg::Options::="--force-overwrite" install bat

    print_installation_message "Install httpie"
    install_ubuntu_package httpie

    print_installation_message "Install git extras"
    install_ubuntu_package git-extras

    print_installation_message "Install ruby"
    install_ubuntu_package ruby

    print_installation_message "Install tmux"
    install_ubuntu_package tmux

    print_installation_message "Install jq"
    install_ubuntu_package jq
  fi

fi