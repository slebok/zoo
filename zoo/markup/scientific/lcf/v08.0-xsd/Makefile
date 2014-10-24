extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/910dc127c3e5c459aca565cbc4aabacefd7b735c/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v7.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
