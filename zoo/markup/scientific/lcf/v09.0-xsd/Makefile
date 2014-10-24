extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/5315f399f41f88e697f5b8441e0e2ead4b88dc37/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v8.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
