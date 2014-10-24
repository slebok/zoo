extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/bfa26cf4de2f6dc81c0b761d7a46b08d0265496b/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v15.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
