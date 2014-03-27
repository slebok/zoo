extract:
	${tooldir}/sdf2bgf fetched/*.sdf raw.bgf
	${tooldir}/subgrammar raw.bgf ExecutableProgram ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf extracted/grammar.bgf

fetch:
	cp ${sdflibdir}/fortran/syntax/*.sdf fetched/

include ../../Makefile.grammar