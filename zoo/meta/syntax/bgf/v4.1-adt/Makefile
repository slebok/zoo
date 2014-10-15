extract:
	#rm -f XBGFSyntax.rsc
	# wget --no-check-certificate http://github.com/grammarware/slps/raw/921d8c44a4c998bbb9f2d258a8ddc8a200383801/shared/rascal/src/XBGFSyntax.rsc
	${tooldir}/rscd2bgf XBGFSyntax.rsc ext.bgf
	${tooldir}/subgrammar ext.bgf BGFProduction grammar.bgf

include ../../Makefile.grammar
