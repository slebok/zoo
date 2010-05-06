all:
	../../../../shared/tools/pdf2bgf ecma-334-annex.txt ecma-output.bgf banned-lines.lst keywords.lst
	../../../../shared/tools/checkxml bgf ecma-output.bgf
	../../../../shared/tools/normbgf ecma-output.bgf ecma-334-grammar.bgf
	../../../../shared/tools/bgf2bnf ecma-334-grammar.bgf ecma-334.bnf
	rm -f ecma-output.bgf
