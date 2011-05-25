sdflib = ../../../../../sdf-library/trunk/library/languages/modula-3/syntax

extract:
	${tooldir}/sdf2bgf ${sdflib}/*.sdf modula.ext.bgf
	${tooldir}/subgrammar modula.ext.bgf Compilation modula.ext.2.bgf
	${tooldir}/xbgf refactor.xbgf modula.ext.2.bgf modula.bgf

include ../../Makefile.include