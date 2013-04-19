extract:
	rm -f ext*.bgf
	${tooldir}/rng2bgf xslt.rng ext.bgf
	${tooldir}/normbgf ext.bgf grammar.bgf

get:
	make clean
	wget http://www.thaiopensource.com/relaxng/xslt.rng

include ../../Makefile.grammar
