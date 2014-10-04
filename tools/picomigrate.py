#!/usr/local/bin/python3
# Migration of all remaining metamodels
import os.path

dirs = ['v0.0', 'v0.1', 'v1.0.10', 'v1.0.11', 'v1.0.12', 'v1.0.13', 'v1.0.14', 'v1.0.15', 'v1.0.16', 'v1.0.17', 'v1.0.18', 'v1.0.19', 'v2.0.10', 'v2.0.11', 'v2.0.12', 'v2.0.5', 'v2.0.6', 'v2.0.7', 'v2.0.8', 'v2.0.9']

fetched = 0
extracted = 0
s = ''
for d in dirs:
	print (d)
	x = False
	try:
		f = open('%s/README.txt' % d, 'r')
	except IOError:
		print ('\tREADME: FAIL!')
		break
	print ('\tREADME: CHECK')
	lines  = f.readlines()
	f.close()
	link = ''
	for line in lines:
		if line.find('://')>0:
			link = line.replace('↳','').strip()
	if line=='':
		print('\tLINK: FAIL!')
		break
	fname = link.split('/')[-1]
	# f = open(d+'/fetched/'+,'r')
	years = []
	fs = 0
	for fn in os.listdir(d+'/fetched'):
		if os.path.isfile(d+'/fetched/'+fn):
			print('\tFOUND:',fn)
			f = open(d+'/fetched/'+fn,'r',encoding = "ISO-8859-1")
			fs += 1
			for line in f.readlines():
				for y in range(1995,2015):
					if line.find(str(y))>-1 and str(y) not in years:
						years.append(str(y))
			f.close()
	print('\tYEARS:',years)
	if len(years)==1:
		date = years[0]
	elif len(years)==2:
		date = years[0]+'–'+years[1]
	else:
		date = ', '.join(years)
	if fs == 1:
		lang = 'Scheme'
	else:
		lang = 'EBNF'
	f = open(d+'/zoo.xml','w')
	f.write('''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>%s</name>
	<source>
		<author>Theo D'Hondt</author>
		<author>Wolfgang De Meuter</author>
		<file>%s</file>
		<date>%s</date>
		<link>
			<uri>%s</uri>
			<name>Download</name>
		</link>
	</source>
	<readme/>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>download</method>
		<method>unzip</method>
		<format>%s</format>
	</grammar>
</entry>''' % (d,fname,date,link,lang))
	f.close()
	# # # # # # 
	continue
