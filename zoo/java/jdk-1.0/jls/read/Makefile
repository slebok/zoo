a:

connect:
	${tooldir}/exbgf2xbgf ../../../convergence/exbgf/java/exbgf/correct-read1.exbgf connect.xbgf
	${tooldir}/xbgf connect.xbgf extracted/grammar.bgf connected/grammar.bgf

extract:
	cat fetched/*.html > src.htm
	${tooldir}/html2bgf collect.kw src.htm extracted/grammar.bgf
	rm src.htm

fetch:
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/4.doc.html  > fetched/4.doc.html
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/6.doc.html  > fetched/6.doc.html
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/7.doc.html  > fetched/7.doc.html
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/8.doc.html  > fetched/8.doc.html
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/9.doc.html  > fetched/9.doc.html
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/10.doc.html > fetched/10.doc.html
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/14.doc.html > fetched/14.doc.html
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/15.doc.html > fetched/15.doc.html

include ../../../../Makefile.grammar
