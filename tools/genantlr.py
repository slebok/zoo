#!/usr/bin/python

import os

# <a href="/grammar/1347528470063/MySQL.g"><b>mysql Parser</b></a><br>
# <b>wangmin</b> <i>Thu Sep 13, 2012 02:27</i><br>
# parse mysql, should has some errors in the grammer parser, if any pazzle, please reffrence  http://dev.mysql.com/doc/refman/5.6/en/index.html

# <a href="/grammar/1345144569663/AntlrUnicode.txt"><b>Unicode Character Classes</b></a><br>
# <b>Roger Jack</b> <i>Thu Aug 16, 2012 12:16</i><br>
# This file contains lexer fragments to support 16-bit Unicode Character Classes.

f = open('list.pre','r')
thing = []
state = 0 # first
for line in f.readlines():
	if state == 0:
		thing.append([])
		# name
		thing[-1].append(line.split('<b>')[-1].split('</b>')[0])
		# uri
		if line.find('"')<0:
			print 'QUOTE NOT FOUND in',line
			break
		thing[-1].append(line.split('"')[1])
		state = 1
		continue
	elif state == 1:
		# author
		thing[-1].append(line.split('<b>')[-1].split('</b>')[0])
		# date
		thing[-1].append(line.split('<i>')[-1].split('</i>')[0])
		# the rest
		thing[-1].append([])
		state = 2
		continue
	elif state == 2:
		if line.strip() == '':
			state = 0
			continue
		thing[-1][-1].append(line.strip())
f.close()

handles = []
dl = []
for t in thing:
	if len(t)!=5:
		print 'BAD THING:',t
		continue
	name,uri,author,date,lines = t
	if uri[0] == '/':
		uri = 'http://www.antlr3.org'+uri
	handle = uri.split('/')[-1]
	if handle == '':
		handle = uri.split('/')[-2]
	handle = handle.split('.')[0]
	while handle in handles:
		print 'CLASH on',handle
		handle = handle + '1'
	handles.append(handle)
	print 'DIRR = ',handle
	print 'NAME = ',name
	print 'LINK = ',uri
	print 'AUTH = ',author
	print 'DATE = ',date
	print 'TEXT = ',lines
	print
	os.mkdir('tst/'+handle)
	os.mkdir('tst/'+handle+'/fetched')
	filename = uri.split('/')[-1]
	if filename == '':
		filename = 'index.html'
	dl.append('\twget '+uri)
	dl.append('\tmv '+filename+' tst/'+handle+'/fetched/')
	zoo = open('tst/'+handle+'/zoo.xml','w')
	zoo.write('''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>%s</name>
	<source>
		<author>%s</author>
		<title>%s</title>
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
	</grammar>
</entry>''' % (handle,author,name,filename,date,uri))
	zoo.close()
	zoo = open('tst/'+handle+'/README.txt','w')
	zoo.write('''http://www.antlr3.org/grammar/list.html
	%s

%s
%s, %s

%s

Grammar in a broad sense fetched automatically on 23 September 2014 by Vadim Zaytsev, http://grammarware.net
''' % (uri,name,author,date,'\n'.join(lines)))
	zoo.close()
	zoo = open('tst/'+handle+'/Makefile','w')
	zoo.write('''extract:

fetch:
	wget %s
	mv %s fetched/
''' % (uri,filename))
	zoo.close()

print len(thing)

f = open('Makefile','w')
f.write('list.html:\n\twget http://www.antlr3.org/grammar/list.html\n\nall:\n'+'\n'.join(dl))
f.close()

# <?xml version="1.0" encoding="UTF-8"?>
# <entry>
# 	<name>Oracle Network Services</name>
# 	<source>
# 		<author>Nathaniel Harward</author>
# 		<title>ANTLRv3 grammar for Oracle Network Services configuration files</title>
# 		<file>OracleNetServicesV3.g</file>
# 		<date>2007</date>
# 		<link>
# 			<uri>http://www.harward.us/~nharward/antlr/OracleNetServicesV3.g</uri>
# 			<name>Download</name>
# 		</link>
# 	</source>
# 	<readme/>
# 	<grammar>
# 		<dir>fetched</dir>
# 		<level>0</level>
# 		<method>download</method>
# 	</grammar>
# </entry>
