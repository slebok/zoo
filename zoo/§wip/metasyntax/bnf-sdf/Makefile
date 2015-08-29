extract:
	${tooldir}/sdf2bgf ${sdflibdir}/bnf/syntax/*.sdf raw.bgf
	${tooldir}/xbgf correct.xbgf raw.bgf ext.bgf
	${tooldir}/subgrammar ext.bgf Rules grammar.bgf

include ../../Makefile.grammar
