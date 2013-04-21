extract: ldf.xsd
	${tooldir}/xsd2bgf ldf.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/8d785b3c96ab13f50b534c318b93592375db4842/shared/xsd/ldf.xsd -O raw.ldf.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/8d785b3c96ab13f50b534c318b93592375db4842/shared/xsd/fakemathml.xsd
	cat raw.ldf.xsd | grep -v 'bgf.xsd' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../v38.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
