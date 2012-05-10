tdir = ../../../shared/tools
sdflib = ../../../../sdf-library/trunk/library/languages/logo/syntax

all:
	make extract
	make test

extract:
	${tdir}/sdf2bgf ${sdflib}/*.sdf raw.bgf
	${tdir}/subgrammar raw.bgf Program ext.bgf
	${tdir}/xbgf refactor.xbgf ext.bgf grammar.bgf

test:
	ls -1 *.xbgf | xargs -n1 ${tdir}/validate xbgf
	ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf

clean:
	rm -f *.bgf
