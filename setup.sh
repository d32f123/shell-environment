#!/usr/bin/env zsh

# Required packages:
# vim, tmux, zsh
# Required font:
# https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

export CONFIG_DIR=$HOME/.config
export ZDOTDIR=$CONFIG_DIR/zsh
export TMUX_HOME=$CONFIG_DIR/tmux

export GLOBAL_ETC_DIR=/etc/zshenv
echo 'export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh' >> $GLOBAL_ETC_DIR/zshenv

mkdir $CONFIG_DIR
cp -R .config/zsh $CONFIG_DIR/

# Set up oh-my-zsh
echo Setting up oh my zsh

export ZSH=$CONFIG_DIR/oh-my-zsh
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh

# oh-my-zsh will update .zshrc at ~/.zshrc, append it to .config/zsh/.zshrc
<~/.zshrc >>$ZDOTDIR/.zshrc
rm ~/.zshrc

# Set up Powerline10k theme for zsh
echo Setting up Powerline10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k
source $ZDOTDIR/.zshrc
p10k configure

# --- ZSH is now set up --- #

# --- Set up tmux --- #
cp -R .config/tmux $CONFIG_DIR
# Setting up tmux
if [ ! -e "$TMUX_HOME/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm $TMUX_HOME/plugins/tpm
fi

# Install TPM plugins
echo Installing tmux plugins
tmux new -d -s __noop >/dev/null 2>&1 || true
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "$TMUX_HOME/plugins"
$TMUX_HOME/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

# -- Set up tmux complete --- #

# Set up vim TODO #

