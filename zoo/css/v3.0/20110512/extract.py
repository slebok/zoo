#!/usr/bin/python

import sys

# read
table = []
f = open(sys.argv[1],'r')
done = False
for line in f.readlines()[444:]:
	if line.find('</table>')>-1:
		break
	if line.find('<tr>')>-1:
		table.append([])
		done = False
		continue
	if done:
		continue
	if line.find('<th')>-1 or line.find('<td>')>-1:
		if len(table[-1])==2:
			done = True
		table[-1].append(' '+line.strip())
	elif len(table)>0 and len(table[-1])>0:
		table[-1][-1] += line.strip()
f.close()

# curate
ntable = []
for e in table:
	if len(e)<1:
		continue
	c = e[:]
	for i in range(0,len(c)):
		if c[i].find('<code')>-1:
			c[i] = c[i].replace('<code>','').replace('<code class=property>','').replace('<codeclass=property>','').replace('</code>','')
		if c[i].find('<td>')>-1:
			c[i] = c[i].replace('<td>','')
		if c[i].find('<th')>-1:
			c[i] = c[i].replace('<th scope=row>','')
		if c[i].find('</a>')>-1:
			c[i] = c[i].replace('</a>','')
		# cx = 0
		while c[i].find('<a')>-1 and c[i].find('>')>-1:
			# if cx > 5: break
			print 'DO',c[i]
			c[i] = c[i][:c[i].index('<a')]+ ' ' + c[i][c[i].index('>')+1:]
			# cx += 1
		c[i] = c[i].replace('&lsquo;','&lt;').replace('&rsquo;','&gt;')
		c[i] = c[i].strip()
	ntable.append(c)
table = ntable

# report
print '--------------------------------------------------'
for e in table:
	print '----------\n-->\t',
	print '\n-->\t '.join(e)
print '--------------------------------------------------'

for e in table:
	alts = []
	for a in e[1].replace('[',' [ ').replace(']',' ] ').replace('  ',' ').split('|'):
		if a.find('&lt;')>-1:
			x = a.replace('&lt;','').replace('&gt;','').strip()
			if x.endswith('{1,4}'):
				x = x.replace('{1,4}','').strip()
				if x.startswith('[') and x.endswith(']'):
					x = x[1:-1].strip()
				alts.append(x+' '+x+' '+x+' '+x)
			alts.append(x)
		elif a.strip() == '':
			continue
		elif a.strip().endswith(']'):
			alts.append('"'+a.strip()[:-1].strip()+'" ]')
		else:
			alts.append('"'+a.strip()+'"')
	for n in e[0].split(' '):
		print n,'::=', ' | '.join(alts), ';'
