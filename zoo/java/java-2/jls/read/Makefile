connect:
	${tooldir}/exbgf2xbgf ${slpsdir}/topics/convergence/exbgf/java/exbgf/recover-read2.exbgf recover.xbgf
	${tooldir}/exbgf2xbgf ${slpsdir}/topics/convergence/exbgf/java/exbgf/correct-read2.exbgf correct.xbgf
	${tooldir}/xbgf recover.xbgf extracted/grammar.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf connected/grammar.bgf

extract:
	cat fetched/*.html > src.htm
	${tooldir}/html2bgf collect.kw src.htm extracted/grammar.bgf
	rm src.htm

fetch:
	wget http://java.sun.com/docs/books/jls/second_edition/html/typesValues.doc.html
	wget http://java.sun.com/docs/books/jls/second_edition/html/names.doc.html
	wget http://java.sun.com/docs/books/jls/second_edition/html/packages.doc.html
	wget http://java.sun.com/docs/books/jls/second_edition/html/classes.doc.html
	wget http://java.sun.com/docs/books/jls/second_edition/html/interfaces.doc.html
	wget http://java.sun.com/docs/books/jls/second_edition/html/arrays.doc.html
	wget http://java.sun.com/docs/books/jls/second_edition/html/statements.doc.html
	wget http://java.sun.com/docs/books/jls/second_edition/html/expressions.doc.html
	mv *.html fetched/

include ../../../../Makefile.grammar
