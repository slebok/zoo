extract:
	${tooldir}/pdf2bgf src.grammar.summary.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf raw.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf ext.2.bgf
	${tooldir}/subgrammar ext.2.bgf translation-unit grammar.bgf

diff:
	${hunter} src.grammar.summary.txt config.edd cpp-1.bgf || exit -1
	${tooldir}/xbgf post-extract.xbgf cpp-1.bgf cpp-2.bgf
	#../../../../shared/tools/xbgf correct.xbgf ada-2.bgf ada.bgf
	#../../../../shared/tools/bgf2bnf ada.bgf ada.bnf
	gdts cpp-2.bgf cpp.raw.bgf
	gdtm cpp-2.bgf cpp.raw.bgf

toy:
	${hunter} toy.prepared.txt config.edd toy.bgf || exit -1
	${tooldir}/bgf2bnf toy.bgf toy.txt
	cat toy.txt

include ../../Makefile.grammar
