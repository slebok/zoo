extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/96630844df5c94b96c787d4f59078587a87096ef/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v3.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
