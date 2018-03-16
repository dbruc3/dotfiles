#! /usr/bin/env python
import geocoder
from subprocess import getoutput
import ipgetter

def getLoc():
    ip = getoutput("echo $SSH_CONNECTION | cut -d' ' -f1")
    if ip is None:
        ip = getoutput('curl -s ipecho.net/plain')
    if ip.startswith('192'):
        ip = ipgetter.myip()
    return geocoder.ip(ip)
