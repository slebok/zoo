extract:
	rm -f BGF.rsc
	wget --no-check-certificate https://github.com/grammarware/slps/raw/69838518ae695fd083067423e349a0673f595d04/shared/rascal/src/syntax/BGF.rsc
	${tooldir}/rscd2bgf BGF.rsc ext.bgf
	${tooldir}/mergebgf aliases.bgf ext.bgf grammar.bgf

include ../../Makefile.grammar
