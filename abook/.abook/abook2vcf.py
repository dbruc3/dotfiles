#! /usr/bin/env python
import hashlib, shutil, os
from subprocess import getoutput

def write_vcard(vcard, outdir, filename, checksum, updates):
    if not vcard:
        return
    #clean up address
    vcard['ADR'] = ';'.join(vcard['ADR'])
    if not vcard['ADR'].strip(';'):
        del vcard['ADR']

    #write temp file
    m = hashlib.md5()
    hashkeys = []
    tmpfile = '/tmp/{}'.format(filename)
    with open(tmpfile, 'w') as w:
        w.write('BEGIN:VCARD\nVERSION:3.0\n')
        for k,v in vcard.items():
            if k != 'N':
                hashkeys.append(str.encode(v))
            w.write('{}:{}\n'.format(k,v))
        w.write('END:VCARD')
    [m.update(hk) for hk in sorted(hashkeys)]

    #copy temp file if new or changed
    if not checksum:
        action = 'Creating'
    elif m.hexdigest() != checksum:
        action = 'Updating'
    else:
        return #no change
    msg = '{} {}'.format(action, vcard['FN'])
    updates.append(msg)
    print(msg)
    shutil.copyfile(tmpfile, '{}/{}'.format(outdir, filename))

def convert_phone(num):
    return '1\xa0(' + num.replace('-', ')\xa0', 1)

def add_email(vcard, emails):
    emails = emails.split(',')
    vcard['EMAIL;TYPE=INTERNET,HOME,pref'] = emails[0]
    count = 0
    for email in emails[1:]:
        vcard['EMAIL;TYPE=INTERNET,ALT{}'.format(count)] = email
        count += 1

def abook2vcf(path, outdir):
    updates = []
    filenames = []
    with open(path, 'r') as f:
        vcard = filename = checksum = None
        for line in f: #write previous vcard and initialize new vcard
            if line.startswith('[') and 'format' not in line:
                write_vcard(vcard, outdir, filename, checksum, updates)
                vcard = {'ADR':['','','','','','','']}
                filename = checksum = None
                continue

            parts = line.split('=')
            if not vcard or len(parts) < 2:
                continue

            k = parts[0].strip()
            v = parts[1].strip()

            if k == 'custom5':
                filename = os.path.basename(v)
                filenames.append(filename)
            elif k == 'custom4':
                checksum = v
            elif k == 'name':
                vcard['FN'] = v
                vcard['N'] = v
                parts = v.split(' ')
                if len(parts) > 1:
                    vcard['N'] = '{};{};;;'.format(parts[-1], ' '.join(parts[:-1]))
            elif k == 'email':
                add_email(vcard, v)
            elif k == 'address':
                vcard['ADR'][2] = v + vcard['ADR'][2] 
            elif k == 'address2':
                vcard['ADR'][2] += '\\n{}'.format(v)
            elif k == 'city':
                vcard['ADR'][3] = v
            elif k == 'state':
                vcard['ADR'][4] = v
            elif k == 'zip':
                vcard['ADR'][5] = v
            elif k == 'country':
                vcard['ADR'][6] = v
            elif k == 'phone':
                vcard['TEL;TYPE=HOME,VOICE'] = convert_phone(v)
            elif k == 'workphone':
                vcard['TEL;TYPE=WORK,VOICE'] = convert_phone(v)
            elif k == 'fax':
                vcard['TEL;TYPE=FAX,VOICE'] = convert_phone(v)
            elif k == 'mobile':
                vcard['TEL;TYPE=CELL,VOICE'] = convert_phone(v)
            elif k == 'url':
                vcard['URL'] = v
            elif k == 'anniversary':
                vcard['BDAY;VALUE=date'] = '1604{}'.format(v[1:])
            elif k == 'notes':
                notes = v.split('::')
                vcard['NOTE'] = notes[0]
                for note in notes[1:]:
                    item = note.split(':')
                    vcard[item[0]] = ':'.join(item[1:])

        #write the last card
        write_vcard(vcard, outdir, filename, checksum, updates)
    
    #check for deleted cards
    for f in [f for f in os.listdir(outdir) if f.endswith('.vcf')]:
        if f not in filenames:
            msg = 'Deleting contact {}'.format(f)
            print(msg)
            updates.append(msg)
            os.remove('{}/{}'.format(outdir,f))
    
    #sync files if changes occured
    if updates:
        if len(updates) > 1:
            msg = 'Multiple contacts updated.'
        else:
            msg = updates[0]
        cmd = 'cd {} && git add * && git commit -a -m "{}" && git push'.format(outdir, msg)
        print('Syncing git repository...')
        getoutput(cmd)
#MAIN
import sys
abook2vcf(sys.argv[1], sys.argv[2])
