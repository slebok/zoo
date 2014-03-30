extract:
	${tooldir}/pdf2bgf src.grammar.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf raw.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf rec.bgf
	${tooldir}/subgrammar rec.bgf compilation-unit grammar.bgf

include ../../Makefile.grammar
