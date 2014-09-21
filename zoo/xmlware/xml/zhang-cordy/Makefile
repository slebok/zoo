extract:
	${tooldir}/txl2bgf XML/Txl/XML.Txl root.bgf
	${tooldir}/txl2bgf XML/Txl/XML.Grammar ext.1.bgf
	${tooldir}/txl2bgf XML/Txl/XML_DTD.Grammar ext.2.bgf
	${tooldir}/txl2bgf XML/Txl/XML_Element.Grammar ext.3.bgf
	${tooldir}/mergebgf root.bgf ext.1.bgf ext.2.bgf ext.3.bgf ext.bgf
	${tooldir}/xbgf post-extraction.xbgf ext.bgf grammar.bgf

include ../../Makefile.grammar
