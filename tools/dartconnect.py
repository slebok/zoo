#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, os

base = 'v41.0'

f = open(base+'/connect.glue','r')
glue = f.read()
f.close()
for i in range(42,46):
	d = '%i' % i
	if i<10:
		d = "0"+d
	d = 'v%s.0' % d
	f = open(d+'/connect.glue','w')
	f.write(glue.replace(base,d))
	f.close()
	# f = open(d+'/zoo.xml','r')
	# zl = f.readlines()
	# zl.insert(-1,'''	<grammar>
	# 	<of>Dart</of>
	# 	<dir>connected</dir>
	# 	<level>2</level>
	# 	<method>semi-automatic</method>
	# 	<derivedFrom>extracted</derivedFrom>
	# 	<!--  -->
	# 	<toolused>grammarlab</toolused>
	# 	<fileused>connect.glue</fileused>
	# </grammar>\n''')
	# f.close()
	# f = open(d+'/zoo.xml','w')
	# f.writelines(zl)
	# f.close()
