extract:
	${tooldir}/pdf2bgf src.grammar.summary.txt cpp.raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf cpp.raw.bgf cpp.ext.bgf
	${tooldir}/xbgf correct.xbgf cpp.ext.bgf cpp.ext.2.bgf
	${tooldir}/subgrammar cpp.ext.2.bgf translation-unit cpp.bgf

diff:
	../../hunter.py src.grammar.summary.txt config.edd cpp-1.bgf || exit -1
	#../../../../shared/tools/xbgf post-extract.xbgf ada-1.bgf ada-2.bgf
	#../../../../shared/tools/xbgf correct.xbgf ada-2.bgf ada.bgf
	#../../../../shared/tools/bgf2bnf ada.bgf ada.bnf
	gdts cpp-1.bgf cpp.raw.bgf

include ../../Makefile.include
