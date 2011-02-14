tdir = ../../../shared/tools
sdflib = ../../../../sdf-library/trunk/library/languages/pico/syntax

all:
	make build
	make test

build:
	${tdir}/sdf2bgf ${sdflib}/*.sdf pico.sdf.ext.bgf
	${tdir}/subgrammar pico.sdf.ext.bgf PROGRAM pico.tmp.bgf
	${tdir}/xbgf refactor.xbgf pico.tmp.bgf pico.sdf.rec.bgf

test:
	ls -1 *.xbgf | xargs -n1 ${tdir}/validate xbgf
	ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf

clean:
	rm -f *.bgf
