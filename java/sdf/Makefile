tdir = ../../../../shared/tools
sdflib = ../../../../../sdf-library/trunk/library/languages/java/syntax

all:
	make build
	make test

build:
	${tdir}/sdf2bgf ${sdflib}/*.sdf java.sdf.ext.bgf
	${tdir}/subgrammar java.sdf.ext.bgf Top-sort java.sdf.rec.bgf

test:
	ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf

clean:
	rm -f *.bgf
