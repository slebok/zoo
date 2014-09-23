extract:
	rm -f ext*.bgf
	${tooldir}/rng2bgf fetched/xhtml-basic.rng ext.basic.bgf
	${tooldir}/rng2bgf fetched/datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf fetched/attribs.rng ext.attribs.bgf
	${tooldir}/rng2bgf fetched/struct.rng ext.struct.bgf
	${tooldir}/rng2bgf fetched/text.rng ext.text.bgf
	${tooldir}/rng2bgf fetched/hypertext.rng ext.hypertext.bgf
	${tooldir}/rng2bgf fetched/list.rng ext.list.bgf
	${tooldir}/rng2bgf fetched/basic-form.rng ext.form.bgf
	${tooldir}/rng2bgf fetched/basic-table.rng ext.table.bgf
	${tooldir}/rng2bgf fetched/image.rng ext.image.bgf
	${tooldir}/rng2bgf fetched/param.rng ext.param.bgf
	${tooldir}/rng2bgf fetched/object.rng ext.object.bgf
	${tooldir}/rng2bgf fetched/meta.rng ext.meta.bgf
	${tooldir}/rng2bgf fetched/link.rng ext.link.bgf
	${tooldir}/rng2bgf fetched/base.rng ext.base.bgf
	${tooldir}/mergebgf ext.*.bgf ext.all.bgf
	${tooldir}/normbgf ext.all.bgf extracted/grammar.bgf

fetch:
	rm -rf *.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/xhtml-basic.rng
	mv xhtml-basic.rng fetched/

include ../../Makefile.grammar

