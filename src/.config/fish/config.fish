set INFRA_MANAGEMENT_DIR "~/Code/repos/infra_management"

if status is-interactive
  alias updateDotfiles="cd ~/Code/private-repos/private-dev/env-dotfiles; python dotfiles.py compile"
  alias watchUpdateDotfiles="cd ~/Code/private-repos/private-dev/env-dotfiles; find src | entr -cna python dotfiles.py compile"
  alias ts3dCli="cd ~/Code/repos/local-tools; poetry run python src/main.py"

  # alias related to code projects
  # note that all those alias starts by a n for nvim
  alias nPrivateDev="cd ~/Code/private-repos/private-dev; nvim"
  alias nLocalToolsDev="cd ~/Code/repos/local_tools; nvim"
  alias nInfraManagement="cd ~/Code/repos/infra_management; nvim"
  alias nVisualize="cd ~/Code/repos/visualize; nvim"

  alias ansibleLint="docker run -v $INFRA_MANAGEMENT_DIR/ansible:/sources quay.io/ansible/creator-ee:latest bash -c 'cd /sources; ansible-lint --offline -f md --force-color'"
end

set PATH $HOME/.cargo/bin $PATH

