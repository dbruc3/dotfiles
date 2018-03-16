#!/usr/bin/python

import sys
import forecastio
import datetime
import geocoder
import loc

if len(sys.argv) > 1:
	loc = " ".join(sys.argv[1:])
	geo = geocoder.google(loc)
else:
	geo = loc.getLoc()

if not geo.ok:
	print ("Couldn't find location.")
	quit()

header = '========= Forecast for {}, {} =========='
print(header.format(geo.city, geo.state))

key="df74ca2b28b972e0782399de41a31256"

forecast = forecastio.load_forecast(key, 
				    geo.latlng[0], 
				    geo.latlng[1],
				    units='us')

temp = int(forecast.currently().temperature)
d = forecast.daily()
now = datetime.datetime.now().day

for df in d.data:
	date = u'\033[1mTODAY: {}\N{DEGREE SIGN}'.format(temp)
	if (now != df.time.day):
		date = df.time.strftime('%a %b %d')	
	high = int(df.temperatureMax)
	low = int(df.temperatureMin)
	fmt = u'{}   {}\N{DEGREE SIGN}-{}\N{DEGREE SIGN}   {}\033[0m'
	print(fmt.format(date, high, low, df.summary))
