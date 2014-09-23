/*******************************************************************************
DESCRIPTION:
		Grammar for Sybase's PowerBuilder PowerScript						
		see: http://manuals.sybase.com/onlinebooks/group-pb/pbg0900e/psref/@Generic__BookTextView/222
				
AUTHOR:
		Ivan.Brezina (ibre5041@ibrezina.net)
DATE:
		DEC 2011
NOTES:
		target language Java
		antlr version 3.4
*******************************************************************************/

grammar PBM;


options {
  language = Java;
  output = AST;
}

tokens {
	DELIM = 'delim';
	
	ASTROOT = 'astroot';
	HEADER = 'header';
	BOODY = 'body';
	
	DATATYPEDECL               = 'datatypedecl';
	FORWARDDECL                = 'forwarddecl';
	TYPEVARIABLESDECL          = 'typevariablesdecl';
	GLOBALVARIABLESDECL        = 'globalvariablesdecl';
	VARIABLEDECL               = 'variabledecl';
	CONSTANTDECL               = 'constantdecl';
	FUNCTIONFORWARDDECL        = 'functionforwarddecl';
	FUNCTIONSFORWARDDECL       = 'functionsforwarddecl';
	FUNCTIONBODY               = 'functionbody';
	ONBODY                     = 'onbody';
	EVENTBODY                  = 'eventbody';
	
	STATEMENT                  = 'statement';
	SQLSTATEMENT               = 'sqlstatement';
	
	WINDOWPROP                 = 'windowprop';
	WINDOWSUBPROP              = 'windowsubprop';
	WINDOWSUBPROPNAME          = 'windowsubpropname'; // windowsubpropname == "retreive" is what you're looking for
	WINDOWSUBPROPVAL           = 'windowsubpropval';
}

@header {
  package org.pbm;
}

@lexer::header {
  package org.pbm;
}

@lexer::members {
List tokens = new ArrayList();
public void emit(Token token) {
		state.token = token;
		tokens.add(token);
}
public Token nextToken() {
		super.nextToken();
		if ( tokens.size()==0 ) {
				return Token.EOF_TOKEN;
		}
		return (Token)tokens.remove(0);
}
}

start_rule
	: header_rule	body_rule* EOF   
	 -> ^('astroot' ^('header' header_rule?) ^('body' body_rule*)) 
	;

// NOTE: this rule can match an empty string
header_rule
	: export_header* release_information? window_property_line*
	;

body_rule
	:
	  datatype_decl                -> ^('datatypedecl' datatype_decl)	  
	| access_modif!
	| forward_decl                 -> ^('forwarddecl' forward_decl)
	| type_variables_decl          -> ^('datatypedecl' type_variables_decl)
	| global_variables_decl        -> ^('datatypedecl' global_variables_decl)
	| variable_decl                -> ^('variabledecl' variable_decl)
	| constant_decl                -> ^('constantdecl' constant_decl)
	| function_forward_decl        -> ^('functionforwarddecl' function_forward_decl)
	| functions_forward_decl       -> ^('functionsforwarddecl' functions_forward_decl)
	| function_body                -> ^('functionbody' function_body)
	| on_body                      -> ^('onbody' on_body)
	| event_body                   -> ^('eventbody' event_body)
	;
	
// Header fields
export_header
	:
	( 
		{ input.LT(1).getText().contains("PBExport") }? i=ID { $i.setType(EXPORT_HEADER); } swallow_to_newline
		| EXPORT_HEADER
		| PBSELECT 
	)
	(NEWLINE | EOF) 
	;
	
release_information
	:	'RELEASE' NUMBER SEMI // delim - ignored due to preceeding SEMI see lexer rule NEWLINE 
	;

window_property_line
	: window_property+ delim
	;
	
window_property
	:
	(
	 attribute_name array_decl_sub?
	 LPAREN
	 window_property_attributes_sub?
	 RPAREN
	)
	;

window_property_attributes_sub
	: window_property_attribute_sub+
	;
	
window_property_attribute_sub
	:		(('NULL' | numeric_atom | DQUOTED_STRING | DATE | TIME) NEWLINE? COMMA?)
			|
			(
				attribute_name eq='=' 
				(
					attribute_value array_decl_sub?
					| LPAREN window_property_attributes_sub RPAREN
				) 
			) 
			NEWLINE? COMMA?
			-> ^('windowsubprop' ^('windowsubpropname' attribute_name) ^('windowsubpropval' attribute_value? array_decl_sub? LPAREN? window_property_attributes_sub? RPAREN?))			
	;

attribute_name
	: (identifier_name | 'TYPE' | 'UPDATE') NUMBER?
	( DOT ( identifier_name | 'CASE' | 'TYPE' | 'ON' | 'DYNAMIC') )*
	;

attribute_value
    : (atom_sub_call1) => atom_sub_call1
    | (atom_sub_member1) => atom_sub_member1    
    | ('-')? numeric_atom
    | boolean_atom
    | ENUM
    | DQUOTED_STRING
    | QUOTED_STRING
    | DATE
    | TIME
    | 'TYPE' | 'TO' | 'FROM' | 'REF' | 'NULL' | 'OPEN'
    | LPAREN 
					LPAREN (expression | data_type_sub ) (COMMA (expression| data_type_sub))? RPAREN
					(COMMA LPAREN (expression | data_type_sub ) (COMMA (expression | data_type_sub))? RPAREN)* 
			RPAREN
		| data_type_sub (LPAREN NUMBER RPAREN)?    
    ;
	
// Forward declaration
forward_decl
	: 
		'FORWARD' delim
		(datatype_decl | variable_decl)+
		'END' 'FORWARD' delim
	;

// Type declaration
datatype_decl
	:
		scope_modif? 'TYPE' identifier_name 'FROM' (identifier_name '`')? data_type_name ('WITHIN' identifier_name)? ('AUTOINSTANTIATE')?
		('DESCRIPTOR' DQUOTED_STRING '=' DQUOTED_STRING)? delim  
		(variable_decl | event_forward_decl)*
		'END' 'TYPE' delim
	;

type_variables_decl
	:
	'TYPE' 'VARIABLES' delim
	(access_modif | variable_decl | constant_decl)* 
	'END' 'VARIABLES' delim
	;

global_variables_decl
	:
	('GLOBAL'|'SHARED') 'VARIABLES' delim
	(variable_decl | constant_decl)*
	'END' 'VARIABLES' delim
	;

// Variable declaration
variable_decl_sub
    :
    ('INDIRECT')?
    access_modif_part?
    scope_modif?
    //indirect string y[] {  " ", "  a", "  1", "  ", "  2"  }
    (
   			  data_type_name decimal_decl_sub? identifier_name_ex array_decl_sub ( ('=')? '{' expression_list '}')?
   			|	data_type_name decimal_decl_sub? identifier_name_ex ('=' expression)?
   	)
    (
      	COMMA 
      	(
      				identifier_name_ex array_decl_sub ( ('=')? '{' expression_list '}')?
      			|	identifier_name_ex ('=' expression)?
    	  )
    )*
    ('DESCRIPTOR' DQUOTED_STRING '=' DQUOTED_STRING)?
    ;

variable_decl
		: variable_decl_sub (SEMI | delim)
		;
		
decimal_decl_sub
    :   '{' NUMBER '}'
    ;

array_decl_sub
    :   '[]'
    |		'[' ( ( '+' | '-' )? NUMBER ('TO' ( '+' | '-' )? NUMBER)? (COMMA ( '+' | '-' )? NUMBER ('TO' ( '+' | '-' )? NUMBER)? )* )? ']'
    ;

constant_decl_sub
    : // TODO '=' is mandatory for constants
        'CONSTANT' variable_decl_sub
    ;   

constant_decl
		: constant_decl_sub (SEMI | delim)
		;
		
function_forward_decl
	:
	access_modif_part?
	scope_modif?
	('FUNCTION' data_type_name | 'SUBROUTINE')	
	identifier_name
	LPAREN
	parameters_list_sub?
	RPAREN
	('LIBRARY' (DQUOTED_STRING|QUOTED_STRING) ('ALIAS' 'FOR' (DQUOTED_STRING|QUOTED_STRING) )? )?
	('RPCFUNC' 'ALIAS' 'FOR' (DQUOTED_STRING|QUOTED_STRING) )?
	('THROWS' identifier_name)?
	delim
	;

parameter_sub
	:
		('READONLY')? ('REF')? data_type_name decimal_decl_sub? identifier_name array_decl_sub?
	;

parameters_list_sub
	:
		parameter_sub (COMMA parameter_sub)*
	;

functions_forward_decl
	:
		('FORWARD'|'TYPE') 'PROTOTYPES' delim
		function_forward_decl+
		'END' 'PROTOTYPES' delim
	;
	
function_body
	:
	('PUBLIC' | 'PRIVATE' | 'PROTECTED')?
	scope_modif?
	('FUNCTION' data_type_name | 'SUBROUTINE')	
	identifier_name
	LPAREN
	parameters_list_sub?
	RPAREN 	('THROWS' identifier_name)?
	SEMI
	(statement)*
	'END' ('FUNCTION'|'SUBROUTINE') delim
	;
	
on_body
	: 'ON' (identifier | 'OPEN' | 'CLOSE') 
	// Ugly hack:
	// on ue_postopen;setpointer(Hourglass!)
	// on itemfocuschanged;IF ib_import THEN return
	(SEMI | delim)
	(statement)*
	'END' 'ON' delim
	;

event_forward_decl_sub
	: 'EVENT' (identifier_name | 'CREATE' | 'DESTROY') identifier_name? (LPAREN parameters_list_sub? RPAREN)? 
	| 'EVENT' 'TYPE' data_type_name identifier_name (LPAREN parameters_list_sub? RPAREN) 
	;
	
event_forward_decl
	: event_forward_decl_sub delim
	;
	
event_body
	// Ugly hack on event dw_summary::doubleclicked;call super::doubleclicked;long ll_row
	: 'EVENT' ('TYPE' data_type_name)? (identifier_name '::')? (identifier_name | 'OPEN' | 'CLOSE')
	(LPAREN parameters_list_sub? RPAREN)?
	SEMI
	(statement)*	
	'END' 'EVENT' delim
	;
	
// Member access modifiers
access_modif
    :
    (
        'PUBLIC:' | 'PUBLIC' ':'
    |   'PRIVATE:' | 'PRIVATE' ':'
    |   'PROTECTED:' | 'PROTECTED' ':'
    )
    delim
    ;

access_modif_part
		: 'PUBLIC' | 'PRIVATE' | 'PRIVATEREAD' | 'PRIVATEWRITE' | 'PROTECTED' | 'PROTECTEDREAD' | 'PROTECTEDWRITE'
		;
		
scope_modif
    : 'GLOBAL' | 'LOCAL'
    ;
    
// value expressions
expression
    : (close_call_sub) => close_call_sub                     // TODO should is be an atom?    
    | ('{') => '{' expression_list '}'
		| ('CREATE') => create_call_sub
		| boolean_expression
    ;

expression_list
	: ('REF'? expression) (COMMA 'REF'? expression)*    
	;
	
// LOGICAL expression  
boolean_expression
    :   condition_or
    ;

condition_or
    :   condition_and ( 'OR' condition_and )*
    ;

condition_and
    :   condition_not ( 'AND' condition_not )*
    ;

condition_not
    :   ('NOT')? condition_comparison
    ;

// RELATIONAL
condition_comparison
    :
        add_expr (( '=' | '>' | '<' | '<>' | '>=' | '<=' ) add_expr)?
    ;
    
// ARITHMETICAL
add_expr
    :   mul_expr ( ('-' | '+') mul_expr )*
    ;

mul_expr
    :   unary_sign_expr ( ( '*' | '/' | '^' ) unary_sign_expr )*
    ;

unary_sign_expr
    : (LPAREN expression RPAREN) => (LPAREN expression RPAREN)
    | ('-' | '+')? atom	
    ;
    

// Statements
statement
		:
		(if_simple_statement) => if_simple_statement                 -> ^('statement' if_simple_statement)
		| ('DESCRIBE' identifier_name)	=> sql_statement             -> ^('sqlstatement' sql_statement)
		| (assignment_statement) => assignment_statement             -> ^('statement' assignment_statement)
		| (statement_sub SEMI) => (statement_sub SEMI)               -> ^('statement' statement_sub)
		| (if_statement) => if_statement                             -> ^('statement' if_statement)
		| ('TRY') => try_catch_block                                 -> ^('statement' try_catch_block)
		| (post_event) => post_event                                 -> ^('statement' post_event)
		| (function_call_statement) => function_call_statement       -> ^('statement' function_call_statement)
		| (event_call_statement) => (event_call_statement)           -> ^('statement' event_call_statement)
		| (constant_decl) => constant_decl                           -> ^('statement' constant_decl)
		| (variable_decl) => variable_decl                           -> ^('statement' variable_decl)
		| (super_call_statement) => super_call_statement             -> ^('statement' super_call_statement)
		| (do_loop_while_statement) => do_loop_while_statement       -> ^('statement' do_loop_while_statement)
		| (do_while_loop_statement)	=> do_while_loop_statement       -> ^('statement' do_while_loop_statement)
		| (create_call_statement) => (create_call_statement)         -> ^('statement' create_call_statement)
		| (destroy_call_statement) => (destroy_call_statement)       -> ^('statement' destroy_call_statement)
		| (label_stat) => label_stat                                 -> ^('statement' label_stat)
		| (identifier delim) => identifier delim                     -> ^('statement' identifier)
		| throw_stat                                                 -> ^('statement' throw_stat)
		| goto_stat                                                  -> ^('statement' goto_stat)
		| sql_statement                                              -> ^('sqlstatement' sql_statement) 
		| choose_statement                                           -> ^('statement' choose_statement)
		| return_statement                                           -> ^('statement' return_statement)
		| for_loop_statement                                         -> ^('statement' for_loop_statement)
		| continue_statement                                         -> ^('statement' continue_statement)
		| exit_statement                                             -> ^('statement' exit_statement)
		| atom delim                                                 -> ^('statement' atom)
		;

statement_sub
		: (function_virtual_call_expression_sub) => function_virtual_call_expression_sub
		| (function_call_expression_sub) => function_call_expression_sub
		| (return_sub) => return_sub
		| (open_call_sub) => open_call_sub
		| (close_call_sub) => close_call_sub
		| (variable_decl_sub) => variable_decl_sub		
		| (super_call_sub) => super_call_sub
		| (create_call_sub) => create_call_sub
		| (destroy_call_sub) => destroy_call_sub
		| (continue_sub) => continue_sub
		| (goto_stat_sub) => goto_stat_sub				
		| (assignment_sub) => assignment_sub 
		;
			
assignment_sub
    :
        /* TODO lvalue */                              /* TODO expression */
        lvalue_sub ( '=' | '+=' | '-=' | '*=' | '/=' )
        (
        ('NOT') => boolean_expression
        | ('{') => '{' expression_list '}' // NOTE: this is an array assignment TOO
        | (boolean_expression) => boolean_expression
        | expression
        )
    ;
assignment_statement
		: assignment_sub SEMI? delim
		;
		
lvalue_sub
    : (atom_sub (DOT identifier_name_ex)) =>
    (
    	atom_sub (DOT identifier_name_ex (LPAREN expression_list? RPAREN)? ('[' expression_list ']')?)+ ('[]')?
    )      
    | (atom_sub_call1) => atom_sub_call1
    | (atom_sub_array1) => atom_sub_array1
    | (atom_sub_ref1) => atom_sub_ref1    
    | (atom_sub_member1) => atom_sub_member1 	
     	
		;	
		
return_sub
		: 'RETURN' expression?
		;
		
return_statement
		: return_sub delim
		;		
		
function_call_expression_sub
		: (atom_sub (DOT identifier_name_ex)) => atom_sub (DOT identifier_name_ex (LPAREN expression_list? RPAREN))+ 
		| atom_sub_call1
		;			

function_virtual_call_expression_sub 
// 	lw_sheet.Event Dynamic ue_show(Checked)
//	dw_sheet.Dynamic Event ue_select()
		: identifier_name DOT 'DYNAMIC' ('EVENT')? function_call_expression_sub
		| identifier_name DOT 'EVENT' 'DYNAMIC' function_call_expression_sub
		;

open_call_sub
		: 'OPEN' LPAREN expression_list RPAREN
		;
		
close_call_sub
		:	'CLOSE' LPAREN expression_list RPAREN
		| 'HALT' 'CLOSE'
		;
		
function_call_statement
		: ( function_call_expression_sub | function_virtual_call_expression_sub | open_call_sub | close_call_sub)
			delim
		;

super_call_sub
		: 'CALL' 
		(identifier_name '`')? 
		( 
			(atom_sub_call1) => atom_sub_call1 
			|atom_sub_member1
		)
		;

super_call_statement
		: super_call_sub delim
		;

event_call_statement_sub // li_rc = dw_action.Event ue_value_changed(1,1)
		: 
		( (identifier_name DOT (identifier_name DOT)?) | ('SUPER' '::') )? 		
		'EVENT' 
		atom_sub_call1
		;
		
event_call_statement
		:	event_call_statement_sub delim
		;
		
create_call_sub
		: 'CREATE' ('USING')? (identifier_name DOT)? data_type_name	(LPAREN expression_list? RPAREN)?
		;
		
create_call_statement
		: 	create_call_sub delim
		;	

destroy_call_sub
		: 'DESTROY' expression	
		;
		
destroy_call_statement
		: 	destroy_call_sub delim
		;	
								
for_loop_statement
		:
			'FOR' lvalue_sub '=' expression 'TO' expression ('STEP' expression)? delim
			statement*
			'NEXT' delim
		;

do_while_loop_statement
		: 'DO' ('WHILE' | 'UNTIL') boolean_expression delim
			statement*
			'LOOP' delim			
		;

do_loop_while_statement
		: 'DO' delim
			statement*
			'LOOP' ('WHILE' | 'UNTIL') boolean_expression delim			
		;
		
if_statement
		:	'IF' boolean_expression 'THEN' delim
			statement*
			(
				'ELSEIF' boolean_expression 'THEN' delim
				statement* 
			)*			
			(
				'ELSE' delim
				statement* 
			)?
			'END' 'IF' (SEMI | delim)
		;

// NOTE this one is single liner (all statements end with delim)
if_simple_statement
		: 'IF' boolean_expression 'THEN' statement
		;

continue_sub
		: 'CONTINUE'
		;

continue_statement
		: continue_sub delim
		;

// ldir.Post Event SelectionChanged(1)		
post_event_sub
		: 
		( atom_sub_member1 DOT)?
		('POST' | 'TRIGGER') ('EVENT')?
		identifier_name_ex LPAREN expression_list? RPAREN
		;

post_event
		: post_event_sub delim
		;
		
exit_statement_sub
		: 'EXIT'		
		;
		
exit_statement
		: exit_statement_sub delim
		;
		
choose_statement
		: 'CHOOSE' 'CASE' expression delim
			( 
			(choose_case_range_sub) => choose_case_range_sub
			| (choose_case_cond_sub) => choose_case_cond_sub
			| (choose_case_else_sub) => choose_case_else_sub
			| choose_case_value_sub  
			)+
			'END' 'CHOOSE' delim
		;

choose_case_value_sub
		: 'CASE' expression (COMMA expression)* delim
			statement*
		;

choose_case_cond_sub
		: 'CASE' 'IS' ( '=' | '>' | '<' | '<>' | '>=' | '<=' ) expression delim
			statement*
		;

choose_case_range_sub
		: 'CASE' atom 'TO' atom delim
					statement*
		;
		
choose_case_else_sub
		: 'CASE' 'ELSE' delim
			statement*
		;		

goto_stat_sub
		: 'GOTO' identifier_name
		;
		
goto_stat
		: goto_stat_sub delim
		;
		
label_stat
		: identifier_name COLON delim
		;

try_catch_block
		: 'TRY' delim
		statement*
		(
			'CATCH' LPAREN variable_decl_sub RPAREN delim
			statement*	
		)*
		(
			'FINALLY' delim
			statement*
		)?
		'END' 'TRY' delim	
		;

throw_stat_sub
		:	'THROW' expression
		;

throw_stat
		: throw_stat_sub delim
		;		

sql_statement
		: // NOTE: since the SQL statement ends with SEMI, a newline(delim) is on the HIDDEN channel
		( // Long ones
			('SELECT' | 'SELECTBLOB' |
			'UPDATE' | 'UPDATEBLOB' | 'INSERT' | 'MERGE' | 'DELETE' | 'PREPARE' |
			'EXECUTE' 'IMMEDIATE' |
			'DECLARE' | 'CLOSE' | 'FETCH' | 'OPEN' |			
			'COMMIT'| 'ROLLBACK' | 'CONNECT' | 'DISCONNECT' ) 
			swallow_to_semi SEMI // delim
		)
		| // Short ones
		( 'COMMIT' | 'CONNECT' | 'ROLLBACK' | 'DISCONNECT' ) SEMI // delim
		| // Strange ones (NOTE: Here we handle presence of the function describe(String s)) 
		( 'DESCRIBE' identifier_name identifier_name identifier_name ) SEMI // delim
		;
						
identifier
    :   identifier_name 
    |		'SUPER' '::' ('CREATE' | 'DESTROY' | identifier_name_ex)
    |		identifier_name '::' ('CREATE' | 'DESTROY')
    |		identifier_name DOT ('CREATE' | 'DESTROY')    
    |		identifier_name '::' identifier_name_ex            
    ;

identifier_name
    : ID
    ;

// this one can be used in expressions like:
// excel_object.Application.Sheets("Sheet1").Select()
// identifier_name_ex is never the first part in the identifier (except for 'DESCRIBE').
identifier_name_ex
    : identifier_name
    | 'SELECT' | 'TYPE' | 'UPDATE' | 'DELETE' | 'OPEN' | 'CLOSE' | 'GOTO' | 'INSERT' | 'DESCRIBE' | 'TIME' | 'READONLY'
    ;

fragment
atom_sub
    : (
    	(
    		(array_access_atom) => array_access_atom
    	| (identifier_name LPAREN expression_list? RPAREN) => identifier_name LPAREN expression_list? RPAREN
    	| identifier_name    	
    	)	
    	
    	) 
    ;
    
atom_sub_call1
		// For 'describe' see comment in identifier_name_ex and also definition for 'atom'
    : (identifier | 'DESCRIBE') LPAREN expression_list? RPAREN
    ;

atom_sub_array1    
    : identifier_name '[' expression_list ']'
    ;

atom_sub_ref1    
    :  identifier_name '[]'
    ;
    
atom_sub_member1    
    :  identifier
    ;
    
atom
    :
    (event_call_statement_sub) => event_call_statement_sub    
    // Turn left-recursion into the rigth recursion - ugly but functional
    | 
    (atom_sub (DOT identifier_name_ex)) => atom_sub (DOT identifier_name_ex (LPAREN expression_list? RPAREN)? ('[' expression_list ']')? )+ ('++' | '--' | '[]' )?
    | (cast_expression) => cast_expression        	
    | (atom_sub_call1) => atom_sub_call1
    | (atom_sub_array1) => atom_sub_array1 ('++' | '--')?
    | (atom_sub_ref1) => atom_sub_ref1    
    | (atom_sub_member1) => atom_sub_member1 ('++' | '--')?           
    | numeric_atom
    | boolean_atom
    | ENUM
    | DQUOTED_STRING
    | QUOTED_STRING
    | DATE
    | TIME 
    ;

swallow_to_semi :
        ~( SEMI )+
    ;
    
swallow_to_newline :
       ~( NEWLINE )+
    ;   
array_access_atom
	: identifier_name '[' expression_list ']' 
	;
	
numeric_atom
    : NUMBER
    ;

boolean_atom
    : 'TRUE'
    | 'FALSE'
    ;

cast_expression
		: data_type_sub LPAREN expression (COMMA expression)* RPAREN
		;
		
data_type_sub
    :   'ANY'
    |   'BLOB'
    |   'BOOLEAN'
    |   'BYTE'
    |   'CHARACTER'
    |   'CHAR'
    |   'DATE'
    |   'DATETIME'
    |   'DECIMAL'
    |   'DEC'
    |   'DOUBLE'
    |   'INTEGER'
    |   'INT'
    |   'LONG'
    |   'LONGLONG'
    |   'REAL'
    |   'STRING'
    |   'TIME'
    |   'UNSIGNEDINTEGER'
    |   'UINT'
    |   'UNSIGNEDLONG'
    |   'ULONG'
    |		'WINDOW'
    ;

data_type_name
		: data_type_sub
		| identifier_name
		;
    
delim
    : NEWLINE
    | DELIM
    | EOF
    ;
    
DQUOTED_STRING
    :   '"' (E_TILDE | ~('"') | E_DOUBLE_QUOTE )* '"'
    ;
    
QUOTED_STRING
    :   '\'' ( ~('\'') | E_QUOTE )* '\''
    ;    

fragment
ID_PARTS
		: 'A' .. 'Z' ( 'A' .. 'Z' | DIGIT | '-' | '$' | '#' | '%' | '_' )*
		;

ENUM
    :
        ID_PARTS '!'
    ;

COMMA : ',';


ID  :
        ID_PARTS
    ;

SEMI : ';';

LPAREN : '(';

RPAREN : ')';

COLON : ':';

NUMBER
    :
        (   ( NUM POINT NUM ) => NUM POINT NUM
        |   POINT NUM
        |   NUM
        )
        ( 'E' ( '+' | '-' )? NUM )?
        ( 'D' | 'F')?
    ;

fragment
NUM : DIGIT ( DIGIT )*;

DOT : POINT;

fragment
POINT : '.';

DQUOTE : '"';

SL_COMMENT
	:	'//' ~('\n'|'\r')* d='\r\n'
	{
			int pos = state.tokenStartCharIndex;
			boolean textFound = false;
			while(pos-- != 0)
			{
				String c = input.substring(pos, pos);	
				if(c.equals("\n"))
					break;
				if(c.equals(";"))
					break;					
				if(c.equals("*"))
					break;					
				if(!c.equals(" ") && !c.equals("\t") && !c.equals("/"))
				{
					textFound = true;
					break;
				}
			}
			if(textFound)
			{
				$d.setType(DELIM);
				emit($d);
			}
			$channel=HIDDEN;
	}
	;

ML_COMMENT
	:	'/*' ( options {greedy=false;} : . )* '*/' //'/'* WS* //d='\r\n' 
	{
		$channel=HIDDEN;
	}
	;

WS
	: (' '|'\t') {$channel=HIDDEN;}
	;

// PB specific tokens
fragment TAB : '~t';
fragment CR  : '~r';
fragment LF  : '~n';
fragment E_DOUBLE_QUOTE : '~"';
fragment E_QUOTE : '~\''    ;
fragment E_TILDE : '~~'    ;
//TILDE : '~';

fragment DIGIT : '0' .. '9';

NEWLINE
	: '\r\n'
	// PB woodoo some newlines are hidden while others are not
	// each statement ends with a newline but we do not want empty lines to parsed
	{		
		if ( state.tokenStartCharIndex == 0)
		{
			$channel = HIDDEN;
		} else if ( input.substring(state.tokenStartCharIndex - 1,state.tokenStartCharIndex-1).equals("\n")) {			
			$channel = HIDDEN;
		} else {
			int pos = state.tokenStartCharIndex;
			boolean textFound = false;
			// Loop from the rigth to the left
			// Set $channel to HIDDEN unless you find something usefull (non-space, non-comment, non-SEMICOLON
			while(pos-- != 0)
			{
				String c = input.substring(pos, pos);
				String p = input.substring(pos-1, pos-1);	
				if(c.equals("\n"))
					break;
				if(c.equals(";"))
					break;					
				if(c.equals("/") && p.equals("*"))
					break;
				if(!c.equals(" ") && !c.equals("\t"))
				{
					textFound = true;
					break;
				}
			}
			if(!textFound)
			{
				$channel = HIDDEN;
			}			
		}
//			if($channel == HIDDEN)
//			{
//				System.out.println("Empty line at: " + input.getLine());			
//			}					
	}		
	;
	
LINE_CONTINUATION
	: '&' WS*  '\r\n' 
	{ 
	$channel = HIDDEN;
	//System.out.println("Line continuation at: " + input.getLine()); 
	}
	;
	
EXPORT_HEADER
	:
	'$' 'A' .. 'Z' 
	( options {greedy=false;} : ( 'A' .. 'Z' | DIGIT | '-' | '#' | '%' | '_' ) )* 
	'$' ~('\n'|'\r')* //d='\r\n'
	;

PBSELECT
	: p=('PBSELECT' ~('\n'|'\r')*) 
	{
		
	}
	;
	
DATE // 1996-09-26
	: DIGIT DIGIT DIGIT DIGIT '-' DIGIT DIGIT '-' DIGIT DIGIT
	;

TIME // 00:00:00:000000
	: DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT 
	(':'	DIGIT DIGIT DIGIT DIGIT DIGIT DIGIT)?
	;
	
BINDPAR
	: ':' ID_PARTS
	; 
		
TQ : '???';

DOUBLE_PIPE
 	 : '||' // used in Oracle SQL statements (see swallow_to_semi)
 	 ;
