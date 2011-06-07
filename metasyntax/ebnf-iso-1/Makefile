extract:
	cp src.8.1.txt src.prepared.txt
	perl -pi -w -e 's/˜/~/g;' src.prepared.txt
	perl -pi -w -e 's/ˆ/^/g;' src.prepared.txt
	${hunter} src.prepared.txt config.edd raw.bgf
	${tooldir}/xbgf post-extract.xbgf raw.bgf ext.bgf
	${tooldir}/xbgf refactor.xbgf ext.bgf grammar.bgf

include ../../Makefile.grammar
