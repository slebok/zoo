extract: ldf.xsd
	${tooldir}/xsd2bgf ldf.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	wget --no-check-certificate http://raw.github.com/grammarware/slps/eee74db24bdb1c49952cb8ff19a531a55d4257a2/shared/xsd/ldf.xsd -O raw.ldf.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../30/grammar.bgf grammar.bgf

include ../../Makefile.grammar
