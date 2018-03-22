#! /bin/bash

cd ~/.dotfiles
changes=`git status -s | wc -l`
if [ "$changes" != 0 ]
then
	printf " $changes\u0394"
fi
