build:
	../../../../shared/tools/pdf2bgf iso-is-annex.txt iso-output.bgf banned-lines.lst keywords.lst
	../../../../shared/tools/checkxml bgf iso-output.bgf
	../../../../shared/tools/normbgf iso-output.bgf iso-is-grammar.bgf
	../../../../shared/tools/bgf2bnf iso-is-grammar.bgf iso-is.bnf
	rm -f iso-output.bgf

clean:
	rm -f iso-output.bgf iso-is-grammar.bgf iso-is.bnf

test:
	make build
	../../../../shared/tools/gdt iso-is-grammar.bgf extracted-grammar.bgf
