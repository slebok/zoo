all:
	echo 'Extracting the actual grammar...'
	../../extraction/rascal/extract.py RascalRascal.rsc rascal.bgf
	../../../shared/tools/validate bgf rascal.bgf
	../../../shared/tools/subgrammar rascal.bgf Module PreModule Command rascal.true.bgf
	../../../shared/tools/validate bgf rascal.true.bgf
	../../../shared/tools/bgf2bnf rascal.bgf rascal.bnf
	../../../shared/tools/bgf2bnf rascal.true.bgf rascal.true.bnf
	../../../shared/tools/bgf2html rascal.true.bgf rascal.true.html

hor:
	echo 'Recovering the horizontal grammar...'
	../../../shared/tools/xbgf horizontalize.xbgf rascal.bgf rascal.hor.bgf
	../../../shared/tools/validate bgf rascal.hor.bgf
	../../../shared/tools/subgrammar rascal.hor.bgf Module PreModule Command rascal.true.hor.bgf
	../../../shared/tools/validate bgf rascal.true.hor.bgf
	../../../shared/tools/bgf2bnf rascal.hor.bgf rascal.hor.bnf
	../../../shared/tools/bgf2bnf rascal.true.hor.bgf rascal.true.hor.bnf
	../../../shared/tools/bgf2html rascal.true.hor.bgf rascal.true.hor.html

clean:
	rm -f *.bgf *.bnf *.html
