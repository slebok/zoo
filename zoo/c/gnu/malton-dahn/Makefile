extract:
	${tooldir}/txl2bgf fetched/c.Txl raw.1.bgf
	${tooldir}/txl2bgf fetched/C.Grm raw.2.bgf
	${tooldir}/txl2bgf fetched/CCommentOverrides.Grm raw.3.bgf
	${tooldir}/txl2bgf fetched/CGnuOverrides.Grm raw.4.bgf
	${tooldir}/mergebgf raw.1.bgf raw.2.bgf raw.3.bgf raw.4.bgf extracted.bgf
	${tooldir}/normbgf extracted.bgf extracted/grammar.bgf

include ../../Makefile.grammar
