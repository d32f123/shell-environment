#!/usr/bin/env zsh

export SSH_DIR=$HOME/.ssh
export CONFIG_DIR=$HOME/.config
export ZDOTDIR=$CONFIG_DIR/zsh

<./zsh/.zshrc >>$ZDOTDIR/.zshrc

cp -R ./ssh/* $SSH_DIR/
