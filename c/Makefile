extract:
	cd iso-9899-1999 && make extract
	cd iso-9899-tc2  && make extract
	cd iso-9899-tc3  && make extract

clean:
	rm -f */*.bgf */*.html */*.bnf */intermediate.lll */tmp.xml

test:
	ls -1 */*.bgf | xargs -n1 ../../../shared/tools/validate bgf
