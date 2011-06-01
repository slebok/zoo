extract:
	${tooldir}/sdf2bgf ${sdflibdir}/fortran/syntax/*.sdf raw.bgf
	${tooldir}/subgrammar raw.bgf ExecutableProgram ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf grammar.bgf

include ../../Makefile.grammar