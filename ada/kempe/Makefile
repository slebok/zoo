extract:
	cat src.syntax.summary.txt > src.prepared.txt
	perl -pi -w -e 's/{\|/{TERMINALBAR/g;' src.prepared.txt
	../../hunter.py src.prepared.txt config.edd ada-1.bgf
	${tooldir}/xbgf post-extract.xbgf ada-1.bgf ada-2.bgf
	${tooldir}/xbgf correct.xbgf ada-2.bgf ada.bgf

include ../../Makefile.include
