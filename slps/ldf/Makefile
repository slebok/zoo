extract:
	${tooldir}/xsd2bgf ../../../../shared/xsd/ldf.xsd raw.bgf
	${tooldir}/xbgf fold-roles.xbgf raw.bgf ext.1.bgf
	${tooldir}/xbgf fold-names.xbgf ext.1.bgf ext.2.bgf
	${tooldir}/xbgf fold-meta.xbgf ext.2.bgf ext.3.bgf
	${tooldir}/xbgf rename-types.xbgf ext.3.bgf ext.4.bgf
	${tooldir}/xbgf beautify.xbgf ext.4.bgf ext.5.bgf
	${tooldir}/subgrammar ext.5.bgf document grammar.bgf

include ../../Makefile.grammar
