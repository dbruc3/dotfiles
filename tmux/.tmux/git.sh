#! /bin/bash

cd ~/.dotfiles
changes=`git status -s | wc -l`
if [ ! -z "$changes" ]
then
	printf " $changes\u0394"
fi
