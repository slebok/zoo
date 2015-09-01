#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, os

# .{ "(" { condition-prefix }<SUB>","</SUB>+ ")" ":" }* { label-prefix ":" }*.
def parsepar(s):
	i = 0
	while i<len(s):
		if s[i] == '{':
			(z,j) = parsepar(s[i:])
			


f = open(sys.argv[1],'r')
# g = open(sys.argv[2],'w')
lines = f.readlines()
i = 0
while i < len(lines):
	# <TD>=</TD>
	if lines[i].strip()=='<TD>=</TD>':
		print 'Found',lines[i-1].split('#use:')[1].split('>')[0],
		i += 1
		cx = 0
		lns = []
		while lines[i].strip()!='</TABLE>':
			line = lines[i].strip()
			line = line.replace('&#160;[&#160;',' ( ').replace('&#160;]&#160;',' )? ')
			while line.find('<SUB>')>-1:
				# .{ "(" { condition-prefix }<SUB>","</SUB>+ ")" ":" }* { label-prefix ":" }*.
				# ⦃⦄

			for tag in ('TR','TD','B'):
				line = line.replace('<%s>'%tag,'').replace('</%s>'%tag,'')
			if line != '':
				lns.append(line.replace('&#160;',' '))
				cx += 1
			i += 1
			if i > len(lines):
				break
		print '\t',cx,'lines'
		for l in lns:
			print '\t.%s.' % l
	i += 1
# g.write(s)
# g.close()
f.close()