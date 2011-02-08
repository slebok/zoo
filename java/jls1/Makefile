tdir = ../../../../shared/tools

all:
	make build
	make test

build:
	make impl
	make read

debug:
	${tdir}/html2bgf syntax.kw impl.html impl1.bgf -v
	${tdir}/html2bgf collect.kw read.html read1.bgf -v

impl:
	@echo "Extracting impl1" > /dev/stderr
	${tdir}/html2bgf syntax.kw impl.html impl1.bgf
	${tdir}/xbgf ../../../convergence/java/xbgf/correct-impl1.xbgf impl1.bgf impl1r.bgf

read:
	@echo "Extracting read1" > /dev/stderr
	${tdir}/html2bgf collect.kw read.html read1.bgf
	${tdir}/xbgf ../../../convergence/java/xbgf/correct-read1.xbgf read1.bgf read1r.bgf

test:
	ls -1 *.bgf | xargs -n1 ${tdir}/checkxml bgf
	${tdir}/gdts impl1.bgf extracted-implementable-grammar.bgf
	${tdir}/gdts read1.bgf extracted-readable-grammar.bgf
	${tdir}/gdts impl1r.bgf recovered-implementable-grammar.bgf
	${tdir}/gdts read1r.bgf recovered-readable-grammar.bgf

clean:
	rm -f ????1*.bgf parse.html
