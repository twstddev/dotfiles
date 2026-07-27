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

function create_local_symlink() {
  local source_path
  local target_path="$HOME/.local/bin/$2"

  if ! source_path=$(command -v "$1"); then
    print_message "⚠️  ${YELLOW}Could not find $1; no symlink was created${NOCOLOR}"
    return
  fi
  mkdir -p "$HOME/.local/bin"

  if [[ -e "$target_path" && ! -L "$target_path" ]]; then
    print_message "⚠️  ${YELLOW}$target_path already exists and was not replaced${NOCOLOR}"
    return
  fi

  ln -sfn "$source_path" "$target_path"
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

    print_installation_message "Install btop"
    install_ubuntu_package btop

    print_installation_message "Install ripgrep"
    install_ubuntu_package ripgrep

    print_installation_message "Install jq"
    install_ubuntu_package jq

    print_installation_message "Install fd"
    install_ubuntu_package fd-find
    create_local_symlink fdfind fd

    print_installation_message "Install bat"
    install_ubuntu_package bat
    create_local_symlink batcat bat

    print_installation_message "Install ruby"
    install_ubuntu_package ruby

    print_installation_message "Install httpie"
    install_ubuntu_package httpie

    print_installation_message "Install eza"
    install_ubuntu_package eza

    print_installation_message "Install zoxide"
    install_ubuntu_package zoxide
  fi

elif [[ "$OSTYPE" == "darwin"* ]]; then

    print_installation_message "Install neovim"
    install_brew_package neovim

    print_installation_message "Install tmux"
    install_brew_package tmux

    print_installation_message "Install fzf"
    install_brew_package fzf

    print_installation_message "Install btop"
    install_brew_package btop

    print_installation_message "Install ripgrep"
    install_brew_package ripgrep

    print_installation_message "Install jq"
    install_brew_package jq

    print_installation_message "Install fd"
    install_brew_package fd

    print_installation_message "Install bat"
    install_brew_package bat

    print_installation_message "Install ruby"
    install_brew_package ruby

    print_installation_message "Install httpie"
    install_brew_package httpie

    print_installation_message "Install eza"
    install_brew_package eza

    print_installation_message "Install zoxide"
    install_brew_package zoxide

fi
