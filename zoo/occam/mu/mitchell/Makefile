extract:
	make extract-hunter

extract-hunter:
	cp src.grammar.manual.txt src.prepared.txt
	perl -pi -w -e 's/ j / | /g;' src.prepared.txt
	perl -pi -w -e 's/ f / { /g;' src.prepared.txt
	perl -pi -w -e 's/ g / } /g;' src.prepared.txt
	# perl -pi -w -e 's/}uard/guard/g;' src.prepared.txt
	perl -pi -w -e 's/ﬁ/fi/g;' src.prepared.txt
	# cat src.grammar.txt | sed -e 's/ j / | /' > src.prepared.txt
	${hunter} src.prepared.txt config.edd raw.bgf || exit -1
	# ${tooldir}/xbgf post-extract.xbgf raw.bgf grammar.bgf

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
