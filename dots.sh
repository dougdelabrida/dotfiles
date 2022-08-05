#!/bin/zsh

cd ~/dotfiles/
case $1 in
  install) brew bundle;;
  config) stow */;;
esac
