extract:
	cp src.grammar.summary.txt src.prepared.txt
	perl -pi -w -e 's/∼/~/g;' src.prepared.txt
	perl -pi -w -e 's/: one of/:oneof\n/g;' src.prepared.txt
	perl -pi -w -e 's/: /:\n/g;' src.prepared.txt
	perl -pi -w -e 's/^:\n/: /g;' src.prepared.txt
	perl -pi -w -e 's/:\none of /: one of\n/g;' src.prepared.txt
	${tooldir}/pdf2bgf src.prepared.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf raw.bgf ext.bgf
	#${tooldir}/xbgf correct.xbgf ext.bgf ext.2.bgf
	#${tooldir}/subgrammar ext.2.bgf translation-unit grammar.bgf

include ../../Makefile.grammar
