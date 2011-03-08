all:
	cd ../../../extraction/antlr && make build
	make build

build:
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool parr/Java.stripped.g parr.bgf
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool habelitz/Java.stripped.g habelitz.ext.bgf
	../../../../shared/tools/xbgf habelitz/post-extraction.xbgf habelitz.ext.bgf habelitz.bgf
	rm habelitz.ext.bgf

test:
	ls -1 *.bgf | xargs -n1 ../../../../shared/tools/validate bgf

clean:
	rm *.bgf
