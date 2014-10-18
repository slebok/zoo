#!/usr/bin/python
# -*- coding: utf-8 -*-

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
		if line.startswith('<grammar>'):
			line = '\t' + line
		if line.find('fuleused')>-1:
			if line.find('recovered')>-1:
				continue
			else:
				f.write(line.replace('fuleused','fileused'))
		else:
			f.write(line)
	f.close()
