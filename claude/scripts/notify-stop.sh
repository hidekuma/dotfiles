#!/bin/bash
# Claude Code Stop hook script

terminal-notifier \
    -title "Claude Code [$(basename "$PWD")]" \
    -message "세션 종료" \
    -sound Glass \
    -activate com.googlecode.iterm2
