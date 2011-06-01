extract:
	../../../extraction/antlr/antlrpp.py ada.rsc.g ada.prepared.g
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool ada.prepared.g raw.bgf
	${tooldir}/xbgf post-extract.xbgf raw.bgf grammar.bgf
	#${tooldir}/subgrammar ext.bgf compilation_unit grammar.bgf

include ../../Makefile.grammar
