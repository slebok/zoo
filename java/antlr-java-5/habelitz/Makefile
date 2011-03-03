all:
	make build
	make run

build:
	java -cp ../../../../../download/antlr-3.2.jar org.antlr.Tool Java.g JavaTreeParser.g
	mv Java*.java com/habelitz/jsobjectizer/unmarshaller/antlrbridge/generated
	javac -cp ../../../../../download/antlr-3.2.jar *.java com/habelitz/jsobjectizer/unmarshaller/antlrbridge/generated/*.java
	jar cf habelitz.jar *.class com/habelitz/jsobjectizer/unmarshaller/antlrbridge/generated/*.class

run:
	java -cp $$CLASSPATH:../../../../../download/antlr-3.2.jar:habelitz.jar -ea TestIO TestIO.java

clean:
	rm -f *.tokens Java*.java *.class com/habelitz/jsobjectizer/unmarshaller/antlrbridge/generated/* *.jar
