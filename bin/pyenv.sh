#!/bin/bash
brew install pyenv
brew upgrade pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ../.zsh_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ../.zsh_profile
echo 'eval "$(pyenv init -)"' >> ../.zsh_profile
source ../.zsh_profile
