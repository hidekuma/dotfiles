#!/bin/bash

cd $(dirname $BASH_SOURCE)
BASE=$(pwd)
echo $BASE

mkdir -p ~/.config/nvim
ln -sf ~/.vim/autoload/plug.vim ~/.config/nvim
ln -sf $BASE/../vimrc ~/.config/nvim/init.vim
ln -sf $BASE/../coc-settings.json ~/.config/nvim/coc-settings.json

nvim +PlugInstall +qall
