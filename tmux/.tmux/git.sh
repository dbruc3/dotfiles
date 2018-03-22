#! /bin/bash

cd ~/.dotfiles
changes=`git status -s`
if [ ! -z "$changes" ]
then
	printf " \u0394"
fi
