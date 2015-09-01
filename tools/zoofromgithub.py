#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, os, os.path
import urllib, urllib2, httplib, socket

def tagify(txt,tag):
	return '\n\t\t<%s>%s</%s>' % (tag,txt,tag)

def safelyLoadURL(url):
	print '[RUSH] Loading %s...' % url
	errors = 0
	while errors<3:
		try:
			return urllib.urlopen(url).read()
		except IOError,e:
	 		print '[WARN] Failed to load URL, retrying...'
	 		errors += 1
		except socket.error,e:
			print '[WARN] Connection reset by peer, retrying...'
			errors += 1
	print '[FAIL] Error fetching URL:',url
	return ''

def saveToFile(content,filename):
	f = open(filename,'w')
	f.write(content)
	f.close()

if __name__ == "__main__":
	# cf. https://github.com/BNFC/bnfc/blob/master/examples/Alfa/Alfa.cf
	if len(sys.argv)==1:
		print '[STOP] Give me something'
		sys.exit(1)
	if sys.argv[1].startswith('https://') or sys.argv[1].startswith('http://'):
		slashed = sys.argv[1].split('/')
		if slashed[0] == 'http:':
			print '[INFO] Unsecure connection.'
		else:
			print '[INFO] Secure connection.'
		if slashed[1] != '':
			print '[STOP] Invalid URI'
			sys.exit(2)
		if slashed[2] != 'github.com':
			print '[STOP] Not a GitHub URI'
			sys.exit(3)
		user = slashed[3]
		proj = slashed[4]
		fyle = slashed[-1]
		branch = slashed[6]
		path = '/'.join(slashed[7:])
		print '[INFO] GitHub user:',user
		print '[INFO] Their project:',proj
		print '[INFO] Project branch:',branch
		print '[INFO] Path within the project:',path
		print '[INFO] Filename:',fyle
		# https://github.com/BNFC/bnfc/commits/master/examples/Alfa/Alfa.cf
		page = 1
		commits = []
		done = False
		while not done:
			history = safelyLoadURL('https://github.com/%s/%s/commits/%s/%s?page=%i' % (user,proj,branch,path,page))
			done = True
			# saveToFile(history,'history.tmp')
			s = 0
			for line in history.split('\n'):
				if s == 1:
					commits.append(line.split('"')[1].split('/commit/')[-1])
					print '[YES!] Found commit', commits[-1]
					s = 0
					continue
				if line.find('commit-title')>-1:
					s = 1
				if line.find('<div class="pagination">')>-1:
					done = False
			page += 1
		print '[INFO] Total of', len(commits), 'commits found.'
		ver = 0
		commits.reverse()
		names = {}
		for commit in commits:
			ver += 1
			os.mkdir('v%i.0' % ver)
			os.mkdir('v%i.0/fetched' % ver)
			explore = 'https://github.com/%s/%s/blob/%s/%s' % (user,proj,commit,path)
			dl = 'https://raw.githubusercontent.com/%s/%s/%s/%s' % (user,proj,commit,path)
			datpage = safelyLoadURL(explore)
			# saveToFile(datpage,'possiblydie.tmp')
			try:
				author = datpage.split('rel="contributor">')[1].split('<')[0]
			except IndexError:
				author = ''
			try:
				time = datpage.split('<time datetime="')[1].split('"')[0]
			except IndexError:
				time = ''
			print '[INFO] v%i.0 by %s on %s' % (ver,author,time)
			if author:
				if author not in names.keys():
					prof = safelyLoadURL('https://github.com/'+author)
					if prof.find('<title>%s</title>' % author)>-1:
						rname = author
						print '[WARN] This author has no name'
					else:
						rname = prof.split('<title>%s (' % author)[1].split(')')[0]
						print '[INFO] %s goes by the name of %s' % (author,rname)
					names[author] = rname
				author = tagify(names[author],'author')
			else:
				author = tagify('The Dart Team','author')
			if time:
				time = tagify(time,'date')
			else:
				time = tagify('?','date')
			zoo = '''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>v%i.0</name>
	<source>%s
		<file>%s</file>%s
		<link>
			<uri>%s</uri>
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
''' % (ver,author,fyle,time,explore)
			make = 'extract:\n\nfetch:\n\tcurl %s > fetched/%s\n' % (dl,fyle)
			readme = 'http://github.com/%s/%s\n\thttps://github.com/%s/%s/blob/%s/%s\n\n...\n\nGrammar in a broad sense fetched automatically by Vadim Zaytsev, http://grammarware.net' % (user,proj,user,proj,commit,path)
			saveToFile(safelyLoadURL(dl),'v%i.0/fetched/%s' % (ver,fyle))
			saveToFile(make,'v%i.0/Makefile' % (ver))
			saveToFile(zoo,'v%i.0/zoo.xml' % (ver))
			saveToFile(readme,'v%i.0/README.txt' % (ver))
	print '[STOP] All Ok'




