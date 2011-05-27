extract:
	cp src.manually.fixed.txt src.prepared.txt
	perl -pi -w -e 's/–/-/g;' src.prepared.txt
	perl -pi -w -e 's/C\+\+/CPP/g;' src.prepared.txt
	../../hunter.py src.prepared.txt config.edd eiffel-1.bgf
	${tooldir}/xbgf post-extract.xbgf eiffel-1.bgf eiffel-2.bgf
	${tooldir}/xbgf correct.xbgf eiffel-2.bgf eiffel.bgf

include ../../Makefile.include
