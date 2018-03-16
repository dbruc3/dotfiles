#!/bin/sh
temp=$(sensors coretemp-isa-0000 | grep Package | cut -d'+' -f2 | cut -d'.' -f1)
if [ $temp -gt 90 ]
then
	color='red'
elif [ $temp -gt 80 ]
then
	color='colour208'
elif [ $temp -gt 40 ]
then
	color='green'
else
	color='blue'
fi

tmux set-option -g status-bg $color
tmux set-option -g window-status-bg $color
tmux set-option -g window-status-current-fg $color
tmux set-option -g status-right-bg $color
