extract:
	${tooldir}/html2bgf fetched/syntax.doc.html extracted/grammar.bgf

connect:
	${tooldir}/exbgf2xbgf ../../../convergence/exbgf/java/exbgf/correct-impl2.exbgf connect.xbgf
	${tooldir}/xbgf connect.xbgf extracted/grammar.bgf connected/grammar.bgf

fetch:
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/syntax.doc.html > fetched/syntax.doc.html

include ../../../../Makefile.grammar
