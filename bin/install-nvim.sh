#!/bin/bash

# v0.10.2
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-macos-x86_64.tar.gz                                                                                                               130↵
chmod u+x nvim-macos-x86_64.tar.gz
tar xzf nvim-macos-x86_64.tar.gz
# ./nvim-macos-x86_64/bin/nvim
mv nvim-macos-x86_64 ~/
sudo ln -sf ~/nvim-macos-x86_64/bin/nvim /usr/local/bin/nvim
