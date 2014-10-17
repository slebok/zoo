extract:
	${tooldir}/rng2bgf fetched/docbook.rng ext.main.bgf
	${tooldir}/rng2bgf fetched/dbnotn.rng ext.notn.bgf
	${tooldir}/rng2bgf fetched/dbcent.rng ext.cent.bgf
	${tooldir}/rng2bgf fetched/dbpool.rng ext.pool.bgf
	${tooldir}/rng2bgf fetched/dbhier.rng ext.hier.bgf
	${tooldir}/rng2bgf fetched/calstbl.rng ext.calstbl.bgf
	${tooldir}/mergebgf ext.*.bgf extracted/grammar.bgf

get:
	rm -rf docbook-rng-*
	wget http://www.oasis-open.org/docbook/relaxng/1.0b1/docbook-rng-1.0b1.zip
	unzip docbook-rng-1.0b1.zip
	rm docbook-rng-1.0b1.zip
	mv docbook-rng-1.0b1/* fetched/
	rmdir docbook-rng-1.0b1

include ../../Makefile.grammar
