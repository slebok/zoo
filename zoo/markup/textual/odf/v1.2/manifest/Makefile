extract:
	${tooldir}/rng2bgf OpenDocument-v1.2-os-manifest-schema.rng ext.bgf
	${tooldir}/normbgf ext.bgf grammar.bgf

get:
	rm -f *.rng
	wget http://docs.oasis-open.org/office/v1.2/os/OpenDocument-v1.2-os-manifest-schema.rng

include ../../Makefile.grammar
