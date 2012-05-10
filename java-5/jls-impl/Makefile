extract:
	${tooldir}/html2bgf src.htm raw.bgf
	${tooldir}/exbgf ../../../convergence/java/exbgf/recover-impl3.exbgf raw.bgf ext.bgf
	${tooldir}/exbgf ../../../convergence/java/exbgf/correct-impl3.exbgf ext.bgf grammar.bgf

get:
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/syntax.html > src.htm

include ../../Makefile.grammar
