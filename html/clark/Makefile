extract:
	rm -f ext*.bgf
	${tooldir}/rng2bgf xhtml.rng ext.xhtml.bgf
	${tooldir}/rng2bgf modules/datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf modules/attribs.rng ext.attribs.bgf
	${tooldir}/rng2bgf modules/frames.rng ext.frames.bgf
	${tooldir}/rng2bgf modules/text.rng ext.text.bgf
	${tooldir}/rng2bgf modules/hypertext.rng ext.hypertext.bgf
	${tooldir}/rng2bgf modules/list.rng ext.list.bgf
	${tooldir}/rng2bgf modules/image.rng ext.image.bgf
	${tooldir}/rng2bgf modules/ssismap.rng ext.ssismap.bgf
	${tooldir}/rng2bgf modules/base.rng ext.base.bgf
	${tooldir}/rng2bgf modules/link.rng ext.link.bgf
	${tooldir}/rng2bgf modules/meta.rng ext.meta.bgf
	${tooldir}/rng2bgf modules/param.rng ext.param.bgf
	${tooldir}/rng2bgf modules/object.rng ext.object.bgf
	${tooldir}/rng2bgf modules/bdo.rng ext.bdo.bgf
	${tooldir}/rng2bgf modules/pres.rng ext.pres.bgf
	${tooldir}/rng2bgf modules/edit.rng ext.edit.bgf
	${tooldir}/rng2bgf modules/applet.rng ext.applet.bgf
	${tooldir}/rng2bgf modules/form.rng ext.form.bgf
	${tooldir}/rng2bgf modules/style.rng ext.style.bgf
	${tooldir}/rng2bgf modules/script.rng ext.script.bgf
	${tooldir}/rng2bgf modules/table.rng ext.table.bgf
	${tooldir}/rng2bgf modules/csismap.rng ext.csismap.bgf
	${tooldir}/rng2bgf modules/events.rng ext.events.bgf
	${tooldir}/rng2bgf modules/inlstyle.rng ext.inlstyle.bgf
	${tooldir}/rng2bgf modules/target.rng ext.target.bgf
	${tooldir}/rng2bgf modules/iframe.rng ext.iframe.bgf
	${tooldir}/rng2bgf modules/nameident.rng ext.nameident.bgf
	${tooldir}/rng2bgf modules/legacy.rng ext.legacy.bgf
	${tooldir}/mergebgf ext.*.bgf ext.all.bgf
	${tooldir}/normbgf ext.all.bgf grammar.bgf


get:
	make clean
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/applet.rng -O modules/applet.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/attribs.rng -O modules/attribs.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/base.rng -O modules/base.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/basic-form.rng -O modules/basic-form.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/basic-table.rng -O modules/basic-table.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/bdo.rng -O modules/bdo.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/csismap.rng -O modules/csismap.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/datatypes.rng -O modules/datatypes.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/edit.rng -O modules/edit.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/events.rng -O modules/events.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/form.rng -O modules/form.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/frames.rng -O modules/frames.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/hypertext.rng -O modules/hypertext.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/iframe.rng -O modules/iframe.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/image.rng -O modules/image.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/inlstyle.rng -O modules/inlstyle.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/legacy.rng -O modules/legacy.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/link.rng -O modules/link.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/list.rng -O modules/list.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/meta.rng -O modules/meta.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/nameident.rng -O modules/nameident.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/object.rng -O modules/object.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/param.rng -O modules/param.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/pres.rng -O modules/pres.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/ruby.rng -O modules/ruby.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/script.rng -O modules/script.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/ssismap.rng -O modules/ssismap.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/struct.rng -O modules/struct.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/style.rng -O modules/style.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/table.rng -O modules/table.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/target.rng -O modules/target.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/modules/text.rng -O modules/text.rng
	wget http://www.thaiopensource.com/relaxng/xhtml/xhtml.rng

clean:
	rm -rf modules/*

include ../../Makefile.grammar

