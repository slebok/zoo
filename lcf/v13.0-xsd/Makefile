extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/1ea0b2092c89cd43643e24a7d1952cc5d13665fd/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v12.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
