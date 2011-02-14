tdir = ../../../shared/tools
sdflib = ../../../../sdf-library/trunk/library/languages/modula-3/syntax

all:
	make build
	make test

build:
	${tdir}/sdf2bgf ${sdflib}/*.sdf modula.3.sdf.ext.bgf
	${tdir}/subgrammar modula.3.sdf.ext.bgf Compilation modula.tmp.bgf
	${tdir}/xbgf refactor.xbgf modula.tmp.bgf modula.3.sdf.rec.bgf

test:
	ls -1 *.xbgf | xargs -n1 ${tdir}/validate xbgf
	ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf

clean:
	rm -f *.bgf
