extract:
	${tooldir}/pdf2bgf src.grammar.txt csharp.raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf csharp.raw.bgf csharp.ext.bgf
	${tooldir}/subgrammar csharp.ext.bgf compilation-unit csharp.bgf

include ../../Makefile.include
