all:
	../../../shared/tools/sdf2bgf ../../../../sdf-library/trunk/library/languages/bnf/syntax/*.sdf  bnf-sdf.bgf
	../../../shared/tools/sdf2bgf ../../../../sdf-library/trunk/library/languages/ebnf/syntax/*.sdf ebnf-sdf.bgf
	../../../shared/tools/xbgf correct.bnf.xbgf bnf-sdf.bgf _.bgf
	../../../shared/tools/subgrammar _.bgf Rules bnf-sdf.fix.bgf
	../../../shared/tools/xbgf correct.ebnf.xbgf ebnf-sdf.bgf _.bgf
	../../../shared/tools/subgrammar _.bgf Grammar ebnf-sdf.fix.bgf
	@rm -f _.bgf

test:
	@ls -1 *.bgf | xargs -n1 ../../../shared/tools/validate bgf