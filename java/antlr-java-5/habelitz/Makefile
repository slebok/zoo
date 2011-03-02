all:
	make build
	#make run

build:
	java -cp ../../../../../download/antlr-3.2.jar org.antlr.Tool Java.g JavaTreeParser.g
	javac -cp ../../../../../download/antlr-3.2.jar *.java

clean:
	rm Java.tokens Java*.java *.class
