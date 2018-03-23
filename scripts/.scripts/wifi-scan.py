#! /usr/bin/env python
import json
from subprocess import getoutput
from termcolor import colored

def rssi_to_bars(rssi):
    bars = 0
    if rssi > -60:
        bars = 4
    elif rssi > -75:
        bars = 3
    elif rssi > -90:
        bars = 2
    elif rssi > -105:
        bars = 1
    return u'\u2586'*bars

spots = [s for s in json.loads(getoutput('termux-wifi-scaninfo')) if s['ssid']]
wifi = getoutput("termux-wifi-connectioninfo | grep '\"ssid\":' | cut -d'\"' -f4")
for spot in sorted(spots, key=lambda k: k['rssi'], reverse=True):
    line = '[{}]\t{}'.format(rssi_to_bars(spot['rssi']), spot['ssid'])
    if spot['ssid'] == wifi.strip():
        print(colored(line, 'green'))
    else:
        print(line)
