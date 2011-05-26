extract:
	${tooldir}/sdf2bgf ${sdflibdir}/yacc/syntax/*.sdf yacc.ext.bgf
	${tooldir}/xbgf refactor.xbgf yacc.ext.bgf yacc.ext.2.bgf
	${tooldir}/subgrammar yacc.ext.2.bgf Grammar yacc.bgf

include ../../Makefile.include
