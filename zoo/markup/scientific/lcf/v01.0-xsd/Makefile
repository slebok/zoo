extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/5e90b6c0dc39d4a636344a034b0895e0d0ea036c/shared/xsd/lcf.xsd -O lcf.xsd

include ../../Makefile.grammar
