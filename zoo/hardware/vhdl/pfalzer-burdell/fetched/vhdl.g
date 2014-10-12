//The MIT License
//
//Copyright (c) 2006-2010  Karl W. Pfalzer
//Copyright (c) 2011-      George P. Burdell
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
header {
package parser.vhdl;
}

options {
  	language="Java";
  	//language="Cpp";
}

//{BEGIN parser
//
class VhdlParser extends Parser;

options {
  	k=2;
  	//buildAST=true;
}

{
	/**
	 *	Track module declarations and instances.
	 */
	public static Tracker	stTracker = new Tracker();

	/**
	 *	A convenience for building Token
	 */
	private static class BldToken extends antlr.CommonToken {
		private BldToken(Token orig, String news) {
			super(orig.getType(), news);
			setFilename(orig.getFilename());
			setLine(orig.getLine());
		}
	}
}

abstract_literal
:   decimal_literal
|   based_literal
;

access_type_definition
:   K_ACCESS subtype_indication
;

actual_designator
:   expression
|   K_OPEN
;

actual_parameter_part
:   association_list
;

actual_part
:   (name LPAREN)=> name LPAREN actual_designator RPAREN
|   actual_designator
;

adding_operator
:   PLUS
|   MINUS
|   AND
;

aggregate
:   LPAREN element_association (COMMA element_association)* RPAREN
;

alias_declaration
:   K_ALIAS alias_designator (COLON subtype_indication)? 
        K_IS name (signature)? SEMI
;

alias_designator
:   identifier
|   character_literal
|   operator_symbol
;

allocator
:   K_NEW 
        (   (subtype_indication)=> subtype_indication
        |   qualified_expression
        )
;

architecture_body
:   K_ARCHITECTURE identifier K_OF name K_IS
        architecture_declarative_part
        K_BEGIN architecture_statement_part K_END
        (K_ARCHITECTURE)? (simple_name)? SEMI
;

architecture_declarative_part
:   (block_declarative_item)*
;

architecture_statement_part
:   (concurrent_statement)*
;

array_type_definition
:   (unconstrained_array_definition)=> unconstrained_array_definition
|   constrained_array_definition
;

assertion
:   K_ASSERT condition
        (K_REPORT expression)?
        (K_SEVERITY expression)?
;

assertion_statement
:   (label_colon)? assertion SEMI
;

association_element
:   ((formal_part EQGRT)=> formal_part EQGRT)? actual_part
;

association_list
:   association_element (COMMA association_element)*
;

attribute_declaration
:   K_ATTRIBUTE identifier COLON name SEMI
;

attribute_designator
:   simple_name
;

tic_attribute_designator
:	TIC_SIMPLE_NAME
;

attribute_specification
:   K_ATTRIBUTE attribute_designator 
        K_OF entity_specification K_IS expression SEMI
;

base_unit_declaration
:   identifier
;

based_literal
:   BASED_LITERAL
;

binding_indication
:   (K_USE entity_aspect)?  (generic_map_aspect)? (port_map_aspect)?  
;

bit_string_literal
:   BIT_STRING_LITERAL
;

block_configuration
:   K_FOR block_specification (use_clause)* (configuration_item)*
        K_END K_FOR SEMI
;

block_declarative_item
:   (subprogram_declaration)=> subprogram_declaration
|   subprogram_body
|   type_declaration
|   subtype_declaration
|   constant_declaration
|   signal_declaration
|   variable_declaration
|   file_declaration
|   alias_declaration
|   component_declaration
|   (attribute_specification)=> attribute_specification
|   attribute_declaration
|   configuration_specification
|   disconnection_specification
|   use_clause
|   (K_GROUP identifier COLON)=> group_declaration
|   group_template_declaration
;

block_declarative_part
:   (block_declarative_item)*
;

block_header
:   (generic_clause (generic_map_aspect SEMI)? )?
        (port_clause (port_map_aspect SEMI)? )?
;

block_specification
:   (label LPAREN)=> label LPAREN index_specification RPAREN
|   name
;

block_statement
:   label COLON K_BLOCK (LPAREN expression RPAREN)? (K_IS)?
        block_header block_declarative_part
        K_BEGIN block_statement_part K_END K_BLOCK (label)? SEMI
;

block_statement_part
:   (concurrent_statement)*
;

case_statement
:   (label_colon)? K_CASE expression K_IS
        (case_statement_alternative)+
        K_END K_CASE (label)? SEMI
;

case_statement_alternative
:   K_WHEN choices EQGRT sequence_of_statements
;

character_literal
:	CHARACTER_LITERAL
;

choice
:   (simple_expression)=> simple_expression
|   (simple_name)=> simple_name
|   discrete_range
|   K_OTHERS
;

choices
:   choice (BAR choice)*
;

component_configuration
:   K_FOR component_specification (binding_indication SEMI)?
        (block_configuration)? K_END K_FOR SEMI
;

component_declaration
:   K_COMPONENT identifier (K_IS)?
        (generic_clause)? (port_clause)?
        K_END K_COMPONENT (simple_name)? SEMI
;

component_instantiation_statement
{ Token instNm = null, refNm = null;}
:   instNm=label COLON refNm=instantiated_unit 
			{stTracker.addInstance(refNm, instNm);}
		(generic_map_aspect)? (port_map_aspect)? SEMI
;

component_specification
:   instantiation_list COLON name
;

composite_type_definition
:   array_type_definition
|   record_type_definition
;

concurrent_assertion_statement
:   (label_colon)? (K_POSTPONED)? assertion SEMI
;

concurrent_procedure_call_statement
:   (label_colon)=> label_colon (K_POSTPONED)? procedure_call SEMI
|   (K_POSTPONED)? procedure_call SEMI
;

concurrent_signal_assignment_statement
:   (label_colon)=> 
		label_colon (K_POSTPONED)? concurrent_signal_assignment_statement_2
|   (K_POSTPONED)? concurrent_signal_assignment_statement_2
;

concurrent_signal_assignment_statement_2
:	conditional_signal_assignment
|   selected_signal_assignment
;

concurrent_statement
:   (block_statement)=> block_statement
|   (process_statement)=> process_statement
|   (concurrent_procedure_call_statement)=> 
		concurrent_procedure_call_statement
|   (concurrent_assertion_statement)=> concurrent_assertion_statement
|   (concurrent_signal_assignment_statement)=>
		concurrent_signal_assignment_statement
|   (component_instantiation_statement)=>
		component_instantiation_statement
|   generate_statement
;

condition
:   expression
;

condition_clause
:   K_UNTIL condition
;

//NOTE: LRM has production called "options" which conflicts w/
//      antlr "option" keyword, so change to voptions.
conditional_signal_assignment
:   target LSTEQ voptions conditional_waveforms SEMI
;

conditional_waveforms
:	waveform ((K_WHEN condition K_ELSE)=> conditional_waveforms_2)?
    	(K_WHEN condition)?
;

conditional_waveforms_2
:	K_WHEN condition K_ELSE waveform
    	((K_WHEN condition K_ELSE)=> conditional_waveforms_2)?
;

configuration_declaration
:   K_CONFIGURATION identifier K_OF name K_IS
        configuration_declarative_part block_configuration
        K_END (K_CONFIGURATION)? (simple_name)? SEMI
;

configuration_declarative_item
:   use_clause
|   attribute_specification
|   group_declaration
;

configuration_declarative_part
:   (configuration_declarative_item)*
;

configuration_item
:   (block_configuration)=> block_configuration
|   component_configuration
;

configuration_specification
:   K_FOR component_specification binding_indication SEMI
;

constant_declaration
:   K_CONSTANT identifier_list COLON subtype_indication (COLONEQ expression)? SEMI
;

constrained_array_definition
:   K_ARRAY index_constraint K_OF subtype_indication
;

constraint
:   range_constraint
|   index_constraint
;

context_clause
:   (context_item)*
;

context_item
:   library_clause
|   use_clause
;

decimal_literal
:   DECIMAL_LITERAL
;

declaration
:   type_declaration
|   subtype_declaration 
|   (object_declaration)=> object_declaration 
|   interface_declaration 
|   alias_declaration
|   attribute_declaration 
|   component_declaration 
|   (K_GROUP identifier COLON)=> group_declaration
|   group_template_declaration
|   entity_declaration 
|   configuration_declaration 
|   subprogram_declaration 
|   package_declaration
;

delay_mechanism
:   K_TRANSPORT
|   (K_REJECT expression)? K_INERTIAL
;

design_file
:    (design_unit)+
;

design_unit
:   context_clause library_unit
;

designator
:   identifier 
|   operator_symbol
;

direction
:   K_TO 
|   K_DOWNTO
;

disconnection_specification
:   K_DISCONNECT guarded_signal_specification K_AFTER expression SEMI
;

discrete_range
:   (range)=> range
|   subtype_indication
;

element_association
:   ((choices EQGRT)=> choices EQGRT)? expression
;

element_declaration
:   identifier_list COLON element_subtype_definition SEMI
;

element_subtype_definition
:   subtype_indication
;

entity_aspect
:   K_ENTITY name (LPAREN identifier RPAREN)?
|   K_CONFIGURATION name
|   K_OPEN
;

entity_class
:   K_ENTITY
|   K_PROCEDURE
|   K_TYPE
|   K_SIGNAL
|   K_LABEL
|   K_ARCHITECTURE
|   K_FUNCTION
|   K_SUBTYPE
|   K_VARIABLE
|   K_LITERAL
|   K_CONFIGURATION 
|   K_PACKAGE 
|   K_CONSTANT 
|   K_COMPONENT
|   K_UNITS
;

entity_class_entry
:   entity_class (LSTGRT)?
;

entity_class_entry_list
:   entity_class_entry (COMMA entity_class_entry)*
;

entity_declaration
{ Token id = null;}
:   K_ENTITY id=identifier {stTracker.addModule(id);}
		K_IS entity_header entity_declarative_part
        (K_BEGIN entity_statement_part)?
        K_END (K_ENTITY)? (simple_name)? SEMI
;

entity_declarative_item
:   (subprogram_declaration)=> subprogram_declaration
|   subprogram_body 
|   type_declaration 
|   subtype_declaration 
|   constant_declaration 
|   signal_declaration 
|   variable_declaration 
|   file_declaration 
|   alias_declaration 
|   (attribute_specification)=> attribute_specification
|   attribute_declaration
|   disconnection_specification 
|   use_clause 
|   (K_GROUP identifier COLON)=> group_declaration
|   group_template_declaration
;

entity_declarative_part
:   (entity_declarative_item)*
;

entity_designator
:   entity_tag (signature)?
;

entity_header
:   (generic_clause)?  (port_clause)?
;

entity_name_list
:   entity_designator (COMMA entity_designator)*
|   K_OTHERS
|   K_ALL
;

entity_specification
:   entity_name_list COLON entity_class
;

entity_statement
:   (concurrent_assertion_statement)=> concurrent_assertion_statement
|   (concurrent_procedure_call_statement)=> 
		concurrent_procedure_call_statement 
|   process_statement
;

entity_statement_part
:   (entity_statement)*
;

entity_tag
:   simple_name 
|   character_literal 
|   operator_symbol
;

enumeration_literal
:   identifier 
|   character_literal
;

enumeration_type_definition
:   LPAREN enumeration_literal (COMMA enumeration_literal)* RPAREN
;

exit_statement
:   (label_colon)? K_EXIT (label)? (K_WHEN condition)? SEMI
;

expression
:   relation (logical_op relation)*
;

logical_op
:	K_AND
|	K_OR
|	K_XOR
|	K_NAND
|	K_NOR
|	K_XNOR
;

factor
:   primary (options{greedy=true;}: STAR2 primary)?
|   K_ABS primary
|   K_NOT primary
;

file_declaration
:   K_FILE identifier_list COLON 
		subtype_indication (file_open_information)? SEMI
;

file_logical_name
:   expression 
;

file_open_information
:   (K_OPEN expression)? K_IS file_logical_name 
;

file_type_definition
:   K_FILE K_OF name
;

floating_type_definition
:   range_constraint
;

formal_parameter_list
:   interface_list
;

formal_part
:   name (LPAREN name RPAREN )?
;

full_type_declaration
:   K_TYPE identifier K_IS type_definition SEMI
;

function_call
: 	name (LPAREN actual_parameter_part RPAREN)?
;

generate_statement
:   label COLON generation_scheme K_GENERATE
        ((block_declarative_item)* K_BEGIN)?
        (concurrent_statement)*
        K_END K_GENERATE (label)? SEMI
;

generation_scheme
:   K_FOR parameter_specification
|   K_IF condition
;

generic_clause
:   K_GENERIC LPAREN generic_list RPAREN SEMI
;

generic_list
:   interface_list
;

generic_map_aspect
:   K_GENERIC K_MAP LPAREN association_list RPAREN
;

group_constituent
:   name 
|   character_literal
;

group_constituent_list
:   group_constituent (COMMA group_constituent)*
;

group_declaration
:   K_GROUP identifier COLON name LPAREN group_constituent_list RPAREN SEMI
;

group_template_declaration
:   K_GROUP identifier K_IS LPAREN entity_class_entry_list RPAREN SEMI
;

guarded_signal_specification
:   signal_list COLON name
;

identifier returns [Token tok]
{ tok=null;}
:   id:BASIC_IDENTIFIER 	{tok=id;}   
|	id2:EXTENDED_IDENTIFIER	{tok=id2;}
;

identifier_list
:   identifier (COMMA identifier)*
;

if_statement
:   (label_colon)?
        K_IF condition K_THEN sequence_of_statements
        (K_ELSIF condition K_THEN sequence_of_statements)*
        (K_ELSE sequence_of_statements)? K_END K_IF (label)? SEMI
;

incomplete_type_declaration
:   K_TYPE identifier SEMI
;

index_constraint
:   LPAREN discrete_range (COMMA discrete_range)* RPAREN
;

index_specification
:   (discrete_range)=> discrete_range
|   expression
;

index_subtype_definition
:   name K_RANGE LSTGRT
;

instantiated_unit returns [Token tok]
{tok=null;}
:   (K_COMPONENT)? tok=name
|   K_ENTITY tok=name (LPAREN identifier RPAREN)? 
|   K_CONFIGURATION name
;

instantiation_list
:   label (COMMA label)*
|   K_OTHERS 
|   K_ALL
;

interface_constant_declaration
:   (K_CONSTANT)? identifier_list COLON (K_IN)? subtype_indication
        (COLONEQ expression)?
;

interface_declaration
:   (interface_constant_declaration)=> interface_constant_declaration
|   (interface_signal_declaration )=> interface_signal_declaration 
|   interface_variable_declaration 
|   interface_file_declaration
;

interface_element
:   interface_declaration
;

interface_file_declaration
:   K_FILE identifier_list COLON subtype_indication
;

interface_list
:   interface_element (SEMI interface_element)*
;

interface_signal_declaration
:   (K_SIGNAL)? identifier_list COLON (mode)? subtype_indication (K_BUS)? 
        (COLONEQ expression)?
;

interface_variable_declaration
:   (K_VARIABLE)? identifier_list COLON (mode)? subtype_indication
        (COLONEQ expression)?
;

iteration_scheme
:   K_WHILE condition
|   K_FOR parameter_specification
;

label returns [Token tok]
{tok=null;}
:   tok=identifier
;

label_colon
:   label COLON
;

library_clause
:   K_LIBRARY logical_name_list SEMI
;

library_unit
:   (K_ARCHITECTURE | K_PACKAGE K_BODY)=> secondary_unit
|   primary_unit
;

literal
:   (numeric_literal)=> numeric_literal
|   enumeration_literal 
|   string_literal 
|   bit_string_literal 
|   K_NULL
;

logical_name
:   identifier 
;

logical_name_list
:   logical_name (COMMA logical_name)*
;

logical_operator
:   K_AND
|   K_OR
|   K_NAND
|   K_NOR
|   K_XOR
|   K_XNOR
;

loop_statement
:   (label_colon)?
        (iteration_scheme)? K_LOOP sequence_of_statements
        K_END K_LOOP (label)? SEMI
;

miscellaneous_operator
:   STAR2 
|   K_ABS
|   K_NOT
;

mode
:   K_IN
|   K_OUT
|   K_INOUT
|   K_BUFFER
|   K_LINKAGE
;

multiplying_operator
:   STAR
|   SLASH
|   K_MOD 
|   K_REM
;

//Note: following is left-recursive so replace
//name
//:   simple_name
//|   operator_symbol 
//|   selected_name
//|   indexed_name
//|   slice_name
//|   attribute_name
//;
//
name returns [Token tok]
{ 	StringBuilder smplName = null;
	Token first = null;
	tok = null;
}
:   (   tok=simple_name	{smplName = new StringBuilder(tok.getText()); first=tok;}
    |   operator_symbol
    )
    ( options {greedy=true;}:
        (   DOT tok=suffix 
				{	if ((tok != null) && (null != smplName)) {
						smplName.append('.').append(tok.getText());
					}
				}
        |   TIC aggregate
        |   (signature)? tic_attribute_designator
        |   (LPAREN expression (COMMA expression)* RPAREN)=>
        		LPAREN expression (COMMA expression)* RPAREN
        |   (LPAREN actual_parameter_part RPAREN)=> LPAREN actual_parameter_part RPAREN
        |   LPAREN discrete_range RPAREN
        )
    )*
	{
		if (null != first) {
			tok = new BldToken(first, smplName.toString());
		}
	}
;

next_statement
:   (label_colon)? K_NEXT (label)? (K_WHEN condition)? SEMI
;

null_statement
:   (label_colon)? K_NULL SEMI
;

numeric_literal
:   (abstract_literal)=> abstract_literal
|   physical_literal
;

//Note: (In LRM 4.3.1), there are explicitly declared objects and cannot have
//identifier names which are reserved words.
//LRM 13.9: A reserved word must not be used as an explicitly declared identifier.
//However, at this time, do NOT do anything w/ distinguishing these: i.e., identifier
//are not context sensitive, so reserved/keywords (K_xxx) will be returned when *PERHAPS*
//a reserved/keyword (as an ident) is acceptable.
object_declaration
:   constant_declaration
|   signal_declaration 
|   variable_declaration 
|   file_declaration
;

operator_symbol
:   string_literal
;

//NOTE: options: see "voptions"

package_body
:   K_PACKAGE K_BODY simple_name K_IS
        package_body_declarative_part K_END
        (K_PACKAGE K_BODY)? (simple_name)? SEMI
;

package_body_declarative_item
:   (subprogram_declaration)=> subprogram_declaration
|   subprogram_body 
|   type_declaration 
|   subtype_declaration 
|   constant_declaration 
|   variable_declaration 
|   file_declaration 
|   alias_declaration 
|   use_clause 
|   (K_GROUP identifier COLON)=> group_declaration
|   group_template_declaration
;

package_body_declarative_part
:   (package_body_declarative_item)*
;

package_declaration
:   K_PACKAGE identifier K_IS package_declarative_part 
        K_END (K_PACKAGE)? (simple_name)? SEMI
;

package_declarative_item
:   subprogram_declaration
|   type_declaration 
|   subtype_declaration 
|   constant_declaration 
|   signal_declaration 
|   variable_declaration 
|   file_declaration 
|   alias_declaration 
|   component_declaration 
|   (attribute_specification)=> attribute_specification
|   attribute_declaration
|   disconnection_specification 
|   use_clause 
|   (K_GROUP identifier COLON)=> group_declaration
|   group_template_declaration
;

package_declarative_part
:   (package_declarative_item)*
;

parameter_specification
:   identifier K_IN discrete_range
;

physical_literal
:   (abstract_literal)? name
;

physical_type_definition
:   range_constraint K_UNITS 
		base_unit_declaration (secondary_unit_declaration)?
        K_END K_UNITS (simple_name)?
;

port_clause
:   K_PORT LPAREN port_list RPAREN SEMI
;

port_list
:   interface_list
;

port_map_aspect
:   K_PORT K_MAP LPAREN association_list RPAREN
;
    
primary
:	(function_call)=> function_call
|   (name (signature)? tic_attribute_designator)=>
        name (signature)? tic_attribute_designator	//attribute_name
|	(name TIC)=> qualified_expression
|	(LPAREN expression RPAREN)=> LPAREN expression RPAREN
|	literal
|	allocator
|	aggregate
;

primary_unit
:   entity_declaration
|   configuration_declaration 
|   package_declaration
;

procedure_call
:   name ( LPAREN actual_parameter_part RPAREN )?
;

procedure_call_statement
:   (options{greedy=true;}: label_colon)? procedure_call SEMI
;

process_declarative_item
:   (subprogram_declaration)=> subprogram_declaration 
|   subprogram_body 
|   type_declaration 
|   subtype_declaration 
|   constant_declaration 
|   variable_declaration 
|   file_declaration 
|   alias_declaration 
|   (attribute_specification)=> attribute_specification
|   attribute_declaration
|   use_clause 
|   (K_GROUP identifier COLON)=> group_declaration
|   group_template_declaration
;

process_declarative_part
:   (process_declarative_item)*
;

process_statement
:   (label_colon)?  (K_POSTPONED)? K_PROCESS (LPAREN sensitivity_list RPAREN)?
        (K_IS)? process_declarative_part K_BEGIN
        process_statement_part K_END (K_POSTPONED)? K_PROCESS (label)? SEMI
;

process_statement_part
:   (sequential_statement)*
;

protected_type_body
:   K_PROTECTED K_BODY protected_type_body_declarative_part 
        K_END K_PROTECTED K_BODY (simple_name)?
;

protected_type_body_declarative_item
:   (subprogram_declaration)=> subprogram_declaration 
|   subprogram_body 
|   type_declaration 
|   subtype_declaration 
|   constant_declaration 
|   variable_declaration 
|   file_declaration 
|   alias_declaration 
|   (attribute_specification)=> attribute_specification
|   attribute_declaration
|   use_clause 
|   (K_GROUP identifier COLON)=> group_declaration
|   group_template_declaration
;

protected_type_body_declarative_part
:   (protected_type_body_declarative_item)*
;

protected_type_declaration
:   K_PROTECTED protected_type_declarative_part 
        K_END K_PROTECTED (simple_name)?
;

protected_type_declarative_item
:   subprogram_specification
|   attribute_specification 
|   use_clause
;

protected_type_declarative_part
:   (protected_type_declarative_item)*
;

protected_type_definition
:   protected_type_declaration
|   protected_type_body 
;

qualified_expression
:	name TIC
	(	(aggregate)=> aggregate 
	| 	LPAREN expression RPAREN 
	)
;

range
:   (simple_expression direction simple_expression)=>
		simple_expression direction simple_expression
|   name
;

range_constraint
:   K_RANGE range
;

record_type_definition
:   K_RECORD (element_declaration)+
        K_END K_RECORD (simple_name)?
;

relation
:   shift_expression (relational_operator shift_expression)? 
;

relational_operator
:   EQ 
|   SLASHEQ    
|   LST 
|   LSTEQ    
|   GRT 
|   GRTEQ
;

report_statement
:   (label_colon)?  K_REPORT expression (K_SEVERITY expression)? SEMI
;

return_statement
:   (label_colon)? K_RETURN (expression)? SEMI
;

scalar_type_definition
:   enumeration_type_definition 
|   (range_constraint)=> range_constraint
|   physical_type_definition
;

secondary_unit
:   architecture_body
|   package_body
;

secondary_unit_declaration
:   identifier EQ physical_literal SEMI
;

selected_signal_assignment
:   K_WITH expression K_SELECT target LSTEQ voptions selected_waveforms SEMI
;

selected_waveforms
:   waveform K_WHEN choices (COMMA waveform K_WHEN choices)*
;

sensitivity_clause
:   K_ON sensitivity_list
;

sensitivity_list
:   name (COMMA name)*
;

sequence_of_statements
:   (sequential_statement)*
;

sequential_statement
:   ((label_colon)? K_WAIT)=> wait_statement 
|   ((label_colon)? K_ASSERT)=> assertion_statement 
|   ((label_colon)? K_REPORT)=> report_statement 
|   ((label_colon)? K_IF)=> if_statement 
|   ((label_colon)? K_CASE)=> case_statement 
|   ((label_colon)? K_NEXT)=> next_statement 
|   ((label_colon)? K_EXIT)=> exit_statement 
|   ((label_colon)? K_RETURN)=> return_statement 
|   ((label_colon)? K_NULL)=> null_statement
|   (loop_statement )=> loop_statement 
|   (procedure_call_statement )=> procedure_call_statement 
|   (variable_assignment_statement)=> variable_assignment_statement 
|   signal_assignment_statement 
;

shift_expression
:   simple_expression (shift_operator simple_expression)?
;

shift_operator
:   K_SLL
|   K_SRL
|   K_SLA
|   K_SRA
|   K_ROL
|   K_ROR
;

sign
:   PLUS
|   MINUS
;

signal_assignment_statement
:   (options{greedy=true;}: label_colon)? target 
		LSTEQ (delay_mechanism)? waveform SEMI
;

signal_declaration
:   K_SIGNAL identifier_list COLON subtype_indication (signal_kind)? 
        (COLONEQ expression)? SEMI
;

signal_kind
:   K_REGISTER 
|   K_BUS
;

signal_list
:   name (COMMA name)*
|   K_OTHERS
|   K_ALL
;

signature
:   LBRACK (name (COMMA name)*)? (K_RETURN name)? RBRACK
;

simple_expression
:   (sign)? term (options{greedy=true;}: adding_operator term)*
;

simple_name returns [Token tok]
{tok=null;}
:   tok=identifier
;

string_literal
:	STRING_LITERAL
;

subprogram_body
:   subprogram_specification K_IS subprogram_declarative_part
    K_BEGIN subprogram_statement_part K_END 
    (subprogram_kind)? (designator)? SEMI
;

subprogram_declaration
:   subprogram_specification SEMI
;

subprogram_declarative_item
:   (subprogram_declaration)=> subprogram_declaration 
|   subprogram_body 
|   type_declaration 
|   subtype_declaration 
|   constant_declaration 
|   variable_declaration 
|   file_declaration 
|   alias_declaration 
|   (attribute_specification)=> attribute_specification
|   attribute_declaration
|   use_clause 
|   (K_GROUP identifier COLON)=> group_declaration
|   group_template_declaration
;

subprogram_declarative_part
:   (subprogram_declarative_item)*
;

subprogram_kind
:   K_PROCEDURE 
|   K_FUNCTION
;

subprogram_specification
:   K_PROCEDURE designator (LPAREN formal_parameter_list RPAREN)?
|   (K_PURE | K_IMPURE)? K_FUNCTION designator 
		(LPAREN formal_parameter_list RPAREN)?  K_RETURN name
;

subprogram_statement_part
:   (sequential_statement)*
;

subtype_declaration
:   K_SUBTYPE identifier K_IS subtype_indication SEMI
;

subtype_indication
:   name (name)? (constraint)?
;

suffix returns [Token tok]
{tok=null;}
:   tok=simple_name
|   character_literal
|   operator_symbol 
|   K_ALL
;

target
:   name
|   aggregate
;

term
:   factor (options{greedy=true;}: multiplying_operator factor)*
;

timeout_clause
:   K_FOR expression
;

type_declaration
:   (full_type_declaration)=> full_type_declaration
|   incomplete_type_declaration
;

type_definition
:   scalar_type_definition
|   composite_type_definition 
|   access_type_definition 
|   file_type_definition 
|   protected_type_definition
;

unconstrained_array_definition
:   K_ARRAY LPAREN index_subtype_definition 
		(COMMA index_subtype_definition)* RPAREN K_OF subtype_indication
;

use_clause
:   K_USE name (COMMA name)* SEMI
;

variable_assignment_statement
:   (options{greedy=true;}: label_colon)? target COLONEQ expression SEMI
;

variable_declaration
:   (K_SHARED)? K_VARIABLE identifier_list COLON subtype_indication 
        (COLONEQ expression)? SEMI
;

wait_statement
:   (label_colon)? K_WAIT (sensitivity_clause)? (condition_clause)? 
        (timeout_clause)? SEMI
;

waveform
:   waveform_element (COMMA waveform_element)*
|   K_UNAFFECTED
;

waveform_element
:   expression (K_AFTER expression)?
;

//Note: voptions replaces "options" to fix conflict w/ options 
//keyword in antlr
voptions
:   (K_GUARDED)? (delay_mechanism)?
;
//
//}END parser

//=====================================================================
class VhdlLexer extends Lexer;
options {
	k=2;
	charVocabulary='\u0003'..'\u00FF';

	//VHDL is case-insensitive
	//
	caseSensitive=false;
	caseSensitiveLiterals=false;
	testLiterals=true;
}

tokens {
	K_ABS = "abs" ;
	K_ACCESS = "access" ;
	K_AFTER = "after" ;
	K_ALIAS = "alias" ;
	K_ALL = "all" ;
	K_AND = "and" ;
	K_ARCHITECTURE = "architecture" ;
	K_ARRAY = "array" ;
	K_ASSERT = "assert" ;
	K_ATTRIBUTE = "attribute" ;
	K_BEGIN = "begin" ;
	K_BLOCK = "block" ;
	K_BODY = "body" ;
	K_BUFFER = "buffer" ;
	K_BUS = "bus" ;
	K_CASE = "case" ;
	K_COMPONENT = "component" ;
	K_CONFIGURATION  = "configuration"  ;
	K_CONSTANT  = "constant"  ;
	K_DISCONNECT = "disconnect" ;
	K_DOWNTO = "downto" ;
	K_ELSE = "else" ;
	K_ELSIF = "elsif" ;
	K_END = "end" ;
	K_ENTITY = "entity" ;
	K_EXIT = "exit" ;
	K_FILE = "file" ;
	K_FOR = "for" ;
	K_FUNCTION = "function" ;
	K_GENERATE = "generate" ;
	K_GENERIC = "generic" ;
	K_GROUP = "group" ;
	K_GUARDED = "guarded" ;
	K_IF = "if" ;
	K_IMPURE = "impure" ;
	K_IN = "in" ;
	K_INERTIAL = "inertial" ;
	K_INOUT = "inout" ;
	K_IS = "is" ;
	K_LABEL = "label" ;
	K_LIBRARY = "library" ;
	K_LINKAGE = "linkage" ;
	K_LITERAL = "literal" ;
	K_LOOP = "loop" ;
	K_MAP = "map" ;
	K_MOD  = "mod"  ;
	K_NAND = "nand" ;
	K_NEW  = "new"  ;
	K_NEXT = "next" ;
	K_NOR = "nor" ;
	K_NOT = "not" ;
	K_NULL = "null" ;
	K_OF  = "of"  ;
	K_ON = "on" ;
	K_OPEN = "open" ;
	K_OR = "or" ;
	K_OTHERS  = "others"  ;
	K_OUT = "out" ;
	K_PACKAGE  = "package"  ;
	K_PORT = "port" ;
	K_POSTPONED = "postponed" ;
	K_PROCEDURE  = "procedure"  ;
	K_PROCESS = "process" ;
	K_PROTECTED = "protected" ;
	K_PURE = "pure" ;
	K_RANGE = "range" ;
	K_RECORD = "record" ;
	K_REGISTER  = "register"  ;
	K_REJECT = "reject" ;
	K_REM = "rem" ;
	K_REPORT = "report" ;
	K_RETURN = "return" ;
	K_ROL = "rol" ;
	K_ROR = "ror" ;
	K_SELECT = "select" ;
	K_SEVERITY = "severity" ;
	K_SHARED = "shared" ;
	K_SIGNAL = "signal" ;
	K_SLA = "sla" ;
	K_SLL = "sll" ;
	K_SRA = "sra" ;
	K_SRL = "srl" ;
	K_SUBTYPE = "subtype" ;
	K_THEN = "then" ;
	K_TO  = "to"  ;
	K_TRANSPORT = "transport" ;
	K_TYPE = "type" ;
	K_UNAFFECTED = "unaffected" ;
	K_UNITS  = "units"  ;
	K_UNTIL = "until" ;
	K_USE = "use" ;
	K_VARIABLE = "variable" ;
	K_WAIT = "wait" ;
	K_WHEN = "when" ;
	K_WHILE = "while" ;
	K_WITH = "with" ;
	K_XNOR = "xnor" ;
	K_XOR = "xor" ;
}

LPAREN:	'(' ;
RPAREN: ')' ;
QUOTE:  '"' ;
POUND:  '#' ;
AND:    '&' ;

STAR:   '*' ;
STAR2:  "**";
PLUS:   '+' ;
COMMA:  ',' ;
MINUS:	'-' ;
DOT:	'.' ;
SLASH:  '/' ;
SLASHEQ:"/=";
COLON:	':' ;
SEMI:	';' ;
LST:	'<' ;
LSTEQ:	"<=";
LSTGRT:	"<>";
EQ:		'=' ;
GRT:	'>' ;
GRTEQ:	">=";
EQGRT:	"=>";
LBRACK:	'[' ;
RBRACK:	']'	;
USCORE:	'_'	;
BAR:	'|' ;
EXCL:	'!'	;
DOLLAR:	'$'	;
PCNT:	'%'	;
AT:		'@' ;
QMARK:	'?'	;
BSLASH:	'\\';
CARET:	'^'	;
BTIC:	'`'	;
LCURLY:	'{'	;
RCURLY:	'}'	;
TILDE:	'~' ;
COLONEQ:":=";

WS
:	(' '|'\r'|'\t')+	{$setType(Token.SKIP);}
;

NEWLINE
:	'\n' {$setType(Token.SKIP); newline();}
;

COMMENT
: "--" (~'\n')* 	{$setType(Token.SKIP);}
;

BASIC_IDENTIFIER
options {testLiterals=false;}
:   LETTER (('_')? (LETTER | DIGIT))*
;

BIT_STRING_LITERAL
:   BASE_SPECIFIER '"' (BIT_VALUE)? '"'
;

//To distinguish between single quoted and attribute prefix (i.e., 'event)
protected
TIC: '\''
;

//Need ident in 'ident to return single token so ident part is never a keyword.
//For example 'RANGE will otherwise return TIC and K_RANGE which is not correct.
protected
TIC_SIMPLE_NAME
:   TIC (BASIC_IDENTIFIER |	TIC EXTENDED_IDENTIFIER)
;

CHARACTER_LITERAL
:   ("'" (GRAPHIC_CHARACTER)? "'")=> "'" (GRAPHIC_CHARACTER)? "'"
|	(TIC_SIMPLE_NAME)=> TIC_SIMPLE_NAME {$setType(TIC_SIMPLE_NAME);}
|	TIC	{$setType(TIC);}	
;

EXTENDED_IDENTIFIER
:   "\\" (GRAPHIC_CHARACTER)* "\\"
;

STRING_LITERAL
:   '"' (GRAPHIC_CHARACTER_BASE | "\"\"")* '"'
;

BASED_OR_DECIMAL
:	(INTEGER '#')=> BASED_LITERAL	{$setType(BASED_LITERAL);}
|	DECIMAL_LITERAL					{$setType(DECIMAL_LITERAL);}
;

protected
DECIMAL_LITERAL
:   INTEGER ('.' INTEGER)? (EXPONENT)?
;

protected
BASED_LITERAL
:   INTEGER '#' BASED_INTEGER ('.' BASED_INTEGER)? '#' (EXPONENT)?
;

protected
BASE_SPECIFIER
:   'b' | 'o' | 'x'
;

protected
BASED_INTEGER
:   EXTENDED_DIGIT (('_')? EXTENDED_DIGIT)*
;

protected
EXTENDED_DIGIT
:   DIGIT
|   LETTER
;

//Note: Character set codes from: http://htmlhelp.com/reference/charset
//      " is added in GRAPHIC_CHARACTER
protected
BASIC_GRAPHIC_CHARACTER_BASE
:   '\u00C0'..'\u00DE' //code: 192-222
|   DIGIT
|   '#' | '&' | '\'' | '(' | ')' | '*' | '+' | ',' | '-' | '.' | '/'
|   ':' | ';' | '<' | '='  | '>' | '[' | ']' | '_' | '|'
|   ' ' | '\u00A0' //NBSP
;

protected
GRAPHIC_CHARACTER_BASE
:   BASIC_GRAPHIC_CHARACTER_BASE
|   LOWER_CASE_LETTER
|   '\u00DF'..'\u00FF' //code: 223-255
|   '!' | '$' | '%' | '@' | '?' | '\\' | '^' | '`' | '{' | '}' | '~'
|   '\u00A1'..'\u00BF'  //code: 161-191
;

protected
GRAPHIC_CHARACTER
:	GRAPHIC_CHARACTER_BASE
|	'"'
;

protected
BIT_VALUE
:   BASED_INTEGER
;

protected
DIGIT
:   '0'..'9'
;

protected
EXPONENT
:   'e' (('+')? | '-') INTEGER
;

protected 
LOWER_CASE_LETTER
:   'a'..'z' 
;

protected 
LETTER
:   LOWER_CASE_LETTER 
;

protected
INTEGER
:   DIGIT (('_')? DIGIT)*
;

