extract: ldf.xsd
	${tooldir}/xsd2bgf ldx.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/f19ca1b8d95bade382ca068f4642c27f46035126/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/f19ca1b8d95bade382ca068f4642c27f46035126/shared/xsd/ldx.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/9a4a5f4704331c2bcdff904eb5a32b92ce84f6fc/shared/xsd/fakemathml.xsd
	cat raw.ldf.xsd | grep -v 'bgf.xsd' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v14.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
