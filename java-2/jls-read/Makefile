extract:
	${tooldir}/html2bgf collect.kw src.htm raw.bgf
	${tooldir}/exbgf ../../../convergence/java/exbgf/recover-read2.exbgf raw.bgf ext.bgf
	${tooldir}/exbgf ../../../convergence/java/exbgf/correct-read2.exbgf ext.bgf grammar.bgf

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
