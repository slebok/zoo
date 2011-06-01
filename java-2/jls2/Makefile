tdir = ../../../../shared/tools

all:
	make build
	make test

build:
	make impl
	make read

debug:
	${tdir}/html2bgf impl.html impl2.bgf -v
	${tdir}/html2bgf collect.kw read.html read2.bgf -v

impl:
	@echo "Extracting impl2" > /dev/stderr
	${tdir}/html2bgf impl.html impl2.bgf
	${tdir}/xbgf ../../../convergence/java/xbgf/correct-impl2.xbgf impl2.bgf impl2r.bgf

read:
	@echo "Extracting read2" > /dev/stderr
	${tdir}/html2bgf collect.kw read.html read2.bgf
	${tdir}/xbgf ../../../convergence/java/xbgf/recover-read2.xbgf read2.bgf read2t.bgf
	${tdir}/xbgf ../../../convergence/java/xbgf/correct-read2.xbgf read2t.bgf read2r.bgf

test:
	ls -1 *.bgf | xargs -n1 ${tdir}/checkxml bgf
	${tdir}/gdts impl2.bgf extracted-implementable-grammar.bgf
	${tdir}/gdts read2.bgf extracted-readable-grammar.bgf
	${tdir}/gdts impl2r.bgf recovered-implementable-grammar.bgf
	${tdir}/gdts read2r.bgf recovered-readable-grammar.bgf

clean:
	rm -f ????2*.bgf parse.html
