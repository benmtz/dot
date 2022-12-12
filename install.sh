#!/bin/bash

REPO_URL=https://github.com/benmtz/dot.git
DEST=~/.dots

pkg install -y python git

git clone $REPO_URL $DEST 
cd $DEST 

pip install -r requirements.txt

python dotfiles.py install-font
python dotfiles.py compile
python dotfiles.py link --force

