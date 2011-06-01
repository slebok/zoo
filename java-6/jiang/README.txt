http://www.antlr.org/grammar/list:
 ↳  http://openjdk.java.net/projects/compiler-grammar/antlrworks/Java.g

Java 1.6 grammar
Yang Jiang Fri Jan 16, 2009 12:01
ANTLR-based Java grammar from openjdk project to develop an experimental version of the javac compiler based upon a grammar written in ANTLR. Derived from Terence Parr's Java 1.5 grammar. NOTE:: Use ANTLR -Xconversiontimeout 100000 option. If it still doesn't work or the compilation process takes too long, try to comment out the following two lines:
| {isValidSurrogateIdentifierStart((char)input.LT(1), (char)input.LT(2))}?=>('\ud800'..'\udbff') ('\udc00'..'\udfff')
| {isValidSurrogateIdentifierPart((char)input.LT(1), (char)input.LT(2))}?=>('\ud800'..'\udbff') ('\udc00'..'\udfff')
