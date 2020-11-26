#!/bin/bash
brew install python3
pip3 install virtualenv virtualenvwrapper
mkdir ~/.virtualenvs
echo "export WORKON_HOME=~/.virtualenvs" >> ../.zsh_profile
echo "export VIRTUALENVWRAPPER_PYTHON='$(which python3)'" >> ../.zsh_profile
echo "source $(find /usr -name virtualenvwrapper.sh)" >> ../.zsh_profile 
