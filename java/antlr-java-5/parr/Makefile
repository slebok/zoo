all:
	make build
	make run

build:
	java -Xmx100M -cp ../../../../../download/antlr-3.2.jar org.antlr.Tool Java.g
	javac -cp ../../../../../download/antlr-3.2.jar *.java
	jar cf parr.jar *.class

run:
	java -cp $$CLASSPATH:../../../../../download/antlr-3.2.jar:parr.jar -ea TestIO TestIO.java

clean:
	rm Java.tokens Java*.java *.class *.jar
