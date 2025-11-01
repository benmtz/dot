# https://taskfile.dev/docs/experiments/env-precedence
export TASK_X_ENV_PRECEDENCE=1

registr add ftask "Fuzzy find and run task commands with optional looping" "ftask -l"
function ftask() {
  local loop_flag=0
  
  # Parse arguments
  while getopts "l" opt; do
    case $opt in
      l) loop_flag=1 ;;
    esac
  done

  local result=$(task --list-all | sed -e '1d; s/\* \(.*\):\s*\(.*\)\s*(aliases.*/\1\t\2/' -e 's/\* \(.*\):\s*\(.*\)/\1\t\2/' | awk '{$1= $1};1' | fzf)
  
  if [[ -n "$result" ]]; then
    task $result
    echo "-- task name =--"
    echo task $result
  fi

  if [[ $loop_flag -eq 1 ]]; then
    echo ""
    read "?Enter to continue..."
    ftask -l
  fi
}

