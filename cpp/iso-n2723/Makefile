build:
	grep -xv 'c ' iso-is-annex.txt > iso-is-annex-no-c.txt
	perl -pi -w -e 's/hand ler/handler/g;' iso-is-annex-no-c.txt
	../../../../shared/tools/pdf2bgf iso-is-annex-no-c.txt iso-output.bgf banned-lines.lst keywords.lst
	../../../../shared/tools/checkxml bgf iso-output.bgf
	../../../../shared/tools/normbgf iso-output.bgf iso-is-grammar.bgf
	../../../../shared/tools/bgf2bnf iso-is-grammar.bgf iso-is.bnf
	rm -f iso-output.bgf

clean:
	rm -f iso-output.bgf iso-is-grammar.bgf iso-is.bnf iso-is-annex-no-c.txt intermediate.lll

test:
	make build
	../../../../shared/tools/gdt iso-is-grammar.bgf extracted-grammar.bgf
