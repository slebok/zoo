extract:
	${tooldir}/pdf2bgf src.language.syntax.summary.txt c.raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf c.raw.bgf c.ext.bgf
	${tooldir}/subgrammar c.ext.bgf translation-unit c.bgf

include ../../Makefile.include
