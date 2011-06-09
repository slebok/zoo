extract: 
	cp src.syntax.summary.txt src.prepared.txt
	cat src.semantics.txt >> src.prepared.txt
	perl -pi -w -e 's/{\|/{TERMINALBAR/g;' src.prepared.txt
	perl -pi -w -e 's/–/-/g;' src.prepared.txt
	perl -pi -w -e 's/J\./0\./g;' src.prepared.txt
	${hunter} src.prepared.txt config.edd raw.bgf
	${tooldir}/xbgf post-extract.xbgf raw.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf grammar.bgf

include ../../Makefile.grammar
