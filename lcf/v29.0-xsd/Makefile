extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/7a0be94dfdabed204d670c19ed52cf41cca4f31a/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v28.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
