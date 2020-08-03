#!/usr/bin/env zsh

export CONFIG_DIR=$HOME/.config
export ZDOTDIR=$CONFIG_DIR/zsh

<./zsh/.zshrc >>$ZDOTDIR/.zshrc

