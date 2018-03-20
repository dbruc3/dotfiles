#!/bin/bash

timenow=$(date | cut -d' ' -f4 | cut -d':' -f1 | sed 's/^0*//')
remain=$(( 24 - $timenow ))
events=$((khal list now $remain hours)
header="~/.config/khal/.header"

if [ -f $header ]
then
	rm $header
fi

if [[ "$events" != "No events" ]]
then
	script -q -c "khal list now $remain hours" /dev/null | grep -v Today | tee $header
fi
