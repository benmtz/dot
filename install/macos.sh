#!/usr/bin/env bash

packages=(
  # Term utilities
  rg
  ranger
  starship
  tree
  jq
  yq
  neovim
  lazygit
  git-delta
  tmux
  # Lang
  go
  node
  deno
  # IaC
  ansible-lint
  ansible
  packer
  terraform
  age
  sops
  dive
  govc
  yamllint
  # Kube
  k9s
  k3sup
  stern
  kubie
  fish
)

brew install "${packages[@]}"

sudo chsh -s /usr/local/bin/fish $(whoami)

python3 -m pip install lolcat

