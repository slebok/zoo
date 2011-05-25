extract:
	${tooldir}/pdf2bgf src.grammar.txt csharp.raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf csharp.raw.bgf csharp.ext.bgf
	${tooldir}/xbgf correct.xbgf csharp.ext.bgf csharp.ext.2.bgf
	${tooldir}/subgrammar csharp.ext.2.bgf compilation-unit csharp.bgf

include ../../Makefile.include
