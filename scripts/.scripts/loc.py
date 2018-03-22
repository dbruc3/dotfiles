#! /usr/bin/env python
import geocoder
from subprocess import getoutput

def getLoc():
    yoga = getoutput('termux-location -p network -r last')
    if 'not found' in yoga:
        import ipgetter
        ip = ipgetter.myip()
        return geocoder.ip(ip)
    else:
        import json
        data = json.loads(yoga)
        return geocoder.osm([data['latitude'], data['longitude']], method='reverse')
