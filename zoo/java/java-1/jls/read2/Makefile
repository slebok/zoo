a:

connect:
	${tooldir}/exbgf2xbgf ../../../convergence/exbgf/java/exbgf/correct-read1.exbgf connect.xbgf
	${tooldir}/xbgf connect.xbgf extracted/grammar.bgf connected/grammar.bgf

extract:
	cat fetched/*.html > src.htm
	${tooldir}/html2bgf collect.kw src.htm extracted/grammar.bgf
	rm src.htm

fetch:
	wget http://docs.oracle.com/javase/specs/jls/se8/html/jls-4.html
	wget http://docs.oracle.com/javase/specs/jls/se8/html/jls-6.html
	wget http://docs.oracle.com/javase/specs/jls/se8/html/jls-7.html
	wget http://docs.oracle.com/javase/specs/jls/se8/html/jls-8.html
	wget http://docs.oracle.com/javase/specs/jls/se8/html/jls-9.html
	wget http://docs.oracle.com/javase/specs/jls/se8/html/jls-10.html
	wget http://docs.oracle.com/javase/specs/jls/se8/html/jls-14.html
	wget http://docs.oracle.com/javase/specs/jls/se8/html/jls-15.html
	mv *.html fetched/

include ../../../../Makefile.grammar
