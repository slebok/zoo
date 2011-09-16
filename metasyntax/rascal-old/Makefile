extract:
	echo 'Extracting the actual grammar...'
	../../../extraction/rascal/extract.py RascalRascal.rsc ext.bgf
	${tooldir}/subgrammar ext.bgf Module PreModule Command grammar.bgf

horizontal:
	echo 'Recovering the horizontal grammar...'
	${tooldir}/xbgf horizontalize.xbgf grammar.bgf hor.bgf

include ../../Makefile.grammar
