extract: ldf.xsd
	${tooldir}/xsd2bgf ldf.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	wget --no-check-certificate http://raw.github.com/grammarware/slps/2c5e2630ea72dbf60a571552d094e8d0c10396ab/shared/xsd/ldf.xsd -O raw.ldf.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../16/grammar.bgf grammar.bgf

include ../../Makefile.grammar
