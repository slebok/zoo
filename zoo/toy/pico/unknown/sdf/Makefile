extract:
	${tooldir}/sdf2bgf ${sdflibdir}/pico/syntax/*.sdf raw.bgf
	${tooldir}/subgrammar raw.bgf PROGRAM ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf grammar.bgf

include ../../Makefile.grammar
