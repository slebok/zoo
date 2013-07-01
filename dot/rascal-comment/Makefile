extract:
	cp ${rascaldir}/dot/syntax/Dot.rsc Dot.prepared.rsc
	perl -pi -w -e 's/"\/\*"//g;' Dot.prepared.rsc
	perl -pi -w -e 's/^\t//g;' Dot.prepared.rsc
	perl -pi -w -e 's/\t/ /g;' Dot.prepared.rsc
	${hunter} Dot.prepared.rsc config.edd raw.bgf
	# fix inner choices to get ext.bgf
	xbgf post-extract.xbgf ext.bgf grammar.bgf

include ../../Makefile.grammar
