extract: ldf.xsd
	${tooldir}/xsd2bgf ldf.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/19a6b034bc7e29aba4ca8df1feaccd8e0c8c0058/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/19a6b034bc7e29aba4ca8df1feaccd8e0c8c0058/shared/xsd/fakemathml.xsd
	cat raw.ldf.xsd | grep -v 'bgf.xsd' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v42.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
