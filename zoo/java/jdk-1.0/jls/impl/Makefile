connect:
	${tooldir}/exbgf2xbgf ${slpsdir}/topics/convergence/exbgf/java/exbgf/correct-impl1.exbgf connect.xbgf
	${tooldir}/xbgf connect.xbgf extracted/grammar.bgf connected/grammar.bgf

extract:
	${tooldir}/html2bgf syntax.kw fetched/src.htm extracted/grammar.bgf

fetch:
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/19.doc.html > fetched/src.htm

include ../../../../Makefile.grammar
