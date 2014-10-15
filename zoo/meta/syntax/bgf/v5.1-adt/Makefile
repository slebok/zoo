extract:
	rm -f BGF.rsc
	wget --no-check-certificate https://github.com/grammarware/slps/raw/962c2678e0ee1583dfddb9413e0af3520943a474/shared/rascal/src/syntax/BGF.rsc
	${tooldir}/rscd2bgf BGF.rsc grammar.bgf

include ../../Makefile.grammar
