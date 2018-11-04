#!/bin/bash
brew install tmux
git clone https://github.com/gpakosz/.tmux.git
cp .tmux/.tmux.conf ../
cp .tmux/.tmux.conf.local ../
rm -rf .tmux

# .tmux/.tmux.conf.local
# increase history size
# set -g history-limit 10000

# start with mouse mode enabled
# set -g mouse on

# force Vi mode
# really you should export VISUAL or EDITOR environment variable, see manual
# set -g status-keys vi
# set -g mode-keys vi
