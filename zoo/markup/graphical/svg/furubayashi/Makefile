extract:
	rm -f ext.*.bgf
	${tooldir}/rng2bgf fetched/svg11.rng ext.svg.bgf
	${tooldir}/rng2bgf fetched/svg-datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf fetched/svg-default-attrib.rng ext.default-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-core-attrib.rng ext.core-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-viewport-attrib.rng ext.viewport-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-paint-attrib.rng ext.paint-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-opacity-attrib.rng ext.opacity-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-graphics-attrib.rng ext.graphics-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-docevents-attrib.rng ext.docevents-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-graphevents-attrib.rng ext.graphevents-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-animevents-attrib.rng ext.animevents-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-xlink-attrib.rng ext.xlink-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-extresources-attrib.rng ext.extresources-attrib.bgf
	${tooldir}/rng2bgf fetched/svg-structure.rng ext.structure.bgf
	${tooldir}/rng2bgf fetched/svg-conditional.rng ext.conditional.bgf
	${tooldir}/rng2bgf fetched/svg-image.rng ext.image.bgf
	${tooldir}/rng2bgf fetched/svg-style.rng ext.style.bgf
	${tooldir}/rng2bgf fetched/svg-shape.rng ext.shape.bgf
	${tooldir}/rng2bgf fetched/svg-text.rng ext.text.bgf
	${tooldir}/rng2bgf fetched/svg-marker.rng ext.marker.bgf
	${tooldir}/rng2bgf fetched/svg-profile.rng ext.profile.bgf
	${tooldir}/rng2bgf fetched/svg-gradient.rng ext.gradient.bgf
	${tooldir}/rng2bgf fetched/svg-pattern.rng ext.pattern.bgf
	${tooldir}/rng2bgf fetched/svg-clip.rng ext.clip.bgf
	${tooldir}/rng2bgf fetched/svg-mask.rng ext.mask.bgf
	${tooldir}/rng2bgf fetched/svg-filter.rng ext.filter.bgf
	${tooldir}/rng2bgf fetched/svg-cursor.rng ext.cursor.bgf
	${tooldir}/rng2bgf fetched/svg-hyperlink.rng ext.hyperlink.bgf
	${tooldir}/rng2bgf fetched/svg-view.rng ext.view.bgf
	${tooldir}/rng2bgf fetched/svg-script.rng ext.script.bgf
	${tooldir}/rng2bgf fetched/svg-animation.rng ext.animation.bgf
	${tooldir}/rng2bgf fetched/svg-font.rng ext.font.bgf
	${tooldir}/rng2bgf fetched/svg-extensibility.rng ext.extensibility.bgf
	${tooldir}/mergebgf ext.*.bgf extracted/grammar.bgf

get:
	rm -rf fetched/*
	wget http://yupotan.sppd.ne.jp/relax-ng/svg11/svg11-relaxng-20060604.zip
	unzip svg11-relaxng-20060604.zip
	rm svg11-relaxng-20060604.zip

include ../../Makefile.grammar
