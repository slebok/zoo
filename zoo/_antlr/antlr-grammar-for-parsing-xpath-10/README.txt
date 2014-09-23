http://www.antlr3.org/grammar/list.html
	http://blog.jwbroek.com/2010/07/antlr-grammar-for-parsing-xpath-10.html

XPath 1.0 grammar
Jan-Willem van den Broek, Thu Jul 15, 2010 17:09

XPath 1.0 grammar. Should conform to the official spec at http://www.w3.org/TR/1999/REC-xpath-19991116. The grammar rules have been kept as close as possible to those in the spec, but some adjustmewnts were unavoidable. These were mainly removing left recursion (spec seems to be based on LR), and to deal with the double nature of the '*' token (node wildcard and multiplication operator). See also section 3.7 in the spec. These rule changes should make no difference to the strings accepted by the grammar.

Grammar in a broad sense fetched automatically on 23 September 2014 by Vadim Zaytsev, http://grammarware.net
