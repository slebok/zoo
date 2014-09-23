extract:
	rm -f ext*.bgf
	${tooldir}/rng2bgf fetched/xhtml-strict.rng ext.strict.bgf
	${tooldir}/rng2bgf fetched/datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf fetched/attribs.rng ext.attribs.bgf
	${tooldir}/rng2bgf fetched/struct.rng ext.struct.bgf
	${tooldir}/rng2bgf fetched/text.rng ext.text.bgf
	${tooldir}/rng2bgf fetched/hypertext.rng ext.hypertext.bgf
	${tooldir}/rng2bgf fetched/list.rng ext.list.bgf
	${tooldir}/rng2bgf fetched/image.rng ext.image.bgf
	${tooldir}/rng2bgf fetched/ssismap.rng ext.ssismap.bgf
	${tooldir}/rng2bgf fetched/base.rng ext.base.bgf
	${tooldir}/rng2bgf fetched/link.rng ext.link.bgf
	${tooldir}/rng2bgf fetched/meta.rng ext.meta.bgf
	${tooldir}/rng2bgf fetched/param.rng ext.param.bgf
	${tooldir}/rng2bgf fetched/object.rng ext.object.bgf
	${tooldir}/rng2bgf fetched/bdo.rng ext.bdo.bgf
	${tooldir}/rng2bgf fetched/pres.rng ext.pres.bgf
	${tooldir}/rng2bgf fetched/edit.rng ext.edit.bgf
	${tooldir}/rng2bgf fetched/applet.rng ext.applet.bgf
	${tooldir}/rng2bgf fetched/form.rng ext.form.bgf
	${tooldir}/rng2bgf fetched/basic-form.rng ext.form2.bgf
	${tooldir}/rng2bgf fetched/style.rng ext.style.bgf
	${tooldir}/rng2bgf fetched/script.rng ext.script.bgf
	${tooldir}/rng2bgf fetched/table.rng ext.table.bgf
	${tooldir}/rng2bgf fetched/basic-table.rng ext.table2.bgf
	${tooldir}/rng2bgf fetched/csismap.rng ext.csismap.bgf
	${tooldir}/rng2bgf fetched/events.rng ext.events.bgf
	${tooldir}/rng2bgf fetched/inlstyle.rng ext.inlstyle.bgf
	${tooldir}/rng2bgf fetched/target.rng ext.target.bgf
	${tooldir}/rng2bgf fetched/iframe.rng ext.iframe.bgf
	${tooldir}/rng2bgf fetched/nameident.rng ext.nameident.bgf
	${tooldir}/mergebgf ext.*.bgf ext.all.bgf
	${tooldir}/normbgf ext.all.bgf extracted/grammar.bgf

fetch:
	rm -rf *.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/xhtml-strict.rng
	mv xhtml-strict.rng fetched/

include ../../Makefile.grammar

