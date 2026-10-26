registr add tm "Fuzzy attach or create a tmux session" "tm"
function tm() {
    # --print-query puts the typed query on line 1, selection on line 2.
    # Use selection when matched, otherwise treat query as the new session name.
    local -a result
    result=("${(@f)$(tmux list-sessions -F '#S' 2>/dev/null | fzf --print-query)}")
    local name="${result[-1]}"
    [[ -n "$name" ]] && tmux new-session -A -s "$name"
}

registr add tml "List all tmux sessions" "tml"
function tml() {
    tmux list-sessions
}
