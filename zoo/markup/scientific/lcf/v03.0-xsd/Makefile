extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/a9f327598babe798699bc7d6cf2246d5ca4f72a0/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v2.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
