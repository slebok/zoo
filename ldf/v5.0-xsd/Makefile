extract: ldf.xsd
	${tooldir}/xsd2bgf ldf.xsd grammar.bgf

get: ldf.xsd

ldf.xsd:
	wget --no-check-certificate http://raw.github.com/grammarware/slps/c094e4591f60cdf54b3698892800042de24897da/shared/xsd/ldf.xsd -O raw.ldf.xsd
	cat raw.ldf.xsd | grep -v 'xsd:import' > ldf.xsd
	perl -pi -w -e 's/bgf:/ldf:/g;' ldf.xsd

diff:
	${tooldir}/gdts ../4/grammar.bgf grammar.bgf

include ../../Makefile.grammar
