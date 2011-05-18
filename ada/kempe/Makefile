all: 
	make ada.bgf

ada.bgf: iso-ada-1.bgf
	../../../../shared/tools/xbgf post-extract.xbgf iso-ada-1.bgf iso-ada-2.bgf
	../../../../shared/tools/xbgf nt2t.xbgf iso-ada-2.bgf iso-ada-3.bgf
	../../../../shared/tools/xbgf correct.xbgf iso-ada-3.bgf ada.bgf
	../../../../shared/tools/checkbgf ada.bgf

iso-ada-1.bgf: iso-grammar.txt keywords.lst
	../../../../shared/tools/lll2bgf iso-grammar.txt iso-ada-1.bgf
	../../../../shared/tools/validate bgf iso-ada-1.bgf || exit -1
	../../../../shared/python/keywords2xbgf.py

clean:
	rm -f iso-ada-?.bgf ada.bgf nt2t.xbgf
