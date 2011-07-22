extract:
	cat src.article.title.wiki src.article.part1.manually.fixed.wiki src.links.manually.fixed.wiki src.magic.links.wiki src.special.block.part1.manually.fixed.wiki src.inline.text.part1.manually.fixed.wiki > src.bnf.prepared.wiki
	perl -pi -w -e 's/<source lang="bnf">/<source lang=bnf>/g;' src.bnf.prepared.wiki

	${hunter} src.article.part2.manually.fixed.wiki       metawiki.edd      raw.1.bgf
	${hunter} src.noparse.block.wiki                      noparse.edd       raw.2.bgf
	${hunter} src.special.block.part2.manually.fixed.wiki special.edd       raw.3.bgf
	${hunter} src.inline.text.part2.manually.fixed.wiki   inline.edd        raw.4.bgf
	${hunter} src.bnf.prepared.wiki                       main.edd          raw.5.bgf

	${tooldir}/mergebgf raw.1.bgf raw.2.bgf raw.3.bgf raw.4.bgf raw.5.bgf ext.01.bgf

	${tooldir}/xbgf utilise-plus.xbgf            ext.01.bgf ext.02.bgf
	${tooldir}/xbgf remove-concatenation.xbgf    ext.02.bgf ext.03.bgf
	${tooldir}/xbgf remove-extension-points.xbgf ext.03.bgf ext.04.bgf
	${tooldir}/xbgf remove-php-legacy.xbgf       ext.04.bgf ext.05.bgf
	${tooldir}/xbgf deyaccify.xbgf               ext.05.bgf ext.06.bgf
	${tooldir}/xbgf remove-comments.xbgf         ext.06.bgf ext.07.bgf
	${tooldir}/xbgf remove-lookahead.xbgf        ext.07.bgf ext.08.bgf
	${tooldir}/xbgf remove-duplicates.xbgf       ext.08.bgf ext.09.bgf
	${tooldir}/xbgf dehtmlify.xbgf               ext.09.bgf ext.10.bgf
	${tooldir}/xbgf utilise-question.xbgf        ext.10.bgf ext.11.bgf
	${tooldir}/xbgf utilise-star.xbgf            ext.11.bgf ext.12.bgf
	${tooldir}/xbgf fix-markup.xbgf              ext.12.bgf ext.13.bgf
	${tooldir}/xbgf define-special-symbols.xbgf  ext.13.bgf ext.14.bgf
	${tooldir}/xbgf fake-exclusion.xbgf          ext.14.bgf ext.15.bgf
	${tooldir}/xbgf remove-postfix-case.xbgf     ext.15.bgf ext.16.bgf
	${tooldir}/xbgf fix-names.xbgf               ext.16.bgf ext.17.bgf
	${tooldir}/xbgf unify-whitespace.xbgf        ext.17.bgf ext.18.bgf
	${tooldir}/xbgf connect-grammar.xbgf         ext.18.bgf ext.19.bgf
	${tooldir}/xbgf refactor-repetition.xbgf     ext.19.bgf ext.20.bgf
	${tooldir}/xbgf define-lexicals.xbgf         ext.20.bgf ext.21.bgf

	${hunter} mediawiki.config.wiki plain.edd add.bgf
	${tooldir}/mergebgf ext.21.bgf add.bgf ext.22.bgf
	${tooldir}/subgrammar ext.21.bgf wiki-page grammar.bgf

	${tooldir}/bgf2html grammar.bgf view.html
	${tooldir}/checkbgf grammar.bgf
	${tooldir}/checkbgf ext.01.bgf

plot:
	${tooldir}/bgf2dot  grammar.bgf grammar.dot
	perl -pi -w -e 's/\?/q/g;' grammar.dot
	perl -pi -w -e 's/-/_/g;' grammar.dot
	perl -pi -w -e 's/_>/->/g;' grammar.dot
	perl -pi -w -e 's/;/;\n/g;' grammar.dot
	perl -pi -w -e 's/digraph generated{//g;' grammar.dot
	echo 'digraph generated{' > grammar2.dot
	cat grammar.dot | sort | uniq >> grammar2.dot
	dot -Tpdf grammar2.dot >grammar.pdf
	cp grammar.pdf ~/projects/personal/papers/mediawiki

get:
	echo 'http://www.mediawiki.org/wiki/Markup_spec/BNF'                                                                 > README.txt
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/BNF&action=raw&oldid=281673'                        >> README.txt
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/BNF/Article_title&action=raw&oldid=295042'           > src.article.title.wiki
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/BNF/Article&action=raw&oldid=281674'                 > src.article.wiki
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/BNF/Noparse-block&action=raw&oldid=372814'           > src.noparse.block.wiki
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/BNF/Links&action=raw&oldid=376721'                   > src.links.wiki
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/BNF/Magic_links&action=raw&oldid=269783'             > src.magic.links.wiki
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/BNF/Special_block&action=raw&oldid=281676'           > src.special.block.wiki
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/BNF/Inline_text&action=raw&oldid=295055'             > src.inline.text.wiki
	curl -k 'http://www.mediawiki.org/w/index.php?title=Markup_spec/BNF/Fundamental_elements&action=raw&oldid=212918'    > src.fundamental.elements.wiki
	cat src.article.title.wiki src.article.wiki src.noparse.block.wiki src.links.wiki src.magic.links.wiki src.special.block.wiki src.inline.text.wiki src.fundamental.elements.wiki > src.bnf.wiki

include ../../Makefile.grammar
