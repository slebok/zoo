extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/a44de6969bae0ddbbe7faf8a5ba69c3285e1b3ea/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v9.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
