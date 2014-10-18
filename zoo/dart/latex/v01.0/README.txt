http://github.com/dart-lang/bleeding_edge
	https://github.com/dart-lang/bleeding_edge/blob/aeaa33414f6a36599953da71049f4c7fa5e12508/dart/docs/language/dartLangSpec.tex

Dart Programming Language Specification
Draft Version 0.61
edit №1

Known errors:
    {\bf identifierList:}
      identifier (, identifier)*
    (unquoted ",")

    {\bf NEWLINE:}$\backslash$ n;
      $\backslash$ r
    .
    (also unquoted)

    {\bf importOrExport:}libraryImport ;
	  libraryExport   
  	(no dot at the end of the production rule)

    {\bf assertStatement:}
     assert '(' conditionalExpression ')' '{\escapegrammar ;}'
    (assert should be "assert")


Grammar in a broad sense fetched automatically and extracted in October 2014 by Vadim Zaytsev, http://grammarware.net
