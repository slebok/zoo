extract:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/16699a41710e43b6d75f5863b8763b95ab1787e4/shared/xsd/bgf.xsd
	${tooldir}/xsd2bgf bgf.xsd grammar.bgf

include ../../Makefile.grammar
