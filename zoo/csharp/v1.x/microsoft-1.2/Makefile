extract:
	${tooldir}/pdf2bgf src.grammar.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf raw.bgf ext.bgf
	${tooldir}/subgrammar ext.bgf compilation-unit grammar.bgf

include ../../Makefile.grammar
