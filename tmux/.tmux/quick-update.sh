#!/bin/bash

now=$(date +%s)
last=$(cat ~/.tmux/.lastupdate)
day=$(date --date @$now | cut -d' ' -f 2,3,6)
lastday=$(date --date @$last | cut -d' ' -f 2,3,6)

if [ "$day" == "$lastday" ]
then
	exit
fi

echo "Updating..."
~/.tmux/news-update.sh &
~/scripts/periodic/wallpaper.py
date +%s > ~/.tmux/.lastupdate
clear
cat ~/.image.title
