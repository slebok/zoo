extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/e99a046831cc9f08d1a68496232d52901e39a9d0/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v21.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
