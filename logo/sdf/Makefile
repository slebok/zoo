extract:
	${tooldir}/sdf2bgf ${sdflibdir}/logo/syntax/*.sdf raw.bgf
	${tooldir}/subgrammar raw.bgf Program ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf grammar.bgf

include ../../Makefile.grammar
