#!/Library/Frameworks/Python.framework/Versions/3.1/bin/python3
# -*- coding: utf-8 -*-
import os, sys
import xml.etree.ElementTree as ET
sys.path.append(os.getcwd().split('slps')[0]+'slps/shared/python')
import BGF3
from functools import reduce

debug = False

config = {}
masked = {}
always_terminals = []
always_nonterminals = []

special = \
	[
		'DEFINING-SYMBOL',
		'DEFINITION-SEPARATOR-SYMBOL',
		'START-TERMINAL-SYMBOL',
		'END-TERMINAL-SYMBOL',
		'START-GROUP-SYMBOL',
		'END-GROUP-SYMBOL',
		'START-OPTION-SYMBOL',
		'END-OPTION-SYMBOL',
		'START-STAR-SYMBOL',
		'END-STAR-SYMBOL',
		'START-PLUS-SYMBOL',
		'END-PLUS-SYMBOL',
		'START-SEPLIST-STAR-SYMBOL',
		'END-SEPLIST-STAR-SYMBOL',
		'START-SEPLIST-PLUS-SYMBOL',
		'END-SEPLIST-PLUS-SYMBOL',
		'POSTFIX-REPETITION-STAR-SYMBOL',
		'POSTFIX-REPETITION-PLUS-SYMBOL',
		'UNDEFINED-NONTERMINALS-ARE-TERMINALS',
		'NONTERMINAL-IF-CONTAINS',
		'NONTERMINAL-IF-UPPERCASE',
		'TERMINAL-IF-UPPERCASE',
		'IGNORE-EXTRA-NEWLINES',
		'GLUE-NONALPHANUMERIC-TERMINALS'
	]

def isAlpha(x):
	return reduce(lambda a,b:a and b=='_' or b.isalnum(),x,True)

def isQNumber(x):
	if x =='.':
		return False
	else:
		return reduce(lambda a,b:a and b=='.' or b.isdigit(),x,True)

def removeComments(ts,s,e):
	while s in ts:
		i = ts.index(s)
		# special case
		if i>1 and 'start-terminal-symbol' in config.keys() and ts[i-1:i+2]==[config['start-terminal-symbol'],s,config['end-terminal-symbol']]:
			print('STEP 0: adjusted for the comment starting symbol being used as a terminal.')
			nts = ts[:i-1]
			nts.append(ts[i-1]+ts[i]+ts[i+1])
			nts.extend(ts[i+2:])
			ts = nts
			continue
		j = endOfContext(ts,i,e)
		if j<0:
			print('STEP 0 error: mismatched comment delimiters.')
			j = i
		nts = ts[:i]
		nts.extend(ts[j:])
		#print('<<<',ts)
		ts = nts
		#print('>>>',ts)
	return ts
	
def splitTokenStream(s):
	ts = [s[0]]
	i = 1
	alpha = isAlpha(s[0])
	while (i<len(s)):
		if alpha:
			if isAlpha(s[i]):
				ts[-1] += s[i]
			else:
				alpha = False
				ts.append(s[i])
		else:
			ts.append(s[i])
			alpha = isAlpha(s[i])
		i += 1
	return list(filter(lambda x:x not in [' ',' ','	'],ts))
	# not space, not hard space, not tab; newlines are preserved for now

def reconsiderSpaces(ts,sep,vs):
	nts = [ts[0]]
	vs = list(vs)
	vs.append('\n')
	for x in ts[1:]:
		if x == '\n' and 'ignore-extra-newlines' in config.keys():
			continue
		if x == sep:
			nts.append('')
		elif nts[-1] in vs or x in vs:
			if nts[-1]=='':
				nts[-1] = x
			else:
				nts.append(x)
		else:
			nts[-1] += ' ' + x
	return nts

def readConfig(f):
	global debug
	cfg = ET.parse(f)
	for e in cfg.findall('*'):
		if e.tag == 'mask':
			masked[e.findtext('token')] = e.findtext('terminal')
		elif e.text:
			config[e.tag] = e.text.replace('\\n','\n')
		else:
			config[e.tag] = ''
		if e.tag=='nonterminal-if-camelcase':
			for x in e.findall('except'):
				always_terminals.append(x.text)
		if e.tag=='undefined-nonterminals-are-terminals':
			for x in e.findall('except'):
				always_nonterminals.append(x.text)
		if e.tag=='decompose-symbols':
			for x in e.findall('except'):
				always_terminals.append(x.text)
	if debug:
		print('Ok',config)

# Use defining symbol to distinguish productions
def useDefiningSymbol(ts,d):
	poss = []
	prods = []
	for i in range(0,len(ts)):
		if ts[i] == d and isAlpha(ts[i-1]):
			poss.append(i)
	poss.append(len(ts)+1)
	for i in range(0,len(poss)-1):
		if 'end-label-symbol' in config.keys():
			if ts[poss[i]-2] == config['end-label-symbol']:
				if 'start-label-symbol' in config.keys():
					# todo: now works only with one-token labels!
					if ts[poss[i]-4] == config['start-label-symbol']:
						# everything is fine
						p = [ts[poss[i]-3],ts[poss[i]-1]]
					else:
						print('STEP 4 problem: start-label-symbol mismatch!')
						# todo: recover
				else:
					# no starting symbol for the label
					p = [ts[poss[i]-3],ts[poss[i]-1]]
			else:
				# no label this time
				p = ['',ts[poss[i]-1]]
		else:
			# no labels at all
			p = ['',ts[poss[i]-1]]
		end = poss[i+1]-1
		if 'end-label-symbol' in config.keys() and ts[end-1] == config['end-label-symbol']:
			end -= 2
			if 'start-label-symbol' in config.keys() and ts[end-1] == config['start-label-symbol']:
				end -= 1
		p.extend(ts[poss[i]+1:end])
		prods.append(p)
	return prods

def useDefinitionSeparatorSymbol(ts,d):
	poss = [-1]
	alts = []
	levels = [0,0,0]
	for i in range(0,len(ts)):
		if 'start-group-symbol' in config.keys() and ts[i]==config['start-group-symbol']:
			levels[0] += 1
		if 'end-group-symbol' in config.keys() and ts[i]==config['end-group-symbol']:
			levels[0] -= 1
		if 'start-repeat-symbol' in config.keys() and ts[i]==config['start-repeat-symbol']:
			levels[1] += 1
		if 'end-repeat-symbol' in config.keys() and ts[i]==config['end-repeat-symbol']:
			levels[1] -= 1
		if 'start-option-symbol' in config.keys() and ts[i]==config['start-option-symbol']:
			levels[2] += 1
		if 'end-option-symbol' in config.keys() and ts[i]==config['end-option-symbol']:
			levels[2] -= 1
		if ts[i] == d:
			if levels == [0,0,0]:
				poss.append(i)
			else:
				ts[i] = 'DEFINITION-SEPARATOR-SYMBOL'
	poss.append(len(ts)+1)
	for i in range(0,len(poss)-1):
		alts.append(ts[poss[i]+1:poss[i+1]])
	return alts

def findMostProbableTail(ps):
	# bucket sort
	ss = {}
	for s in map(lambda x:x[-1],ps):
		if s not in ss.keys():
			ss[s] = 1
		else:
			ss[s] += 1
	# at least 80% has the same end symbol?
	# TODO: describe the heuristic
	vs = list(ss.values())
	m = max(vs)
	vs.remove(m)
	m2 = max(vs)
	#print('m=',m,'m2=',m2,'len(ps)=',len(ps))
	if m < max(0.25*len(ps),2*m2):
		possibles = []
		for i in ss.keys():
			if ss[i]>1:
				possibles.append((i,ss[i]))
		print('Candidates were:',possibles,'with total',len(ps))
		return None,None,None
	for k in ss.keys():
		if ss[k] == m:
			break
	n2f = []
	fps = []
	cx = 0
	for p in ps:
		if p[-1] == k:
			fps.append(p)
		else:
			n2f.append(cx)
		cx += 1
	return n2f,findCommonTail(fps),100*m/len(ps)

def findCommonTail(ps):
	tail = []
	for i in range(1,len(ps[0])):
		if [x[-i] for x in ps] == [ps[0][-i]]*len(ps):
			tail.append(ps[0][-i])
		else:
			break
	tail.reverse()
	return tail

def assembleBracketedSymbols(ts,start,end):
	tss = []
	terminal = False
	i = 0
	while (i<len(ts)):
		if terminal:
			tss[-1] += ts[i]
			if ts[i] == end:
				terminal = False
		else:
			tss.append(ts[i])
			if ts[i] == start:
				terminal = True
		i += 1
	return tss

def findGroups(ats,start,end):
	global debug
	poss = [[],[]]
	i = j = level = 0
	lp = {}
	for i in range(0,len(ats)):
		for j in range(0,len(ats[i])):
			if ats[i][j] == start:
				poss[0].append((i,j))
				poss[1].append(None)
				lp[level] = len(poss[0])-1
				level += 1
			if ats[i][j] == end:
				level -= 1
				poss[1][lp.pop(level)] = (i,j)
	if len(poss[0]) != len(poss[1]):
		print('STEP 7 deadlock: number of start-group-symbol and end-group-symbol occurrences do not match.')
		return ats
	if debug and poss[0]:
		print('poss >>>>>',poss)
		print('ats >>>>>>',ats)
	for i in range(0,len(poss[0])):
		if poss[0][i][0] == poss[1][i][0]:
			# same alternative
			tmp = ats[poss[0][i][0]][:poss[0][i][1]]
			tmp.append([ats[poss[0][i][0]][poss[0][i][1]:poss[1][i][1]][1:]])
			tmp.extend(ats[poss[0][i][0]][poss[1][i][1]+1:])
			ats[poss[0][i][0]] = tmp
			#print '-->',tmp
		else:
			newats = []
			for j in range(0,len(ats)):
				if j<poss[0][i][0]:
					newats.append(ats[j])
				elif j>poss[1][i][0]:
					newats.append(ats[j])
				elif j==poss[0][i][0]:
					before = ats[j][:poss[0][i][1]]
					tmp = [ats[j][poss[0][i][1]+1:]]
				elif j==poss[1][i][0]:
					tmp.append(ats[j][:poss[1][i][1]])
					before.append(tmp)
					before.extend(ats[j][poss[1][i][1]+1:])
					newats.append(before)
				else:
					tmp.append(ats[j])
			ats = newats
			#print '--> not implemented yet'
	if len(ats) == 1 and len(ats[0]) == 1 and type(ats[0][0]) == type([]):
		ats = ats[0][0]
	return ats

def findSpecialGroups(ats,start,end):
	global debug
	poss = [[],[]]
	i = j = level = 0
	lp = {}
	for i in range(0,len(ats)):
		for j in range(0,len(ats[i])):
			if ats[i][j] == start:
				poss[0].append((i,j))
				poss[1].append(None)
				lp[level] = len(poss[0])-1
				level += 1
			if ats[i][j] == end:
				level -= 1
				poss[1][lp.pop(level)] = (i,j)
	if len(poss[0]) != len(poss[1]):
		print('STEP 7 deadlock: number of start-?-symbol and end-?-symbol occurrences do not match.')
		return ats
	if debug and poss[0]:
		print('poss >>>>>',poss)
		print('ats >>>>>>',ats)
	for i in range(0,len(poss[0])):
		if poss[0][i][0] != poss[1][i][0]:
			newats = []
			for j in range(0,len(ats)):
				if j<poss[0][i][0]:
					newats.append(ats[j])
				elif j>poss[1][i][0]:
					newats.append(ats[j])
				elif j==poss[0][i][0]:
					before = ats[j][:poss[0][i][1]+1]
					tmp = [ats[j][poss[0][i][1]+1:]]
				elif j==poss[1][i][0]:
					tmp.append(ats[j][:poss[1][i][1]])
					before.append(tmp)
					before.extend(ats[j][poss[1][i][1]:])
					newats.append(before)
				else:
					tmp.append(ats[j])
			ats = newats
	if len(ats) == 1 and len(ats[0]) == 1 and type(ats[0][0]) == type([]):
		ats = ats[0][0]
	return ats

def mapsymbols(ts,symbol,special):
	for i in range(0,len(ts)):
		if ts[i] == symbol:
			ts[i] = special
		elif type(ts[i]) == type([]):
			ts[i] = mapsymbols(ts[i],symbol,special)
	return ts

def endOfContext(a,i,e):
	s = a[i]
	level = 1
	j = i+1
	#print('Searching in a context of',a[i:],'for',e)
	while level>0 and j<len(a):
		if a[j]==s:
			level += 1
		elif a[j]==e:
			level -= 1
		j += 1
	if level != 0:
		#print('Cannot find end of context in:',a[i:],'@',level)
		return -level
	return j

def startOfContext(a,i,s):
	e = a[i]
	level = 1
	j = i-1
	#print('Searching in a context of',a[i:],'for',e)
	while level>0 and j>=0:
		if a[j]==s:
			level += 1
		elif a[j]==e:
			level -= 1
		j -= 1
	if level != 0:
		#print('Cannot find end of context in:',a[i:],'@',level)
		return -level
	return j

def map2expr(ss):
	global debug
	ess = []
	es = []
	i = 0
	while i<len(ss):
		if ss[i] == 'START-STAR-SYMBOL':
			j = endOfContext(ss,i,'END-STAR-SYMBOL')
			if j<0:
				print('Unbalanced bracketing, please fix first. Level:',-j)
				j = len(ss)
			if debug:
				print('>>>context>>>',ss[i:j])
			e = BGF3.Star()
			e.setExpr(map2expr(ss[i+1:j-1]))
			es.append(e)
			i = j
		elif ss[i] == 'START-PLUS-SYMBOL':
			j = endOfContext(ss,i,'END-PLUS-SYMBOL')
			if j<0:
				print('Unbalanced bracketing, please fix first. Level:',-j)
				j = len(ss)
			if debug:
				print('>>>context>>>',ss[i:j])
			e = BGF3.Plus()
			e.setExpr(map2expr(ss[i+1:j-1]))
			es.append(e)
			i = j
		elif ss[i] == 'START-OPTION-SYMBOL':
			j = endOfContext(ss,i,'END-OPTION-SYMBOL')
			if j<0:
				print('Unbalanced bracketing, please fix first. Level:',-j)
				j = len(ss)
			if debug:
				print('>>>context>>>',ss[i:j])
			e = BGF3.Optional()
			e.setExpr(map2expr(ss[i+1:j-1]))
			es.append(e)
			i = j
		elif ss[i] == 'START-SEPLIST-STAR-SYMBOL':
			j = endOfContext(ss,i,'END-SEPLIST-STAR-SYMBOL')
			if j<0:
				print('Unbalanced bracketing, please fix first. Level:',-j)
				j = len(ss)
			if j-i != 4:
				print('Incorrect separator list!')
			if debug:
				print('>>>context>>>',ss[i:j])
			# {x y}* => (x (yx)*)?
			e = BGF3.Sequence()
			x = map2expr([ss[i+1]])
			y = map2expr([ss[i+2]])
			e.add(x)
			e2 = BGF3.Sequence()
			e2.add(y)
			e2.add(x)
			s = BGF3.Star()
			s.setExpr(BGF3.Expression(e2))
			e.add(BGF3.Expression(s))
			e2 = BGF3.Optional()
			e2.setExpr(e)
			es.append(e2)
			i = j
		elif ss[i] == 'START-SEPLIST-PLUS-SYMBOL':
			j = endOfContext(ss,i,'END-SEPLIST-PLUS-SYMBOL')
			if j<0:
				print('Unbalanced bracketing, please fix first.')
				j = len(ss)
			if j-i != 4:
				print('Incorrect separator list!')
			if debug:
				print('>>>context>>>',ss[i:j])
			# {x y}+ => (x (yx)*)
			e = BGF3.Sequence()
			x = map2expr([ss[i+1]])
			y = map2expr([ss[i+2]])
			e.add(x)
			e2 = BGF3.Sequence()
			e2.add(y)
			e2.add(x)
			s = BGF3.Star()
			s.setExpr(BGF3.Expression(e2))
			e.add(BGF3.Expression(s))
			es.append(e)
			i = j
		elif ss[i] == 'START-GROUP-SYMBOL':
			j = endOfContext(ss,i,'END-GROUP-SYMBOL')
			if j<0:
				print('Unbalanced bracketing, please fix first.')
				j = len(ss)
			if i == 0 and j == len(ss):
				ss = ss[1:-1]
				continue
			if debug:
				print('>>>context>>>',ss[i:j])
			es.append(map2expr(ss[i+1:j-1]))
			i = j
		elif ss[i] == 'DEFINITION-SEPARATOR-SYMBOL':
			if debug:
				print('It is a bar! It is a choice!')
			ess.append(es)
			es = []
			i += 1
		elif ss[i][0] == config['start-terminal-symbol']:
			if debug:
				print('TERMINAL',ss[i][1:-1])
			e = BGF3.Terminal()
			if ss[i][1:-1] == '':
				print('Serialisation error: empty terminal, replaced with ""!')
				e.setName('""')
			else:
				e.setName(ss[i][1:-1])
			es.append(e)
			i += 1
		else:
			if debug:
				print('NONTERMINAL',ss[i])
			e = BGF3.Nonterminal()
			e.setName(ss[i])
			es.append(e)
			i += 1
	ess.append(es)
	if len(ess) == 0:
		print('Serialisation error: empty output sequence!')
		return
	elif len(ess) == 1:
		if len(ess[0]) == 0:
			print('Serialisation error: empty internal output sequence!')
			return BGF3.Expression(BGF3.Epsilon())
		elif len(ess[0]) == 1:
			return BGF3.Expression(ess[0][0])
		else:
			e = BGF3.Sequence()
			for x in ess[0]:
				e.add(BGF3.Expression(x))
			return BGF3.Expression(e)
	else:
		e = BGF3.Choice()
		for es in ess:
			if len(es) == 0:
				print('Serialisation error: empty internal output sequence!')
				return BGF3.Expression(BGF3.Epsilon())
			elif len(es) == 1:
				e.add(BGF3.Expression(es[0]))
			else:
				ee = BGF3.Sequence()
				for x in es:
					ee.add(BGF3.Expression(x))
				e.add(BGF3.Expression(ee))
		return BGF3.Expression(e)
	print('Dead code reached!')
	return

def mapglue(b,s):
	a = b[:]
	i = 0
	while i < len(a):
		if a[i][0] != s[0]:
			# first char mismatch
			i += 1
			continue
		combined = a[i]
		j = i+1
		while j<len(a) and len(combined)<len(s):
			combined += a[j]
			j += 1
		if combined == s:
			# success
			b = a[:i]
			b.append(''.join(a[i:j]))
			b.extend(a[j:])
			#i = j
			i += 1
			a = b
		else:
			# fail
			i += 1
	return a

def filterNewlines(s):
	i = 0
	while i<len(s):
		if type(s[i])==type([]):
			s[i] = filterNewlines(s[i])
			i += 1
		elif s[i]=='\n':
			z = s[:i]
			z.extend(s[i+1:])
			s = z
		else:
			i += 1
	return s

def glueTerminals(p):
	q = []
	for y in p[2:]:
		if y[0] != config['start-terminal-symbol'] or len(q) == 0 or q[-1][0] != config['start-terminal-symbol']:
			q.append(y)
			continue
		x = y[1:-1]
		if len(q)>0 and not isAlpha(q[-1][1:-1]) and not isAlpha(x):
			# addition on terminals
			q[-1] = q[-1][:-1] + y[1:]
		else:
			q.append(y)
	r = p[:2]
	r.extend(q)
	if debug and p != r:
		print('>>>in>>>>',p)
		print('>>>out>>>',r)
	return r

def assembleQualifiedNumbers(ts):
	ds = []
	for x in ts:
		if len(ds)>0 and (isQNumber(x) or x=='.') and isQNumber(ds[-1]):
			ds[-1] += x
		else:
			ds.append(x)
	return ds

def splitString(s,kw):
	# split s according to any kws while preserving them
	if len(kw)==0:
		return [s]
	elif s.find(kw[0])<0:
		return splitString(s,kw[1:])
	else:
		ss = s.split(kw[0])
		done = []
		for x in ss:
			done.append(x)
			done.append(kw[0])
		done.pop()
		if done[-1]=='':
			done.pop()
		if done[0] =='':
			done = done[1:]
		res = []
		for a in done:
			res.extend(splitString(a,kw[1:]))
		reject = False
		if min(map(len,res))<2:
			reject = True
		if 'nonterminal-if-contains' in config.keys():
			for y in res:
				if y in kw or y.find(config['nonterminal-if-contains']) < 0:
					continue
				else:
					reject = True
					#print('!!!!! Have to reject',res,'of',s)
		if reject:
			return splitString(s,kw[1:])
		else:
			return res

def decomposeSymbols(p,defd):
	# [label, nt, ...]
	q = p[:2]
	for x in p[2:]:
		match = False
		# expanded for better readability
		if x in defd:
			# defined nonterminal
			q.append(x)
			continue
		if x in always_terminals:
			# configured exception
			q.append(x)
			continue
		if x[0] == config['start-terminal-symbol'] and x[-1] == config['end-terminal-symbol']:
			# terminal
			q.append(x)
			continue
		#if 'nonterminal-if-contains' in config.keys() and x.find(config['nonterminal-if-contains']) > -1:
		#	# we have a way of telling nonterminals from terminals, and this is not it
		#	q.append(x)
		#	continue
		# none of the above: it is a nonterminal, it's not defined and we have no way to dismiss it
		var = splitString(x,defd)
		if len(var)==1:
			q.append(x)
			continue
		#print(x,'-->',var)
		pos = True
		for y in var:
			if y in defd or ('nonterminal-if-contains' in config.keys() and y.find(config['nonterminal-if-contains']) < 0):
				continue
			else:
				pos = False
		if pos:
			print('STEP 7:',x,'matches as',var)
			q.extend(var)
			# todo: need to be adjusted if the order of phases is changed
			#q.append(config['start-terminal-symbol']+t+config['end-terminal-symbol'])
			match = True
			continue
		if not match:
			q.append(x)
	return q

def convert2terminal(x,defd):
	# unfolded for better readability
	if x =='' or x=='\n':
		# probably an error, let's not deal with it here
		return x
	if x in defd:
		# defined nonterminal
		return x
	if x in special:
		# pseudo-meta-symbol
		return x
	if x in always_nonterminals:
		# configured exception
		return x
	if 'nonterminal-if-contains' in config.keys() and x.find(config['nonterminal-if-contains'])>-1:
		# undefined nonterminal, but banned by configuration from being converted to a terminal
		return x
	if 'nonterminal-if-uppercase' in config.keys() and len(x)>1 and x.isupper():
		# configuration claims that LONGUPPERCASE is a nonterminal
		return x
	if 'nonterminal-if-camelcase' in config.keys() and len(x)>1 and x[0].isupper() and x[1:].isalpha() and x not in always_terminals:
		# configuration claims that CamelCase is a nonterminal
		return x
	if x[0] == config['start-terminal-symbol'] and x[-1] == config['end-terminal-symbol']:
		# already a terminal
		return x
	# none of the above
	return config['start-terminal-symbol']+x+config['end-terminal-symbol']

def balanceProd(p):
	i = 2
	while i<len(p):
		if p[i].find('START')<0:
			i += 1
			continue
		j = endOfContext(p,i,p[i].replace('START','END'))
		if j<0:
			# endeavour 1: maybe there is another metasymbol with the same concrete representation?
			amb = []
			for k in config.keys():
				if config[k] == config[p[i].lower()] and k != p[i].lower():
					amb.append(k.upper())
			oldpi = p[i]
			fail = False
			for a in amb:
				p[i] = a
				j = endOfContext(p,i,p[i].replace('START','END'))
				if j>0:
					break
				else:
					fail = True
			if fail:
				print('Cannot balance a production :-(')
				i += 1
			else:
				print('STEP 6: Rebalanced ambiguity of',oldpi,'with',p[i])
				i = j
		else:
			i = j
	return p

def postfix2confix(p):
	for s in ('POSTFIX-REPETITION-PLUS-SYMBOL','POSTFIX-REPETITION-STAR-SYMBOL'):
		while s in p:
			w = p.index(s)
			if w == 0:
				print('STEP 6: Impossible place for postfix operator, converted to a terminal.')
				p[w] = config['start-terminal-symbol']+p[w]+config['end-terminal-symbol']
				continue
			if 'end-group-symbol' in config.keys() and p[w-1] == config['end-group-symbol']:
				# group
				j = startOfContext(p,w-1,config['start-group-symbol'])
				if j<0:
					print('STEP 6: Impossible to balance the group preceding a postfix operator, converted it to a terminal')
					p[w] = config['start-terminal-symbol']+p[w]+config['end-terminal-symbol']
					continue
				else:
					print('STEP 6: Converted postfix repetition to confix notation.')
					p[w-1] = s.replace('POSTFIX-REPETITION','END')
					p[j] = s.replace('POSTFIX-REPETITION','START')
					q = p[:w]
					q.extend(p[w+1:])
					p = q
			else:
				# single element
				print('STEP 6: Converted postfix repetition to confix notation.')
				q = p[:w-1]
				q.append(s.replace('POSTFIX-REPETITION','START'))
				q.append(p[w-1])
				q.append(s.replace('POSTFIX-REPETITION','END'))
				q.extend(p[w+1:])
				p = q
	return p

def useTerminatorToFixProds(ps,ts):
	# TODO: will not work with labels
	nps = []
	for p in ps:
		while ts in p:
			i = p.index(ts)
			nps.append(p[:i])
			np = [nps[-1][0]]
			if config['defining-symbol'] not in p[i+1:]:
				tail = p[i+1:]
				if 'ignore-extra-newlines' in config.keys():
					while '\n' in tail:
						tail.remove('\n')
				if len(tail)>0:
					print('STEP 4 problem: terminator symbol without proper defining symbol context.',tail)
					return nps
				else:
					p = tail
					continue
			else:
				nt = p[i+1:p.index(config['defining-symbol'])]
				if 'ignore-extra-newlines' in config.keys():
					while '\n' in nt:
						nt.remove('\n')
				if len(nt) != 1:
					print('STEP 4 problem: cannot determine nonterminal name from',nt)
					nt = ' '.join(nt)
				else:
					nt = nt[0]
				np.append(nt)
			np.extend(p[p.index(config['defining-symbol'])+1:])
			#print('<<<p<<<',p)
			p = np
			#print('>>>p>>>',p)
	return nps

if __name__ == "__main__":
	if len(sys.argv) != 4:
		print('Usage:')
		print('	extract.py input.txt config.edd output.bgf')
		sys.exit(-1)
	#f = open('src.grammar.txt','r')
	f = open(sys.argv[1],'r')
	readConfig(sys.argv[2])
	# STEP 0: read the file, remove whitespace (?)
	print('STEP 0: reading the file, removing whitespace and comments.')
	tokens = splitTokenStream(f.read())
	f.close()
	if 'start-comment-symbol' in config.keys() and 'end-comment-symbol' in config.keys():
		# remove comments
		# assumption: comments are never nested!
		tokens = removeComments(mapglue(mapglue(tokens,config['start-comment-symbol']),config['end-comment-symbol']),config['start-comment-symbol'],config['end-comment-symbol'])
	if debug:
		print(tokens)
	# STEP 1: assemble terminal symbols
	print('STEP 1: assembling terminal symbols according to start-terminal-symbol and end-terminal-symbol.')
	for k in masked.keys():
		if len(k)>1:
			print('STEP 1: going to glue tokens that resemble masked terminal', k.replace('\n','\\n'))
			tokens = mapglue(tokens,k)
	if 'start-terminal-symbol' in config.keys() and 'end-terminal-symbol' in config.keys():
		tokens = [config['start-terminal-symbol']+masked[x]+config['end-terminal-symbol'] if x in masked.keys() else x for x in tokens]
		tokens = assembleBracketedSymbols(tokens,config['start-terminal-symbol'],config['end-terminal-symbol'])
	else:
		print('STEP 1 skipped, sorry: start-terminal-symbol and end-terminal-symbol are not both specified.')
		# technically we still need them to denote terminals in our internal representation
		config['start-terminal-symbol'] = config['end-terminal-symbol'] = '"'
		tokens = [config['start-terminal-symbol']+masked[x]+config['end-terminal-symbol'] if x in masked.keys() else x for x in tokens]
	if 'terminal-if-uppercase' in config.keys():
		print('STEP 1: All uppercase tokens are considered terminals.')
		tokens = [config['start-terminal-symbol']+x+config['end-terminal-symbol'] if len(x)>1 and x[0]!=config['start-terminal-symbol'] and x.isupper() else x for x in tokens]
	tokens = [config['start-terminal-symbol']+x+config['end-terminal-symbol'] if x==config['start-terminal-symbol']+config['end-terminal-symbol'] or x==config['start-terminal-symbol'] else x for x in tokens]
	if debug:
		print(tokens)
	# STEP 2: assemble nonterminal symbols
	print('STEP 2: assembling nonterminal symbols according to start-nonterminal-symbol and end-nonterminal-symbol.')
	if 'start-nonterminal-symbol' in config.keys() and 'end-nonterminal-symbol' in config.keys():
		tokens = assembleBracketedSymbols(tokens,config['start-nonterminal-symbol'],config['end-nonterminal-symbol'])
	else:
		print('STEP 2 skipped, sorry: start-nonterminal-symbol and end-nonterminal-symbol are not both specified.')
	# STEP 3: assembling composite metasymbols together
	print('STEP 3: assembling metasymbols according to their possible values.')
	tokens = assembleQualifiedNumbers(tokens)
	for k in config.keys():
		if len(config[k])>1:
			print('STEP 3: going to glue tokens that resemble metasymbol', config[k].replace('\n','\\n'))
			tokens = mapglue(tokens,config[k])
	if debug:
		print(tokens)
	# STEP 4: slice according to defining-symbol
	print('STEP 4: splitting the token stream into productions.')
	if 'nonterminals-may-contain-spaces' in config.keys() and 'concatenate-symbol' in config.keys():
		# can only treat them together, because spaces in names without concatenation symbol are highly ambiguous
		# and concatenation symbols are never used if nonterminal names do not have spaces
		tokens = reconsiderSpaces(tokens,config['concatenate-symbol'],config.values())
	if 'defining-symbol' in config.keys():
		prods = useDefiningSymbol(tokens,config['defining-symbol'])
	else:
		print('STEP 4 skipped, sorry: defining-symbol is not specified.')
		# TODO
	# STEP 4a.1: [sanity check] Infer terminator-symbol
	if debug:
		print('The grammar is perceived like this:')
		for p in prods:
			print('\t',p[1],'is defined as',p[2:])
	print('STEP 4: inferring terminator-symbol by looking at the productions.')
	if 'terminator-symbol' in config.keys():
		# we do have the terminator, but suppose we also had definition symbol!
		# TODO otherwise
		ts = findCommonTail(prods[:-1])
		if ts:
			need2fix = [-1]
			prob = 100
		else:
			(need2fix,ts,prob) = findMostProbableTail(prods)
		if ''.join(ts) == config['terminator-symbol']:
			print('STEP 4 confirmed terminator-symbol, congratulations!')
		else:
			print('STEP 4 would have thought that terminator-symbol is',ts,'and not',config['terminator-symbol'])
		# now let's fix productions that were joined together
		prods = useTerminatorToFixProds(prods,config['terminator-symbol'])
	else:
		ts = findCommonTail(prods[:-1])
		if ts:
			print('STEP 4 successful: inferred terminator-symbol:',ts)
			config['terminator-symbol'] = ts
			need2fix = [-1]
		else:
			(need2fix,ts,prob) = findMostProbableTail(prods)
			if ts:
				print('STEP 4 successful: inferred the most probable terminator-symbol:',repr(ts[0]),',','%i'%prob+'% sure')
				config['terminator-symbol'] = ts[0]
			else:
				# ORLY?
				print('STEP 4 unsuccessful, sorry.')
				for p in prods:
					print('%40s'%p[1],'>>>>>>',p[-2:])
	# STEP 4a.2: adjusting the terminator-symbol on the unfit productions
	poststep4 = 0
	if debug:
		print('The grammar is perceived like this:')
		for p in prods:
			print('\t',p[1],'is defined as',p[2:])
	
	for f in need2fix:
		for i in range(0,len(config['terminator-symbol'])):
			if prods[f][-len(config['terminator-symbol'])+i:] == config['terminator-symbol'][:len(config['terminator-symbol'])-i]:
				prods[f] = prods[f][:-len(config['terminator-symbol'])+i]
				prods[f].extend(config['terminator-symbol'])
				poststep4 += 1
				break
		if ''.join(prods[f][-len(config['terminator-symbol'])-1:-1]) == config['terminator-symbol'] and prods[f][-1] == '\n':
			prods[f].pop()
			poststep4 += 1
	if poststep4 > 0:
		print('STEP 4 also adjusted',poststep4,'productions that did not quite fit the expectations.')
	if debug:
		print('The grammar is perceived like this:')
		for p in prods:
			print('\t',p[1],'is defined as',p[2:])
	# STEP 4b: splitting the token stream into productions according to terminator-symbol; inferring defining-symbol
	# TODO
	prods = [p[:-(len(config['terminator-symbol']))] if p[-(len(config['terminator-symbol'])):] == config['terminator-symbol'] else p for p in prods]
	# STEP 5: slice insides according to definition-separator-symbol
	step5 = False
	for s in ('definition-separator-symbol','postfix-repetition-star-symbol','postfix-repetition-plus-symbol','start-group-symbol','end-group-symbol','start-star-symbol','end-star-symbol','start-plus-symbol','end-plus-symbol','start-seplist-star-symbol','end-seplist-star-symbol','start-seplist-plus-symbol','end-seplist-plus-symbol','start-option-symbol','end-option-symbol'):
		if s in config.keys():
			print('STEP 5: marking',s+'.')
			step5 = True
			prods = [[s.upper() if x==config[s] else x for x in p] for p in prods]
			#prods = list(map(lambda p:list(map(lambda x:s.upper() if x==config[s] else x,p)),prods))
	if not step5:
		print('STEP 5 skipped: sorry, no metasymbols specified.')
	# STEP 6: validating metasymbols
	prods = list(map(postfix2confix,prods))
	prods = list(map(balanceProd,prods))
	# STEP 7: various commands
	print('STEP 7: executing special extraction commands.')
	step7 = False
	defined = [x[1] for x in prods]
	if debug:
		print('Defined are',defined)
	defined.append(config['defining-symbol'])
	if 'ignore-extra-newlines' in config.keys():
		print('STEP 7: ignoring extra newlines.')
		step7 = True
		prods = [list(filter(lambda y:y!='\n',p)) for p in prods]
		#prods = list(map(lambda x:filter(lambda y:y!='\n',x),prods))
	if 'decompose-symbols' in config.keys():
		print('STEP 7 (part of rule 4): decomposing compound symbols.')
		step7 = True
		prods = [decomposeSymbols(x,defined) for x in prods]
	if 'undefined-nonterminals-are-terminals' in config.keys():
		print('STEP 7 (rule 5): turning undefined nonterminals into terminals.')
		step7 = True
		prods = [[convert2terminal(x,defined) for x in p] for p in prods]
	#for p in prods:
	#	print(p[1],'is defined as',p[2:])
	if 'glue-nonalphanumeric-terminals' in config.keys():
		print('STEP 7 (part of rule 3): glueing non-alphanumeric terminal symbols together.')
		step7 = True
		prods = list(map(glueTerminals,prods))
	if not step7:
		print('STEP 7 skipped, sorry: no special commands found in the configuration.')
	# STEP X: validating bracketing?
	# ...
	# RESULT
	if 'nonterminals-may-contain-spaces' in config.keys():
		#
		prods = [[x.replace(' ','_') for x in p] for p in prods]
		print('LAST STEP: replacing spaces with underscores for BGF compatibility and readability.')
	if debug:
		print('RESULT:')
		for p in prods:
			print('\t',p[1],'is defined as:',p[2:])
	# FINAL STEP: compose BGF
	bgf = BGF3.Grammar()
	for q in prods:
		p = BGF3.Production()
		if 'disregard-labels' not in config.keys() and q[0]:
			p.setLabel(q[0])
		p.setNT(q[1])
		p.setExpr(map2expr(q[2:]))
		bgf.addProd(p)
	ET.ElementTree(bgf.getXml()).write(sys.argv[3])
	print('FINAL STEP: BGF written.')
