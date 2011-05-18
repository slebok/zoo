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
		config[e.tag] = e.text.replace('\\n','\n')
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
		prods.append(ts[poss[i]-1:poss[i+1]-1])
	return prods

def useDefinitionSeparatorSymbol(ts,d):
	poss = [-1]
	alts = []
	for i in range(0,len(ts)):
		if ts[i] == d:
			poss.append(i)
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
	poss = [[],[]]
	i = j = 0
	for i in range(0,len(ats)):
		for j in range(0,len(ats[i])):
			if ats[i][j] == start:
				poss[0].append((i,j))
			if ats[i][j] == end:
				poss[1].append((i,j))
	if len(poss[0]) != len(poss[1]):
		print 'STEP 6 deadlock: number of start-group-symbol and end-group-symbol occurrences do not match.'
		return ats
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
				print 'OPTION GO'
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

def map2expr(s):
	global debug
	e = None
	if type(s)==type([]):
		# sequence or choice
		if type(s[0])==type([]):
			es = map(map2expr,s)
			if len(es) == 1:
				e = es[0]
			else:
				e = BGF.Choice()
				for a in es:
					e.add(a)
		else:
			e = mapmany(s)
	else:
		if s[0] == config['start-terminal-symbol']:
			if debug:
				print 'TERMINAL',s[1:-1]
			e = BGF.Terminal()
			e.setName(s[1:-1])
		else:
			if debug:
				print 'NONTERMINAL',s
			e = BGF.Nonterminal()
			e.setName(s)
	return BGF.Expression(e)

def mapglue(b,s):
	a = b[:]
	i = 0
	while i < len(a):
		if type(a[i])==type([]):
			a[i] = mapglue(a[i],s)
		elif i+1 == len(a) or type(a[i+1])==type([]):
			pass
		elif a[i] == s[0] and a[i+1] == s[1]:
			nrhs = a[:i]
			nrhs.append(a[i]+a[i+1])
			nrhs.extend(a[i+2:])
			a = nrhs
			#print 'a =',a
		i += 1
	return a

if __name__ == "__main__":
	if len(sys.argv) != 4:
		print 'Usage:'
		print '	extract.py input.txt config.edd output.bgf'
		sys.exit(-1)
	#f = open('src.grammar.txt','r')
	f = open(sys.argv[1],'r')
	# STEP 0: read the file, remove whitespace (?)
	print 'STEP 0: reading the file, removing whitespace, getting the configuration'
	tokens = splitTokenStream(f.read())
	f.close()
	readConfig(sys.argv[2])
	#print tokens
	# STEP 1: slice according to defining-symbol
	print 'STEP 1: splitting the token stream into productions according to defining-symbol'
	if 'defining-symbol' in config.keys():
		prods = useDefiningSymbol(tokens,config['defining-symbol'])
	else:
		print 'STEP 1 skipped, sorry: defining-symbol is not specified.'
	# STEP 2: [sanity check] Infer terminator-symbol
	print 'STEP 2: inferring terminator-symbol by looking at the productions'
	if 'terminator-symbol' in config.keys():
		print 'STEP 2 skipped: sorry, terminator-symbol is already specified.'
	else:
		ts = findCommonTail(prods[:-1])
		if ts:
			print 'STEP 2 successful: inferred terminator-symbol:',ts
			config['terminator-symbol'] = ts
		else:
			print 'STEP 2 unsuccessful, sorry.'
	# STEP 2a: adjusting the terminator-symbol on the last production
	for i in range(0,len(config['terminator-symbol'])):
		if prods[-1][-len(config['terminator-symbol'])+i:] == config['terminator-symbol'][:len(config['terminator-symbol'])-i]:
			prods[-1] = prods[-1][:-len(config['terminator-symbol'])+i]
			prods[-1].extend(config['terminator-symbol'])
			break
	# STEP 3: assemble terminal symbols
	print 'STEP 3: assembling terminal symbols according to start-terminal-symbol and end-terminal-symbol.'
	if 'start-terminal-symbol' in config.keys() and 'end-terminal-symbol' in config.keys():
		prods = map(lambda x:assembleBracketedSymbols(x,config['start-terminal-symbol'],config['end-terminal-symbol']),prods)
	else:
		print 'STEP 3 skipped, sorry: start-terminal-symbol and end-terminal-symbol are not both specified.'
	# STEP 3a: assembling composite metasymbols together
	for k in config.keys():
		if len(config[k])>1 and k != 'terminator-symbol':
			print 'STEP 3: going to glue tokens that resemble', config[k]
			prods = map(lambda x:mapglue(x,config[k]),prods)
	# STEP 4: assemble nonterminal symbols
	print 'STEP 4: assembling nonterminal symbols according to start-nonterminal-symbol and end-nonterminal-symbol.'
	if 'start-nonterminal-symbol' in config.keys() and 'end-nonterminal-symbol' in config.keys():
		prods = map(lambda x:assembleBracketedSymbols(x,config['start-nonterminal-symbol'],config['end-nonterminal-symbol']),prods)
	else:
		print 'STEP 4 skipped, sorry: start-nonterminal-symbol and end-nonterminal-symbol are not both specified.'
	# STEP 5: slice insides according to definition-separator-symbol
	print 'STEP 5: splitting the right hand sides of productions according to definition-separator-symbol'
	alts = []
	if 'definition-separator-symbol' in config.keys():
		for p in prods:
			if p[-(len(config['terminator-symbol'])):] == config['terminator-symbol']:
				rhs = p[2:-(len(config['terminator-symbol']))]
			else:
				rhs = p[2:]
			alts.append([p[0],useDefinitionSeparatorSymbol(rhs,config['definition-separator-symbol'])])
	else:
		print 'STEP 5 skipped: sorry, defining-symbol is not specified.'
		for p in prods:
			if p[-(len(config['terminator-symbol'])):] == config['terminator-symbol']:
				rhs = p[2:-(len(config['terminator-symbol']))]
			else:
				rhs = p[2:]
			alts.append([p[0],[rhs]])
	# STEP 6: grouping!!!
	print 'STEP 6: grouping according to start-group-symbol and end-group-symbol.'
	if 'start-group-symbol' in config.keys() and 'end-group-symbol' in config.keys():
		newalts = []
		for a in alts:
			newalts.append([a[0],findGroups(a[1],config['start-group-symbol'],config['end-group-symbol'])])
		alts = newalts	
	else:
		print 'STEP 6 skipped, sorry: start-group-symbol and end-group-symbol are not both specified.'
	# STEP 7: finding metasymbols
	print 'STEP 7: finding metasymbols.'
	newalts = []
	for a in alts:
		rhs = a[1]
		for s in ('start-option-symbol','end-option-symbol','start-repeat-symbol','end-repeat-symbol'):
			if s in config.keys():
				rhs = mapsymbols(rhs,config[s],s.upper())
		newalts.append([a[0],rhs])
	alts = newalts
	# STEP 8: validating bracketing?
	# ...
	if debug:
		print 'RESULT:'
		for a in alts:
			print a[0],'is defined as:'
			for x in a[1]:
				print '\t',x
	# FINAL STEP: compose BGF
	bgf = BGF.Grammar()
	for a in alts:
		p = BGF.Production()
		p.setNT(a[0])
		p.setExpr(map2expr(a[1]))
		bgf.addProd(p)
	ET.ElementTree(bgf.getXml()).write(sys.argv[3])
	print 'FINAL STEP: BGF written.'
