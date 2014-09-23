grammar FOL;

options{
	language=Java;
	output=AST;
	ASTLabelType = CommonTree;
}

tokens{
	PREDICATE;
	FUNCTION;
}

/*------------------------------------------------------------------
 * PARSER RULES
 *------------------------------------------------------------------*/

condition: formula EOF! ;

formula	
	:	((FORALL^ | EXISTS^) VARIABLE)? disjunction ;

disjunction
	:	conjunction (OR^ conjunction)* ;

conjunction
	:	negation (AND^ negation)* ;

negation 
	:	NOT^? (predicate | LPAREN! formula RPAREN!) ;

predicate 
	:	PREPOSITION predicateTuple -> ^(PREDICATE PREPOSITION predicateTuple)
	| 	PREPOSITION ;

predicateTuple
	:	LPAREN! term (','! term)* RPAREN! ;

term	:	function | VARIABLE ;

function:	CONSTANT functionTuple -> ^(FUNCTION CONSTANT functionTuple)
	|	CONSTANT;

functionTuple
	:	LPAREN! (CONSTANT | VARIABLE) (','! (CONSTANT | VARIABLE) )* RPAREN!;

/*------------------------------------------------------------------
 * LEXER RULES
 *------------------------------------------------------------------*/

LPAREN : '(' ;
RPAREN :  ')' ;
AND :  '&' ;
OR :  '|' ;
NOT :  '!' ;
FORALL :  'Forall' ;
EXISTS :  'Exists' ;

VARIABLE: '?' (('a'..'z') | ('0'..'9')) CHARACTER* ;

CONSTANT: (('a'..'z') | ('0'..'9')) CHARACTER* ;

PREPOSITION: ('A'..'Z') CHARACTER* ;

fragment CHARACTER: ('0'..'9' | 'a'..'z' | 'A'..'Z' | '_') ;

WS : (' ' | '\t' | '\r' | '\n')+ {$channel = HIDDEN ;} ;
