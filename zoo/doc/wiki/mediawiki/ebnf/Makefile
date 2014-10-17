extract:
	cp src.ebnf.wiki src.ebnf.prepared.wiki
	perl -pi -w -e 's/3 \* digit/digit, digit, digit/g;' src.ebnf.prepared.wiki
	perl -pi -w -e 's/5 \* digit/digit, digit, digit, digit, digit/g;' src.ebnf.prepared.wiki
	# this is a temporary hack for the sake of BGF not supporting exception symbol
	perl -pi -w -e 's/\- \"\|\"//g;' src.ebnf.prepared.wiki
	${hunter} src.ebnf.prepared.wiki config.edd raw.bgf
	${tooldir}/xbgf post-extract.xbgf raw.bgf ext.bgf
	${tooldir}/xbgf correct.xbgf ext.bgf grammar.bgf
	${tooldir}/bgf2html grammar.bgf view.html

get:
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/EBNF&action=raw&oldid=335623'           > src.ebnf.wiki

include ../../Makefile.grammar
