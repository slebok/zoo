all:
	./extract.py src.context.free.syntax.txt config.edd ada.bgf
	validate bgf ada.bgf
	checkbgf ada.bgf

clean:
	rm -rf *.bgf *.bnf
