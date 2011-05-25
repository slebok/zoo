tdir = ../../../../shared/tools
sdflib = ../../../../../sdf-library/trunk/library/languages/fortran/syntax

all:
	make build
	make test

build:
	${tdir}/sdf2bgf ${sdflib}/*.sdf fortran.sdf.ext.bgf
	${tdir}/subgrammar fortran.sdf.ext.bgf ExecutableProgram fortran.tmp.bgf
	${tdir}/xbgf refactor.xbgf fortran.tmp.bgf fortran.sdf.rec.bgf
	cp fortran.sdf.rec.bgf fortran.bgf

test:
	ls -1 *.xbgf | xargs -n1 ${tdir}/validate xbgf
	ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf

clean:
	rm -f *.bgf
