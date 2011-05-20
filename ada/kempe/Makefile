build: 
	cat src.syntax.summary.txt | grep -v 'quotation mark' > src.prepared.txt
	perl -pi -w -e 's/{\|/{TERMINALBAR/g;' src.prepared.txt
	perl -pi -w -e 's/J\./0\./g;' src.prepared.txt
	../hunter.py src.prepared.txt config.edd ada-1.bgf
	../../../../shared/tools/xbgf post-extract.xbgf ada-1.bgf ada-2.bgf
	../../../../shared/tools/xbgf correct.xbgf ada-2.bgf ada.bgf
	../../../../shared/tools/bgf2bnf ada.bgf ada.bnf

test:
	ls -1 *.bgf | xargs -n1 ../../../../shared/tools/validate bgf
	../../../../shared/tools/checkbgf ada.bgf

clean:
	rm -f *.bgf *.bnf src.prepared.txt
