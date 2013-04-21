extract: ldf.xsd
	${tooldir}/xsd2bgf ldx.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/33841b1af5ef5acb9c221119703fdb314afeb857/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/33841b1af5ef5acb9c221119703fdb314afeb857/shared/xsd/ldx.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/9a4a5f4704331c2bcdff904eb5a32b92ce84f6fc/shared/xsd/fakemathml.xsd
	cat raw.ldf.xsd | grep -v 'bgf.xsd' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v15.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
