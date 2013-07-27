extract:
	${tooldir}/html2bgf src.htm raw.bgf
	${tooldir}/exbgf2xbgf ../../../convergence/exbgf/java/exbgf/correct-impl2.exbgf correct.xbgf
	${tooldir}/xbgf correct.xbgf raw.bgf grammar.bgf

get:
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/syntax.doc.html > src.htm

include ../../Makefile.grammar
