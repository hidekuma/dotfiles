#!/bin/bash
cd ~/.tmux/plugins/tpm || exit
git fetch
git pull
~/.tmux/plugins/tpm/bin/update_plugins all
