extract:
	${tooldir}/txl2bgf C/Txl/c.Txl raw.1.bgf
	${tooldir}/txl2bgf C/Txl/C.Grm raw.2.bgf
	${tooldir}/txl2bgf C/Txl/CCommentOverrides.Grm raw.3.bgf
	${tooldir}/txl2bgf C/Txl/CGnuOverrides.Grm raw.4.bgf
	${tooldir}/mergebgf raw.1.bgf raw.2.bgf raw.3.bgf raw.4.bgf extracted.bgf
	${tooldir}/normbgf extracted.bgf grammar.bgf

include ../../Makefile.grammar
