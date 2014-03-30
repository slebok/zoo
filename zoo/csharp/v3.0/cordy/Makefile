extract:
	${tooldir}/txl2bgf CSharp/CSharp.grm raw.bgf
	${tooldir}/txl2bgf CSharp/cs.txl root.bgf
	${tooldir}/mergebgf raw.bgf root.bgf extracted.bgf
	${tooldir}/normbgf extracted.bgf grammar.bgf

include ../../Makefile.grammar
