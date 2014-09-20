extract:
	rm -f ext*.bgf
	${tooldir}/rng2bgf fetched/xslt.rng ext.bgf
	${tooldir}/normbgf ext.bgf extracted/grammar.bgf

get:
	make clean
	wget http://www.thaiopensource.com/relaxng/xslt.rng
	mv xslt.rng fetched/

include ../../Makefile.grammar
