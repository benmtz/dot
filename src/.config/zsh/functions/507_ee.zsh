registr add ee "Browse and create markdown notes in ~/.notes" "ee"
function ee() {
    local notes_dir=~/.notes
    mkdir -p "$notes_dir"

    local -a fzf_output
    fzf_output=("${(@f)$(
        fd -e md --max-depth 1 --base-directory "$notes_dir" --strip-cwd-prefix \
            | sed 's/\.md$//' \
            | fzf --print-query \
                  --preview "bat --style=plain --color=always $notes_dir/{}.md 2>/dev/null"
    )}")
    local fzf_status=$?

    [[ $fzf_status -eq 130 ]] && return

    local query="${fzf_output[1]}"
    local selection="${fzf_output[2]}"
    local note="${selection:-$query}"

    [[ -z "$note" ]] && return

    if [[ -n "$NVIM" ]]; then
        nvim --server "$NVIM" --remote-expr "execute('bd! | edit $notes_dir/$note.md')"
    else
        nvim -c "cd $notes_dir" "$notes_dir/$note.md"
    fi
}
