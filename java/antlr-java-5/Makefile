all:
	cd ../../../extraction/antlr && make build
	make build

build:
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool habelitz/Java.stripped.g habelitz.ext.bgf
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool parr/Java.stripped.g parr.ext.bgf
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool stahl/java.stripped.g stahl.ext.bgf
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool studman/java15.stripped.g studman.ext.bgf
	../../../../shared/tools/xbgf habelitz/post-extraction.xbgf habelitz.ext.bgf habelitz.fix.bgf
	../../../../shared/tools/xbgf parr/post-extraction.xbgf parr.ext.bgf parr.fix.bgf
	../../../../shared/tools/xbgf stahl/post-extraction.xbgf stahl.ext.bgf stahl.fix.bgf
	../../../../shared/tools/xbgf studman/post-extraction.xbgf studman.ext.bgf studman.fix.bgf
	../../../../shared/tools/subgrammar habelitz.fix.bgf javaSource habelitz.bgf
	../../../../shared/tools/subgrammar parr.fix.bgf compilationUnit parr.bgf
	../../../../shared/tools/subgrammar stahl.fix.bgf compilationUnit stahl.bgf
	../../../../shared/tools/subgrammar studman.fix.bgf compilationUnit studman.bgf
	rm *.ext.bgf *.fix.bgf

test:
	ls -1 *.bgf | xargs -n1 ../../../../shared/tools/validate bgf

clean:
	rm *.bgf
