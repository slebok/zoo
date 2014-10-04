#!/usr/bin/python
# -*- coding: utf-8 -*-
import elementtree.ElementTree as ET
import os,sys
sys.path.append(os.getcwd().split('projects')[0]+'projects/slps/shared/python')
import BGF

if __name__ == "__main__":
	g = BGF.Grammar()
	g.addRoot('foo')
	p = BGF.Production()
	p.setNT('foo')
	t = BGF.Terminal()
	t.setName('bar')
	p.setExpr(BGF.Expression(t))
	g.addProd(p)
	ET.ElementTree(g.getXml()).write('grammar.bgf')
