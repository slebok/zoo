all:
	make build
	make run

build:
	java -cp ../../../../../download/antlr-3.2.jar antlr.Tool java1.5.g ../studman/java15.tree.g

run:
	java -cp $$CLASSPATH:../../../../../download/antlr-3.2.jar TestIO TestIO.java

clean:
	rm -f JavaToken*.java JavaLexer*.java JavaRecognizer*.java *.class *.smap
