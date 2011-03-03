all:
	make build
	make run

build:
	java -cp ../../../../../download/antlr-3.2.jar antlr.Tool java.g java.tree.g
	javac -cp $$CLASSPATH:../../../../../download/antlr-3.2.jar TestIO.java

run:
	java -cp $$CLASSPATH:../../../../../download/antlr-3.2.jar TestIO TestIO.java

clean:
	rm -f Java*.java *.class JavaTokenTypes.txt *.smap
