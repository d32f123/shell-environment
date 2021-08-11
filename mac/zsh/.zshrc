# Auto SSH setup
[ -f "$HOME/.ssh/setup.sh" ] && [ -x "$HOME/.ssh/setup.sh" ] && "$HOME/.ssh/setup.sh" >/dev/null || true

# Set up NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
