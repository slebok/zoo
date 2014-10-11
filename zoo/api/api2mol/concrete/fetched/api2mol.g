grammar api2mol;

options {
	k=4;
	backtrack=true;
}

mainRule 
	: contextSection? defaultMetaclassSection? mapping*
	;
	
contextSection
	: AT CONTEXT instanceName (COMMA instanceName)* SEMI
	;
	
defaultMetaclassSection
	: AT DEFAULT_METACLASS ID LPAREN ID RPAREN SEMI
	;

mapping
	: (ENUM)? metaclassName COLON instanceName LCURLY section* RCURLY // Use semantic predicates to make easier the parser
	;

metaclassName
	: ID
	;
	
instanceName
	: ID (DOT ID)*
	;

section
	: newSection
	| multipleSection
	| propertySection
	| valueSection
	;

newSection
	: AT NEW constructorCall* 
	;
	
multipleSection
	: AT MULTIPLE statement*
	;

propertySection
	: ID COLON statement*
	;
	
valueSection 
	: ID COLON instanceName SEMI
	;

statement
	: ID (LPAREN variable (COMMA variable)* RPAREN)? (methodCall)? SEMI
	;

constructorCall
	: ID LPAREN (param (COMMA param)*)? RPAREN SEMI
	;

methodCall
	: ID (LPAREN (param (COMMA param)*)? RPAREN)?
	;

variable
	: ID
	;

// In case we need to define a typed param...
param
	: ID
	;

// keywords
NEW      : 'new';
MULTIPLE : 'multiple';
ENUM     : 'enum';
CONTEXT  : 'context';
DEFAULT_METACLASS : 'defaultMetaclass';

// Special Characters
SLASH  : '\u005C';
COMMA  : '\u002C';
SEMI   : '\u003B';
COLON  : '\u003A';
LPAREN : '\u0028';
RPAREN : '\u0029';
LCURLY : '\u007B';
RCURLY : '\u007D';
DOT    : '\u002E';
AT	   : '\u0040';
ID 	   : ('a'..'z' | 'A'..'Z' | '_' | '*') ( 'a'..'z' | 'A'..'Z' | '0'..'9' | '_')*;

COMMENT			:  	 '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;};
LINE_COMMENT 	: 	'--' ~('\n'|'\r')* '\n' {$channel=HIDDEN;} ;
WS  			:  	(' '|'\r'|'\t'|'\u000C'|'\n') {$channel=HIDDEN;};  