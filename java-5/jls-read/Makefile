extract:
	${tooldir}/html2bgf collect.kw src.htm raw.bgf
	${tooldir}/xbgf ../../../convergence/java/xbgf/recover-read3.xbgf raw.bgf ext.bgf
	${tooldir}/xbgf ../../../convergence/java/xbgf/correct-read3.xbgf ext.bgf grammar.bgf

get:
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/typesValues.html  > src.htm
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/names.html       >> src.htm
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/packages.html    >> src.htm
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/classes.html     >> src.htm
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/interfaces.html  >> src.htm
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/arrays.html      >> src.htm
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/statements.html  >> src.htm
	curl -k http://java.sun.com/docs/books/jls/third_edition/html/expressions.html >> src.htm

include ../../Makefile.grammar
