extract: xldf.xsd
	${tooldir}/xsd2bgf xldf.xsd grammar.bgf

get: xldf.xsd

xldf.xsd:
	rm -f *.xsd
	wget --no-check-certificate http://raw.github.com/grammarware/slps/aa1fd1e7d8b2be0e996fcf61b35927f3ceb4ee93/shared/xsd/xldf.xsd -O raw.xldf.xsd
	cat raw.xldf.xsd | grep -v 'xsd:import' > xldf.xsd
	perl -pi -w -e 's/"bgf:/"xldf:/g;' xldf.xsd
	perl -pi -w -e 's/"xbgf:/"xldf:/g;' xldf.xsd
	perl -pi -w -e 's/"ldf:/"xldf:/g;' xldf.xsd

diff:
	${tooldir}/gdts ../v8.0-xsd/grammar.bgf grammar.bgf

include ../../Makefile.grammar
