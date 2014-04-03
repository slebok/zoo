all:
	make build
	make run

build:
	java -cp ../../../../../download/antlr-3.2.jar antlr.Tool java.g
	mv GeneratedJava* com/puppycrawl/tools/checkstyle/grammars
	jar cf parr.jar *.class

run:
	java -cp $$CLASSPATH:../../../../../download/antlr-3.2.jar:. TestIO TestIO.java

clean:
	rm -f GeneratedJava*.* *.class
