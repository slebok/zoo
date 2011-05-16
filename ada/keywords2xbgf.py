#!/usr/local/bin/python

f = open('keywords.lst','r')
g = open('nt2t.xbgf','w')
g.write('<?xml version="1.0" encoding="UTF-8"?><xbgf:sequence xmlns:xbgf="http://planet-sl.org/xbgf" xmlns:bgf="http://planet-sl.org/bgf">\n'+''.join(map(lambda x:'<xbgf:replace><bgf:expression><nonterminal>'+x.strip()+'</nonterminal></bgf:expression><bgf:expression><terminal>'+x.strip()+'</terminal></bgf:expression></xbgf:replace>\n',f.readlines()))+'</xbgf:sequence>')
g.close()
f.close()
