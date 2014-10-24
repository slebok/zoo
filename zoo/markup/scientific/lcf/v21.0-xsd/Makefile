extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/3f06033b20779a1a09f3c64e1d11c2e42ded2bcd/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v20.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
