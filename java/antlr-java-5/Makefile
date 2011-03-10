all:
	cd ../../../extraction/antlr && make build
	make build

build:
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool parr/Java.stripped.g parr.bgf
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool habelitz/Java.stripped.g habelitz.ext.bgf
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool stahl/java.stripped.g stahl.ext.bgf
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool studman/java15.stripped.g studman.ext.bgf
	../../../../shared/tools/xbgf post-extraction.xbgf habelitz.ext.bgf habelitz.bgf
	../../../../shared/tools/xbgf post-extraction.xbgf studman.ext.bgf studman.bgf
	../../../../shared/tools/xbgf post-extraction.xbgf stahl.ext.bgf stahl.bgf
	rm habelitz.ext.bgf stahl.ext.bgf studman.ext.bgf

test:
	ls -1 *.bgf | xargs -n1 ../../../../shared/tools/validate bgf

clean:
	rm *.bgf
