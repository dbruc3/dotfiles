#! /usr/bin/env python

from subprocess import getoutput

updates = getoutput('expr $(termux-info | grep -v All | wc -l) - 11')

if int(updates) > 0:
    print(u'\U0001F503')
