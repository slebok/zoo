extract:
	rm -f ext.*.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg11-tiny.rng ext.svg.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-default-attrib.rng ext.default-attrib.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-core-attrib.rng ext.core-attrib.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-basic-paint-attrib.rng ext.basic-paint-attrib.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-basic-graphics-attrib.rng ext.basic-graphics-attrib.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-xlink-attrib.rng ext.xlink-attrib.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-extresources-attrib.rng ext.extresources-attrib.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-tiny-model.rng ext.tiny-model.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-basic-structure.rng ext.basic-structure.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-conditional.rng ext.conditional.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-image.rng ext.image.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-style.rng ext.style.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-shape.rng ext.shape.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-basic-text.rng ext.basic-text.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-hyperlink.rng ext.hyperlink.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-view.rng ext.view.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-script.rng ext.script.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-animation.rng ext.animation.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-basic-font.rng ext.basic-font.bgf
	${tooldir}/rng2bgf ../furubayashi/svg11/svg-extensibility.rng ext.extensibility.bgf
	${tooldir}/mergebgf ext.*.bgf grammar.bgf

include ../../Makefile.grammar
