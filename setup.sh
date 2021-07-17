#!/usr/bin/env zsh

# Required packages:
# vim, tmux, zsh, tree
# Required font:
# https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
BASE_DIR="$(pwd)"
ROOT_ACCESS="$(which sudo | which doas)"

export XDG_CONFIG_HOME=$CONFIG_DIR
export XDG_CACHE_HOME=$CACHE_DIR
export XDG_DATA_HOME=$DATA_DIR

export CONFIG_DIR="$HOME/.config"
export ZDOTDIR="$CONFIG_DIR/zsh"
export TMUX_HOME="$CONFIG_DIR/tmux"

export ETC_DIR="${ETC_DIR:-/etc}"
echo 'export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh' >tmp.zshenv
${ROOT_ACCESS} cat "$ETC_DIR/zshenv" >>tmp.zshenv || true
${ROOT_ACCESS} mv tmp.zshenv "$ETC_DIR/zshenv"

mkdir "$CONFIG_DIR" 2>/dev/null || true
cp -R zsh "$CONFIG_DIR/"

# Set up oh-my-zsh
echo Setting up oh my zsh

export ZSH=$CONFIG_DIR/oh-my-zsh
export CHSH=no
export RUNZSH=no
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh
cd "$BASE_DIR"
rm install.sh

# oh-my-zsh will update .zshrc at ~/.zshrc, append it to .config/zsh/.zshrc
sed -e '/ZSH_THEME/d' -i.bak ~/.zshrc
<~/.zshrc >>$ZDOTDIR/.zshrc
rm ~/.zshrc ~/.zshrc.bak

# Set up Powerline10k theme for zsh
echo Setting up Powerline10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k
SSH_TTY_TEMP="$SSH_TTY"
unset SSH_TTY
# Should run p10k configure
cd "$BASE_DIR"

# --- ZSH is now set up --- #

# --- Set up tmux --- #
cp -R tmux $CONFIG_DIR
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
mv ~/.tmux/* ~/.config/tmux/
rmdir ~/.tmux

SIDEBAR_VARIABLES="$TMUX_HOME/plugins/tmux-sidebar/scripts/variables.sh"
mv "$SIDEBAR_VARIABLES" "$SIDEBAR_VARIABLES.bak"
sed '/^SIDEBAR_DIR/ s?=(.*)?='"$TMUX_HOME/sidebar"'?g' "$SIDEBAR_VARIABLES.bak" >"$SIDEBAR_VARIABLES"

cd "$BASE_DIR"

# -- Set up tmux complete --- #

