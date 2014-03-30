extract:
	${tooldir}/pdf2bgf fetched/src.grammar.txt raw.bgf banned-lines.lst keywords.lst
	${tooldir}/normbgf raw.bgf extracted/grammar.bgf
	${tooldir}/xbgf correct.xbgf extracted/grammar.bgf rec.bgf
	${tooldir}/subgrammar rec.bgf compilation-unit corrected/grammar.bgf

include ../../../Makefile.grammar
