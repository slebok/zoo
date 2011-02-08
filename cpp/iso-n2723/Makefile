tooldir = ../../../../shared/tools

build:
	grep -xv 'c ' iso-is-annex.txt > iso-is-annex-no-c.txt
	perl -pi -w -e 's/hand ler/handler/g;' iso-is-annex-no-c.txt
	${tooldir}/pdf2bgf iso-is-annex-no-c.txt iso-output.bgf banned-lines.lst keywords.lst
	${tooldir}/checkxml bgf iso-output.bgf
	${tooldir}/normbgf iso-output.bgf iso-is-grammar.bgf
	${tooldir}/xbgf correct.xbgf iso-is-grammar.bgf iso-output.bgf
	${tooldir}/subgrammar iso-output.bgf translation-unit iso-is-grammar-fix.bgf
	rm -f iso-output.bgf

clean:
	rm -f iso-is-grammar.bgf iso-is-grammar-fix.bgf intermediate.lll iso-is-annex-no-c.txt

test:
	make build
	${tooldir}/gdts iso-is-grammar.bgf extracted-grammar.bgf
	${tooldir}/gdts iso-is-grammar-fix.bgf recovered-grammar.bgf
