/*

Copyrights 2008-2009 Xebic Reasearch BV. All rights reserved (see license.txt).
Original work by Patrick Hulsmeijer.

*/

tree grammar ES3Walker ;

options
{
	ASTLabelType = CommonTree ;
	tokenVocab = ES3 ;
}


/*
Note: functionDeclaration is reachable via statement->expression as functionExpression and functionDeclaration are combined.
*/
program
	: statement*
	;

statement
	: block
	| variableDeclaration
	| expression
	| ifStatement
	| doStatement
	| whileStatement
	| forStatement
	| continueStatement
	| breakStatement
	| returnStatement
	| withStatement
	| labelledStatement
	| switchStatement
	| throwStatement
	| tryStatement
	;

block
	: ^( BLOCK statement* )
	;

variableDeclaration
	: ^( VAR ( Identifier | ^( ASSIGN Identifier expr ) )+ )
	;

ifStatement
	: ^( IF expression statement+ )
	;

doStatement
	: ^( DO statement expression )
	;

whileStatement
	: ^( WHILE expression statement )
	;

forStatement
	: ^(
	FOR 
	(
		^( FORSTEP ( exprOptClause | variableDeclaration ) exprOptClause exprOptClause )
		| ^( FORITER ( exprClause | variableDeclaration ) exprClause )
	)
	statement
	);

exprOptClause
	: ^( EXPR expression? )
	;

exprClause
	: ^( EXPR expression )
	;

continueStatement
	: ^( CONTINUE Identifier? )
	;

breakStatement
	: ^( BREAK Identifier? )
	;

returnStatement
	: ^( RETURN expression? )
	;

withStatement
	: ^( WITH expression statement )
	;

labelledStatement
	: ^( LABELLED Identifier statement )
	;

switchStatement
	: ^( SWITCH expression defaultClause? caseClause* )
	;

defaultClause
	: ^( DEFAULT statement* )
	;

caseClause
	: ^( CASE expression statement* )
	;

throwStatement
	: ^( THROW expression )
	;

tryStatement
	: ^( TRY block catchClause? finallyClause? )
	;
	
catchClause
	: ^( CATCH Identifier block )
	;
	
finallyClause
	: ^( FINALLY block )
	;

expression
	: expr 
	| ^( CEXPR expr+ )
	;

expr
	: leftHandSideExpression
	
	// Assignment operators
	| ^( ASSIGN expr expr )
	| ^( MULASS expr expr )
	| ^( DIVASS expr expr )
	| ^( MODASS expr expr )
	| ^( ADDASS expr expr )
	| ^( SUBASS expr expr )
	| ^( SHLASS expr expr )
	| ^( SHRASS expr expr )
	| ^( SHUASS expr expr )
	| ^( ANDASS expr expr )
	| ^( XORASS expr expr )
	| ^( ORASS expr expr )
	
	// Conditional operator
	| ^( QUE expr expr expr )
	
	// Logical operators
	| ^( LOR expr expr )
	| ^( LAND expr expr )
	
	// Binary bitwise operators
	| ^( AND expr expr )
	| ^( OR expr expr )
	| ^( XOR expr expr )
	
	// Equality operators
	| ^( EQ expr expr )
	| ^( NEQ expr expr )
	| ^( SAME expr expr )
	| ^( NSAME expr expr )
	
	// Relational operator
	| ^( LT expr expr )
	| ^( GT expr expr )
	| ^( LTE expr expr )
	| ^( GTE expr expr )
	| ^( INSTANCEOF expr expr )
	| ^( IN expr expr )
	
	// Bitwise shift operator
	| ^( SHL expr expr )
	| ^( SHR expr expr )
	| ^( SHU expr expr )
	
	// Additive operators
	| ^( ADD expr expr )
	| ^( SUB expr expr )
	
	// Multipiclative operators
	| ^( MUL expr expr )
	| ^( DIV expr expr )
	| ^( MOD expr expr )
	
	// Unary operator
	| ^( DELETE expr )
	| ^( VOID expr )
	| ^( TYPEOF expr )
	| ^( INC expr )
	| ^( DEC expr )
	| ^( POS expr )
	| ^( NEG expr )
	| ^( INV expr )
	| ^( NOT expr )
	
	// Postfix operators
	| ^( PINC expr )
	| ^( PDEC expr )
	;

leftHandSideExpression
	: primaryExpression
	| newExpression
	| functionDeclaration
	| callExpression
	| memberExpression
	;

newExpression
	: ^( NEW leftHandSideExpression )
	;

functionDeclaration
	: ^( FUNCTION Identifier? ^( ARGS Identifier* ) block )
	;

callExpression
	: ^( CALL leftHandSideExpression ^( ARGS expr* ) )
	;
	
memberExpression
	: ^( BYINDEX leftHandSideExpression expression )
	| ^( BYFIELD leftHandSideExpression Identifier )
	;

primaryExpression
	: Identifier
	| literal
	;

literal
	: THIS
	| NULL
	| booleanLiteral
	| numericLiteral
	| StringLiteral
	| RegularExpressionLiteral
	| arrayLiteral
	| objectLiteral
	;

booleanLiteral
	: TRUE
	| FALSE
	;

numericLiteral
	: DecimalLiteral
	| OctalIntegerLiteral
	| HexIntegerLiteral
	;

arrayLiteral
	: ^( ARRAY ( ^( ITEM expr? ) )* )
	;

objectLiteral
	: ^( OBJECT ( ^( NAMEDVALUE propertyName expr ) )* )
	;

propertyName
	: Identifier
	| StringLiteral
	| numericLiteral
	;
