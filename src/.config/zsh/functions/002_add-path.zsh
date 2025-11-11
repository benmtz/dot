registr add add-path "Add a directory to the PATH environment variable" "add-path ~/.local/bin"
function add-path() {
  if [[ -d "$1" ]]; then
    export PATH="$1:$PATH"
  fi
}

