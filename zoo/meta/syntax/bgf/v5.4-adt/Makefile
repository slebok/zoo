extract:
	rm -f BGF.rsc
	wget --no-check-certificate https://github.com/grammarware/slps/raw/05824bef6fe551c7cb134ec2d8b1d3ea8b6b28d4/shared/rascal/src/language/BGF.rsc
	diff BGF.rsc ../../../../shared/rascal/src/language/BGF.rsc
	${tooldir}/rscd2bgf BGF.rsc grammar.bgf

include ../../Makefile.grammar
