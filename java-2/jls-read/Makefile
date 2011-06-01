extract:
	${tooldir}/html2bgf collect.kw src.htm raw.bgf
	${tooldir}/xbgf ../../../convergence/java/xbgf/recover-read2.xbgf raw.bgf ext.bgf
	${tooldir}/xbgf ../../../convergence/java/xbgf/correct-read2.xbgf ext.bgf grammar.bgf

get:
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/typesValues.doc.html  > src.htm
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/names.doc.html       >> src.htm
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/packages.doc.html    >> src.htm
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/classes.doc.html     >> src.htm
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/interfaces.doc.html  >> src.htm
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/arrays.doc.html      >> src.htm
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/statements.doc.html  >> src.htm
	curl -k http://java.sun.com/docs/books/jls/second_edition/html/expressions.doc.html >> src.htm

include ../../Makefile.grammar
