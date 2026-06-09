#!/bin/bash
# Install virtualenvwrapper into an isolated venv so it's decoupled from the
# active `python3` (Homebrew keeps bumping it to EXTERNALLY-MANAGED versions
# that block pip and lack the module). zsh_profile.m1 points
# VIRTUALENVWRAPPER_PYTHON at ~/.local/venvwrapper/bin/python.
set -e

brew install python3

python3 -m venv ~/.local/venvwrapper
~/.local/venvwrapper/bin/pip install --upgrade pip
~/.local/venvwrapper/bin/pip install virtualenvwrapper

mkdir -p ~/.virtualenvs

echo "Done. virtualenvwrapper installed at ~/.local/venvwrapper"
