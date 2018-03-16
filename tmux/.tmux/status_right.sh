#!/bin/bash

mail=$(cat ~/.mutt/.mail)
articles=$(cat ~/.newsboat/.unread)
updates=$(cat ~/scripts/.checkupdates)
string=''

if [ "$mail" != "0" ] && [ ! -z "$mail" ]
then
	string="$string - ${mail}m"
fi

if [ "$articles" != "0" ]
then
	string="$string - ${articles}a"
fi

if [ "$updates" != "0" ]
then
	string="$string - ${updates}u"
fi

echo "$string" | cut -c 3-
