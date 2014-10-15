extract:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/eadfc3bc8ec417737c5f36c74935bb727d0b79b6/shared/xsd/bgf.xsd
	${tooldir}/xsd2bgf bgf.xsd grammar.bgf

include ../../Makefile.grammar
