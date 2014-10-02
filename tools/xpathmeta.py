#!/usr/bin/python
# XPath grammars metadata creation

import sys

tpl = '''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>W3C-19990709</name>
	<source>
		<organisation>W3C</organisation>
		<title>XML Path Language (XPath)</title>
		<subtitle>Version 1.0, W3C Working Draft</subtitle>
		<date>19990709</date>
		<file>WD-xpath-19990709.xml</file>
		<link>
			<uri>http://www.w3.org/1999/07/WD-xpath-19990709/</uri>
			<name>Source</name>
		</link>
	</source>
	<readme/>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>download</method>
	</grammar>
</entry>
'''

extxml = '''
	<grammar>
		<of>XPath</of>
		<dir>extracted</dir>
		<level>1</level>
		<derivedFrom>fetched</derivedFrom>
		<method>automatic</method>
		<toolused>spec2bgf</toolused>
		<toolused>xbgf</toolused>
	</grammar>'''

dirs = ["w3c-19990709", "w3c-19990813", "w3c-19991008", "w3c-19991116", "w3c-20030502", "w3c-20030822", "w3c-20031112", "w3c-20040723", "w3c-20050211", "w3c-20050404", "w3c-20050915", "w3c-20051103", "w3c-20060608", "w3c-20061121", "w3c-20070123", "w3c-20090421", "w3c-20101214"]
ext = ["w3c-19991116"]

for d in dirs:
	m = open(d+'/Makefile','r')
	# curl -k http://www.w3.org/1999/07/WD-xpath-19990709.xml > fetched/WD-xpath-19990709.xml
	for line in m.readlines():
		if line.find('curl')>-1:
			src = line.split(' -k ')[1].split(' > ')[0]
	srcfile = src.split('/')[-1]
	m.close()
	r = open(d+'/README.txt','r')
	rlines = r.readlines()
	r.close()
	name = rlines[0].strip()
	subtitle = rlines[1].strip()
	srcurl = 'NO'
	for line in rlines:
		if line.find('http://')>-1:
			srcurl = line.strip()
			break
	if srcfile != '':
		ts = srcfile.split('-')[-1].split('.')[0]
	else:
		ts = srcurl.split('-')[-1].split('/')[0]
	if subtitle.find('Draft')<0 and subtitle.find('Recommendation')<0:
		if srcurl.find('WD-')>-1:
			subtitle += ', Working Draft'
		elif srcurl.find('CR-')>-1:
			subtitle += ', Candidate Recommendation'
		elif srcurl.find('PER-')>-1:
			subtitle += ',  Proposed Edited Recommendation'
		elif srcurl.find('PR-')>-1:
			subtitle += ',  Proposed Recommendation'
	if srcfile == '':
		srcfile = 'index.html'
	if len(ts)!=8:
		ts2 = srcurl.split('-')[-1]
		if len(ts2) ==8:
			print 'Time fixed as',ts2
			ts = ts2
		else:
			print 'Unknown time:',ts,'from',srcurl
			sys.exit()
	# 20060608
	year = ts[0:4]
	mon = ts[4:6]
	day = ts[6:8]
	if day[0] == '0':
		day = day[1]
	if mon == '01':
		mon = 'January'
	elif mon == '02':
		mon = 'February'
	elif mon == '03':
		mon = 'March'
	elif mon == '04':
		mon = 'April'
	elif mon == '05':
		mon = 'May'
	elif mon == '06':
		mon = 'June'
	elif mon == '07':
		mon = 'July'
	elif mon == '08':
		mon = 'August'
	elif mon == '09':
		mon = 'September'
	elif mon == '10':
		mon = 'October'
	elif mon == '11':
		mon = 'November'
	elif mon == '12':
		mon = 'December'
	ts = '%s %s %s' % (day,mon,year)
	print 'DIR',d
	print '\tSURC:',src
	print '\tTIME:',ts
	print '\tFILE:',srcfile
	print '\tNAME:',name
	print '\tSUBT:',subtitle
	print '\tURL:',srcurl
	xml = open(d+'/zoo.xml','w')
	xml.write('''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>%s</name>
	<source>
		<author>W3C</author>
		<title>%s</title>
		<subtitle>%s</subtitle>
		<date>%s</date>
		%s
		<link>
			<uri>%s</uri>
			<name>Source</name>
		</link>
	</source>
	<readme/>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>download</method>
	</grammar>%s
</entry>
''' % (d.upper(),name,subtitle,ts,'<file>'+srcfile+'</file>' if file!= "" else "",srcurl,extxml if d in ext else ""))
	xml.close()
