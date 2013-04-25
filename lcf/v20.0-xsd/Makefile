extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/11e115ed3fd6ab72c3c88f952626ae4878419875/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v19.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
