extract: ldf.xsd
	${tooldir}/xsd2bgf ldf.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	wget --no-check-certificate http://raw.github.com/grammarware/slps/9e1861cadc0a9134da58f9143cc84f7d53e63cd2/shared/xsd/ldf.xsd -O raw.ldf.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../28/grammar.bgf grammar.bgf

include ../../Makefile.grammar
