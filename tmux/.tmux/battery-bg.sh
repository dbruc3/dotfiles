#!/usr/bin/env bash

main() {
    perc=$(termux-battery-status | grep perc | cut -d ' ' -f4 | cut -d, -f1)

	if [ $perc -eq 100 ]; then
        color="magenta"
    elif [ $perc -le 99 -a $perc -ge 95 ]; then
        color="blue"
	elif [ $perc -le 40 -a $perc -ge 20 ]; then
		color="yellow"
	elif [ $perc -le 19 -a $perc -ge 5 ]; then
    	color="colour208"
	elif [ $perc -le 5 ]; then
        color="red"
	else
		color="green"
    fi
	
	tmux set-option -g status-bg $color
	tmux set-option -g window-status-bg $color
	tmux set-option -g window-status-current-fg $color
	tmux set-option -g status-right-bg $color
}
main

