#!/usr/bin/env sh

export CONFIG_DIR="$HOME/.config"
export ZDOTDIR="$CONFIG_DIR/zsh"
export TMUX_HOME="$CONFIG_DIR/tmux"
export OH_MY_ZSH_HOME="$CONFIG_DIR/oh-my-zsh"
export VIM_HOME="$CONFIG_DIR/vim"

rm -rf "$ZDOTDIR" "$TMUX_HOME" "$OH_MY_ZSH_HOME" "$VIM_HOME"
