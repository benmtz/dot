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

then 
```
ansible-pull https://github.com/benmtz/dot.git ansible/install-termux.yaml
