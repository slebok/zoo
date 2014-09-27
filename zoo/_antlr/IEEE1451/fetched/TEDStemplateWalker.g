tree grammar TEDStemplateWalker;

/*
 * Antlr V3.0.1 Grammar
 * Copyright NICTA (www.nicta.com.au) - Safe.Network 2007
 * Author Peizhao Hu (Peizhao.Hu@nicta.com.au)
 */



options {
	tokenVocab=TEDStemplate; // import tokens from TEDStemplate.g
	ASTLabelType=CommonTree;
	k=3;
}

/* define package name of the generated java files */
@treeparser::header {
package com.nicta.safe.ACoMS.sensor.teds;
}

@members {
TDL_parser parser = new TDL_parser();
}
teds_template_file
	:	template_list
		validation_keycode_statement?
	;

template_list
	:	^(TEMPLATE_LIST template+)
		{ System.out.println("TEMPLATE_LIST found"); }
	;
		
template
	:	^(TEMPLATE template_description_statement statement_list ENDTEMPLATE)
		{ System.out.println("TEMPLATE found"); }
	;

statement_list
	:	statement+
	;	
	
template_description_statement
	:	manufacturer_code id_number_of_bits template_id description?
		{ 
		  System.out.println("TEMPLATE ["+$description.text+"] -> manID:"+$manufacturer_code.text
		  	+" templateID:"+$template_id.text+" found"); 
		}
	;
	
manufacturer_code
	:	^(ManufacturerID DecimalLiteral)
		{ System.out.println("ManufacturerID: "+$DecimalLiteral.text+" found"); }
	; 
	
id_number_of_bits
	:	^(IDNumberOfBits DecimalLiteral)
		{ System.out.println("IDNumberOfBits: "+$DecimalLiteral.text+" found"); }
	;	
	
template_id
	:	^(TemplateID DecimalLiteral)
		{ System.out.println("TemplateID: "+$DecimalLiteral.text+" found"); }
	;
		
statement
	:	tdl_version_number_statement
	|	abstract_statement
	|	align_statement
	|	physical_unit_statement 
	|	enumerate_statement
	|	property_definition_command
	|	selectcase_statement
	|	structarray_statement
	|	ugid_statement
	;
	
tdl_version_number_statement
	:	^(TDL_VERSION_NUMBER DecimalLiteral)
		{ System.out.println("TemplateID: "+$DecimalLiteral.text+" found"); }
	;

abstract_statement
	:	^(ABSTRACT_STATEMENT ABSTRACT_DESC)
		{ System.out.println("ABSTRACT_STATEMENT: "+$ABSTRACT_DESC.text+" found"); }
	;

align_statement
	:	^(ALIGN boundary)
		{ System.out.println("ALIGN: "+$boundary.text+" found"); }
	;
	
physical_unit_statement
	:	^(PHYSICAL_UNIT_DEFINITION QUOTED_STRING dot2_unit)
		{ System.out.println("PHYSICAL_UNIT_DEFINITION: "+$QUOTED_STRING.text+" found"); }
	;
	
enumerate_statement
	:	^(ENUMERATE VARIABLE_NAME enumerate_list)
		{ System.out.println("ENUMERATE: "+$VARIABLE_NAME.text+" found"); }
	;
	
enumerate_list
	:	^(ENUMERATE_LIST enumerate_item+)
	;
	
enumerate_item
	:	QUOTED_STRING
	|	VARIABLE_NAME
	|	numeric   
	;
	
property_definition_command
	:	^(COMMAND_PROPERTY property optional_prop_description? accesslevel size datatype format physical_unit optional_assignment?)
		{ System.out.println("COMMAND_PROPERTY found"); }
	;
	
property
	:	^(COMMAND_PROPERTY_NAME PROPERTYNAME optional_subproperty?)
		{ System.out.println("COMMAND_PROPERTY_NAME "+$PROPERTYNAME.text+" found"); }
	;

optional_subproperty
	:	^(SUBPROPERTY_NAME subproperty)
	;
	
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
	:	^(PROPERTY_DESCRIPTION prop_description)
		{ System.out.println("PROPERTY_DESCRIPTION "+$prop_description.text+" found"); }
        | 	^(PROPERTY_DESCRIPTION PROPERTYNAME QUOTED_STRING)
        	{ System.out.println("PROPERTY_DESCRIPTION "+$PROPERTYNAME.text+" and "+$QUOTED_STRING.text+" found"); }
        ;

accesslevel 
	:	^(ACCESS_LEVEL ID)
		{ System.out.println("ACCESS_LEVEL "+$ID.text+" found"); }
        | 	^(ACCESS_LEVEL CAL)
        	{ System.out.println("ACCESS_LEVEL "+$CAL.text+" found"); }
        | 	^(ACCESS_LEVEL USR)
        	{ System.out.println("ACCESS_LEVEL "+$USR.text+" found"); }
        ;

datatype 
	: 	^(DATA_TYPE UNINT)
		{ System.out.println("DATA_TYPE "+$UNINT.text+" found"); }
        | 	^(DATA_TYPE CHR5)
        	{ System.out.println("DATA_TYPE "+$CHR5.text+" found"); }
        | 	^(DATA_TYPE DATE)
        	{ System.out.println("DATA_TYPE "+$DATE.text+" found"); }
        | 	^(DATA_TYPE CONRELRES startvalue tolerance)
        	{ System.out.println("DATA_TYPE "+$CONRELRES.text+" found"); }
        |	^(DATA_TYPE CONRES startvalue tolerance)
        	{ System.out.println("DATA_TYPE "+$CONRES.text+" found"); }
        | 	^(DATA_TYPE ASCII)
        	{ System.out.println("DATA_TYPE "+$ASCII.text+" found"); }
        | 	^(DATA_TYPE STRING5)
        	{ System.out.println("DATA_TYPE "+$STRING5.text+" found"); }
        | 	^(DATA_TYPE STRING7)
        	{ System.out.println("DATA_TYPE "+$STRING7.text+" found"); }
        | 	^(DATA_TYPE STRING16)
        	{ System.out.println("DATA_TYPE "+$STRING16.text+" found"); }
        | 	^(DATA_TYPE SINGLE)
        	{ System.out.println("DATA_TYPE "+$SINGLE.text+" found"); }
        | 	^(DATA_TYPE UNICODE)
        	{ System.out.println("DATA_TYPE "+$UNICODE.text+" found"); }
        | 	^(DATA_TYPE BITBIN)
        	{ System.out.println("DATA_TYPE "+$BITBIN.text+" found"); }
        | 	^(DATA_TYPE ENUMERATE VARIABLE_NAME)
        	{ System.out.println("DATA_TYPE ENUMERATE."+$VARIABLE_NAME.text+" found"); }
        ;

format 	: 	^(FORMAT QUOTED_STRING)
		{ System.out.println("FORMAT "+$QUOTED_STRING.text+" found"); }
	;

physical_unit 
	: 	^(PHYSICAL_UNIT QUOTED_STRING)
		{ System.out.println("PHYSICAL_UNIT "+$QUOTED_STRING.text+" found"); }
        | 	^(PHYSICAL_UNIT dot2_unit)
        	{ System.out.println("PHYSICAL_UNIT "+$dot2_unit.text+" found"); }
        ;
              
dot2_unit
	:	^(DOT2_UNIT numeric numeric numeric numeric numeric numeric numeric numeric numeric numeric numeric numeric)
		{ System.out.println("DOT2_UNIT found"); }
        ;
		
optional_assignment 
	: 	^(equals assignment)
		{ System.out.println($equals.text); }
	;
                      
assignment
	:	HexLiteral
        |	BINARY_INTEGER
        |	VARIABLE_NAME
        | 	numeric
        | 	QUOTED_STRING
        ;

selectcase_statement 
	: 	^(SELECTCASE description accesslevel selectcase_number_of_bits case_statement+ ENDSELECT)
		{ System.out.println("SELECTCASE "+$description.text+" found"); }
        ;

case_statement 
	: 	^(CASE description case_bit_value statement_list? ENDCASE)
		{ System.out.println("CASE "+$description.text+" found"); }
        ;

structarray_statement 
	: 	^(STRUCTARRAY VARIABLE_NAME description accesslevel size struct_statement+ ENDSTRUCTARRAY)
		{ System.out.println("STRUCTARRAY."+$VARIABLE_NAME.text+" "+$description.text+" found"); }
        ;

struct_statement 
	: 	property_definition_command
        | 	structarray_statement
        ;

ugid_statement 
	: 	^(UGID QUOTED_STRING description)
		{ System.out.println("UGID."+$QUOTED_STRING.text+" "+$description.text+" found"); }
	;

validation_keycode_statement 
	: 	^(VALIDATION_KEYCODE DecimalLiteral)
		{ System.out.println("VALIDATION_KEYCODE "+$DecimalLiteral.text+" found"); }
	;  
description 
	: 	^(DESCRIPTION_STATEMENT QUOTED_STRING)
		{ System.out.println("DESCRIPTION_STATEMENT "+$QUOTED_STRING.text+" found"); }
	;
prop_description : QUOTED_STRING ;
case_bit_value 
	: 	^(CASE_BIT DecimalLiteral)
		{ System.out.println("CASE_BIT "+$DecimalLiteral.text+" found"); }
	;
	
selectcase_number_of_bits 
	: 	^(SELECTCASE_NUMBER_BITS DecimalLiteral)
		{ System.out.println("SELECTCASE_NUMBER_BITS "+$DecimalLiteral.text+" found"); }
	;
	
size 
	: 	^(SIZE DecimalLiteral)
		{ System.out.println("SIZE "+$DecimalLiteral.text+" found"); }
	;
	
boundary : DecimalLiteral ;
startvalue : numeric ;
tolerance  : numeric ;


numeric
	: 	FloatingPointLiteral
	|   	DecimalLiteral
	;
	
equals      : EQ ;
