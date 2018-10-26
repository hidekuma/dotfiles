#!/bin/bash
brew install pyenv
brew upgrade pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ../.zsh_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ../.zsh_profile
echo 'eval "$(pyenv init -)"' >> ../.zsh_profile
source ../.zsh_profile


# 가상환경 안만들어질떄
#CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" \
#LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib" \
#PYTHON_CONFIGURE_OPTS=--enable-unicode=ucs2 \
#pyenv install -v 3.6.6
