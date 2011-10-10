extract:
	make fixes
	${hunter} grammar.lexically.fixed.prepared.src ebnf.edd raw.bgf
	${tooldir}/xbgf post-extract.xbgf raw.bgf ext.1.bgf
	${tooldir}/xbgf fix-spaces.xbgf ext.1.bgf ext.2.bgf
	${tooldir}/xbgf drop-empty-alternatives.xbgf ext.2.bgf ext.3.bgf
	${tooldir}/xbgf unite-misspellings.xbgf ext.3.bgf ext.4.bgf
	${tooldir}/xbgf emulate-negation.xbgf ext.4.bgf ext.5.bgf
	${tooldir}/xbgf emulate-omission.xbgf ext.5.bgf ext.6.bgf
	${tooldir}/xbgf correct.xbgf ext.6.bgf ext.7.bgf
	${tooldir}/xbgf complete.xbgf ext.7.bgf grammar.bgf

fixes:
	cp grammar.manually.fixed.src grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/HEX NUMBER/HEX_NUMBER/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/HEX DIGIT SEQUENCE/HEX_DIGIT_SEQUENCE/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/HEX DIGIT/HEX_DIGIT/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/SINGLE LINE STRING/SINGLE_LINE_STRING/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/MULTI LINE STRING/MULTI_LINE_STRING/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/ESCAPE SEQUENCE/ESCAPE_SEQUENCE/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/HEX DIGIT SEQUENCE/HEX_DIGIT_SEQUENCE/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/STRING CONTENT DQ/STRING_CONTENT_DQ/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/STRING CONTENT SQ/STRING_CONTENT_SQ/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/STRING INTERPOLATION/STRING_INTERPOLATION/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/IDENTIFIER NO DOLLAR/IDENTIFIER_NO_DOLLAR/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/BUILT IN IDENTIFIER/BUILT_IN_IDENTIFIER/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/IDENTIFIER START NO DOLLAR/IDENTIFIER_START_NO_DOLLAR/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/IDENTIFIER PART NO DOLLAR/IDENTIFIER_PART_NO_DOLLAR/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/IDENTIFIER START/IDENTIFIER_START/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/IDENTIFIER PART/IDENTIFIER_PART/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/SINGLE LINE COMMENT/SINGLE_LINE_COMMENT/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/MULTI LINE COMMENT/MULTI_LINE_COMMENT/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/‘/’/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/̃/~/g;' grammar.lexically.fixed.prepared.src
	perl -pi -w -e 's/ˆ/^/g;' grammar.lexically.fixed.prepared.src

include ../../Makefile.grammar
