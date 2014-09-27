http://www.graphviz.org/
	http://www.graphviz.org/doc/info/lang.html

The DOT Language

The following is an abstract grammar defining the DOT language. Terminals are
shown in bold font and nonterminals in italics. Literal characters are given in
single quotes. Parentheses ( and ) indicate grouping when needed. Square
brackets [ and ] enclose optional items. Vertical bars | separate alternatives.

The keywords node, edge, graph, digraph, subgraph, and strict are case-independent. Note also that the allowed compass point values are not keywords, so these strings can be used elsewhere as ordinary identifiers and, conversely, the parser will actually accept any identifier.

An ID is one of the following:

Any string of alphabetic ([a-zA-Z\200-\377]) characters, underscores ('_') or digits ([0-9]), not beginning with a digit;
a numeral [-]?(.[0-9]+ | [0-9]+(.[0-9]*)? );
any double-quoted string ("...") possibly containing escaped quotes (\")1;
an HTML string (<...>).

An ID is just a string; the lack of quote characters in the first two forms is just for simplicity. There is no semantic difference between abc_2 and "abc_2", or between 2.34 and "2.34". Obviously, to use a keyword as an ID, it must be quoted. Note that, in HTML strings, angle brackets must occur in matched pairs, and newlines and other formatting whitespace characters are allowed. In addition, the content must be legal XML, so that the special XML escape sequences for ", &, <, and > may be necessary in order to embed these characters in attribute values or raw text. As an ID, an HTML string can be any legal XML string. However, if used as a label attribute, it is interpreted specially and must follow the syntax for HTML-like labels.
Both quoted strings and HTML strings are scanned as a unit, so any embedded comments will be treated as part of the strings.

An edgeop is -> in directed graphs and -- in undirected graphs.

The language supports C++-style comments: /* */ and //. In addition, a line beginning with a '#' character is considered a line output from a C preprocessor (e.g., # 34 to indicate line 34 ) and discarded.

Semicolons and commas aid readability but are not required. Also, any amount of whitespace may be inserted between terminals.

As another aid for readability, dot allows double-quoted strings to span multiple physical lines using the standard C convention of a backslash immediately preceding a newline character2. In addition, double-quoted strings can be concatenated using a '+' operator. As HTML strings can contain newline characters, which are used solely for formatting, the language does not allow escaped newlines or concatenation operators to be used within them.

Grammar in a broad sense fetched on 27 September 2014 by Vadim Zaytsev, http://grammarware.net
