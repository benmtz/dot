# lazygit in top level git dir
function gg() {
    local current_dir=$(pwd)
    local root_git_dir=""

    while [[ "$current_dir" != "/" ]]; do
        if [[ -d "$current_dir/.git" ]]; then
            root_git_dir="$current_dir"
        fi
        current_dir=$(dirname "$current_dir")
    done

    if [[ -z "$root_git_dir" ]]; then
        echo "No git repository found"
        return 1
    fi

    function find_git_repos() {
        cd "$1"
        fd --no-ignore-vcs -d 5 -H -g "**/.git" | while read dir; do
            local gitdir=$(dirname "$dir")
            echo "${gitdir#$root_git_dir/}"
        done
    }

    local subdir=$(find_git_repos "$root_git_dir" | fzf)
    lazygit -p "$root_git_dir/$subdir"
}
