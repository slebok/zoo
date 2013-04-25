extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/38c6bfd3e95bb78eaeb6592b3ef91658537e8203/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v11.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
