set INFRA_MANAGEMENT_DIR "~/Code/repos/infra_management"

if status is-interactive
  alias updateDotfiles="cd ~/Code/gh_dotfiles; python dotfiles.py compile"
  alias watchUpdateDotfiles="cd ~/Code/gh_dotfiles; find src | entr -cna python dotfiles.py compile"
  alias ts3dCli="cd ~/Code/repos/local-tools; poetry run python src/main.py"

  alias ansibleLint="docker run -v $INFRA_MANAGEMENT_DIR/ansible:/sources quay.io/ansible/creator-ee:latest bash -c 'cd /sources; ansible-lint --offline -f md --force-color'"
end

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/go/bin $PATH

direnv hook fish | source

if not test -d $HOME/.asdf
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
  mkdir -p ~/.config/fish/completions
  ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
end
source ~/.asdf/asdf.fish


