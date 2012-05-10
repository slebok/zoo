all:
	make build
	make run

extract:
	../../../extraction/antlr/antlrpp.py Java.rsc.g Java.prepared.g
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool Java.prepared.g raw.bgf
	../../../../shared/tools/xbgf post-extraction.xbgf raw.bgf ext.bgf
	../../../../shared/tools/subgrammar ext.bgf javaSource grammar.bgf

build:
	java -cp ../../../../download/antlr-3.2.jar org.antlr.Tool Java.g JavaTreeParser.g
	mv Java*.java com/habelitz/jsobjectizer/unmarshaller/antlrbridge/generated
	javac -cp ../../../../download/antlr-3.2.jar *.java com/habelitz/jsobjectizer/unmarshaller/antlrbridge/generated/*.java
	jar cf habelitz.jar *.class com/habelitz/jsobjectizer/unmarshaller/antlrbridge/generated/*.class

run:
	java -cp $$CLASSPATH:../../../../download/antlr-3.2.jar:habelitz.jar -ea TestIO TestIO.java

clean:
	rm -f *.tokens Java*.java *.class com/habelitz/jsobjectizer/unmarshaller/antlrbridge/generated/* *.jar Java.prepared.g *.bgf
