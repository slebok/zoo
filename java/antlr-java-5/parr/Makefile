all:
	make build
	make run

extract:
	../../../../extraction/antlr/antlrpp.py Java.rsc.g Java.pp.g
	java -cp ${CLASSPATH}:../../../../../download/antlrworks-1.1.7.jar:../../../../extraction/antlr slps.antlr2bgf.Tool Java.pp.g parr.ext.bgf
	../../../../../shared/tools/xbgf post-extraction.xbgf parr.ext.bgf parr.fix.bgf
	../../../../../shared/tools/subgrammar parr.fix.bgf compilationUnit parr.bgf

build:
	java -Xmx100M -cp ../../../../../download/antlr-3.2.jar org.antlr.Tool Java.g
	javac -cp ../../../../../download/antlr-3.2.jar *.java
	jar cf parr.jar *.class

run:
	java -cp $$CLASSPATH:../../../../../download/antlr-3.2.jar:parr.jar -ea TestIO TestIO.java

clean:
	rm Java.tokens Java*.java *.class *.jar
