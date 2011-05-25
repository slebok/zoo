extract:
	cd ecma-334-1     && make extract
	cd ecma-334-2     && make extract
	cd ecma-334-3     && make extract
	cd ecma-334-4     && make extract
	cd iso-23270-2003 && make extract
	cd iso-23270-2006 && make extract
	cd msft-ls-1.0    && make extract
	cd msft-ls-1.2    && make extract
	cd msft-ls-3.0    && make extract
	cd msft-ls-4.0    && make extract

clean:
	rm -f */*.bgf */*.html */*.bnf */intermediate.lll */tmp.xml

test:
	ls -1 */*.bgf | xargs -n1 ../../../shared/tools/validate bgf
