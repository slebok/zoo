#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys

prevsubt = ''
minor = 1
for i in range(1,46):
	d = '%i' % i
	if i<10:
		d = "0"+d
	d = 'v%s.0' % d
	f = open(d+'/fetched/dartLangSpec.tex','r')
	t = subt = ''
	for line in f.readlines():
		if line.find('\\title{')>-1:
			t = line.split('{')[1].split('\\')[0].strip().replace('  ',' ')
		if line.find('Draft Version')>-1 or line.find('\\large Version')>-1:
			subt = line.replace('{','').replace('}','').replace('\\large','').strip().replace('  ',' ')
	if t:
		print '[%s] Title found:' % d,t
	else:
		print '[%s] Title not found.' % d
		sys.exit(1)
	if subt:
		print '[%s] Subtitle found:' % d,subt
	else:
		print '[%s] Subtitle not found.' % d
		sys.exit(1)
	if prevsubt == subt:
		minor += 1
		m = 'Minor'
	else:
		minor = 1
		m = 'Major'
	name = '%s, edit №%i' % (subt, minor)
	print '[%s] %s version increase to "%s"' % (d, m, name)
	f.close()
	f = open(d+'/zoo.xml','r')
	zl = f.readlines()
	f.close()
	f = open(d+'/zoo.xml','w')
	for line in zl:
		if line.find('<name>v')>-1:
			line = '\t<name>'+name+'</name>\n'
		f.write(line)
		if line.find('<author>')>-1:
			f.write('\t\t<title>%s</title>\n\t\t<subtitle>%s</subtitle>\n' % (t,subt))
	f.close()
	f = open(d+'/README.txt','r')
	zl = f.readlines()
	f.close()
	f = open(d+'/README.txt','w')
	for line in zl:
		if line.strip()=='...':
			f.write('%s\n%s\n%s\n'% (t,subt,name.replace(subt+',','').strip()))
		else:
			f.write(line)
	f.close()
	prevsubt = subt

'''
<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>v16.0</name>
	<source>
		<author>The Dart Team</author>
		<file>dartLangSpec.tex</file>
		<date>?</date>
		<link>
			<uri>https://github.com/dart-lang/bleeding_edge/blob/b4f8cd2c03a7f3637e062219cf265d67e8eb1ebe/dart/docs/language/dartLangSpec.tex</uri>
			<name>Explore</name>
		</link>
	</source>
	<readme/>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>git</method>
		<format>LaTeX</format>
	</grammar>
</entry>
'''