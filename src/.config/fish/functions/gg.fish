function gg -d "lazygit in top level git dir"

    set -l current_dir (pwd)
    set -l root_git_dir ""

    while test "$current_dir" != "/"
        if test -d "$current_dir/.git"
            set root_git_dir "$current_dir"
        end
        set current_dir (dirname "$current_dir")
    end

    if test -z "$root_git_dir"
        echo "No git repository found"
        exit 1
    end

    function find_git_repos
        cd "$argv[1]"
        fd --no-ignore-vcs -d 5 -H -g "**/.git" | while read -l dir
            set -l gitdir (dirname "$dir")
            echo (string replace -r "^$root_git_dir/" "" -- $gitdir)
        end
    end

    set subdir (find_git_repos $root_git_dir | fzf)
    lazygit -p $root_git_dir/$subdir
end
