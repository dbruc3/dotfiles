#! /usr/bin/env python
import sys, loc

url = 'https://www.google.com/maps'

if len(sys.argv) == 1:
    print(url)
    quit()

action = 'search'
dest = sys.argv[1:]
locc = ''

if sys.argv[1] == '--dir':
    action = 'dir'
    dest = sys.argv[2:]
    location = loc.getLoc()
    locc = '{},{}/'.format(location.lat, location.lng)

dest = '+'.join(dest)
print('https://www.google.com/maps/{}/{}{}'.format(action, locc, dest))
