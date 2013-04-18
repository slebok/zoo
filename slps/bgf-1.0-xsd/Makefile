extract:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/ccb3c35e68dbd822e221a74e04a088ada1a14b5f/shared/xsd/bgf.xsd
	${tooldir}/xsd2bgf bgf.xsd grammar.bgf

include ../../Makefile.grammar
