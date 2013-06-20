extract:
	rm -f BGF.rsc
	wget --no-check-certificate https://github.com/grammarware/slps/raw/fc2e428f2d95abf11ec52ee5c26768fa99ff450d/shared/rascal/src/syntax/BGF.rsc
	${tooldir}/rscd2bgf BGF.rsc grammar.bgf

include ../../Makefile.grammar
