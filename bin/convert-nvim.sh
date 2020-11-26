#!/bin/bash

cd $(dirname $BASH_SOURCE)
BASE=$(pwd)
echo $BASE

# nvim
mkdir -p ~/.config/nvim/autoload
ln -sf $BASE/../vimrc ~/.config/nvim/init.vim
ln -sf ~/.vim/autoload/plug.vim ~/.config/nvim/autoload/
ln -sf ~/.vim/syntax/plug.vim ~/.config/syntax/autoload/
ln -sf ~/.vim/ultisnips/plug.vim ~/.config/ultisnips/autoload/
ln -sf ~/.vim/vim-snippets/plug.vim ~/.config/vim-snippets/autoload/

mkdir -p ~/.config/nvim
ln -sf $BASE/../coc-settings.json ~/.config/nvim/coc-settings.json

nvim +PlugInstall +qall
