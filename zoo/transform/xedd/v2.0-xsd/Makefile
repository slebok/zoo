extract: xedd.xsd
	${tooldir}/xsd2bgf xedd.xsd grammar.bgf

get: xedd.xsd

xedd.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/5ec2a7520b89bd70cb3a9eb6d5c32d1688b7f04b/shared/xsd/xedd.xsd

diff:
	${tooldir}/gdts ../v1.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
