#!/usr/bin/env sh
tmux set-environment -u TMUX_BAR_DISABLED \;\
     set -u prefix \;\
     set -u key-table \;\
     set -u status-style \;\
     set -u window-status-current-style \;\
     set -u window-status-current-format \;\
     refresh-client -S

