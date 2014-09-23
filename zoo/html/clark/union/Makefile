extract:
	rm -f ext*.bgf
	${tooldir}/rng2bgf fetched/xhtml.rng ext.xhtml.bgf
	${tooldir}/rng2bgf fetched/datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf fetched/attribs.rng ext.attribs.bgf
	${tooldir}/rng2bgf fetched/frames.rng ext.frames.bgf
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
	${tooldir}/rng2bgf fetched/legacy.rng ext.legacy.bgf
	${tooldir}/mergebgf ext.*.bgf ext.all.bgf
	${tooldir}/normbgf ext.all.bgf extracted/grammar.bgf


fetch:
	make clean
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/applet.rng -O fetched/applet.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/attribs.rng -O fetched/attribs.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/base.rng -O fetched/base.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/basic-form.rng -O fetched/basic-form.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/basic-table.rng -O fetched/basic-table.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/bdo.rng -O fetched/bdo.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/csismap.rng -O fetched/csismap.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/datatypes.rng -O fetched/datatypes.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/edit.rng -O fetched/edit.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/events.rng -O fetched/events.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/form.rng -O fetched/form.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/frames.rng -O fetched/frames.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/hypertext.rng -O fetched/hypertext.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/iframe.rng -O fetched/iframe.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/image.rng -O fetched/image.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/inlstyle.rng -O fetched/inlstyle.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/legacy.rng -O fetched/legacy.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/link.rng -O fetched/link.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/list.rng -O fetched/list.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/meta.rng -O fetched/meta.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/nameident.rng -O fetched/nameident.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/object.rng -O fetched/object.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/param.rng -O fetched/param.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/pres.rng -O fetched/pres.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/ruby.rng -O fetched/ruby.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/script.rng -O fetched/script.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/ssismap.rng -O fetched/ssismap.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/struct.rng -O fetched/struct.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/style.rng -O fetched/style.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/table.rng -O fetched/table.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/target.rng -O fetched/target.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/text.rng -O fetched/text.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/xhtml.rng

clean:
	rm -rf fetched/*

include ../../Makefile.grammar

