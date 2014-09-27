http://www.antlr3.org/grammar/list.html
	http://research.xebic.com
		http://research.xebic.com/es3/*

A complete ECMAScript 3 grammar
Xebic Research B.V. (Patrick Hulsmeijer), Wed Apr 9, 2008 05:08

Combined lexer/parser and treeparser grammars written from scratch with the ES3 specification in hand. Includes support for auto semicolon insertion and regular expression literals.

Copyrights 2008-2009 Xebic Reasearch BV. All rights reserved (see license.txt).
Original work by Patrick Hulsmeijer.

This ANTLR 3 LL(*) grammar is based on Ecma-262 3rd edition (JavaScript 1.5, JScript 5.5). 
The annotations refer to the "A Grammar Summary" section (e.g. A.1 Lexical Grammar) and the numbers in parenthesis to the paragraph numbers (e.g. (7.8) ).

History
	2008-4-9: Initial release.
	2008-4-11: Solely targeting Java for simplicity sake.
	2008-4-15: Added license. Fixed two bugs: EOL in MultiLineComment should be treated as SEMIC, function bodies should accept functionDeclarations.
	2009-4-16: Updated license statements.
	2009-12-4: Added seperate C# version.
	2010-2-25: Updated license.

Grammar in a broad sense fetched on 27 September 2014 by Vadim Zaytsev, http://grammarware.net
