#!/usr/bin/python

dirs = ['w3c-19990222',#'w3c-20000630',
'w3c-20010906','w3c-20011218', 'w3c-20020325','w3c-20021108','w3c-20030123','w3c-20030905','w3c-20031010', 'w3c-20031215','w3c-20040210']

for d in dirs:
	url = ''
	m = open(d+'/Makefile','r')
	for line in m.readlines():
		# wget http://www.w3.org/TR/1999/REC-rdf-syntax-19990222/
		if line.find('wget')>-1:
			url = line.replace('wget','').strip()
	m.close()
	title = ''
	m = open(d+'/index.html','r')
	for line in m.readlines():
		# <TITLE>Resource Description Framework (RDF) Model and Syntax Specification</TITLE>
		if line.find('TITLE')>-1:
			title = line.replace('<TITLE>','').replace('</TITLE>','').strip()
			break
		elif line.find('title')>-1:
			title = line.replace('<title>','').replace('</title>','').strip()
			break
	m.close()
	date = d.replace('w3c-','')
	m = open(d+'/zoo.xml','w')
	m.write('''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>W3C %s</name>
	<source>
		<standard>W3C</standard>
		<title>%s</title>
		<date>%s</date>
		<link>
			<uri>%s</uri>
			<name>Download</name>
		</link>
	</source>
	<!-- <readme/> -->
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>download</method>
	</grammar>
</entry>
''' % (date,title,date,url))
	m.close()
