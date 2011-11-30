extract:
	make fixes
	${hunter} manually.fixed.src ebnf2.edd raw.bgf
	cp raw.bgf grammar.bgf

fixes:
	cat DartLanguageSpecification0.05.txt | grep -v 'Observations:' | grep -v 'AProduction:' > prepared.text.src
	`dirname ${hunter}`/getgrammar.py prepared.text.src ebnf1.edd prepared.grammar.src
	cp prepared.grammar.src prepared.fixed.grammar.src
	perl -pi -w -e "s/‘/\'/g;" prepared.fixed.grammar.src
	perl -pi -w -e "s/’/\'/g;" prepared.fixed.grammar.src
	perl -pi -w -e "s/“/\'/g;" prepared.fixed.grammar.src
	perl -pi -w -e "s/”/\'/g;" prepared.fixed.grammar.src
	perl -pi -w -e "s/'0'\.\.'9'/'0'\|'1'\|'2'\|'3'\|'4'\|'5'\|'6'\|'7'\|'8'\|'9'/g;" prepared.fixed.grammar.src
	perl -pi -w -e 's/\[..?\]//g;' prepared.fixed.grammar.src

include ../../Makefile.grammar
