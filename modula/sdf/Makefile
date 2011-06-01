extract:
	${tooldir}/sdf2bgf ${sdflibdir}/modula-3/syntax/*.sdf raw.bgf
	${tooldir}/subgrammar raw.bgf Compilation ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf grammar.bgf

include ../../Makefile.grammar