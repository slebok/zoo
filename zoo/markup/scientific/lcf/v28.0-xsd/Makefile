extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/eee74db24bdb1c49952cb8ff19a531a55d4257a2/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v27.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
