#!/bin/bash

path='/home/dan/.elinks/bookmarks'

inotifywait -m $path -e create -e modify |
	while read path action file; do
		cat $path | sed -e 's/\t/::/g' | awk -F '::' '{printf $2}{printf "::"}{printf $1}{print "::"}' | $path/save.sh 
		rm $path
	done
