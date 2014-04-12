extract:
	${tooldir}/sdf2bgf fetched/*.sdf extracted/grammar.bgf
	${tooldir}/subgrammar extracted/grammar.bgf Compilation ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf connected/grammar.bgf

fetch:
	cp ${sdflibdir}/modula-3/syntax/*.sdf fetched/

include ../../../Makefile.grammar