dsl = xldf
src  = ../../../../shared/xsd/${dsl}.xsd
tdir = ../../../../shared/tools

build:
	${tdir}/xsd2bgf ${src} ${dsl}.bgf
	${tdir}/bgf2bnf ${dsl}.bgf ${dsl}.bnf

test:
	@ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf 

clean:
	rm -f *~ ${dsl}.*
