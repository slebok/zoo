#!/usr/local/bin/python

import sys
import urllib, urllib2, httplib, socket

def safelyLoadURL(url):
	print '(loading %s...)' % url
	errors = 0
	while errors<3:
		try:
			return urllib.urlopen(url).read()
		except IOError,e:
	 		print 'Warning: failed to load URL, retrying...'
	 		errors += 1
		except socket.error,e:
			print 'Warning: connection reset by peer, retrying...'
			errors += 1
	print 'Error fetching URL:',url
	return ''

def getauthors(s):
	auths = []
	for line in s.strip().split('\n'):
		if line.startswith('Authors'):
			auths.extend(line.replace('Authors :','').replace('Authors:','').replace(' and ',', ').strip().split(', '))
	return '\n'.join(['<author>%s</author>' % a for a in auths])

def dateback(s):
	for line in s.strip().split('\n'):
		if line.startswith('date'):
			return line.replace('date :','').strip()
	return ''

def descr(s):
	return s.strip().split('\n')[0].strip()
	# for line in s.strip().split('\n'):
	# 	if line.startswith('Description'):
	# 		return line.replace('Description :','').strip()
	# return ''

def cleanup(s):
	z = s.replace('<hr />','').replace('<p>','').replace('</p>','').replace('<b>','').replace('</b>','').replace('&nbsp;',' ').replace('<br />','')
	# if z.find('&lt;at&gt;')>-1:# or z.find('&lt;ATs&gt;')>-1:
	# 	z = z.split('(')[0].strip()
	sz = z.strip().split('\n')
	for i in range(0,len(sz)):
		if sz[i].find('&lt;at&gt;')>-1 or sz[i].find('&lt;ATs&gt;')>-1 or sz[i].find('&lt;AT&gt;')>-1 or sz[i].find('_at_')>-1:
			sz[i] = sz[i].split('(')[0].strip()
	return '\n'.join(sz)

links = []
f = open('Ecore.html','r')
lines = f.readlines()
for link in ''.join(lines).split('http://gforge.inria.fr/scm/viewvc.php/*checkout*/')[1:]:
	a = 'http://gforge.inria.fr/scm/viewvc.php/*checkout*/' + link.split('"')[0]
	if a.find('.ecore')>-1 and a not in links:
		links.append(a)
f.close()

hashes = []
readmes = []
descriptions = []
dates = []

cur = ''
for line in lines:
	if line.find('mw-headline')>-1:
		# <a name="ACG_1.0"></a><h3> <span class="mw-headline"> ACG 1.0 </span></h3>
		tag = line.split('"')[1]
		hashes.append(tag)
		if cur:
			readmes.append(cur)
		cur = line.split('mw-headline')[1][2:].split('<')[0].strip()
	elif line.find('<ul><li>')<0 and line.find('</li></ul>')<0:
		cur += line
if cur:
	readmes.append(cur)
# readmes = cleanup(readmes[1:])
readmes = [cleanup(readmes[i]) for i in range(1,len(readmes))]
descriptions = map(descr,readmes)
dates = map(dateback,readmes)
authors = map(getauthors, readmes)

# print descriptions


print len(links),len(hashes),len(readmes)
# # print(hashes)
# for r in readmes:
# 	print r
# 	print '---------------------'
# sys.exit(1)

# print links[:10]
for i in range(0,len(links)):
	link = links[i]
	name = link.split('.ecore')[0].split('/')[-1]
	# f = open('%s/%s.ecore' % (name,name), 'w')
	# f.write(safelyLoadURL(link))
	# f.close()
	# f = open('%s/Makefile' % name, 'w')
	# f.write('extract:\n\t${tooldir}/ecore2bgf %s.ecore grammar.bgf\n\ninclude ../../Makefile.grammar\n' % name)
	# f.close()
	# http://www.emn.fr/z-info/atlanmod/index.php/Ecore
	# f = open('%s/README.txt' % name, 'w')
	# f.write('Source: http://www.emn.fr/z-info/atlanmod/index.php/Ecore#%s\n\n' % name)
	# http://gforge.inria.fr/scm/viewvc.php/*checkout*/AtlantEcore/ACG.ecore?root=atlantic-zoos
	if (0):
		f.write('''http://www.emn.fr/z-info/atlanmod/index.php/Ecore#%s
 ->  %s

%s

Grammar in a broad sense extracted automatically on 8 April 2013 by Vadim Zaytsev, http://grammarware.net
''' % (hashes[i],link,readmes[i]))
	# f.close()
	# print ' -> ',descriptions[i]
	# print ' -> ',dates[i]
	# print 'Done:', name
	print '''<version>
		<name>%s</name>
		<grammar>
			<name>Extracted</name>
			<handle>metamodels/%s</handle>
			<source>
				%s
				<file>%s.ecore</file>
				<date>%s</date>
				<readme/>
				<link>
					<uri>http://www.emn.fr/z-info/atlanmod/index.php/Ecore</uri>
					<name>AtlantEcore Zoo</name>
				</link>
				<link>
					<mu>topics/metamodels/%s/%s.ecore</mu>
					<name>GitHub</name>
				</link>
			</source>
			<toolset ref="ecore2bgf"/>
		</grammar></version>''' % (descriptions[i], name, authors[i], name, dates[i], name, name)
	