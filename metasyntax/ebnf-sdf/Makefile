extract:
	${tooldir}/sdf2bgf ${sdflibdir}/ebnf/syntax/*.sdf ebnf-sdf.ext.bgf
	${tooldir}/xbgf correct.xbgf ebnf-sdf.ext.bgf ebnf-sdf.ext.2.bgf
	${tooldir}/subgrammar ebnf-sdf.ext.2.bgf Grammar ebnf-sdf.bgf

include ../../Makefile.include
