extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/ea4d30192dc1396ab1d078c45960a82fe3c2fb0a/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v5.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
