#!/usr/local/bin/python
# -*- coding: utf-8 -*-
import os, sys
import elementtree.ElementTree as ET
sys.path.append(os.getcwd().split('slps')[0]+'slps/shared/python')
import BGF, slpsns

config = {}

debug = False

def isAlpha(x):
	return reduce(lambda a,b:a and b=='_' or b.isalnum(),x,True)

def isQNumber(x):
	if x =='.':
		return False
	else:
		return reduce(lambda a,b:a and b=='.' or b.isdigit(),x,True)

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
	return filter(lambda x:x not in [' ',' ','	'],ts)
	# not space, not hard space, not tab; newlines are preserved for now

def readConfig(f):
	global debug
	cfg = ET.parse(f)
	for e in cfg.findall('*'):
		if e.text:
			config[e.tag] = e.text.replace('\\n','\n')
		else:
			config[e.tag] = ''
	if debug:
		print 'Ok',config

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
						print 'STEP 4 problem: start-label-symbol mismatch!'
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

def findCommonTail(ps):
	tail = []
	for i in range(1,len(ps[0])):
		if map(lambda x:x[-i],ps) == [ps[0][-i]]*len(ps):
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
		print 'STEP 6 deadlock: number of start-group-symbol and end-group-symbol occurrences do not match.'
		return ats
	if debug and poss[0]:
		print 'poss >>>>>',poss
		print 'ats >>>>>>',ats
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
		print 'STEP 6 deadlock: number of start-?-symbol and end-?-symbol occurrences do not match.'
		return ats
	if debug and poss[0]:
		print 'poss >>>>>',poss
		print 'ats >>>>>>',ats
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

def mapmany(s):
	global debug
	i = 0
	es = []
	while(i<len(s)):
		if s[i] == 'START-OPTION-SYMBOL':
			if debug:
				print 'OPTION GO @',i,'in',s
			subexprs = []
			i += 1
			level = 1
			while level>0:
				subexprs.append(s[i])
				if s[i] == 'START-OPTION-SYMBOL':
					level += 1
				if s[i] == 'END-OPTION-SYMBOL':
					level -= 1
				i += 1
			i -= 1
			if debug:
				print '>>>opt>>>',subexprs[:-1]
			se = mapmany(subexprs[:-1])
			opt = BGF.Optional()
			opt.setExpr(se)
			es.append(opt)
		elif s[i] == 'START-REPEAT-SYMBOL':
			if debug:
				print 'REPEAT GO'
			subexprs = []
			i += 1
			level = 1
			while level>0:
				subexprs.append(s[i])
				if s[i] == 'START-REPEAT-SYMBOL':
					level += 1
				if s[i] == 'END-REPEAT-SYMBOL':
					level -= 1
				i += 1
			i -= 1
			if debug:
				print '>>>rep>>>',subexprs[:-1]
			se = mapmany(subexprs[:-1])
			opt = BGF.Star()
			opt.setExpr(se)
			es.append(opt)
		else:
			es.append(map2expr(s[i]))
		i += 1
	if len(es) == 1:
		e = BGF.Expression(es[0])
	else:
		e = BGF.Sequence()
		for a in es:
			e.add(BGF.Expression(a))
	return e

def endOfContext(a,i,e):
	s = a[i]
	level = 1
	j = i+1
	while level>0 and j<len(a):
		if a[j]==s:
			level += 1
		elif a[j]==e:
			level -= 1
		j += 1
	if level != 0:
		print 'Cannot find end of context in:',a[i:],'@',level
	return j

def onlyLevel1(ss):
	i = 0
	z = []
	while i<len(ss):
		if ss[i] == 'START-STAR-SYMBOL':
			i = endOfContext(ss,i,'END-STAR-SYMBOL')
		elif ss[i] == 'START-PLUS-SYMBOL':
			i = endOfContext(ss,i,'END-PLUS-SYMBOL')
		elif ss[i] == 'START-OPTION-SYMBOL':
			i = endOfContext(ss,i,'END-OPTION-SYMBOL')
		else:
			z.append(ss[i])
			i += 1
	print '<<<ss<<<',ss
	print '>>>zz>>>',z
	return z

def map2expr(ss):
	global debug
	ess = []
	es = []
	i = 0
	while i<len(ss):
		if ss[i] == 'START-STAR-SYMBOL':
			j = endOfContext(ss,i,'END-STAR-SYMBOL')
			if debug:
				print '>>>context>>>',ss[i:j]
			e = BGF.Star()
			e.setExpr(map2expr(ss[i+1:j-1]))
			es.append(e)
			i = j
		elif ss[i] == 'START-PLUS-SYMBOL':
			j = endOfContext(ss,i,'END-PLUS-SYMBOL')
			if debug:
				print '>>>context>>>',ss[i:j]
			e = BGF.Plus()
			e.setExpr(map2expr(ss[i+1:j-1]))
			es.append(e)
			i = j
		elif ss[i] == 'START-OPTION-SYMBOL':
			j = endOfContext(ss,i,'END-OPTION-SYMBOL')
			if debug:
				print '>>>context>>>',ss[i:j]
			e = BGF.Optional()
			e.setExpr(map2expr(ss[i+1:j-1]))
			es.append(e)
			i = j
		elif ss[i] == 'START-GROUP-SYMBOL':
			j = endOfContext(ss,i,'END-GROUP-SYMBOL')
			if i == 0 and j == len(ss):
				ss = ss[1:-1]
				continue
			if debug:
				print '>>>context>>>',ss[i:j]
			es.append(map2expr(ss[i+1:j-1]))
			i = j
		elif ss[i] == 'DEFINITION-SEPARATOR-SYMBOL':
			if debug:
				print 'It is a bar! It is a choice!'
			ess.append(es)
			es = []
			i += 1
		elif ss[i][0] == config['start-terminal-symbol']:
			if debug:
				print 'TERMINAL',ss[i][1:-1]
			e = BGF.Terminal()
			e.setName(ss[i][1:-1])
			es.append(e)
			i += 1
		else:
			if debug:
				print 'NONTERMINAL',ss[i]
			e = BGF.Nonterminal()
			e.setName(ss[i])
			es.append(e)
			i += 1
	ess.append(es)
	if len(ess) == 0:
		print 'Serialisation error: empty output sequence!'
		return
	elif len(ess) == 1:
		if len(ess[0]) == 0:
			print 'Serialisation error: empty internal output sequence!'
			return
		elif len(ess[0]) == 1:
			return BGF.Expression(ess[0][0])
		else:
			e = BGF.Sequence()
			for x in ess[0]:
				e.add(BGF.Expression(x))
			return BGF.Expression(e)
	else:
		e = BGF.Choice()
		for es in ess:
			if len(es) == 0:
				print 'Serialisation error: empty internal output sequence!'
				return
			elif len(es) == 1:
				e.add(BGF.Expression(es[0]))
			else:
				ee = BGF.Sequence()
				for x in es:
					ee.add(BGF.Expression(x))
				e.add(BGF.Expression(ee))
		return BGF.Expression(e)
	print 'Dead code reached!'
	return

def mapglue(b,s):
	a = b[:]
	i = 0
	while i < len(a):
		if type(a[i])==type([]):
			a[i] = mapglue(a[i],s)
			i += 1
			continue
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
			i = j
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
		print '>>>in>>>>',p
		print '>>>out>>>',r
	return r

def assembleQualifiedNumbers(ts):
	ds = []
	for x in ts:
		if len(ds)>0 and (isQNumber(x) or x=='.') and isQNumber(ds[-1]):
			ds[-1] += x
		else:
			ds.append(x)
	return ds

def decomposeSymbols(p,defd):
	# [label, nt, ...]
	q = p[:2]
	for x in p[2:]:
		match = False
		if x not in defd and x.find(config['undefined-nonterminals-are-terminals'])>-1:
			for d in defd:
				if x[:len(d)] == d and x[len(d):].find(config['undefined-nonterminals-are-terminals'])<0:
					nt = d
					t = x[len(d):]
					if debug:
						print '->->->->->',x,'matches as',nt,'+',t
					q.append(nt)
					# todo: need to be adjusted if the order of phases is changed
					#q.append(config['start-terminal-symbol']+t+config['end-terminal-symbol'])
					q.append(t)
					match = True
					break
				if x[-len(d):] == d and x[:-len(d)].find(config['undefined-nonterminals-are-terminals'])<0:
					nt = d
					t = x[:-len(d)]
					if debug:
						print '=>=>=>=>=>',x,'matches as',t,'+',nt
					# todo: need to be adjusted if the order of phases is changed
					#q.append(config['start-terminal-symbol']+t+config['end-terminal-symbol'])
					q.append(t)
					q.append(nt)
					match = True
					break
		if not match:
			q.append(x)
	return q

if __name__ == "__main__":
	if len(sys.argv) != 4:
		print 'Usage:'
		print '	extract.py input.txt config.edd output.bgf'
		sys.exit(-1)
	#f = open('src.grammar.txt','r')
	f = open(sys.argv[1],'r')
	# STEP 0: read the file, remove whitespace (?)
	print 'STEP 0: reading the file, removing whitespace, getting the configuration.'
	tokens = splitTokenStream(f.read())
	f.close()
	readConfig(sys.argv[2])
	#print tokens
	# STEP 1: assemble terminal symbols
	print 'STEP 1: assembling terminal symbols according to start-terminal-symbol and end-terminal-symbol.'
	if 'start-terminal-symbol' in config.keys() and 'end-terminal-symbol' in config.keys():
		tokens = assembleBracketedSymbols(tokens,config['start-terminal-symbol'],config['end-terminal-symbol'])
	else:
		print 'STEP 1 skipped, sorry: start-terminal-symbol and end-terminal-symbol are not both specified.'
	# STEP 2: assemble nonterminal symbols
	print 'STEP 2: assembling nonterminal symbols according to start-nonterminal-symbol and end-nonterminal-symbol.'
	if 'start-nonterminal-symbol' in config.keys() and 'end-nonterminal-symbol' in config.keys():
		tokens = assembleBracketedSymbols(tokens,config['start-nonterminal-symbol'],config['end-nonterminal-symbol'])
	else:
		print 'STEP 2 skipped, sorry: start-nonterminal-symbol and end-nonterminal-symbol are not both specified.'
	# STEP 3: assembling composite metasymbols together
	print 'STEP 3: assembling metasymbols according to their possible values.'
	tokens = assembleQualifiedNumbers(tokens)
	for k in config.keys():
		if len(config[k])>1:
			print 'STEP 3: going to glue tokens that resemble', config[k].replace('\n','\\n')
			tokens = mapglue(tokens,config[k])
	if debug:
		print tokens
	# STEP 4: slice according to defining-symbol
	print 'STEP 4: splitting the token stream into productions according to defining-symbol.'
	if 'defining-symbol' in config.keys():
		prods = useDefiningSymbol(tokens,config['defining-symbol'])
	else:
		print 'STEP 4 skipped, sorry: defining-symbol is not specified.'
		# TODO
	# STEP 4a.1: [sanity check] Infer terminator-symbol
	print 'STEP 4: inferring terminator-symbol by looking at the productions.'
	if 'terminator-symbol' not in config.keys():
		ts = findCommonTail(prods[:-1])
		if ts:
			print 'STEP 4 successful: inferred terminator-symbol:',ts
			config['terminator-symbol'] = ts
		else:
			print 'STEP 4 unsuccessful, sorry.'
			for p in prods:
				print '%40s'%p[1],'>>>>>>',p[-2:]
			# ORLY?
	# STEP 4a.2: adjusting the terminator-symbol on the last production
	for i in range(0,len(config['terminator-symbol'])):
		if prods[-1][-len(config['terminator-symbol'])+i:] == config['terminator-symbol'][:len(config['terminator-symbol'])-i]:
			prods[-1] = prods[-1][:-len(config['terminator-symbol'])+i]
			prods[-1].extend(config['terminator-symbol'])
			break
	# STEP 4b: splitting the token stream into productions according to terminator-symbol; inferring defining-symbol
	# TODO
	prods = map(lambda p:p[:-(len(config['terminator-symbol']))] if p[-(len(config['terminator-symbol'])):] == config['terminator-symbol'] else p,prods)
	# STEP 5: slice insides according to definition-separator-symbol
	step5 = False
	for s in ('definition-separator-symbol','start-group-symbol','end-group-symbol','start-star-symbol','end-star-symbol','start-plus-symbol','end-plus-symbol','start-option-symbol','end-option-symbol'):
		if s in config.keys():
			print 'STEP 5: marking',s+'.'
			step5 = True
			prods = map(lambda p:map(lambda x:s.upper() if x==config[s] else x,p),prods)
	if not step5:
		print 'STEP 5 skipped: sorry, no metasymbols specified.'
	# STEP 6:
	print 'STEP 6: executing special extraction commands.'
	step6 = False
	defined = map(lambda x:x[1],prods)
	defined.append(config['defining-symbol'])
	if 'ignore-extra-newlines' in config.keys():
		print 'STEP 6: ignoring extra newlines.'
		step6 = True
		prods = map(lambda x:filter(lambda y:y!='\n',x),prods)
	if 'decompose-symbols' in config.keys():
		print 'STEP 6 (part of rule 4): decomposing compound symbols.'
		step6 = True
		prods = map(lambda x:decomposeSymbols(x,defined),prods)
	if 'undefined-nonterminals-are-terminals' in config.keys():
		print 'STEP 6 (rule 5): turning undefined nonterminals into terminals.'
		step6 = True
		if 'start-terminal-symbol' not in config.keys() and 'end-terminal-symbol' not in config.keys():
			config['start-terminal-symbol'] = config['end-terminal-symbol'] = '"'
		prods = map(lambda p:map(lambda x:x if x in defined or x.find(config['undefined-nonterminals-are-terminals'])>-1 or (x.isupper() and len(x)>1) or x=='' else config['start-terminal-symbol']+x+config['end-terminal-symbol'],p),prods)
	if 'glue-nonalphanumeric-terminals' in config.keys():
		print 'STEP 6 (part of rule 3): glueing non-alphanumeric terminal symbols together.'
		step6 = True
		prods = map(glueTerminals,prods)
	if not step6:
		print 'STEP 6 skipped, sorry: no special commands found in the configuration.'
	# STEP X: validating bracketing?
	# ...
	# RESULT
	if debug:
		print 'RESULT:'
		for p in prods:
			print p[0],'is defined as:'
			print '\t',p[2:]
	# FINAL STEP: compose BGF
	bgf = BGF.Grammar()
	for q in prods:
		p = BGF.Production()
		if 'disregard-labels' not in config.keys() and q[0]:
			p.setLabel(q[0])
		p.setNT(q[1])
		p.setExpr(map2expr(q[2:]))
		bgf.addProd(p)
	ET.ElementTree(bgf.getXml()).write(sys.argv[3])
	print 'FINAL STEP: BGF written.'
