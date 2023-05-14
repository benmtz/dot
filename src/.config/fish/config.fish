set INFRA_MANAGEMENT_DIR "~/Code/repos/infra_management"

if status is-interactive
  alias updateDotfiles="cd ~/Code/gh_dotfiles; python dotfiles.py compile"
  alias watchUpdateDotfiles="cd ~/Code/gh_dotfiles; find src | entr -cna python dotfiles.py compile"
  alias ts3dCli="cd ~/Code/repos/local-tools; poetry run python src/main.py"

  alias ansibleLint="docker run -v $INFRA_MANAGEMENT_DIR/ansible:/sources quay.io/ansible/creator-ee:latest bash -c 'cd /sources; ansible-lint --offline -f md --force-color'"
end

if test -d /home/linuxbrew/.linuxbrew 
	eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/go/bin $PATH
set PATH /opt/homebrew/opt/openjdk/bin $PATH

direnv hook fish | source



