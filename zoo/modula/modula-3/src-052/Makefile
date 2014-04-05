extract:
	${hunter} src.manually.fixed.txt config.edd extracted/grammar.bgf

connect:
	${tooldir}/xbgf complete.xbgf extracted/grammar.bgf ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf connected/grammar.bgf

include ../../../Makefile.grammar
