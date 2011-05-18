build:
	./extract.py src.context.free.syntax.txt config.edd ada.bgf

test:
	validate bgf ada.bgf
	checkbgf ada.bgf

clean:
	rm -rf *.bgf *.bnf
