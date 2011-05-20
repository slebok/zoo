build: 
	make ada.bgf

ada.bgf: src.syntax.summary.txt
	cat src.syntax.summary.txt | grep -v 1. | grep -v 2. | grep -v 3. | grep -v 4. | grep -v 5. | grep -v 6. | grep -v 7. | grep -v 8. | grep -v 9. | grep -v 0. | grep -v 'quotation mark' > src.prepared.txt
	perl -pi -w -e 's/{\|/{TERMINALBAR/g;' src.prepared.txt
	../hunter.py src.prepared.txt config.edd ada-1.bgf
	../../../../shared/tools/xbgf post-extract.xbgf ada-1.bgf ada-2.bgf
	../../../../shared/tools/xbgf correct.xbgf ada-2.bgf ada.bgf
	../../../../shared/tools/bgf2bnf ada.bgf ada.bnf

test:
	ls -1 *.bgf | xargs -n1 ../../../../shared/tools/validate bgf
	../../../../shared/tools/checkbgf ada.bgf

clean:
	rm -f *.bgf *.bnf src.prepared.txt
