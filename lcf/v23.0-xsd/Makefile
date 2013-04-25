extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/6db3305f0340808574c307b39c29ba717b38522d/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v22.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
