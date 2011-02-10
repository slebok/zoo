#!/usr/local/bin/python
# -*- coding: utf-8 -*-
import elementtree.ElementTree as ET
import os,sys
sys.path.append(os.getcwd().split('slps')[0]+'slps/shared/python')
import BGF

singles = (BGF.Empty(),BGF.Epsilon(),BGF.Any())

def ntd(x,d):
	nt = BGF.Nonterminal()
	nt.setName(x)
	w = d()
	w.setExpr(BGF.Expression(nt))
	return BGF.Expression(w)

if __name__ == "__main__":
	g = BGF.Grammar()
	prod = 400
	term = 150
	for i in range(0,prod):
		p = BGF.Production()
		p.setNT('nt'+str(i))
		p.setExpr(BGF.Expression(singles[i%3]))
		g.addProd(p)
		p = BGF.Production()
		p.setNT('nt'+str(i))
		a = ntd('nt'+str((i+1)%prod),BGF.Plus)
		b = ntd('nt'+str((i+2)%prod),BGF.Star)
		c = ntd('nt'+str((i+3)%prod),BGF.Optional)
		bc = BGF.Choice()
		bc.add(b)
		bc.add(c)
		abc = BGF.Sequence()
		abc.add(a)
		abc.add(BGF.Expression(bc))
		d = BGF.Terminal()
		d.setName('t'+str(i%term))
		abc.add(BGF.Expression(d))
		p.setExpr(BGF.Expression(abc))
		g.addProd(p)
	ET.ElementTree(g.getXml()).write('monster.bgf')
