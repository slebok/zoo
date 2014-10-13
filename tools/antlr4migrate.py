#!/usr/bin/python

dirs = [['creole/creole.g4'],
['csv/CSV.g4'],
['dot/DOT.g4'],
# ['ecmascript/ECMAScript.CSharpTarget.g4'],
['ecmascript/ECMAScript.g4'],
['erlang/Erlang.g4'],
['fasta/fasta.g4'],
['gff3/gff3.g4'],
['html/HTMLLexer.g4', 'html/HTMLParser.g4'],
['icalendar/ICalendar.g4'],
['idl/IDL.g4'],
['iri/IRI.g4'],
['java/Java.g4'],
['java8/Java8.g4'],
['lua/Lua.g4'],
['pcre/PCRE.g4'],
['pgn/PGN.g4'],
['python3/Python3.g4'],
['r/R.g4', 'r/RFilter.g4'],
['redcode/redcode.g4'],
['scala/scala.g4'],
['scss/ScssLexer.g4', 'scss/ScssParser.g4'],
['sqlite/SQLite.g4'],
['swift/Swift.g4'],
['tnsnames/tnsnames.g4'],
['tnt/tnt.g4'],
['turtle/TURTLE.g4'],
['ucb-logo/UCBLogo.g4'],
['webidl/WebIDL.g4'],
['xml/XMLLexer.g4', 'xml/XMLParser.g4']]

gm = open('Makefile','w')
gm.write('all:\n')
for d in dirs:
	first = d[0].split('/')[0]
	second = d[0].split('/')[1].split('.')[0]
	# gm.write('\tmkdir zoo/'+first+'/fetched\n')
	m = open('zoo/%s/Makefile' % first,'w')
	m.write('extract:\n\nfetch:\n\trm -f fetched/*.g4\n')
	for dd in d:
		fname = dd.split('/')[-1]
		gm.write('\tcp '+dd+' zoo/'+first+'/fetched/\n')
		m.write('\thttps://raw.githubusercontent.com/antlr/grammars-v4/master/'+dd+' > fetched/'+fname+'\n')
	m.close()
	z = open('zoo/%s/zoo.xml' % first, 'w')
	z.write('''<?xml version="1.0" encoding="UTF-8"?>
<entry>
	<name>%s</name>
	<source>
		<author>Terence Pratt</author>
		<file>%s</file>
		<date>2013</date>
		<link>
			<uri>https://github.com/antlr/grammars-v4/tree/master/%s</uri>
			<name>Explore</name>
		</link>
	</source>
	<readme/>
	<grammar>
		<dir>fetched</dir>
		<level>0</level>
		<method>git</method>
		<format>ANTLR4</format>
	</grammar>
</entry>''' % (second,first,first))
	z.close()
	r = open('zoo/%s/README.txt' % first, 'w')
	r.write('''http://www.antlr.org/
	https://github.com/antlr
		https://github.com/antlr/grammars-v4/
			https://github.com/antlr/grammars-v4/tree/master/%s

...

Grammar in a broad sense fetched automatically on 12 October 2014 by Vadim Zaytsev, http://grammarware.net
''' % first)
	r.close()

gm.close()

# extract:

# fetch:
# 	rm -f fetched/*.g4
# 	curl https://raw.githubusercontent.com/antlr/grammars-v4/master/basic/jvmBasic.g4 > fetched/jvmBasic.g4
