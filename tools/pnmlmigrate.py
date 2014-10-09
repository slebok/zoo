#!/usr/local/bin/python3
# Migration of PNML schemata
import os.path

dirs = ['anyElement', 'pnmlcoremodel', 'conventions', 'ptnet', 'booleans', 'finiteenumerations', 'cyclicenumerations', 'finiteintranges', 'dots', 'multisets', 'partitions', 'lists', 'integers', 'strings', 'terms', 'arbitrarydeclarations', 'hlcorestructure', 'hlpng', 'symmetricnet', 'highlevelnet', 'ext-specialarcs', 'ext-reset', 'ext-inhibitor', 'ext-resetinhibitor', 'guyard-modular', 'guyard-simplified', 'guyard-basic', 'guyard-structured', 'touzet']

fetched = 0
extracted = 0
s = ''
for d in dirs:
	print (d)
	x = False
	try:
		f = open('%s/README.txt' % d, 'r')
	except IOError:
		print ('\tREADME: FAIL!')
		break
	print ('\tREADME: CHECK')
	date = ''
	dlink = ''
	lines = f.readlines()
	for line in lines:
		if line.find('(c)')>-1:
			date = line[3:].strip().split(' ')[0]
		elif line.find('date :')>-1:
			date = line.replace('date :','').strip()
		elif line.find('http://www.pnml.org/version-2009/grammar/')>-1 or line.find('http://www.pnml.org/version-2009/extensions/')>-1:
			dlink = line.replace('↳',' ').strip()
	f.close()
	if date=='':
		print('\tDATE: FAIL!')
		break
	else:
		print('\tDATE:',date)
	try:
		f = open('%s/zoo-backup.xml' % d, 'r')
	except IOError:
		print ('\tZOO: FAIL!')
		break
	print ('\tZOO: CHECK')
	lines = f.readlines()
	atl = rng = False
	src = False
	srclines = []
	for line in lines:
		if src:
			srclines.append(line)
			if line.find('<readme/>')>-1 or line.find('</source>')>-1:
				src = False
			continue
		if line.find('<src>')>-1:
			if line.find('Atlantic')>-1:
				atl = True
			elif line.find('PNML')>-1:
				rng = True
		if line.find('<source>')>-1:
			src = True
	if atl:
		print('\tSOURCE: ATLANTIC')
	elif rng:
		print('\tSOURCE: RELAX')
	else:
		print('\tSOURCE: UNKNOWN')
		break
	f.close()
	f = open('%s/zoo-backup.xml' % d, 'w')
	f.writelines(lines)
	f.close()
	f = open('%s/zoo.xml' % d, 'w')
	if atl:
		s = '''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>%s</name>
	<source>
%s
	</source>
	<readme/>
	<link>
		<uri>http://www.emn.fr/z-info/atlanmod/index.php/Ecore</uri>
		<name>Atlantic</name>
	</link>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>download</method>
		<format>XMI</format>
	</grammar>
	<grammar>
		<of>PNML</of>
		<dir>extracted</dir>
		<level>1</level>
		<method>automatic</method>
		<derivedFrom>fetched</derivedFrom>
		<!--  -->
		<toolused>ecore2bgf</toolused>
	</grammar>
</entry>''' % (d,''.join(srclines))
	if rng:
		s = '''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>%s</name>
	<source>
%s		<link>
			<uri>%s</uri>
			<name>Download</name>
		</link>
	</source>
	<readme/>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>download</method>
		<format>RELAXNG</format>
	</grammar>
	<grammar>
		<of>PNML</of>
		<dir>extracted</dir>
		<level>1</level>
		<method>automatic</method>
		<derivedFrom>fetched</derivedFrom>
		<!--  -->
		<toolused>rng2bgf</toolused>
	</grammar>
</entry>''' % (d,''.join(srclines),dlink)
	f.write(s)
	f.close()
