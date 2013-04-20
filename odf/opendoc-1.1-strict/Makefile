extract:
	${tooldir}/rng2bgf OpenDocument-strict-schema-v1.1.rng raw.bgf
	${tooldir}/mergebgf raw.bgf ../opendoc-1.1/grammar.bgf ext.bgf
	${tooldir}/normbgf ext.bgf grammar.bgf

get:
	rm -f *.rng
	wget http://docs.oasis-open.org/office/v1.1/OS/OpenDocument-strict-schema-v1.1.rng

include ../../Makefile.grammar
