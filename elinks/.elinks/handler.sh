#!/bin/bash

log='/home/dan/.log'
ext=$(echo $1 | rev | cut -d'.' -f1 | rev | cut -d'?' -f1)
isImg=$(echo 'jpg png jpeg gif svg bmp' | grep $ext)
isAudio=$(echo 'mp3 ogg' | grep $ext)
isDown=$(echo 'pdf' | grep $ext)
source ~/.zshrc

echo $ext >> $log

if [[ $1 == *"youtube.com/watch"* ]] ||
   [[ $1 == *"ted.com"* ]] ||
    [ ! -z "$isAudio" ]
then
	mpv --really-quiet $1 &
elif [ ! -z "$isImg" ] 
then
	curl -s $1 > /tmp/image.$ext
	$BROWSER /tmp/image.$ext
elif [ $ext == 'pdf' ]
then
	fn=$(basename $1)
	fp="~/reading/pdf/downloads/$fn"
	curl -s $1 > $fp
	$BROWSER $fp
else
	elinks -remote "openURL($1)"
	fp=$(/home/dan/.newsboat/reader/read.sh -o file -c $1)

	if [ ! -z $fp ]
	then
		elinks -remote "openURL($fp)"
	fi
fi
