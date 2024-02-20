function gg -d "lazygit in top level git dir"

    set -l current_dir (pwd)
    set -l root_git_dir ""

    # Find the top most git repository
    while test "$current_dir" != "/"
        if test -d "$current_dir/.git"
            set root_git_dir "$current_dir" # Potential root dir
        end
        set current_dir (dirname "$current_dir")
    end

    if test -z "$root_git_dir"
        echo "No git repository found"
        exit 1
    end

    function find_git_repos
        cd "$argv[1]"
        find . -maxdepth 3 \( -name '.git' -and ! -path '*target*' -and ! -path '*venv*' -and ! -path '*node_modules*' \) -print | while read -l dir
            set -l gitdir (dirname "$dir")
            echo (string replace -r "^$root_git_dir/" "" -- $gitdir)
        end
    end

    set subdir (find_git_repos $root_git_dir | fzf)
    lazygit -p $root_git_dir/$subdir
end
