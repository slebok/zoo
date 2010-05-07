all:
	make build
	make test

build:
	make impl
	make read

debug:
	python ../../../../shared/python/getpre.py syntax.kw impl.html parse.html
	python ../../../extraction/bnf2bgf/html2bgf.py parse.html impl1.bgf -v
	python ../../../../shared/python/getpre.py collect.kw read.html parse.html 
	python ../../../extraction/bnf2bgf/html2bgf.py parse.html read1.bgf -v

impl:
	@echo "Extracting impl1" > /dev/stderr
	python ../../../../shared/python/getpre.py syntax.kw impl.html parse.html
	python ../../../extraction/bnf2bgf/html2bgf.py parse.html impl1.bgf

read:
	@echo "Extracting read1" > /dev/stderr
	python ../../../../shared/python/getpre.py collect.kw read.html parse.html
	python ../../../extraction/bnf2bgf/html2bgf.py parse.html read1.bgf

test:
	../../../../shared/tools/checkxml bgf impl1.bgf
	../../../../shared/tools/checkxml bgf read1.bgf
	../../../../shared/tools/gdts impl1.bgf extracted-implementable-grammar.bgf
	../../../../shared/tools/gdts read1.bgf extracted-readable-grammar.bgf

clean:
	rm -f *.bgf parse.html
