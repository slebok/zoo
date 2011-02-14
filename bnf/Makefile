tdir = ../../../shared/tools
sdflib = ../../../../sdf-library/trunk/library/languages

all:
	make build
	make test

build:
	${tdir}/sdf2bgf ${sdflib}/bnf/syntax/*.sdf bnf.sdf.bgf
	${tdir}/sdf2bgf ${sdflib}/ebnf/syntax/*.sdf ebnf.sdf.bgf
	${tdir}/sdf2bgf ${sdflib}/yacc/syntax/*.sdf yacc.sdf.bgf
	${tdir}/xbgf correct.bnf.xbgf bnf.sdf.bgf _.bgf
	${tdir}/subgrammar _.bgf Rules bnf.sdf.fix.bgf
	${tdir}/xbgf correct.ebnf.xbgf ebnf.sdf.bgf _.bgf
	${tdir}/subgrammar _.bgf Grammar ebnf.sdf.fix.bgf
	${tdir}/xbgf refactor.yacc.xbgf yacc.sdf.bgf _.bgf
	${tdir}/subgrammar _.bgf Grammar yacc.sdf.fix.bgf

test:
	ls -1 *.xbgf | xargs -n1 ${tdir}/validate xbgf
	ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf

clean:
	rm -f bnf.sdf.bgf ebnf.sdf.bgf bnf.sdf.fix.bgf ebnf.sdf.fix.bgf yacc.sdf.bgf yacc.sdf.fix.bgf _.bgf
