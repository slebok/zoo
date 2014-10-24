extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/ce197e1a47e85385c75e3abcce8940ecde677133/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v4.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
