#!/usr/bin/python

import sys
import forecastio
import datetime
import geocoder
import loc
from termcolor import colored

if len(sys.argv) > 1:
	lo = " ".join(sys.argv[1:])
	geo = geocoder.google(lo)
else:
	geo = loc.getLoc()

if not geo.ok:
	print("Couldn't find location.")
	quit()

key="df74ca2b28b972e0782399de41a31256"

forecast = forecastio.load_forecast(key, geo.latlng[0], geo.latlng[1])

alerts = forecast.alerts()
for a in alerts:
	print(colored(a.description.split('\n',1)[0], 'red'))

c = forecast.currently()
h = forecast.hourly()
d = forecast.daily()

temp = int(c.temperature)
now = c.summary
high = int(d.data[0].temperatureMax)
low = int(d.data[0].temperatureMin)
day = h.summary

first = 'In {}, {}: {}\N{DEGREE SIGN} {}\t{}\N{DEGREE SIGN}-{}\N{DEGREE SIGN}'
print(first.format(geo.city, geo.state, temp, now, high, low))
print(day)

start,summ = '',''
now = datetime.datetime.now().day

#for hd in h.data:
#	if (hd.time.day == now):
#		if (summ != hd.summary):
#			if (summ != ''):
#				print '{}-{}:{}   '.format(start, hd.time.hour, summ),
#			start= hd.time.hour
#			summ = hd.summary
#print '{}-{}:{}'.format(start, 23, summ)
