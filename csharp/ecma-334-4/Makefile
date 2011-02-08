tooldir = ../../../../shared/tools

build:
	${tooldir}/pdf2bgf ecma-334-annex.txt ecma-output.bgf banned-lines.lst keywords.lst
	${tooldir}/checkxml bgf ecma-output.bgf
	${tooldir}/normbgf ecma-output.bgf ecma-334-grammar.bgf
	${tooldir}/xbgf correct.xbgf ecma-334-grammar.bgf ecma-output.bgf
	${tooldir}/subgrammar ecma-output.bgf compilation-unit ecma-334-grammar-fix.bgf
	rm -f ecma-output.bgf

clean:
	rm -f ecma-334-grammar.bgf ecma-334-grammar-fix.bgf intermediate.lll

test:
	make build
	${tooldir}/gdts ecma-334-grammar.bgf extracted-grammar.bgf
	${tooldir}/gdts ecma-334-grammar-fix.bgf recovered-grammar.bgf
