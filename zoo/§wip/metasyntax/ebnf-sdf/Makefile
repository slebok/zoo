extract:
	${tooldir}/sdf2bgf ${sdflibdir}/ebnf/syntax/*.sdf raw.bgf
	${tooldir}/xbgf correct.xbgf raw.bgf ext.bgf
	${tooldir}/subgrammar ext.bgf Grammar grammar.bgf

include ../../Makefile.grammar
