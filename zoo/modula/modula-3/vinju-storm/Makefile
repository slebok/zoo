fetch:
	ls ${sdflibdir}/modula-3/syntax/*.sdf
	cp ${sdflibdir}/modula-3/syntax/*.sdf fetched/

extract:
	${tooldir}/sdf2bgf fetched/*.sdf extracted/grammar.bgf
	${tooldir}/subgrammar extracted/grammar.bgf Compilation ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf connected/grammar.bgf

include ../../../Makefile.grammar