extract:
	../../hunter.py src.context.free.syntax.txt config.edd ada.raw.bgf
	../../../../shared/tools/xbgf correct.xbgf ada.raw.bgf ada.bgf

test:
	ls -1 *.bgf | xargs -n1 ../../../../shared/tools/validate bgf
	../../../../shared/tools/checkbgf ada.bgf

clean:
	rm -rf *.bgf *.bnf
