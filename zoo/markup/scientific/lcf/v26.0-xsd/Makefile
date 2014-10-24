extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/cea9cfb70f92db69e61f3cdc00917ddc6e5ededc/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v25.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
