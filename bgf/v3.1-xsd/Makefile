extract:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/6283da30b664c59f2d16f7289dda2c63394ef715/shared/xsd/bgf.xsd
	${tooldir}/xsd2bgf bgf.xsd grammar.bgf

include ../../Makefile.grammar
