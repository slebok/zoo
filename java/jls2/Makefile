all:
	make build
	make test

build:
	make impl
	make read

debug:
	python ../../../extraction/bnf2bgf/html2bgf.py impl.html impl2.bgf -v
	python ../../../../shared/python/getpre.py collect.kw read.html parse.html
	python ../../../extraction/bnf2bgf/html2bgf.py parse.html read2.bgf -v

impl:
	@echo "Extracting impl2" > /dev/stderr
	python ../../../extraction/bnf2bgf/html2bgf.py impl.html impl2.bgf

read:
	@echo "Extracting read2" > /dev/stderr
	python ../../../../shared/python/getpre.py collect.kw read.html parse.html
	python ../../../extraction/bnf2bgf/html2bgf.py parse.html read2.bgf

test:
	../../../../shared/tools/checkxml bgf impl2.bgf
	../../../../shared/tools/checkxml bgf read2.bgf
	../../../../shared/tools/gdts impl2.bgf extracted-implementable-grammar.bgf
	../../../../shared/tools/gdts read2.bgf extracted-readable-grammar.bgf

clean:
	rm -f *.bgf parse.html
