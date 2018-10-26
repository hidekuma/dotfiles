#!/bin/bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ../.zsh_profile
echo 'eval "$(rbenv init -)"' >> ../.zsh_profile
source ~/.zshrc

mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
