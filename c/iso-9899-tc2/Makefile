tooldir = ../../../../shared/tools

build:
	${tooldir}/pdf2bgf iso-is-annex.txt iso-output.bgf banned-lines.lst keywords.lst
	${tooldir}/checkxml bgf iso-output.bgf
	${tooldir}/normbgf iso-output.bgf iso-is-grammar.bgf
	${tooldir}/xbgf correct.xbgf iso-is-grammar.bgf iso-output.bgf
	${tooldir}/subgrammar iso-is-grammar.bgf translation-unit iso-is-grammar-fix.bgf
	rm -f iso-output.bgf

test:
	make build
	${tooldir}/gdts iso-is-grammar.bgf extracted-grammar.bgf
	${tooldir}/gdts iso-is-grammar-fix.bgf recovered-grammar.bgf

clean:
	rm -f iso-is-grammar.bgf iso-is-grammar-fix.bgf
