extract:
	${tooldir}/html2bgf collect.kw src.htm raw.bgf
	${tooldir}/exbgf2xbgf ../../../convergence/exbgf/java/exbgf/correct-read1.exbgf correct.xbgf
	${tooldir}/xbgf correct.xbgf raw.bgf grammar.bgf

get:
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/4.doc.html   > src.htm
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/6.doc.html  >> src.htm
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/7.doc.html  >> src.htm
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/8.doc.html  >> src.htm
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/9.doc.html  >> src.htm
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/10.doc.html >> src.htm
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/14.doc.html >> src.htm
	curl -k http://java.sun.com/docs/books/jls/first_edition/html/15.doc.html >> src.htm

include ../../Makefile.grammar
