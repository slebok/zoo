tdir = ../../../../shared/tools

all:
	make build
	make test

build:
	make impl
	make read

debug:
	${tdir}/html2bgf impl.html impl3.bgf -v
	${tdir}/html2bgf collect.kw read.html read3.bgf -v

impl:
	@echo "Extracting impl3" > /dev/stderr
	${tdir}/html2bgf impl.html impl3.bgf
	${tdir}/xbgf ../../../convergence/java/xbgf/recover-impl3.xbgf impl3.bgf impl3t.bgf
	${tdir}/xbgf ../../../convergence/java/xbgf/correct-impl3.xbgf impl3t.bgf impl3r.bgf

read:
	@echo "Extracting read3" > /dev/stderr
	${tdir}/html2bgf collect.kw read.html read3.bgf
	${tdir}/xbgf ../../../convergence/java/xbgf/recover-read3.xbgf read3.bgf read3t.bgf
	${tdir}/xbgf ../../../convergence/java/xbgf/correct-read3.xbgf read3t.bgf read3r.bgf

test:
	ls -1 *.bgf | xargs -n1 ${tdir}/checkxml bgf
	${tdir}/gdts impl3.bgf extracted-implementable-grammar.bgf
	${tdir}/gdts read3.bgf extracted-readable-grammar.bgf
	${tdir}/gdts impl3r.bgf recovered-implementable-grammar.bgf
	${tdir}/gdts read3r.bgf recovered-readable-grammar.bgf

clean:
	rm -f ????3*.bgf parse.html

