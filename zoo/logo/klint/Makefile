extract:
	${tooldir}/sdf2bgf fetched/*.sdf raw.bgf
	${tooldir}/subgrammar raw.bgf Program ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf grammar.bgf

fetch:
	cp ${sdflibdir}/logo/syntax/*.sdf fetched/

include ../../Makefile.grammar
