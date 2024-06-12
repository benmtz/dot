if not test -d $HOME/.asdf
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
  mkdir -p ~/.config/fish/completions
  ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
end
source ~/.asdf/asdf.fish

fish_add_path $HOME/.asdf/bin

# We add asdf at then end so it acts as a fallback
fish_add_path -a $HOME/.asdf/shims 

