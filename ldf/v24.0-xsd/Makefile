extract: ldf.xsd
	${tooldir}/xsd2bgf ldx.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/881caaf305bbabac1c9c4046b51e0e6b555763d0/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/881caaf305bbabac1c9c4046b51e0e6b555763d0/shared/xsd/ldx.xsd -O ldx.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v23.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
