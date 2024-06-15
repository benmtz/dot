set INFRA_MANAGEMENT_DIR "~/Code/repos/infra_management"

function is-jetbrains-terminal
  if set -q JEDITERM_SOURCE_ARGS
    return 0
  else
    return 1
  end
end

if status is-interactive
  alias updateDotfiles="cd ~/Code/gh_dotfiles; python dotfiles.py compile"
  alias watchUpdateDotfiles="cd ~/Code/gh_dotfiles; find src | entr -cna python dotfiles.py compile"
  alias ts3dCli="cd ~/Code/repos/local-tools; poetry run python src/main.py"

  alias ansibleLint="docker run -v $INFRA_MANAGEMENT_DIR/ansible:/sources quay.io/ansible/creator-ee:latest bash -c 'cd /sources; ansible-lint --offline -f md --force-color'"
end

fish_vi_key_bindings

if test -d /home/linuxbrew/.linuxbrew
	eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

set XDG_CONFIG_HOME "$HOME/.config"
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/go/bin $PATH

direnv hook fish | source

starship init fish | source

if test $(uname -s) = "Darwin"
  echo "DARWIN"
  set -x ANDROID_HOME $HOME/Library/Android/sdk
  set -x OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES
  set PATH $ANDROID_HOME/emulator $PATH
  set PATH $ANDROID_HOME/platform-tools $PATH
  set -x DOCKER_HOST unix://$HOME/.colima/docker.sock
end

if not is-jetbrains-terminal;
  set USE_CUSTOM_GREETER 0
end
