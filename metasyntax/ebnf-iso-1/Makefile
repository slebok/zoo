extract:
	cp src.8.1.txt src.prepared.txt
	perl -pi -w -e 's/˜/~/g;' src.prepared.txt
	perl -pi -w -e 's/ˆ/^/g;' src.prepared.txt
	../../hunter.py src.prepared.txt config.edd ebnf-iso-1.raw.bgf
	${tooldir}/xbgf post-extract.xbgf ebnf-iso-1.raw.bgf ebnf-iso-1.ext.bgf
	${tooldir}/xbgf refactor.xbgf ebnf-iso-1.ext.bgf ebnf-iso-1.bgf

include ../../Makefile.include
