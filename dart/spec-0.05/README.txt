http://www.dartlang.org/docs/spec/index.html
http://www.dartlang.org/docs/spec/dartLangSpec.html
The following link was used to download the textual version of the spec:
http://docs.google.com/document/d/12QYA9m3PbotzgPcEVf5K7n7YBv3VhM4U54Dy8TP1Qvc/export?format=txt&id=12QYA9m3PbotzgPcEVf5K7n7YBv3VhM4U54Dy8TP1Qvc&token=AC4w5ViscdISFR2ppBEVbbUixAo0It8Ftw%3A1322569540000&tfe=ed_13

The Dart Programming Language Specification
Draft Version 0.05
The Dart Team
November 14, 2011

List of errors:
	• in the definition of SINGLE_LINE_STRING, ' '' ' instead of ' " ' (which should mean '"' anyway)
	• in the definition of MULTI_LINE_STRING, two consequent defining metasymbols (MULTI_LINE_STRING: : …)
	• in the definition of staticFinalDeclarationList, two consequent defining metasymbols (staticFinalDeclarationList: : …)
	• the definition of ESCAPE_SEQUENCE ends with ':' instead of ';', which severely impedes automated recovery since
	  it introduces confusion between the defining metasymbol and the terminator metasymbol
	• the definition of getterSignature lacks the terminator metasymbol (fixed by Grammar Hunter easily)
	• the definition of setterSignature lacks the terminator metasymbol (fixed by Grammar Hunter easily)
	• the definition of bitwiseAndExpression lacks the terminator metasymbol (fixed by Grammar Hunter easily)
	• the definition of expressionStatement lacks the terminator metasymbol (fixed by Grammar Hunter easily)
	• seems like this version prefers single quoted terminals, but it has lots of legacy uses of 'fancy' quotes like “, ”, ‘ or ’

