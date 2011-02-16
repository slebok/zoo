dsl = bgf
src  = ../../../../shared/xsd/${dsl}.xsd
tdir = ../../../../shared/tools

build:
	${tdir}/xsd2bgf ${src} ${dsl}.bgf
	${tdir}/subgrammar ${dsl}.bgf grammar ${dsl}.fix.bgf
	${tdir}/bgf2bnf ${dsl}.fix.bgf ${dsl}.bnf

test:
	@ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf 

clean:
	rm -f *~ ${dsl}.*
