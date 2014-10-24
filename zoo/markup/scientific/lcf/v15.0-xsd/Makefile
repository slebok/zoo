extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/2d094b9be9d148ffe7b14c0c5ba5d11c4e1c7fb8/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v14.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
