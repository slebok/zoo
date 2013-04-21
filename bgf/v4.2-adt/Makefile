extract:
	rm -f BGF.rsc
	wget --no-check-certificate https://github.com/grammarware/slps/raw/ad3139811a32018301f770c307f9e11f00c92ad3/shared/rascal/src/syntax/BGF.rsc
	${tooldir}/rscd2bgf BGF.rsc grammar.bgf

include ../../Makefile.grammar
