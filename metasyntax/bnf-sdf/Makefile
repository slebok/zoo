extract:
	${tooldir}/sdf2bgf ${sdflibdir}/bnf/syntax/*.sdf bnf-sdf.ext.bgf
	${tooldir}/xbgf correct.xbgf bnf-sdf.ext.bgf bnf-sdf.ext.2.bgf
	${tooldir}/subgrammar bnf-sdf.ext.2.bgf Rules bnf-sdf.bgf

include ../../Makefile.include
