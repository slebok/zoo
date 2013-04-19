extract:
	rm -f ext.*.bgf
	${tooldir}/rng2bgf mml2/mathml2.rng ext.mathml.bgf
	${tooldir}/rng2bgf mml2/mml-content-all.rng ext.content-all.bgf
	${tooldir}/rng2bgf mml2/mml-content-attrib.rng ext.content-attrib.bgf
	${tooldir}/rng2bgf mml2/mml-content-construct.rng ext.content-construct.bgf
	${tooldir}/rng2bgf mml2/mml-content-leaf.rng ext.content-leaf.bgf
	${tooldir}/rng2bgf mml2/mml-content-operators.rng ext.content-operators.bgf
	${tooldir}/rng2bgf mml2/mml-content-others.rng ext.content-others.bgf
	${tooldir}/rng2bgf mml2/mml-content-quantifiers.rng ext.content-quantifiers.bgf
	${tooldir}/rng2bgf mml2/mml-content-relations.rng ext.content-relations.bgf
	${tooldir}/rng2bgf mml2/mml-content-semantics.rng ext.content-semantics.bgf
	${tooldir}/rng2bgf mml2/mml-content-specials.rng ext.content-specials.bgf
	${tooldir}/rng2bgf mml2/mml-content-symbols.rng ext.content-symbols.bgf
	${tooldir}/rng2bgf mml2/mml-datatypes.rng ext.datatypes.bgf
	${tooldir}/rng2bgf mml2/mml-framework.rng ext.framework.bgf
	${tooldir}/rng2bgf mml2/mml-math.rng ext.math.bgf
	${tooldir}/rng2bgf mml2/mml-pres-action.rng ext.pres-action.bgf
	${tooldir}/rng2bgf mml2/mml-pres-all.rng ext.pres-all.bgf
	${tooldir}/rng2bgf mml2/mml-pres-attrib.rng ext.pres-attrib.bgf
	${tooldir}/rng2bgf mml2/mml-pres-content.rng ext.pres-content.bgf
	${tooldir}/rng2bgf mml2/mml-pres-empty.rng ext.pres-empty.bgf
	${tooldir}/rng2bgf mml2/mml-pres-layout-empty.rng ext.pres-layout-empty.bgf
	${tooldir}/rng2bgf mml2/mml-pres-layout.rng ext.pres-layout.bgf
	${tooldir}/rng2bgf mml2/mml-pres-scripts-empty.rng ext.pres-scripts-empty.bgf
	${tooldir}/rng2bgf mml2/mml-pres-scripts.rng ext.pres-scripts.bgf
	${tooldir}/rng2bgf mml2/mml-pres-tables.rng ext.pres-tables.bgf
	${tooldir}/mergebgf ext.*.bgf grammar.bgf

get:
	rm -rf mml2*
	wget http://yupotan.sppd.ne.jp/relax-ng/mml2-relaxng20080315.zip
	unzip mml2-relaxng20080315.zip
	rm mml2-relaxng20080315.zip

include ../../Makefile.grammar
