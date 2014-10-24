extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/e60e3943a62ec592f6bd623d234730409ceabfb3/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v24.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
