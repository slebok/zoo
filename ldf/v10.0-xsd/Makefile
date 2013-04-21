extract: ldf.xsd
	${tooldir}/xsd2bgf ldx.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/4038079fccea5a4e6777e6d68fb460b6fe8147a5/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/4038079fccea5a4e6777e6d68fb460b6fe8147a5/shared/xsd/ldx.xsd -O ldx.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v9.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
