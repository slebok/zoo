#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys

dirs = [#'readable',
'v1.0-xsd',
'v10.0-xsd',
'v11.0-xsd',
'v11.1-xsd',
'v11.2-xsd',
'v12.0-xsd',
'v13.0-xsd',
'v13.1-xsd',
'v14.0-xsd',
'v15.0-xsd',
'v15.1-xsd',
'v16.0-xsd',
'v17.0-xsd',
'v18.0-xsd',
'v18.1-xsd',
'v19.0-xsd',
'v2.0-xsd',
'v2.1-xsd',
'v20.0-xsd',
'v20.1-xsd',
'v21.0-xsd',
'v21.1-xsd',
'v22.0-xsd',
'v23.0-xsd',
'v3.0-xsd',
'v4.0-xsd',
'v5.0-xsd',
'v6.0-xsd',
'v7.0-xsd',
'v7.1-xsd',
'v8.0-xsd',
'v8.1-xsd',
'v9.0-xsd',
'v9.1-xsd']

base = sys.argv[1]
m = open(base+'/Makefile','w')
for d in dirs:
	f = open(base+'/'+d+'/README.txt','r')
	for line in f.readlines():
		if line.find('http://github.com')>-1:
		# http://github.com/grammarware/slps/blob/5e90b6c0dc39d4a636344a034b0895e0d0ea036c/shared/xsd/lcf.xsd
			uri = 'http'+line.split('http')[1].strip()
		# This is version 10 of the LCF schema committed to SLPS.
		if line.find('version')>-1:
			ver = line.split('version')[1].strip().split(' ')[0]
	f.close()
	print d,'->',uri
	f = open(base+'/'+d+'/zoo.xml','w')
	f.write('''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>LDF %s</name>
	<source>
		<author>Vadim Zaytsev</author>
		<title>Software Language Processing Suite</title>
		<subtitle>LDF</subtitle>
		<specific>%s</specific>
		<file>shared/xsd/ldf.xsd</file>
		<date>2008–2011</date>
		<link>
			<uri>%s</uri>
			<name>Explore</name>
		</link>
	</source>
	<readme/>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>git</method>
		<format>XSD</format>
	</grammar>
	<grammar>
		<of>LCF</of>
		<dir>extracted</dir>
		<level>1</level>
		<method>semi-automatic</method>
		<derivedFrom>fetched</derivedFrom>
		<!--  -->
		<toolused>xsd2bgf</toolused>
	</grammar>
</entry>
''' % (d.split('-')[0],'Version '+ver,uri))
	f.close()
	m.write('	fe %s %s/%s.xsd\n' % (d,d,base))
m.close()