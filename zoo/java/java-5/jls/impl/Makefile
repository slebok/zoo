connect:
	${tooldir}/exbgf2xbgf ${slpsdir}/topics/convergence/exbgf/java/exbgf/recover-impl3.exbgf recover.xbgf
	${tooldir}/exbgf2xbgf ${slpsdir}/topics/convergence/exbgf/java/exbgf/correct-impl3.exbgf correct.xbgf
	${tooldir}/xbgf recover.xbgf extracted/grammar.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf connected/grammar.bgf

extract:
	${tooldir}/html2bgf fetched/syntax.html extracted/grammar.bgf

fetch:
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/syntax.html > fetched/syntax.html

include ../../../../Makefile.grammar
