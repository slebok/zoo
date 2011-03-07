http://www.antlr.org/grammar/list:
 ↳  http://www.antlr.org/grammar/1152141644268/Java.g

Java 1.5 grammar for ANTLR v3
Terence Parr Wed Jul 5, 2006 16:20
A Java 1.5 grammar written from the spec. Very clean and pretty fast. I have not tried to optimize for speed.



Java.stripped.g is derived from Java.g by:
	* removing all comments
	* removing all header sections (options, @lexer, ...)
	* removing fragments
	* removing predicates
	* removing rewrite rules
	* removing semantic actions
	* removing productions with .. or . or ~
	* removing local symbol options
	------------------------------------------------------ most of this was done automatically in Rascal
