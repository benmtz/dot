# dot

Dotfiles managed with [mise](https://mise.jdx.dev): `src/` holds jinja-templated
sources, `./dotfiles compile` hydrates them into `dist/`, and `./dotfiles link`
copies them into `$HOME`.

## Bootstrap (any OS)

```
# install mise, then from this repo:
mise install            # toolchain from src/.config/mise/config.toml
mise run full           # compile + link everything
./dotfiles install-font # nerdfont, OS-aware
```

## Commands

```
./dotfiles compile      # src/ -> dist/ (theme.ini provides the values)
./dotfiles link --force # dist/ -> $HOME
./dotfiles extract PATH # reverse-hydrate a live config back into src/
```

## Termux

in order to install ansible on termux follow the following

```
pkg install -y \
    python python-dev \
    libffi libffi-dev \
    openssl openssl-dev \
    libsodium \
    clang \
    cmake
pip install --upgrade pip setuptools wheel
export CARGO_BUILD_TARGET="aarch64-linux-android"
export RUSTFLAGS="-C lto=n"
pip install --upgrade cryptography ansible pywinrm[credssp]
```
if failing see https://gist.github.com/kuttor/5540b0b7ee18ea62283068b03813693e#file-ansible-termux-sh-L5
