extract:
	cat fetched/src.syntax.summary.txt > src.prepared.txt
	perl -pi -w -e 's/{\|/{TERMINALBAR/g;' src.prepared.txt
	${hunter} src.prepared.txt config.edd raw.bgf
	${tooldir}/xbgf post-extract.xbgf raw.bgf extracted/grammar.bgf
	${tooldir}/xbgf correct.xbgf extracted/grammar.bgf corrected/grammar.bgf

include ../../../Makefile.grammar
