extract:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/8d857bfc477110a04be6a6ae66d36e6cbd9f3ba7/shared/xsd/bgf.xsd
	${tooldir}/xsd2bgf bgf.xsd grammar.bgf

include ../../Makefile.grammar
