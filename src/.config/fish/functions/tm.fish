function tm
  set -l result (tmux list-sessions -F '#S' 2>/dev/null | fzf --print-query)
  # --print-query puts the typed query on line 1, the selection (if any) on line 2.
  # Use the selection when there's a match, otherwise create a session named after the query.
  set -l name $result[-1]
  test -n "$name"; and tmux new-session -A -s $name
end
