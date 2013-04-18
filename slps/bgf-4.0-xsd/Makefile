extract:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/46c30080305d274e3fde30e9dd36b985534f0bda/shared/xsd/bgf.xsd
	${tooldir}/xsd2bgf bgf.xsd grammar.bgf

include ../../Makefile.grammar
