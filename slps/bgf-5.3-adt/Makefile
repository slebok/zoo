extract:
	rm -f BGF.rsc
	wget --no-check-certificate https://github.com/grammarware/slps/raw/bb8025496d46f747a9e4394a5cea4f235e1e26a6/shared/rascal/src/language/BGF.rsc
	diff BGF.rsc ../../../../shared/rascal/src/language/BGF.rsc
	${tooldir}/rscd2bgf BGF.rsc ext.bgf
	${tooldir}/mergebgf aliases.bgf ext.bgf grammar.bgf

include ../../Makefile.grammar
