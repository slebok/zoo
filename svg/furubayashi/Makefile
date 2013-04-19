extract:
	rm -f ext.*.bgf
	${tooldir}/rng2bgf svg11/svg11.rng ext.svg.bgf
	${tooldir}/rng2bgf svg11/svg-datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf svg11/svg-default-attrib.rng ext.default-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-core-attrib.rng ext.core-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-viewport-attrib.rng ext.viewport-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-paint-attrib.rng ext.paint-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-opacity-attrib.rng ext.opacity-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-graphics-attrib.rng ext.graphics-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-docevents-attrib.rng ext.docevents-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-graphevents-attrib.rng ext.graphevents-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-animevents-attrib.rng ext.animevents-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-xlink-attrib.rng ext.xlink-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-extresources-attrib.rng ext.extresources-attrib.bgf
	${tooldir}/rng2bgf svg11/svg-structure.rng ext.structure.bgf
	${tooldir}/rng2bgf svg11/svg-conditional.rng ext.conditional.bgf
	${tooldir}/rng2bgf svg11/svg-image.rng ext.image.bgf
	${tooldir}/rng2bgf svg11/svg-style.rng ext.style.bgf
	${tooldir}/rng2bgf svg11/svg-shape.rng ext.shape.bgf
	${tooldir}/rng2bgf svg11/svg-text.rng ext.text.bgf
	${tooldir}/rng2bgf svg11/svg-marker.rng ext.marker.bgf
	${tooldir}/rng2bgf svg11/svg-profile.rng ext.profile.bgf
	${tooldir}/rng2bgf svg11/svg-gradient.rng ext.gradient.bgf
	${tooldir}/rng2bgf svg11/svg-pattern.rng ext.pattern.bgf
	${tooldir}/rng2bgf svg11/svg-clip.rng ext.clip.bgf
	${tooldir}/rng2bgf svg11/svg-mask.rng ext.mask.bgf
	${tooldir}/rng2bgf svg11/svg-filter.rng ext.filter.bgf
	${tooldir}/rng2bgf svg11/svg-cursor.rng ext.cursor.bgf
	${tooldir}/rng2bgf svg11/svg-hyperlink.rng ext.hyperlink.bgf
	${tooldir}/rng2bgf svg11/svg-view.rng ext.view.bgf
	${tooldir}/rng2bgf svg11/svg-script.rng ext.script.bgf
	${tooldir}/rng2bgf svg11/svg-animation.rng ext.animation.bgf
	${tooldir}/rng2bgf svg11/svg-font.rng ext.font.bgf
	${tooldir}/rng2bgf svg11/svg-extensibility.rng ext.extensibility.bgf
	${tooldir}/mergebgf ext.*.bgf grammar.bgf

get:
	rm -rf svg11*
	wget http://yupotan.sppd.ne.jp/relax-ng/svg11/svg11-relaxng-20060604.zip
	unzip svg11-relaxng-20060604.zip
	rm svg11-relaxng-20060604.zip

include ../../Makefile.grammar
