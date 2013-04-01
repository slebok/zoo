extract:
	${tooldir}/sdf2bgf ${sdflibdir}/yacc/syntax/*.sdf raw.bgf
	${tooldir}/xbgf refactor.xbgf raw.bgf ext.bgf
	${tooldir}/subgrammar ext.bgf Grammar grammar.bgf

include ../../Makefile.grammar
