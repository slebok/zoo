extract:
	${tooldir}/pdf2bgf src.language.syntax.summary.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf raw.bgf ext.bgf
	${tooldir}/subgrammar ext.bgf translation-unit grammar.bgf

include ../../Makefile.grammar
