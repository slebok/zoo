#!/usr/bin/python
# Instrumenting Python grammar fetching

import sys

dirs = ["v2.2", "v2.2.1", "v2.2.2", "v2.2.3", "v2.2p1", "v2.3", "v2.3.1", "v2.3.2", "v2.3.3", "v2.3.4", "v2.3.5", "v2.4", "v2.4.1", "v2.4.2", "v2.4.3", "v2.4.4", "v2.5", "v2.5.1", "v2.5.2", "v2.5.3", "v2.5.4", "v2.6", "v2.6.1", "v2.6.2", "v2.6.3", "v2.6.4", "v2.6.5", "v2.6.6", "v2.6.7", "v2.6.8", "v2.7", "v2.7.1", "v2.7.2", "v2.7.3", "v2.7.4", "v2.7.5", "v3.0", "v3.0.1", "v3.1", "v3.1.1", "v3.1.2", "v3.1.3", "v3.1.4", "v3.1.5", "v3.2", "v3.2.1", "v3.2.2", "v3.2.3", "v3.2.4", "v3.2.5", "v3.3.0", "v3.3.1", "v3.3.2"]

for d in dirs:
	m = open(d+'/Makefile','r')
	# extract:
	# 	echo TODO
	#
	# fetch:
	# 	wget http://docs.python.org/release/2.2.1/ref/grammar.txt
	# 	mv grammar.txt fetched/
	rls = m.readlines()
	m.close()
	assert rls[0].strip() == 'extract:'
	assert rls[1].strip() == 'echo TODO'
	assert rls[2].strip() == ''
	assert rls[3].strip() == 'fetch:'
	assert rls[4][:5].strip() == 'wget'
	src = rls[4][5:].strip()
	srcfile = src.split('/')[-1]
	wrds = rls[5].strip().split(' ')
	assert len(wrds)==3
	assert wrds[0] == 'mv'
	assert wrds[1] == srcfile
	assert wrds[2] == 'fetched/'
	assert len(rls)==6
	m = open(d+'/README.txt','r')
	# Python Documentation
	# Release 2.2.1
	# http://docs.python.org/release/2.2.1/
	rls = m.readlines()
	m.close()
	title = rls[0].strip()
	subtitle = rls[1].strip()
	url = rls[3].strip()
	ver = url.split('/')[-2]
	assert d == 'v'+ver
	print d
	date = ''
	try:
		m = open(d+'/fetched/grammar.html','r')
		for line in m.readlines():
			if line.find('Last updated')>-1:
				# print 'FOUND DATE!!!'
				date = line.replace('Last updated on','').replace('.','').strip()
		m.close()
	except IOError:
		print '\tNO OPEN HTML @',d+'/fetched/grammar.html'
	print '\tURL:',url
	print '\tVER:',ver
	print '\tSRC:',src
	print '\tTIT:',title
	print '\tSUB:',subtitle
	print '\tDAT:',date
	m = open(d+'/zoo.xml','w')
	m.write('''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>%s</name>
	<source>
		<author>Guido van Rossum</author>
		<title>%s</title>
		<subtitle>%s</subtitle>%s
		<link>
			<uri>%s</uri>
			<name>Grammar</name>
		</link>
	</source>
	<link>
		<uri>%s</uri>
		<name>Release</name>
	</link>
	<readme/>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>download</method>
	</grammar>
</entry>
''' % (d,title,subtitle,'\n\t\t<date>'+date+'</date>' if date != '' else '',src,url))
	m.close()
