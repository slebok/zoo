extract: ldf.xsd
	${tooldir}/xsd2bgf ldf.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/74963d64d1294f4dbc61341021967254535d46da/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/74963d64d1294f4dbc61341021967254535d46da/shared/xsd/fakemathml.xsd
	cat raw.ldf.xsd | grep -v 'bgf.xsd' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v39.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
