all:

extract:
	../../../extraction/antlr/antlrpp.py ada.rsc.g ada.pp.g
	java -cp ${CLASSPATH}:../../../../download/antlrworks-1.1.7.jar:../../../extraction/antlr slps.antlr2bgf.Tool ada.pp.g ada.ext.bgf
	../../../../shared/tools/xbgf post-extract.xbgf ada.ext.bgf ada.fix.bgf
	../../../../shared/tools/subgrammar ada.fix.bgf compilation_unit ada.bgf

clean:
	rm -f ada.pp.g *.bgf
