extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/c5d8aafa4311825e5499a0bbb2b5864ff86a23c8/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v13.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
