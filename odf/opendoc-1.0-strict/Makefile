extract:
	${tooldir}/rng2bgf OpenDocument-strict-schema-v1.0-os.rng raw.bgf
	${tooldir}/mergebgf raw.bgf ../opendoc-1.0/grammar.bgf ext.bgf
	${tooldir}/normbgf ext.bgf grammar.bgf

get:
	rm -f *.rng
	wget http://www.oasis-open.org/committees/download.php/12569/OpenDocument-strict-schema-v1.0-os.rng

include ../../Makefile.grammar
