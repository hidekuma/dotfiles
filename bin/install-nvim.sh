#!/bin/bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/usr/bin/nvim
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
