#!/bin/bash

cd $(dirname $BASH_SOURCE)
BASE=$(pwd)
echo $BASE

# nvim
mkdir -p ~/.config/nvim/autoload
ln -sf $BASE/../vimrc ~/.config/nvim/init.vim
ln -sf ~/.vim/autoload/plug.vim ~/.config/nvim
ln -sf ~/.vim/syntax ~/.config/nvim
#ln -sf ~/.vim/ultisnips ~/.config/nvim
#ln -sf ~/.vim/vim-snippets ~/.config/nvim

mkdir -p ~/.config/nvim
ln -sf $BASE/../coc-settings.json ~/.config/nvim/coc-settings.json

nvim +PlugInstall +qall
