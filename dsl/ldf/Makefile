dsl = ldf
src  = ../../../../shared/xsd/${dsl}.xsd
tdir = ../../../../shared/tools

build:
	${tdir}/xsd2bgf ${src} ${dsl}.raw.bgf
	${tdir}/xbgf fold-roles.xbgf ${dsl}.raw.bgf ${dsl}.1.bgf
	${tdir}/xbgf fold-names.xbgf ${dsl}.1.bgf ${dsl}.2.bgf
	${tdir}/xbgf fold-meta.xbgf ${dsl}.2.bgf ${dsl}.3.bgf
	${tdir}/xbgf rename-types.xbgf ${dsl}.3.bgf ${dsl}.4.bgf
	${tdir}/xbgf beautify.xbgf ${dsl}.4.bgf ${dsl}.final.bgf
	${tdir}/bgf2bnf ${dsl}.final.bgf ${dsl}.final.bnf

test:
	@ls -1 *.bgf | xargs -n1 ${tdir}/validate bgf 

clean:
	rm -f *~ ${dsl}.*
