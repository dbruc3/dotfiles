#! /usr/bin/env python
import os, hashlib
from subprocess import getoutput
ignore = ['BEGIN', 'VERSION', 'END', 'N', 'PRODID', 'REV']

def convert_phone(num):
    return num.replace('1\xa0(', '').replace(')\xa0','-')

def vcf2abook(path):
    abook = {'notes':'::', 'email':'', 'custom5':path}
    hashkeys = []
    with open(path, 'r') as f:
        for line in f:
            parts = line.split(':')
            k = parts[0].strip()
            v = parts[1].strip()

            if k in ignore:
                continue

            if k.startswith('BDAY'):
                abook['anniversary'] = '--{}'.format(v[-5:])
            elif k.startswith('EMAIL'):
                abook['email'] += v + ','
            elif k == 'FN':
                abook['name'] = v
            elif k == 'NOTE':
                abook['notes'] = v + abook['notes']
            elif k == 'ADR':  #must be before HOME phone
                addr = v.split(';')
                number = addr[2]
                numparts = number.split('\\')
                if len(numparts) > 1:
                    number = numparts[0]
                    abook['address2'] = numparts[1][1:]
                abook['address'] = number
                abook['city'] = addr[3]
                abook['state'] = addr[4]
                abook['zip'] = addr[5]
                abook['country'] = addr[6]
            elif 'HOME' in k:
                abook['phone'] = convert_phone(v)
            elif 'CELL' in k:
                abook['mobile'] = convert_phone(v)
            elif 'WORK' in k:
                abook['workphone'] = convert_phone(v)
            elif 'FAX' in k:
                abook['fax'] = convert_phone(v)
            elif 'URL;' in k:
                abook['url'] = v
            elif not k.startswith('item'):
                abook['notes'] += line.strip() + '::'
            else:
                continue
            hashkeys.append(str.encode(v))

    #checksum for contact
    m = hashlib.md5()
    [m.update(hk) for hk in sorted(hashkeys)]
    abook['custom4'] = m.hexdigest()
   
    #clean-up
    abook['notes'] = abook['notes'].strip('::')
    abook['email'] = abook['email'].strip(',')
    return abook

#MAIN
import sys
vcfdir = os.path.abspath(sys.argv[1])
output = os.path.abspath(sys.argv[2])
#cmd = 'cd {} && git pull'.format(vcfdir)
#getoutput(cmd)

with open (output, 'w') as w:
    count = 0
    w.write('[format]\nprogram=abook\nversion=0.6.1\n\n\n')
    for f in [f for f in os.listdir(vcfdir) if f.endswith('.vcf')]:
        abook = vcf2abook('{}/{}'.format(vcfdir, f))
        w.write('[{}]\n'.format(count))
        for k,v in [(k,v) for (k,v) in abook.items() if v]:
            w.write('{}={}\n'.format(k,v))
        count += 1

