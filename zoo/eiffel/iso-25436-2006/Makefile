connect:
	${tooldir}/xbgf correct.xbgf extracted/grammar.bgf connected/grammar.bgf

extract:
	${hunter} fetched/src.prepared.txt config.edd raw.bgf
	${tooldir}/xbgf post-extract.xbgf raw.bgf extracted/grammar.bgf

fetch:
	cp fetched/src.manually.fixed.txt fetched/src.prepared.txt
	perl -pi -w -e 's/–/-/g;' fetched/src.prepared.txt
	perl -pi -w -e 's/C\+\+/CPP/g;' fetched/src.prepared.txt

include ../../Makefile.grammar
