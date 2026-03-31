set -gx ASDF_DATA_DIR "$HOME/.asdf"
set _asdf_shims "$ASDF_DATA_DIR/shims"

if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

