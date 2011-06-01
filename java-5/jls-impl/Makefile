extract:
	${tooldir}/html2bgf src.htm raw.bgf
	${tooldir}/xbgf ../../../convergence/java/xbgf/recover-impl3.xbgf raw.bgf ext.bgf
	${tooldir}/xbgf ../../../convergence/java/xbgf/correct-impl3.xbgf ext.bgf grammar.bgf

get:
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/syntax.html > src.htm

include ../../Makefile.grammar
