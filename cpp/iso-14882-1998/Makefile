extract:
	${tooldir}/pdf2bgf src.grammar.summary.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf raw.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf ext.2.bgf
	${tooldir}/subgrammar ext.2.bgf translation-unit grammar.bgf

diff:
	${hunter} src.grammar.summary.txt config.edd cpp-1.bgf || exit -1
	#../../../../shared/tools/xbgf post-extract.xbgf ada-1.bgf ada-2.bgf
	#../../../../shared/tools/xbgf correct.xbgf ada-2.bgf ada.bgf
	#../../../../shared/tools/bgf2bnf ada.bgf ada.bnf
	gdts cpp-1.bgf cpp.raw.bgf

toy:
	../../hunter.py toy.prepared.txt config.edd toy.bgf || exit -1

include ../../Makefile.grammar
