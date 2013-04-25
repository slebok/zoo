extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/68fd0a46f1a47b37d964c4fb80ff512c82fc8ccb/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v17.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
