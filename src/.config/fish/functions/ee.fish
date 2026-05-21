function ee -d "Browse and create markdown notes in ~/.notes"
    set -l notes_dir ~/.notes
    mkdir -p $notes_dir

    set -l fzf_output (
        fd -e md --max-depth 1 --base-directory $notes_dir --strip-cwd-prefix \
            | sed 's/\.md$//' \
            | fzf --print-query \
                  --preview "bat --style=plain --color=always $notes_dir/{}.md 2>/dev/null"
    )

    set -l fzf_status $status

    # Ctrl-C / Escape → bail
    test $fzf_status -eq 130; and return

    set -l query $fzf_output[1]
    set -l selection $fzf_output[2]

    # Use selection if matched, otherwise use query for new note
    set -l note (test -n "$selection"; and echo $selection; or echo $query)

    test -z "$note"; and return

    if test -n "$NVIM"
        nvim --server $NVIM --remote-expr "execute('bd! | edit $notes_dir/$note.md')"
    else
        nvim -c "cd $notes_dir" $notes_dir/$note.md
    end
end
