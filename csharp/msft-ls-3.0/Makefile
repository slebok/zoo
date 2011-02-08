tooldir = ../../../../shared/tools

build:
	${tooldir}/pdf2bgf msft-ls-annex.txt msft-output.bgf banned-lines.lst keywords.lst
	${tooldir}/checkxml bgf msft-output.bgf
	${tooldir}/normbgf msft-output.bgf msft-ls-grammar.bgf
	${tooldir}/xbgf correct.xbgf msft-ls-grammar.bgf msft-output.bgf
	${tooldir}/subgrammar msft-output.bgf compilation-unit msft-ls-grammar-fix.bgf
	rm -f msft-output.bgf

clean:
	rm -f msft-output.bgf msft-ls-grammar.bgf intermediate.lll msft-ls-grammar-fix.bgf

test:
	make build
	${tooldir}/gdts msft-ls-grammar.bgf extracted-grammar.bgf
	${tooldir}/gdts msft-ls-grammar-fix.bgf recovered-grammar.bgf
