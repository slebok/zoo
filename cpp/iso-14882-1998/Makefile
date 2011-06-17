extract:
	make extract-hunter

extract-hunter:
	${hunter} src.grammar.summary.txt config.edd raw.bgf || exit -1
	${tooldir}/xbgf post-extract.xbgf raw.bgf grammar.bgf

extract-pdf2bgf:
	${tooldir}/pdf2bgf src.grammar.summary.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf raw.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf ext.2.bgf
	${tooldir}/subgrammar ext.2.bgf translation-unit grammar.bgf

diff:
	make clean
	make extract-pdf2bgf
	cp grammar.bgf grammar-pdf2bgf.bgf
	make extract-hunter
	cp grammar.bgf grammar-hunter.bgf
	${tooldir}/gdts grammar-hunter.bgf grammar-pdf2bgf.bgf

include ../../Makefile.grammar
