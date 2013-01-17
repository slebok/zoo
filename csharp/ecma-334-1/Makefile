extract:
	${hunter} src.fixed.txt config.edd output.bgf
	xbgf fix.xbgf output.bgf good.bgf
	gdts good.bgf grammar.bgf

fix:
	grep -v 1 src.grammar.txt | grep -v 2 | grep -v 3 | grep -v 4 | grep -v 5 | grep -v 6 | grep -v 7 | grep -v 8 | grep -v 9 | grep -v 0 | grep -v SPECIFICATION | grep -v Appendix > src.fixed.txt

hunt:
	${hunter} src.grammar.txt config.edd output.bgf

extract2:
	${tooldir}/pdf2bgf src.grammar.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/xbgf post-extract.xbgf raw.bgf grammar.bgf

include ../../Makefile.grammar
