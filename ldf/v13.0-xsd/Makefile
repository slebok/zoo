extract: ldf.xsd
	${tooldir}/xsd2bgf ldx.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/68353362de02b8999060b7941a921007b295da3f/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/68353362de02b8999060b7941a921007b295da3f/shared/xsd/ldx.xsd -O ldx.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v12.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
