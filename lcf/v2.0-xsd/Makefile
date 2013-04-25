extract: lcf.xsd
	${tooldir}/xsd2bgf lcf.xsd grammar.bgf

get: lcf.xsd

lcf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/b7becc9e0439cc5ae21a4068bbe562baa8563018/shared/xsd/lcf.xsd -O lcf.xsd

diff:
	${tooldir}/gdts ../v1.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
