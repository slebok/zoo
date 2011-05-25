extract:
	cp src.manually.fixed.txt src.prepared.txt
	perl -pi -w -e 's/C\+\+/CPP/g;' src.prepared.txt
	../hunter.py src.prepared.txt config.edd eiffel-1.bgf
	../../../shared/tools/xbgf post-extraction.xbgf eiffel-1.bgf eiffel-2.bgf
	../../../shared/tools/xbgf correct.xbgf eiffel-2.bgf eiffel.bgf
	../../../shared/tools/bgf2html eiffel.bgf eiffel.html

test:
	ls -1 *.bgf | xargs -n1 ../../../../shared/tools/validate bgf
	../../../../shared/tools/checkbgf ada.bgf

clean:
	rm -f *.bgf *.bnf src.prepared.txt *.html
