_comp_dir="$HOME/.config/zsh/completions"
mkdir -p "$_comp_dir"

if command -v flux &>/dev/null && [[ ! -f "$_comp_dir/_flux" ]]; then
    flux completion zsh > "$_comp_dir/_flux"
fi

if command -v kubectl &>/dev/null && [[ ! -f "$_comp_dir/_kubectl" ]]; then
    kubectl completion zsh > "$_comp_dir/_kubectl"
fi

if command -v fly &>/dev/null; then
    fly completion --shell zsh > "$_comp_dir/_fly" 2>/dev/null
fi

unset _comp_dir
