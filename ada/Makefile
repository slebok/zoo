all: 
	make iso-ada-fix.bgf

iso-ada-fix.bgf: iso-ada.bgf
	xbgf post-extract.xbgf iso-ada-1.bgf iso-ada-2.bgf
	xbgf nt2t.xbgf iso-ada-2.bgf iso-ada-3.bgf
	xbgf correct.xbgf iso-ada-3.bgf iso-ada-fix.bgf
	checkbgf iso-ada-fix.bgf

iso-ada.bgf: iso-grammar.txt
	lll2bgf iso-grammar.txt iso-ada-1.bgf
	validate bgf iso-ada-1.bgf || exit -1
	./keywords2xbgf.py

clean:
	rm -f iso-ada-?.bgf