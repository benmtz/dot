# https://taskfile.dev/docs/experiments/env-precedence
export TASK_X_ENV_PRECEDENCE=1

# On arch task is named go-task,
# align it with other systems
if [[ `command -v go-task` ]]; then
  alias task="go-task"
fi

registr add ftask "Fuzzy find and run task commands with optional looping" "ftask -l"
function ftask() {
  local loop_flag=0
  
  # Parse arguments
  while getopts "l" opt; do
    case $opt in
      l) loop_flag=1 ;;
    esac
  done

  local -a task_cmd
  local -a list_args
  task_cmd=(task)
  list_args=(--list-all)

  # Prefer local Taskfile if it yields tasks. If it doesn't (missing/empty/error),
  # fall back to global/config taskfiles.
  local has_local_tasks=0
  if task --list-all 2>/dev/null | command grep -q '^\* '; then
    has_local_tasks=1
  fi

  if [[ $has_local_tasks -eq 0 ]]; then
    if task -g --list-all 2>/dev/null | command grep -q '^\* '; then
      list_args=(-g --list-all)
    else
      local repo_root
      repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
      local repo_name=${${repo_root:-$PWD}:t}
      local cfg_base=${XDG_CONFIG_HOME:-$HOME/.config}/task
      local cfg_taskfile="${cfg_base}/${repo_name}/Taskfile.yaml"
      if [[ ! -f "$cfg_taskfile" ]]; then
        cfg_taskfile="${cfg_base}/${repo_name}/Taskfile.yml"
      fi
      if [[ -f "$cfg_taskfile" ]]; then
        list_args=(--taskfile "$cfg_taskfile" --list-all)
      fi
    fi
  fi

  local selected=$(
    "${task_cmd[@]}" "${list_args[@]}" 2>/dev/null \
      | sed -E -n \
          -e 's/[[:space:]]*\(aliases.*$//' \
          -e 's/^\* (.*):[[:space:]]*(.*)$/\1\t\2/p' \
      | fzf --delimiter=$'\t' --with-nth=1,2
  )

  local task_name=${selected%%$'\t'*}
  if [[ -n "$task_name" ]]; then
    local -a run_args
    run_args=()
    local arg
    for arg in "${list_args[@]}"; do
      [[ "$arg" == "--list-all" ]] && continue
      run_args+=("$arg")
    done

    "${task_cmd[@]}" "${run_args[@]}" "$task_name"
  fi

  if [[ $loop_flag -eq 1 ]]; then
    echo ""
    read "?Enter to continue..."
    ftask -l
  fi
}

registr add gtask "Fuzzy find and run global Taskfile tasks with optional looping" "gtask -l"
function gtask() {
  local loop_flag=0

  while getopts "l" opt; do
    case $opt in
      l) loop_flag=1 ;;
    esac
  done

  local list_output
  list_output=$(task -g --dir "$PWD" --list-all 2>&1)
  if ! print -r -- "$list_output" | command grep -q '^\* '; then
    print -r -- "$list_output" >&2
    print -r -- "gtask: no global tasks found via 'task -g'." >&2
    print -r -- "gtask: expected one of: $HOME/Taskfile.yaml, $HOME/Taskfile.yml (or lowercase)." >&2
    return 1
  fi

  local selected=$(
    print -r -- "$list_output" \
      | sed -E -n \
          -e 's/[[:space:]]*\(aliases.*$//' \
          -e 's/^\* (.*):[[:space:]]*(.*)$/\1\t\2/p' \
      | fzf --delimiter=$'\t' --with-nth=1,2
  )

  local task_name=${selected%%$'\t'*}
  if [[ -n "$task_name" ]]; then
    task -g --dir "$PWD" "$task_name"
  fi

  if [[ $loop_flag -eq 1 ]]; then
    echo ""
    read "?Enter to continue..."
    gtask -l
  fi
}

