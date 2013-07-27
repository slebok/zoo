extract:
	${tooldir}/html2bgf src.htm raw.bgf
	${tooldir}/exbgf2xbgf ../../../convergence/exbgf/java/exbgf/recover-impl3.exbgf recover.xbgf
	${tooldir}/exbgf2xbgf ../../../convergence/exbgf/java/exbgf/correct-impl3.exbgf correct.xbgf
	${tooldir}/xbgf recover.xbgf raw.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf grammar.bgf

get:
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/syntax.html > src.htm

include ../../Makefile.grammar
