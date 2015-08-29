extract:
	${tooldir}/sdf2bgf ${sdflibdir}/sdf2/syntax/*.sdf raw.bgf
	cp raw.bgf grammar.bgf
	perl -pi -w -e 's/strcon2chardata\("\/\\\\"\)/\/\\/g;' grammar.bgf
	perl -pi -w -e 's/strcon2chardata\("\\\\\/"\)/\\\//g;' grammar.bgf
	perl -pi -w -e 's/strcon2chardata\("<START>"\)/&lt;START&gt;/g;' grammar.bgf
	perl -pi -w -e 's/strcon2chardata\("<Start>"\)/&lt;Start&gt;/g;' grammar.bgf

include ../../Makefile.grammar
