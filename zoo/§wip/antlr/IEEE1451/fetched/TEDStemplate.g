grammar TEDStemplate;

/*
 * Antlr V3.0.1 Grammar
 * Copyright NICTA (www.nicta.com.au) - Safe.Network 2007
 * Author Peizhao Hu (Peizhao.Hu@nicta.com.au)
 */

options {
	output=AST; /* output AST */
	k=3;
}

tokens {
	/* literal token defintions */
	TDL_VERSION_NUMBER='TDL_VERSION_NUMBER';
	VALIDATION_KEYCODE='Validation_Keycode';
	ABSTRACT='ABSTRACT';
	UGID='UGID';
	SPACING='SPACING';
	SELECTCASE='SELECTCASE';
	ENDSELECT='ENDSELECT';
	CASE='CASE';
	ENDCASE='ENDCASE';
	STRUCTARRAY='STRUCTARRAY';
	ENDSTRUCTARRAY='ENDSTRUCTARRAY';
	ENUMERATE='ENUMERATE';
	PHYSICAL_UNIT='PHYSICAL_UNIT';

	ID='ID';
	CAL='CAL';
	USR='USR';

	ALIGN='ALIGN';

	UNINT='UNINT';
	CHR5='CHR5';
	STRING5='STRING5';
	STRING7='STRING7';
	STRING16='STRING16';
	DATE='DATE';
	CONRELRES='CONRELRES';
	CONRES='CONRES';
	ASCII='ASCII';
	SINGLE='SINGLE';
	UNICODE='UNICODE';
	BITBIN='BITBIN';

	DEFAULT='DEFAULT';
	INITIALIZE='Initialize';
	READWRITE='ReadWrite';
	CTRLFUNCTIONMASK='CtrlFunctionMask';
	FUNCTIONTYPE='FunctionType';
	FUNCTION='Function';
	ENDTEMPLATE='ENDTEMPLATE';
	TEMPLATE='TEMPLATE';
	
	/* imaginary token definitions */
	TEMPLATE_LIST;
	
	DOT2_UNIT;
	COMMAND_PROPERTY;
	COMMAND_PROPERTY_NAME;
	PHYSICAL_UNIT_DEFINITION;
	DESCRIPTION_STATEMENT;
	ABSTRACT_STATEMENT;
	
	ManufacturerID;
	IDNumberOfBits;
	TemplateID;
	FORMAT;
	ACCESS_LEVEL;
	DATA_TYPE;
	SIZE;
	SELECTCASE_NUMBER_BITS;
	CASE_BIT;
	SUBPROPERTY_NAME;
	PROPERTY_DESCRIPTION;
	ENUMERATE_LIST;
}

/* define package name of the generated java files */
@parser::header{
package com.nicta.safe.ACoMS.sensor.teds;
}
@lexer::header{
package com.nicta.safe.ACoMS.sensor.teds;
}


//============================================
//        			Parser
//============================================
teds_template_file
	:	template_list
		validation_keycode_statement?
	;

template_list
	:	template (seperator* template)*
	->	^(TEMPLATE_LIST template+)
	;
		
template
	:	TEMPLATE template_description_statement
			statement_list 
		ENDTEMPLATE
	->
		^(TEMPLATE template_description_statement statement_list ENDTEMPLATE)
	;

statement_list
	:	statement+
	;	
	
template_description_statement
	:	manufacturer_code comma
		id_number_of_bits comma 
		template_id comma 
		description? 
	->	
		manufacturer_code id_number_of_bits template_id description?
	;
	
manufacturer_code
	:	mid=DecimalLiteral -> ^(ManufacturerID $mid) ; 
	
id_number_of_bits
	:	idbits=DecimalLiteral -> ^(IDNumberOfBits $idbits);
	
template_id
	:	tid=DecimalLiteral -> ^(TemplateID $tid);
		
statement
	:	comment_statement!
	|	tdl_version_number_statement
	|	abstract_statement
	|	SPACING!
	|	align_statement
	|	physical_unit_statement
	|	enumerate_statement
	|	property_definition_command
	|	selectcase_statement
	|	structarray_statement
	|	ugid_statement
	;

comment_statement
	:	COMMENT ;
	
tdl_version_number_statement
	: 	TDL_VERSION_NUMBER vn=DecimalLiteral 
	->	^(TDL_VERSION_NUMBER $vn)
	;

abstract_statement
	:	ABSTRACT_DESC
	->	^(ABSTRACT_STATEMENT ABSTRACT_DESC)
	;

align_statement
	:	ALIGN boundary 
	->	^(ALIGN boundary)
	;
	
physical_unit_statement
	:	PHYSICAL_UNIT val=QUOTED_STRING comma unit=dot2_unit 
	->	^(PHYSICAL_UNIT_DEFINITION $val $unit)
	;
	
enumerate_statement
	:	ENUMERATE VARIABLE_NAME enumerate_list 
	->	^(ENUMERATE VARIABLE_NAME enumerate_list)
	;
	
enumerate_list
	:	comma enumerate_item (comma enumerate_item)*
	->	^(ENUMERATE_LIST enumerate_item+)
	;
	
enumerate_item
	:	QUOTED_STRING
	|	VARIABLE_NAME
	|	numeric   
	;

property_definition_command
	:	property comma 
		(optional_prop_description comma)?
		accesslevel comma
		size comma
		datatype comma
		format comma
		physical_unit 
		optional_assignment?
	->	^(COMMAND_PROPERTY property optional_prop_description? accesslevel size datatype format physical_unit optional_assignment?)
	;
	
property
	:	PROPERTYNAME optional_subproperty?
	->
		^(COMMAND_PROPERTY_NAME PROPERTYNAME optional_subproperty?)
	;

optional_subproperty
	:	LBRACKET subproperty RBRACKET -> ^(SUBPROPERTY_NAME subproperty);
	
subproperty
	:	DEFAULT
	|	INITIALIZE
	|	READWRITE
	|	CTRLFUNCTIONMASK
	|	FUNCTIONTYPE
	|	FUNCTION
	|	QUOTED_STRING
	;
	
optional_prop_description 
	:	prop_description -> ^(PROPERTY_DESCRIPTION prop_description)
        | 	PROPERTYNAME LBRACKET QUOTED_STRING RBRACKET -> ^(PROPERTY_DESCRIPTION PROPERTYNAME QUOTED_STRING);

accesslevel 
	:  	ID  -> ^(ACCESS_LEVEL ID)
        | 	CAL -> ^(ACCESS_LEVEL CAL)
        | 	USR -> ^(ACCESS_LEVEL USR)
        ;

datatype 
	: 	UNINT -> ^(DATA_TYPE UNINT)
        | 	CHR5 -> ^(DATA_TYPE CHR5)	    
        | 	DATE -> ^(DATA_TYPE DATE)	    
        | 	CONRELRES comma startvalue comma tolerance -> ^(DATA_TYPE CONRELRES startvalue tolerance)
        |	CONRES comma startvalue comma tolerance -> ^(DATA_TYPE CONRES startvalue tolerance)
        | 	ASCII -> ^(DATA_TYPE ASCII)
        | 	STRING5 -> ^(DATA_TYPE STRING5)
        | 	STRING7 -> ^(DATA_TYPE STRING7)
        | 	STRING16 -> ^(DATA_TYPE STRING16)
        | 	SINGLE -> ^(DATA_TYPE SINGLE)
        | 	UNICODE -> ^(DATA_TYPE UNICODE)
        | 	BITBIN -> ^(DATA_TYPE BITBIN)  
        | 	VARIABLE_NAME -> ^(DATA_TYPE ENUMERATE VARIABLE_NAME)
        ;

format 	: 	
	| 	fmt=QUOTED_STRING -> ^(FORMAT $fmt)
	;

physical_unit 
	: 	unit=QUOTED_STRING -> ^(PHYSICAL_UNIT $unit)  // in use
        | 	dot2_unit -> ^(PHYSICAL_UNIT dot2_unit)       // in definition
        ;

// define 12 elements, which define the unit in SI base          
dot2_unit
	:	left_paren numeric
            	comma numeric 
            	comma numeric 
            	comma numeric 
            	comma numeric 
            	comma numeric 
            	comma numeric 
            	comma numeric 
            	comma numeric 
            	comma numeric 
            	comma numeric 
           	comma numeric 
            	right_paren
        ->	
        	^(DOT2_UNIT numeric numeric numeric numeric numeric numeric numeric numeric numeric numeric numeric numeric)
        ;
		
optional_assignment 
	: 	equals assignment
	->      ^(equals assignment)
	;
                      
assignment
	:	HexLiteral
        |	BINARY_INTEGER
        |	VARIABLE_NAME
        | 	numeric
        | 	QUOTED_STRING
        ;

selectcase_statement 
	: 	SELECTCASE description comma accesslevel comma selectcase_number_of_bits
                       	case_statement (seperator* case_statement)*
                ENDSELECT
        ->	
        	^(SELECTCASE description accesslevel selectcase_number_of_bits case_statement+ ENDSELECT)
        ;
        
case_statement 
	: 	CASE description comma case_bit_value
			statement_list?
                ENDCASE
        ->
        	^(CASE description case_bit_value statement_list? ENDCASE)
        ;

structarray_statement
	: 	STRUCTARRAY VARIABLE_NAME comma description comma accesslevel comma size
                        struct_statement+
                ENDSTRUCTARRAY
        ->
        	^(STRUCTARRAY VARIABLE_NAME description accesslevel size struct_statement+ ENDSTRUCTARRAY)
        ;

struct_statement 
	: 	property_definition_command
        | 	structarray_statement
        ;

ugid_statement 
	: 	UGID val=QUOTED_STRING comma desc=description 
	->	^(UGID $val $desc)
	;

validation_keycode_statement 
	: 	VALIDATION_KEYCODE vk=DecimalLiteral
	->	^(VALIDATION_KEYCODE $vk)
	;
	
description : QUOTED_STRING -> ^(DESCRIPTION_STATEMENT QUOTED_STRING) ;
prop_description : QUOTED_STRING ;
case_bit_value : casebit=DecimalLiteral -> ^(CASE_BIT $casebit) ;
selectcase_number_of_bits : selcasebits=DecimalLiteral -> ^(SELECTCASE_NUMBER_BITS $selcasebits) ;
size : 	s=DecimalLiteral -> ^(SIZE $s) ;
boundary : DecimalLiteral ;
startvalue : numeric ;
tolerance  : numeric ;

numeric : FloatingPointLiteral | DecimalLiteral ;

comma       : COMMA;
equals      : EQ ;
left_paren  : LPAREN ;
right_paren : RPAREN ;

seperator : comment_statement ;

//============================================
//        			Lexer
//============================================


protected SPECIALCHAR  	: '^'|'$'|'_'|'!'|'@'|'#'|'&' ;

// no need to match white spaces as they will be skipped!
protected WS		: (' '|'\r'|'\t'|'\u000C'|'\n')+ { $channel=HIDDEN; };

PROPERTYNAME	: 	'%' ('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9'|SPECIALCHAR)* ;
COMMENT 	: 	'//' (~('\n'|'\r'))+ '\r'? '\n' {$channel=HIDDEN;};

ABSTRACT_DESC	:	ABSTRACT (~('\n'|'\r'))+ ;
VARIABLE_NAME	:	('a'..'z'|'A'..'Z') ('a'..'z'|'A'..'Z'|'0'..'9'|SPECIALCHAR)*;
	
QUOTED_STRING	:	('"' (~('"'))* '"') | ('\'' (~('\''))* '\'') ;

// Separators 
LBRACKET	:	'[';
RBRACKET	:	']';
EQ	  	:	'=';
COMMA		:	',';
LPAREN		:	'(';
RPAREN		:	')';

/* modelling literal type */
literal	
	:   	integerLiteral
    	|   	FloatingPointLiteral
    	|   	CharacterLiteral
    	|   	StringLiteral
    	|   	booleanLiteral
	;

integerLiteral
    	:   	HexLiteral
    	|   	OctalLiteral
    	|   	DecimalLiteral
    	;

booleanLiteral
    	:   	'TRUE'
    	|   	'FALSE'
    	;

HexLiteral 	: 	'0' ('x'|'X') HexDigit+ IntegerTypeSuffix? ;

fragment
Sign		: 	'-' | '+' ;

DecimalLiteral 	: 	(Sign)? ('0' | '1'..'9' '0'..'9'*) IntegerTypeSuffix? ;

OctalLiteral 	: 	'0' ('0'..'7')+ IntegerTypeSuffix? ;

fragment
HexDigit 	: 	('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
IntegerTypeSuffix : 	('l'|'L') ;

FloatingPointLiteral
    	: (Sign)?  ('0'..'9')+ '.' ('0'..'9')* Exponent? FloatTypeSuffix?
    	| (Sign)?  '.' ('0'..'9')+ Exponent? FloatTypeSuffix?
    	| (Sign)?  ('0'..'9')+ Exponent? FloatTypeSuffix?
	;

fragment
Exponent 	: 	('e'|'E') ('+'|'-')? ('0'..'9')+ ;

fragment
FloatTypeSuffix : 	('f'|'F'|'d'|'D') ;

CharacterLiteral
    	:	'\'' ( EscapeSequence | ~('\''|'\\') ) '\''
    	;

StringLiteral
    	:  	'"' ( EscapeSequence | ~('\\'|'"') )* '"'
    	;

fragment
EscapeSequence
    	:   	'\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\')
    	|   	UnicodeEscape
    	|   	OctalEscape
    	;
    
fragment
OctalEscape
    	:   	'\\' ('0'..'3') ('0'..'7') ('0'..'7')
    	|  	'\\' ('0'..'7') ('0'..'7')
    	|   	'\\' ('0'..'7')
    	;

fragment
UnicodeEscape	:   	'\\' 'u' HexDigit HexDigit HexDigit HexDigit;

fragment
BINARY_INTEGER	:	'0' ('b'|'B') ('0'|'1')+ ;



