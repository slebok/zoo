tdir = ../../../shared/tools
sdflib = ../../../../sdf-library/trunk/library/languages/logo/syntax

all:
	make build
	make test

build:
	${tdir}/sdf2bgf ${sdflib}/*.sdf logo.sdf.ext.bgf
	${tdir}/subgrammar logo.sdf.ext.bgf Program logo.tmp.bgf
	${tdir}/xbgf refactor.xbgf logo.tmp.bgf logo.sdf.rec.bgf

test:
	ls -1 *.xbgf | xargs -n1 ${tdir}/validate xbgf
	ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf

clean:
	rm -f *.bgf
