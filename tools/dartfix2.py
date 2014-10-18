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
	f = open(d+'/zoo.xml','r')
	zl = f.readlines()
	f.close()
	f = open(d+'/zoo.xml','w')
	for line in zl:
		f.write(line)
		if line.find('</grammar>')>-1:
			f.write('''<grammar>
		<of>Dart</of>
		<dir>extracted</dir>
		<level>1</level>
		<method>automatic</method>
		<derivedFrom>fetched</derivedFrom>
		<!--  -->
		<toolused>dartextract.py</toolused>
		<toolused>grammarlab</toolused>
		<fuleused>recovered.glue</fuleused>
		<fuleused>extract.glue</fuleused>
	</grammar>
''')
	f.close()
	f = open(d+'/Makefile','r')
	zl = f.readlines()
	f.close()
	f = open(d+'/Makefile','w')
	for line in zl:
		f.write(line)
		if line.strip()=='extract:':
			f.write('\t../dartextract.py fetched/dartLangSpec.tex extract.glue\n')
	f.close()
	f = open(d+'/README.txt','r')
	zl = f.readlines()
	f.close()
	f = open(d+'/README.txt','w')
	for line in zl:
		if line.find('Vadim Zaytsev')>-1:
			f.write('Grammar in a broad sense fetched automatically and extracted in October 2014 by Vadim Zaytsev, http://grammarware.net\n')
		else:
			f.write(line)
	f.close()
