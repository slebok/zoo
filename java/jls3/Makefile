all:
	make build
	make test

build:
	make impl
	make read

debug:
	python ../../../extraction/bnf2bgf/html2bgf.py impl.html impl3.bgf -v
	python ../../../../shared/python/getpre.py collect.kw read.html parse.html
	python ../../../extraction/bnf2bgf/html2bgf.py parse.html read3.bgf -v

impl:
	@echo "Extracting impl3" > /dev/stderr
	python ../../../extraction/bnf2bgf/html2bgf.py impl.html impl3.bgf

read:
	@echo "Extracting read3" > /dev/stderr
	python ../../../../shared/python/getpre.py collect.kw read.html parse.html
	python ../../../extraction/bnf2bgf/html2bgf.py parse.html read3.bgf

test:
	../../../../shared/tools/checkxml bgf impl3.bgf
	../../../../shared/tools/checkxml bgf read3.bgf
	../../../../shared/tools/gdts impl3.bgf extracted-implementable-grammar.bgf
	../../../../shared/tools/gdts read3.bgf extracted-readable-grammar.bgf

clean:
	rm -f *.bgf parse.html
