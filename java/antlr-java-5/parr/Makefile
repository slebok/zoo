all:
	make build
	#make run

build:
	java -Xmx100M -cp ../../../../../download/antlr-3.2.jar org.antlr.Tool Java.g
	javac -cp ../../../../../download/antlr-3.2.jar *.java
	jar cf parr.jar *.class

clean:
	rm Java.tokens Java*.java *.class
