#!/bin/bash
brew install rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ../.zsh_profile
echo 'eval "$(rbenv init -)"' >> ../.zsh_profile
source ~/.zshrc
