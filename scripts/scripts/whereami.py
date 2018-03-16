#! /usr/bin/env python
import loc

lo = loc.getLoc()

if not lo.ok:
    quit()

if lo.country == 'US':
    region = lo.state
else:
    region = lo.country

#5 decimals places gives up to 1.1m accuracy
print('{}, {} ({:.5f},{:.5f})'.format(lo.city, region, lo.lat, lo.lng))
