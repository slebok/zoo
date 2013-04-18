extract:
	${tooldir}/rng2bgf docbook-rng-1.0b1/docbook.rng ext.main.bgf
	${tooldir}/rng2bgf docbook-rng-1.0b1/dbnotn.rng ext.notn.bgf
	${tooldir}/rng2bgf docbook-rng-1.0b1/dbcent.rng ext.cent.bgf
	${tooldir}/rng2bgf docbook-rng-1.0b1/dbpool.rng ext.pool.bgf
	${tooldir}/rng2bgf docbook-rng-1.0b1/dbhier.rng ext.hier.bgf
	${tooldir}/rng2bgf docbook-rng-1.0b1/calstbl.rng ext.calstbl.bgf
	${tooldir}/mergebgf ext.*.bgf grammar.bgf

get:
	rm -rf docbook-rng-*
	wget http://www.oasis-open.org/docbook/relaxng/1.0b1/docbook-rng-1.0b1.zip
	unzip docbook-rng-1.0b1.zip
	rm docbook-rng-1.0b1.zip

include ../../Makefile.grammar
