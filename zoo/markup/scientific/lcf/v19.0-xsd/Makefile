extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/d8d752bbd56bf3c9929e12d38c02e8be843937fd/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v18.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
