extract:
	make extract-hunter

extract-hunter:
	${hunter} src.fixed.txt config.edd ext.bgf
	xbgf fix.xbgf ext.bgf grammar.bgf

fix:
	grep -v 1 src.grammar.txt | grep -v 2 | grep -v 3 | grep -v 4 | grep -v 5 | grep -v 6 | grep -v 7 | grep -v 8 | grep -v 9 | grep -v 0 | grep -v SPECIFICATION | grep -v Appendix > src.fixed.txt

extract-pdf2bgf:
	${tooldir}/pdf2bgf src.grammar.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/xbgf post-extract.xbgf raw.bgf grammar.bgf

include ../../Makefile.grammar
