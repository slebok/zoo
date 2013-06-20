extract:
	cp ${rascaldir}/dot/syntax/Dot.rsc Dot.prepared.rsc
	perl -pi -w -e 's/"\/\*"//g;' Dot.prepared.rsc
	perl -pi -w -e 's/^\t//g;' Dot.prepared.rsc
	perl -pi -w -e 's/\t/ /g;' Dot.prepared.rsc
	${hunter} Dot.prepared.rsc config.edd ext.bgf
	# xbgf fix.xbgf ext.bgf grammar.bgf

include ../../Makefile.grammar
