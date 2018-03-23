#! /usr/bin/env python

from subprocess import getoutput

pkgs = getoutput('pkg list-all').split('\n')[4:]

for pkg in pkgs:
    name = pkg.split('/')[0]
    show = getoutput('pkg show {}'.format(name))
    print(show)
    input('Enter to Continue...')
