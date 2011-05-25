extract:
	${tooldir}/pdf2bgf src.grammar.summary.txt cpp.raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf cpp.raw.bgf cpp.ext.bgf
	${tooldir}/xbgf correct.xbgf cpp.ext.bgf cpp.ext.2.bgf
	${tooldir}/subgrammar cpp.ext.2.bgf translation-unit cpp.bgf

include ../../Makefile.include
