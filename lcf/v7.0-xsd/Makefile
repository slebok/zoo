extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/bc8c082b8566ca8f9d74cd4a534440729521010d/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v6.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
