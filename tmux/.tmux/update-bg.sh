#!/usr/bin/env bash
color=$(cat ~/.tmux/.color2)	
tmux set-option -g status-bg $color
tmux set-option -g window-status-bg $color
tmux set-option -g window-status-current-fg $color
tmux set-option -g status-right-bg $color
