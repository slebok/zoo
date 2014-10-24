extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/183d4b732f4743f158d571c4a562b34928362b79/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v23.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
