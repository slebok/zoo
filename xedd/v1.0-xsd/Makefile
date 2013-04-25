extract: xedd.xsd
	${tooldir}/xsd2bgf xedd.xsd grammar.bgf

get: xedd.xsd

xedd.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/efbd9cccd312b4fa74a2b09878076dfa3cf69bb5/shared/xsd/xedd.xsd

include ../../Makefile.grammar
