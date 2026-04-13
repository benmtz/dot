set -gx ASDF_DATA_DIR "$HOME/.asdf"
set _asdf_shims "$ASDF_DATA_DIR/shims"

if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

function sync_plugins
    # cat ~/.tool-versions | sed -E 's/([a-zA-Z0-9-]+).*/\1/g' | xargs -I{} fish -l -c "asdf plugin remove {}"
    cat ~/.tool-versions | sed -E 's/([a-zA-Z0-9-]+).*#[ ]*([a-f0-9]+) (.*)/\1 \3/g' | xargs -I{} fish -l -c "asdf plugin add {}"
    cat ~/.tool-versions | sed -E 's/([a-zA-Z0-9-]+).*#[ ]*([a-f0-9]+) (.*)/\1 \2/g' | xargs -I{} fish -l -c "asdf plugin update {}"
    asdf install
end

