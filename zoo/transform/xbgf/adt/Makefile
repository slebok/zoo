extract:
	${tooldir}/rscd2bgf fetched/XBGF.rsc ext.xbgf.bgf
	${tooldir}/rscd2bgf fetched/XScope.rsc ext.scope.bgf
	${tooldir}/mergebgf aliases.bgf ext.*.bgf grammar.bgf

fetch:
	cp ${slpsdir}/shared/rascal/src/language/XBGF.rsc fetched/
	cp ${slpsdir}/shared/rascal/src/language/XScope.rsc fetched/

include ../../../Makefile.grammar
