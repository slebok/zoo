extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/fd61402155e4af2f462b3eb92e9aad2cb528b353/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v26.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
