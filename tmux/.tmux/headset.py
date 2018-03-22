#! /usr/bin/env python
from subprocess import getoutput

val = getoutput("termux-audio-info | grep A2DP | cut -d' ' -f4")

if val != "false,":
    print(' {}'.format(u'\U0001f3a7'))
