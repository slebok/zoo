#!/usr/bin/python
# -*- coding: utf-8 -*-

import os.path

f = open('exts','r')
g = open('runthis','w')
for line in f.readlines():
	n = line.strip().replace('zoo//','')
	sf = 'zoo/%s/grammar.bgf' % n
	if not os.path.exists(sf):
		print sf, 'does not exist'
		continue
	tf = 'bulk/'+n.replace('§','').replace('/extracted','').replace('/','-')+'.bgf'
	g.write('cp %s %s\n' % (sf,tf))
f.close()
g.close()
