build:
	../../../../shared/tools/pdf2bgf msft-ls-annex.txt msft-output.bgf banned-lines.lst keywords.lst
	../../../../shared/tools/checkxml bgf msft-output.bgf
	../../../../shared/tools/normbgf msft-output.bgf msft-ls-grammar.bgf
	../../../../shared/tools/bgf2bnf msft-ls-grammar.bgf msft-ls.bnf
	rm -f msft-output.bgf

clean:
	rm -f msft-output.bgf msft-ls-grammar.bgf msft-ls.bnf

test:
	make build
	../../../../shared/tools/gdt msft-ls-grammar.bgf extracted-grammar.bgf
