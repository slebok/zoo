all:
	cd ../../../extraction/antlr && make build
	make build

build:
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool parr/Java.stripped.g parr.bgf

clean:
	rm *.bgf
