all:
	../../../../shared/tools/pdf2bgf msft-ls-1.0-annex.txt msft-output.bgf banned-lines.lst keywords.lst
	../../../../shared/tools/checkxml bgf msft-output.bgf
	../../../../shared/tools/normbgf msft-output.bgf msft-ls-1.0-grammar.bgf
	../../../../shared/tools/bgf2bnf msft-ls-1.0-grammar.bgf msft-ls-1.0.bnf
	rm -f msft-output.bgf
