http://www.antlr3.org/grammar/list.html
	http://openjdk.java.net/projects/compiler-grammar/antlrworks/Java.g

Java 1.6 grammar
Yang Jiang, Fri Jan 16, 2009 12:01

ANTLR-based Java grammar from <a href="http://openjdk.java.net/projects/compiler-grammar/">openjdk project to develop an experimental version of the javac compiler based upon a grammar written in ANTLR</a>. Derived from Terence Parr's <a href="http://www.antlr3.org/grammar/1152141644268/Java.g">Java 1.5 grammar</a>. <B>NOTE:</B>: Use ANTLR <i>-Xconversiontimeout 100000</i> option. If it still doesn't work or the compilation process takes too long, try to comment out the following two lines:
| {isValidSurrogateIdentifierStart((char)input.LT(1), (char)input.LT(2))}?=>('\ud800'..'\udbff') ('\udc00'..'\udfff')
| {isValidSurrogateIdentifierPart((char)input.LT(1), (char)input.LT(2))}?=>('\ud800'..'\udbff') ('\udc00'..'\udfff')

Grammar in a broad sense fetched automatically on 23 September 2014 by Vadim Zaytsev, http://grammarware.net
