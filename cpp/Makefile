extract:
	cd iso-14882-1998 && make extract
	cd iso-n2723      && make extract

clean:
	rm -f */*.bgf */*.html */*.bnf */intermediate.lll */tmp.xml

test:
	ls -1 */*.bgf | xargs -n1 ../../../shared/tools/validate bgf
