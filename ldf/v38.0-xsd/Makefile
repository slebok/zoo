extract: ldf.xsd
	${tooldir}/xsd2bgf ldf.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/ca2a84475de299a1ec84b69f3d967848071eb72a/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/ca2a84475de299a1ec84b69f3d967848071eb72a/shared/xsd/fakemathml.xsd
	cat raw.ldf.xsd | grep -v 'bgf.xsd' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v37.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
