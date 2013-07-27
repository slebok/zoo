extract:
	${tooldir}/html2bgf syntax.kw src.htm raw.bgf
	${tooldir}/exbgf2xbgf ../../../convergence/exbgf/java/exbgf/correct-impl1.exbgf correct.xbgf
	${tooldir}/xbgf correct.xbgf raw.bgf grammar.bgf

get:
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/19.doc.html > src.htm

include ../../Makefile.grammar
