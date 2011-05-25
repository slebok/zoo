extract:
	grep -xv 'c ' src.grammar.summary.txt > src.prepared.txt
	perl -pi -w -e 's/hand ler/handler/g;' src.prepared.txt
	perl -pi -w -e 's/∼/~/g;' src.prepared.txt
	${tooldir}/pdf2bgf src.prepared.txt cpp.raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf cpp.raw.bgf cpp.ext.bgf
	${tooldir}/xbgf correct.xbgf cpp.ext.bgf cpp.ext.2.bgf
	${tooldir}/subgrammar cpp.ext.2.bgf translation-unit cpp.bgf

include ../../Makefile.include
