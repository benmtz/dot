#!/bin/bash

REPO_URL=https://github.com/benmtz/dot.git
DEST=~/.dots

# shellcheck disable=SC2054
packages=(
  fish
  python
  git
  which
  git-delta
  jq
  ranger
  lazygit
  nodejs
  golang
  starship
  direnv
)

fish -s $(which fish) $(whoami)

pkg upgrade -y
pkg install -y "${packages[@]}"

python3 -m pip install lolcat

rm -f /data/data/com.termux/files/usr/etc/motd


# git clone $REPO_URL $DEST 
# cd $DEST 
# 
# pip install -r requirements.txt
# 
# python dotfiles.py install-font
# python dotfiles.py compile
# python dotfiles.py link --force
# 
