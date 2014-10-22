#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, os

trans1=(
	('\\~{}','¬'),
	('\\_','_'),
	('{\\bf',''),
	('`','"'),
	('\'','"'),
	('\\texttt{"""}','TDQUOTE'),
	('\\code{"}','DQUOTE'),
	('$\\backslash$ ','\\'),
	('$\\backslash$','\\'),
	('\\$','$'),
	('\\#','#'),
	('\\&','&'),
	('\\gt ','>'),
	('\\gt','>'),
	('\\lt ','<'),
	('\\lt','<'),
	('(,','(","'),
	('\\^{}','^'),
)
trans2=(
	(':}',' ::= '),
	('{}',''),
	('\\{','{'),
	('\\}','}'),
	('"DQUOTE"','DQUOTE'),
	('"TDQUOTE"','TDQUOTE'),
	('"DQUOTEDQUOTEDQUOTE"','TDQUOTE'),
	('"\\texttt{"}"','DQUOTE'),
	('$|$','|'),
	('$||$','||'),
	('{"\\escapegrammar .}"','"."'),
	('\\escapegrammar{";"}','";"'),
	('"a".."z"','"a"|"b"|"c"|"d"|"e"|"f"|"g"|"h"|"i"|"j"|"k"|"l"|"m"|"n"|"o"|"p"|"q"|"r"|"s"|"t"|"u"|"v"|"w"|"x"|"y"|"z"'),
	('"A".."Z"','"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"'),
	('"a".."f"','"a"|"b"|"c"|"d"|"e"|"f"'),
	('"A".."F"','"A"|"B"|"C"|"D"|"E"|"F"'),
	('"0".."9"','"0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"'),
	('\\n','"\\n"'),
	('\\r','"\\r"'),
	('""\\n""','"\\n"'),
	('""\\r""','"\\r"'),
	('\\%','%'),
	('"¬','"~'),
	(' [',' ('),
	('] ',')? '),
	(']* ',')* '),
)

d = os.getcwd().split('/')[-1]
f = open(sys.argv[1],'r')
g = open(sys.argv[2],'w')
yes = False
lines = []
for line in f.readlines():
	if line.find('\\begin{grammar}')>-1:
		yes = True
		line = line.replace('\\begin{grammar}','').split('%')[0].strip()
		if line:
			print 'SMTH AFTER BEGIN'
		else:
			continue
	elif line.find('\\end{grammar}')>-1:
		yes = False
		if not lines[-1].strip().endswith('.'):
			print 'NOT ENDS WITH DOT'
			lines.append('.\n')
		continue
	if yes:
		for p in trans1:
			line = line.replace(p[0],p[1])
		if line.find('%')>-1 and line.find('\\%')<0:
			line = line.split('%')[0]
		while line.find('{}')>-1 and line.find('\\')>-1:
			# before = line.split('\\')[0]
			before = '\\'.join(line.split('{}')[0].split('\\')[:-1])
			# middle = line.split('\\')[1].split('{}')[0]
			middle = line.split('{}')[0].split('\\')[-1]
			after = '{}'.join(line.split('{}')[1:])
			line = before + ' "' + middle.lower() + '" ' + after
		# metadata finalConstVarOrType?  "this"  "{\escapegrammar .}" identifier 
		while line.find('{\\escapegrammar')>-1:
			before = line.split('{\\escapegrammar')[0].rstrip()
			middle = line.split('{\\escapegrammar')[1].split('}')[0].strip()
			after = '}'.join('{\\escapegrammar'.join(line.split('{\\escapegrammar')[1:]).split('}')[1:]).lstrip()
			# print 'LINE-A <%s>' % line.rstrip()
			line = before + middle + after
			# print 'LINE-B <%s>' % line.rstrip()
			# print 'BEFORE <%s>' % before
			# print 'MIDDLE <%s>' % middle
			# print 'AFTERR <%s>' % after.rstrip()
			# print '-'*20
		for p in trans2:
			line = line.replace(p[0],p[1])
		if line.strip() != '':
			if line.strip()!= '.' and line.strip().endswith('.'):
				print 'ENDS WITH DOT!'
				lines.append(line.strip()[:-1]+'\n')
				lines.append('.\n')
			else:
				lines.append(line)
f.close()
i = 0
while lines[i].strip()!='.':
	i += 1
lines = lines[i+3:]
for i in range(0,len(lines)-1):
	if lines[i].strip().endswith('::='):
		continue
	if lines[i].strip().endswith('\\\\'):
		lines[i] = lines[i].replace('\\\\','')
		continue
	if lines[i].strip()=='.':
		continue
	if lines[i+1].strip()!='.':
		tmp = lines[i].strip()
		if tmp[-1] == ';':
			tmp = tmp[:-1]
		lines[i] = tmp + '\n\t\t|'
# the writing style became sloppier from version 1.6.8 (e5526f14814ecd948bd33b1589221f8b02c4378c)
for i in range(0,len(lines)):
	done = lines[i].find('\\')<0
	while not done:
		before = lines[i].split('\\')[0]
		after = '\\'.join(lines[i].split('\\')[1:])
		middle = ''
		while ord(after[0])<=ord('Z') and ord(after[0])>=ord('A'):
			middle += after[0]
			after = after[1:]
		if middle!='':
			print 'FIX REMAINING BACKSLASH'
			lines[i] = before + (' "%s" ' % middle.lower()) + after
			done = lines[i].find('\\')<0
		else:
			done = True
g.write('importG\n')
# g.writelines(lines)
prevline = '!'
s = ''
for line in lines:
	line2 = line.strip()
	if line2=='.':
		if prevline.strip().endswith(';'):
			s = s.rstrip()[:-1] + ' | ε '
		s += ';\n'
	elif line2.endswith('.'):
		s += line2[:-1]+' ;\n'
	else:
		s += '\t'+line2
	prevline = line
s += '.\nexport BGF |home:///projects/webzoo-prep/zoo/dart/latex/%s/extracted/grammar.bgf|.\n' % d
g.write(s)
g.close()

