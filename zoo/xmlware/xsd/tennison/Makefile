extract:
	${tooldir}/rng2bgf xmlschema.rng ext.bgf
	${tooldir}/normbgf ext.bgf grammar.bgf

get:
	rm -f xmlschema.rng
	wget http://www.jenitennison.com/schema/xmlschema.rng

include ../../Makefile.grammar
