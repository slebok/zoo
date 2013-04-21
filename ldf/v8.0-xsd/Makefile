extract: ldf.xsd
	${tooldir}/xsd2bgf ldx.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/6e072e688d8e4f52d287c0d85e362547dafd45d9/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/6e072e688d8e4f52d287c0d85e362547dafd45d9/shared/xsd/ldx.xsd -O ldx.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v7.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
