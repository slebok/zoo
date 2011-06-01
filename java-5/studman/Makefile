all:
	make build
	make run

extract:
	../../../extraction/antlr/antlrpp.py java15.rsc.g java15.pp.g
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool java15.pp.g studman.ext.bgf
	../../../../shared/tools/xbgf post-extraction.xbgf studman.ext.bgf studman.fix.bgf
	../../../../shared/tools/subgrammar studman.fix.bgf compilationUnit grammar.bgf

build:
	java -cp ../../../../download/antlr-3.2.jar antlr.Tool java15.g java15.tree.g
	javac -cp $$CLASSPATH:../../../../download/antlr-3.2.jar TestIO.java

run:
	java -cp $$CLASSPATH:../../../../download/antlr-3.2.jar TestIO TestIO.java

clean:
	rm -f Java*.java *.class JavaTokenTypes.txt *.smap
