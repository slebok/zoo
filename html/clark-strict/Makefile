extract:
	rm -f ext*.bgf
	${tooldir}/rng2bgf xhtml-strict.rng ext.strict.bgf
	${tooldir}/rng2bgf ../clark/modules/datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf ../clark/modules/attribs.rng ext.attribs.bgf
	${tooldir}/rng2bgf ../clark/modules/struct.rng ext.struct.bgf
	${tooldir}/rng2bgf ../clark/modules/text.rng ext.text.bgf
	${tooldir}/rng2bgf ../clark/modules/hypertext.rng ext.hypertext.bgf
	${tooldir}/rng2bgf ../clark/modules/list.rng ext.list.bgf
	${tooldir}/rng2bgf ../clark/modules/image.rng ext.image.bgf
	${tooldir}/rng2bgf ../clark/modules/ssismap.rng ext.ssismap.bgf
	${tooldir}/rng2bgf ../clark/modules/base.rng ext.base.bgf
	${tooldir}/rng2bgf ../clark/modules/link.rng ext.link.bgf
	${tooldir}/rng2bgf ../clark/modules/meta.rng ext.meta.bgf
	${tooldir}/rng2bgf ../clark/modules/param.rng ext.param.bgf
	${tooldir}/rng2bgf ../clark/modules/object.rng ext.object.bgf
	${tooldir}/rng2bgf ../clark/modules/bdo.rng ext.bdo.bgf
	${tooldir}/rng2bgf ../clark/modules/pres.rng ext.pres.bgf
	${tooldir}/rng2bgf ../clark/modules/edit.rng ext.edit.bgf
	${tooldir}/rng2bgf ../clark/modules/applet.rng ext.applet.bgf
	${tooldir}/rng2bgf ../clark/modules/form.rng ext.form.bgf
	${tooldir}/rng2bgf ../clark/modules/basic-form.rng ext.form2.bgf
	${tooldir}/rng2bgf ../clark/modules/style.rng ext.style.bgf
	${tooldir}/rng2bgf ../clark/modules/script.rng ext.script.bgf
	${tooldir}/rng2bgf ../clark/modules/table.rng ext.table.bgf
	${tooldir}/rng2bgf ../clark/modules/basic-table.rng ext.table2.bgf
	${tooldir}/rng2bgf ../clark/modules/csismap.rng ext.csismap.bgf
	${tooldir}/rng2bgf ../clark/modules/events.rng ext.events.bgf
	${tooldir}/rng2bgf ../clark/modules/inlstyle.rng ext.inlstyle.bgf
	${tooldir}/rng2bgf ../clark/modules/target.rng ext.target.bgf
	${tooldir}/rng2bgf ../clark/modules/iframe.rng ext.iframe.bgf
	${tooldir}/rng2bgf ../clark/modules/nameident.rng ext.nameident.bgf
	${tooldir}/mergebgf ext.*.bgf ext.all.bgf
	${tooldir}/normbgf ext.all.bgf grammar.bgf

get:
	rm -rf *.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/xhtml-strict.rng

include ../../Makefile.grammar

