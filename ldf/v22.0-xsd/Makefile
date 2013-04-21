extract: ldf.xsd
	${tooldir}/xsd2bgf ldx.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/c9f72600ca153fc833d1bd3190b547c56897cf74/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/c9f72600ca153fc833d1bd3190b547c56897cf74/shared/xsd/ldx.xsd -O ldx.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v21.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
