extract:
	rm -f bgf.xsd
	wget --no-check-certificate https://github.com/grammarware/slps/raw/36e8dc04a0e2e1ed8ce7598d6cddec6cc3197897/shared/xsd/bgf.xsd
	diff bgf.xsd ../../../../shared/xsd/bgf.xsd
	${tooldir}/xsd2bgf bgf.xsd ext.bgf
	${tooldir}/subgrammar ext.bgf grammar grammar.bgf

include ../../Makefile.grammar
