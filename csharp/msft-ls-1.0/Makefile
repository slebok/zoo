tooldir = ../../../../shared/tools

build:
	${tooldir}/pdf2bgf msft-ls-annex.txt msft-output.bgf banned-lines.lst keywords.lst
	${tooldir}/checkxml bgf msft-output.bgf
	${tooldir}/normbgf msft-output.bgf msft-ls-grammar.bgf
	${tooldir}/subgrammar msft-ls-grammar.bgf compilation-unit msft-ls-grammar-fix.bgf
	rm -f msft-output.bgf

clean:
	rm -f msft-ls-grammar.bgf msft-ls-grammar-fix.bgf intermediate.lll

test:
	make build
	${tooldir}/gdts msft-ls-grammar.bgf extracted-grammar.bgf
	${tooldir}/gdts msft-ls-grammar-fix.bgf recovered-grammar.bgf
