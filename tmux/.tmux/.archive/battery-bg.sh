#!/usr/bin/env bash

main() {
    perc=$(ssh -p 8022 u0_a162@yoga termux-battery-status | grep perc | cut -d ' ' -f4 | cut -d, -f1)

	if [ $perc -eq 100 ]; then
        color="magenta"
    elif [ $perc -le 99 -a $perc -ge 80 ]; then
        color="blue"
	elif [ $perc -le 59 -a $perc -ge 25 ]; then
		color="yellow"
	elif [ $perc -le 24 -a $perc -ge 5 ]; then
    	color="colour208"
	elif [ $perc -le 5 ]; then
        color="red"
	else
		color="green"
    fi
	echo $color > ~/.tmux/.color
}
main
