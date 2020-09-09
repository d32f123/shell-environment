# Set up vars to spring clean
export CONFIG_DIR=$HOME/.config
export CACHE_DIR=$HOME/.cache
export DATA_DIR=$HOME/.local/share

# Set up XDG vars
export XDG_CONFIG_HOME=$CONFIG_DIR
export XDG_CACHE_HOME=$CACHE_DIR
export XDG_DATA_HOME=$DATA_DIR

# Set up CUPS vars
export CUPS_CACHEDIR=$XDG_CACHE_HOME/cups
export CUPS_DATADIR=$XDG_DATA_HOME/cups
export CUPS_STATEDIR=$XDG_CONFIG_HOME/cups

# Set up wget to use XDG
alias wget="wget --hsts-file=$DATA_DIR/wget/wget-hsts"

# Set up PSQL to use XDG
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

# Set up mail to use XDG
export MAILRC="$XDG_CONFIG_HOME/mail/mailrc"

# Set up less history location
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# Set up X11
export XAUTHORITY="$XDG_CONFIG_HOME/x11/Xauthority"


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

# Set up tmux helpers
export TMUX_HOME="$CONFIG_DIR/tmux"
# If acting under ssh and no tmux yet, run tmux
# [ -n "$SSH_CLIENT" ] && [ -z "$TMUX" ] && { tmux new; exit; }
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

# Add printing aliases
alias lp_doc="lp -o ColorModel=CMYGray -o MediaType=Plain -o OutputMode=Best"
alias lp_photo="lp -o ColorModel=RGB -o MediaType=Photo -o OutputMode=Photo"

# Enable Powerlevel10k theme
ZSH_THEME="powerlevel10k/powerlevel10k"

