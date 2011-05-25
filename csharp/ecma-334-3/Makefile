extract:
	${tooldir}/pdf2bgf src.grammar.txt csharp.raw.bgf banned-lines.lst keywords.lst
	${tooldir}/checkxml bgf csharp.raw.bgf
	${tooldir}/normbgf csharp.raw.bgf csharp.bgf
	${tooldir}/bgf2bnf csharp.bgf csharp.bnf

include ../../Makefile.include
