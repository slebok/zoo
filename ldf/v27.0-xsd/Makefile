extract: ldf.xsd
	${tooldir}/xsd2bgf ldf.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	wget --no-check-certificate http://raw.github.com/grammarware/slps/679b2d8c3d1c83169d5b5329243d2fdcd34a9c91/shared/xsd/ldf.xsd -O raw.ldf.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../26/grammar.bgf grammar.bgf

include ../../Makefile.grammar
