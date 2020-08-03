# Set up vars to spring clean
export CONFIG_DIR=$HOME/.config
export CACHE_DIR=$HOME/.cache
export DATA_DIR=$HOME/.local/share

# Set up XDG vars
export XDG_CONFIG_HOME=$CONFIG_DIR
export XDG_CACHE_HOME=$CACHE_DIR
export XDG_DATA_HOME=$DATA_DIR

# Set up locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export MM_CHARSET=UTF-8

# Set up zsh config
export ZDOTDIR=$CONFIG_DIR/zsh
export ZSH=$CONFIG_DIR/oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom

# Set up zsh history
HISTFILE=$DATA_DIR/zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
setopt extendedhistory

# Set up vim
export VIMRUNTIME=/usr/share/vim/vim81

# Set up tmux helpers
export TMUX_HOME="$CONFIG_DIR/tmux"
# If acting under ssh and no tmux yet, run tmux
[ -n "$SSH_TTY" ] && [ -z "$TMUX" ] && { tmux new; exit; }
# If connecting to remote and currently running tmux, better disable local tmux
tmux-ssh() {
    unalias ssh || { ssh "$@"; return; }
    [ -z "$TMUX" ] && { ssh "$@"; return; }
    bar_disabled="$(tmux showenv TMUX_BAR_DISABLED 2>/dev/null || echo)"
    [ -z "$bar_disabled" ] && sh "$TMUX_HOME/deactivate_bar.sh"
    ssh "$@"
    ret="$?"
    [ -z "$bar_disabled" ] && sh "$TMUX_HOME/activate_bar.sh"
    alias ssh=tmux-ssh
    return "$?"
}
alias ssh=tmux-ssh

# Enable Powerlevel10k theme
ZSH_THEME="powerlevel10k/powerlevel10k"

