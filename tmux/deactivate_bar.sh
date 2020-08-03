#!/usr/bin/env sh
tmux set-environment TMUX_BAR_DISABLED TRUE \;\
    set prefix None \;\
    set key-table off \;\
    set status-style "fg=$color_status_text,bg=$color_window_off_status_bg" \;\
    set window-status-current-format "#[fg=$color_window_off_status_bg,bg=$color_window_off_status_current_bg]$separator_powerline_right#[default] #I:#W# #[fg=$color_window_off_status_current_bg,bg=$color_window_off_status_bg]$separator_powerline_right#[default]" \;\
    set window-status-current-style "fg=$color_dark,bold,bg=$color_window_off_status_current_bg" \;\
    if -F '#{pane_in_mode}' 'send-keys -X cancel' \;\
    refresh-client -S \;\
