all:
	cd ../../../extraction/antlr && make build
	make extract

extract:
	cd habelitz && make extract
	cd parr && make extract
	cd stahl && make extract
	cd studman && make extract
	rm */*.ext.bgf */*.fix.bgf

test:
	ls -1 *.bgf */*.bgf | xargs -n1 ../../../../shared/tools/validate bgf

clean:
	rm *.bgf
