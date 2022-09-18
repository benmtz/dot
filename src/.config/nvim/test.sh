#!/usr/bin/env bash

docker run -e XDG_CONFIG_HOME=/root/.config \
           -v $PWD/lua:/root/.config/nvim/lua \
           -v $PWD/tests.lua:/root/.config/nvim/tests.lua \
           nvim --headless -u /root/.config/nvim/tests.lua +qa

