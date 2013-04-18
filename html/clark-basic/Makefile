extract:
	rm -f ext*.bgf
	${tooldir}/rng2bgf xhtml-basic.rng ext.basic.bgf
	${tooldir}/rng2bgf ../clark/modules/datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf ../clark/modules/attribs.rng ext.attribs.bgf
	${tooldir}/rng2bgf ../clark/modules/struct.rng ext.struct.bgf
	${tooldir}/rng2bgf ../clark/modules/text.rng ext.text.bgf
	${tooldir}/rng2bgf ../clark/modules/hypertext.rng ext.hypertext.bgf
	${tooldir}/rng2bgf ../clark/modules/list.rng ext.list.bgf
	${tooldir}/rng2bgf ../clark/modules/basic-form.rng ext.form.bgf
	${tooldir}/rng2bgf ../clark/modules/basic-table.rng ext.table.bgf
	${tooldir}/rng2bgf ../clark/modules/image.rng ext.image.bgf
	${tooldir}/rng2bgf ../clark/modules/param.rng ext.param.bgf
	${tooldir}/rng2bgf ../clark/modules/object.rng ext.object.bgf
	${tooldir}/rng2bgf ../clark/modules/meta.rng ext.meta.bgf
	${tooldir}/rng2bgf ../clark/modules/link.rng ext.link.bgf
	${tooldir}/rng2bgf ../clark/modules/base.rng ext.base.bgf
	${tooldir}/mergebgf ext.*.bgf ext.all.bgf
	${tooldir}/normbgf ext.all.bgf grammar.bgf

get:
	rm -rf *.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/xhtml-basic.rng

include ../../Makefile.grammar

