http://www.dartlang.org/docs/spec/index.html
http://www.dartlang.org/docs/spec/dartLangSpec.pdf

Dart Programming Language Specification
Draft Version 0.01
The Dart Team
October 10th, 2011

List of errors not included in or not apparent from the XBGF files:
- lacking terminator symbol by NUMBER, assertStatement, scriptTag, libraryName
- constOb jectExpression => constObjectExpression
- things like ’;’ instead of ‘;’ in many terminals
- ‘, instead of ‘,’ (or ’,’) in formalParameterList
- ’) instead of ’(’ (or ‘(’) in libraryImport
- getterSignature and setterSignature contain "static" not in bold
- interfaceDefinition contains "interface" not in bold
- hyphenation in nonterminal names in
	factoryConstructorSignature
	mapLiteral
	relationalExpression
	additiveExpression
	interfaceDefinition
	functionExpression
	topLevelDefinition
	scriptDefinition
	libraryDefinition
- The last two alternatives are just wrong, incorrectly understood from ANTLR spec:
	SINGLE LINE STRING:
		   ‘”’ STRING CONTENT DQ* ‘”’
		 | ‘’’ STRING CONTENT SQ* ‘\’’
		 | ‘@’ ‘’’ ( ( ‘’’ | NEWLINE ))* ‘’’
		 | ‘@’ ‘”’ ( ( ‘”’ | NEWLINE ))* ‘”’
	;
- compoundAssignmentOperator contains both ("<<=") and ("<" "<" "="?) alternatives (left unfixed)
- switchCase contains "case" not in bold
- defaultCase contains "case" and "default" not in bold
- assertStatement contains "assert" not in bold