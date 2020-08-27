#!/usr/bin/env sh

export CONFIG_DIR="$HOME/.config"
export ZDOTDIR="$CONFIG_DIR/zsh"
export TMUX_HOME="$CONFIG_DIR/tmux"
export OH_MY_ZSH_HOME="$CONFIG_DIR/oh-my-zsh"

rm -rf "$ZDOTDIR" "$TMUX_HOME" "$OH_MY_ZSH_HOME"
