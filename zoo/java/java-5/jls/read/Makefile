connect:
	${tooldir}/exbgf2xbgf ${slpsdir}/topics/convergence/exbgf/java/exbgf/recover-read3.exbgf recover.xbgf
	${tooldir}/exbgf2xbgf ${slpsdir}/topics/convergence/exbgf/java/exbgf/correct-read3.exbgf correct.xbgf
	${tooldir}/xbgf recover.xbgf extracted/grammar.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf connected/grammar.bgf

extract:
	cat fetched/*.html > src.htm
	${tooldir}/html2bgf collect.kw src.htm extracted/grammar.bgf
	rm src.htm

fetch:
	wget http://java.sun.com/docs/books/jls/third_edition/html/typesValues.html
	wget http://java.sun.com/docs/books/jls/third_edition/html/names.html
	wget http://java.sun.com/docs/books/jls/third_edition/html/packages.html
	wget http://java.sun.com/docs/books/jls/third_edition/html/classes.html
	wget http://java.sun.com/docs/books/jls/third_edition/html/interfaces.html
	wget http://java.sun.com/docs/books/jls/third_edition/html/arrays.html
	wget http://java.sun.com/docs/books/jls/third_edition/html/statements.html
	wget http://java.sun.com/docs/books/jls/third_edition/html/expressions.html
	mv *.html fetched/

include ../../../../Makefile.grammar
