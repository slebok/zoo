extract:
	${tooldir}/rng2bgf OpenDocument-schema-v1.0-os.rng ext.bgf
	${tooldir}/normbgf ext.bgf grammar.bgf

get:
	rm -f *.rng
	wget http://www.oasis-open.org/committees/download.php/12571/OpenDocument-schema-v1.0-os.rng

include ../../Makefile.grammar
