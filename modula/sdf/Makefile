extract:
	${tooldir}/sdf2bgf ${sdflibdir}/modula-3/syntax/*.sdf modula.ext.bgf
	${tooldir}/subgrammar modula.ext.bgf Compilation modula.ext.2.bgf
	${tooldir}/xbgf refactor.xbgf modula.ext.2.bgf modula.bgf

include ../../Makefile.include