extract:
	../../../extraction/antlr/antlrpp.py Dart.rsc.g Dart.pp.g
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool Dart.pp.g raw.bgf
	${tooldir}/xbgf post-extraction.xbgf raw.bgf ext.bgf
	${tooldir}/subgrammar ext.bgf compilationUnit libraryUnit grammar.bgf

get:
	curl -k https://dart.googlecode.com/svn/branches/bleeding_edge/dart/language/grammar/Dart.g > Dart.g

include ../../Makefile.grammar