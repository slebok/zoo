extract:
	${tooldir}/html2bgf syntax.kw src.htm raw.bgf
	${tooldir}/xbgf ../../../convergence/java/xbgf/correct-impl1.xbgf raw.bgf grammar.bgf

get:
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/19.doc.html > src.htm

include ../../Makefile.grammar
