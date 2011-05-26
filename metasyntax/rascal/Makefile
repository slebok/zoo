extract:
	echo 'Extracting the actual grammar...'
	../../../extraction/rascal/extract.py RascalRascal.rsc rascal.ext.bgf
	${tooldir}/subgrammar rascal.ext.bgf Module PreModule Command rascal.bgf

horizontal:
	echo 'Recovering the horizontal grammar...'
	${tooldir}/xbgf horizontalize.xbgf rascal.bgf rascal.hor.bgf
	${tooldir}/subgrammar rascal.hor.bgf Module PreModule Command rascal.true.hor.bgf

include ../../Makefile.include
