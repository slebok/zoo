extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/bc4b5d53b3750eee6d8eaaa7ed9db5b5e89d33bc/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v10.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
