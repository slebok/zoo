grammar AdaParser;
compilation_unit
 : context_items_opt ( library_item | subunit ) ( pragma )*
	;


pragma  : PRAGMA IDENTIFIER pragma_args_opt SEMI
	;

pragma_args_opt : ( LPAREN pragma_arg ( COMMA pragma_arg )* RPAREN )?
	;

pragma_arg : ( IDENTIFIER RIGHT_SHAFT )? expression
	;

context_items_opt : ( pragma )* ( with_clause ( use_clause | pragma )* )*
	;

with_clause : w=WITH c_name_list SEMI
	;

c_name_list : compound_name ( COMMA compound_name )*
	;

compound_name : IDENTIFIER ( DOT IDENTIFIER )*
	;

use_clause : u=USE
		( TYPE subtype_mark ( COMMA subtype_mark )*
			
		| c_name_list 
		)
	SEMI
	;

subtype_mark : compound_name ( TIC attribute_id )?
	;

attribute_id : RANGE
	| DIGITS
	| DELTA
	| ACCESS
	| IDENTIFIER
	;

library_item : private_opt
	( lib_pkg_spec_or_body
	| subprog_decl_or_rename_or_inst_or_body


	| generic_decl
	

	)
	;

private_opt : ( PRIVATE )?
	
	;

lib_pkg_spec_or_body
 : pkg=PACKAGE
		( BODY def_id
			

			 IS pkg_body_part end_id_opt SEMI
			
		| def_id
		
 spec_decl_part

		)
	;

subprog_decl 

	
 : p=PROCEDURE def_id

		( generic_subp_inst
			
		| formal_part_opt
			( renames 
			| is_separate_or_abstract_or_decl

			)
			SEMI
		)
	| f=FUNCTION def_designator

		( generic_subp_inst
			
		| function_tail
			( renames 
			| is_separate_or_abstract_or_decl

			)
			SEMI
		)
	;

def_id 

 : cn=compound_name | n=IDENTIFIER ;

generic_subp_inst : IS generic_inst SEMI
	;

generic_inst : NEW compound_name ( LPAREN value_s RPAREN )?
	
	;

parenth_values : LPAREN value ( COMMA value )* RPAREN 	;

value : ( OTHERS RIGHT_SHAFT expression
	| ranged_expr_s ( RIGHT_SHAFT expression )?
	)
	;

ranged_expr_s : ranged_expr ( PIPE ranged_expr )*
	;

ranged_expr : expression
		( DOT_DOT simple_expression
		| RANGE range
		)?
	;

range_constraint : RANGE range
	;

range : ( range_dots| range_attrib_ref
	)
	;

range_dots : simple_expression DOT_DOT simple_expression
	;

range_attrib_ref : 
	prefix TIC r=RANGE ( LPAREN expression RPAREN )?
	;

prefix : IDENTIFIER
		( DOT ( ALL | IDENTIFIER )
		| p=LPAREN value_s RPAREN 		)*
	;

formal_part_opt : ( LPAREN parameter_specification
		( SEMI parameter_specification )*
		RPAREN )?
	;

parameter_specification : def_ids_colon mode_opt subtype_mark init_opt
	;

def_ids_colon : defining_identifier_list COLON;

defining_identifier_list : IDENTIFIER ( COMMA IDENTIFIER )*
	;

mode_opt : ( IN ( OUT )? | OUT | ACCESS )?
	;

renames: RENAMES ( name
		| dummy=definable_operator_symbol
		)
	;

name: IDENTIFIER
		( DOT	( ALL
			| IDENTIFIER
			| CHARACTER_LITERAL
			| dummy=is_operator
			)
		| p=LPAREN value_s RPAREN 		| TIC attribute_id   
				     
		)*
	
	;

is_operator: op=CHAR_STRING ;

definable_operator_symbol: op=CHAR_STRING ;

parenthesized_primary : pp=LPAREN
		( NuLL RECORD 		| value_s extension_opt
		)
	RPAREN 	;

extension_opt :  ( WITH ( NuLL RECORD | value_s ) )?
	;

is_separate_or_abstract_or_decl: IS separate_or_abstract

	| EPSILON;

separate_or_abstract: SEPARATE 	| ABSTRACT 	;

def_designator 

 : n=compound_name 
	| d=designator 
	;

designator: op=definable_operator_symbol 
	| n=IDENTIFIER 
	;

function_tail : func_formal_part_opt RETURN subtype_mark
	;



func_formal_part_opt : ( LPAREN func_param ( SEMI func_param )* RPAREN )?
	;

func_param : def_ids_colon in_access_opt subtype_mark init_opt
	;

in_access_opt : ( IN | ACCESS )?
	;

spec_decl_part 

 : ( IS ( generic_inst 
		| pkg_spec_part 
		)
	| renames 
	)
	SEMI 	;

pkg_spec_part : basic_declarative_items_opt
		( PRIVATE basic_declarative_items_opt )?
		end_id_opt 	;

basic_declarative_items_opt : ( basic_decl_item | pragma )*
	;

basic_declarative_items : ( basic_decl_item | pragma )+
	;

basic_decl_item
 : pkg=PACKAGE def_id
 spec_decl_part

	| tsk=TASK task_type_or_single_decl

	| pro=PROTECTED prot_type_or_single_decl
 SEMI 	| subprog_decl

	| decl_common
	;

task_type_or_single_decl 

 : TYPE def_id
 discrim_part_opt task_definition_opt
	| def_id
 task_definition_opt
	;

task_definition_opt
 : IS task_items_opt private_task_items_opt end_id_opt SEMI 	| SEMI 
	;

discrim_part_opt
 : ( discrim_part_text )?
	;

discrim_part_text : LPAREN (BOX | discriminant_specifications) RPAREN 	;

known_discrim_part
 : LPAREN discriminant_specifications RPAREN 	;

empty_discrim_opt :  EPSILON
	;

discrim_part
 : discrim_part_text
	;

discriminant_specifications : discriminant_specification
		( SEMI discriminant_specification )*
	;

discriminant_specification : def_ids_colon access_opt subtype_mark init_opt
	;

access_opt : ( ACCESS )?
	;

init_opt : ( ASSIGN expression )?
	;  
	
	   

task_items_opt : ( pragma )* entrydecls_repspecs_opt
	;

entrydecls_repspecs_opt : ( entry_declaration ( pragma | rep_spec )* )*
	;

entry_declaration : e=ENTRY IDENTIFIER
		discrete_subtype_def_opt formal_part_opt SEMI 	;

discrete_subtype_def_opt : ( LPAREN discrete_subtype_definition | EPSILON
	)
	;

discrete_subtype_definition : ( range| subtype_ind
	)
	
	






	;

rep_spec : r=FOR subtype_mark USE rep_spec_part
 SEMI 	;

rep_spec_part 

 : RECORD align_opt comp_loc_s END RECORD 
	| AT expression                        
	| expression
	  
		
	;

align_opt : ( AT MOD expression SEMI )?
	;

comp_loc_s : ( pragma | subtype_mark AT expression RANGE range SEMI )*
	;

private_task_items_opt : ( PRIVATE ( pragma )* entrydecls_repspecs_opt )?
	
	;

prot_type_or_single_decl 

 : TYPE def_id
 discrim_part_opt protected_definition
	| def_id
 protected_definition
	;

protected_definition
 : IS prot_op_decl_s ( PRIVATE prot_member_decl_s )? end_id_opt 	;

prot_op_decl_s : ( prot_op_decl )*
	;

prot_op_decl : entry_declaration
	| p=PROCEDURE def_id
 formal_part_opt SEMI 	| f=FUNCTION def_designator
 function_tail SEMI 	| rep_spec
	| pragma
	;

prot_member_decl_s : ( prot_op_decl | comp_decl )*
	;

comp_decl : def_ids_colon component_subtype_def init_opt SEMI 	;



decl_common
 : t=TYPE IDENTIFIER
		( IS type_def

		|	( discrim_part
				( IS derived_or_private_or_record

				| EPSILON)
			| empty_discrim_opt
			  
			  
			)
		  
		)
		SEMI 	| s=SUBTYPE IDENTIFIER IS subtype_ind SEMI  
	| generic_decl

	| use_clause
	| r=FOR ( local_enum_name USE 			| subtype_mark USE rep_spec_part

		)
		SEMI 	| IDENTIFIER erd=COLON  EXCEPTION RENAMES compound_name | IDENTIFIER ord=COLON subtype_mark RENAMES name | defining_identifier_list od=COLON  
		( EXCEPTION 		| CONSTANT ASSIGN | aliased_constant_opt
			( array_type_definition
 init_opt
				
				
			| subtype_ind init_opt
			)
		)
		SEMI 	;

type_def 

 : LPAREN enum_id_s RPAREN 	| RANGE range
	| MOD expression
	| DIGITS expression range_constraint_opt
	| DELTA expression
		( RANGE range
		| DIGITS expression range_constraint_opt
		)
	| array_type_definition

	| access_type_definition

	| empty_discrim_opt derived_or_private_or_record

	;

enum_id_s : enumeration_literal_specification
		( COMMA enumeration_literal_specification )*
	;

enumeration_literal_specification : IDENTIFIER | CHARACTER_LITERAL
	;

range_constraint_opt : ( range_constraint )?
	;

array_type_definition 

 : ARRAY LPAREN index_or_discrete_range_s RPAREN 		OF component_subtype_def
	;

index_or_discrete_range_s
 : index_or_discrete_range ( COMMA index_or_discrete_range )*
	;

index_or_discrete_range
 : simple_expression
		( DOT_DOT simple_expression  
		| RANGE ( BOX                
			| range              
			)
		)?
	;

component_subtype_def : aliased_opt subtype_ind
	;

aliased_opt : ( ALIASED )?
	;

subtype_ind : subtype_mark constraint_opt
	;

constraint_opt : ( range_constraint
	| digits_constraint
	| delta_constraint
	| index_constraint| discriminant_constraint
	)?
	;

digits_constraint : d=DIGITS expression range_constraint_opt
	;

delta_constraint : d=DELTA expression range_constraint_opt
	;

index_constraint : p=LPAREN discrete_range ( COMMA discrete_range )* RPAREN 	;

discrete_range
 : range| subtype_ind
	;

discriminant_constraint : p=LPAREN discriminant_association 
		( COMMA discriminant_association )* RPAREN 	;

discriminant_association : selector_names_opt expression
	;

selector_names_opt : ( association_head| EPSILON
	)
	;

association_head : selector_name ( PIPE selector_name )* RIGHT_SHAFT 	;

selector_name : IDENTIFIER  
	;

access_type_definition 

 : ACCESS 		( protected_opt
			( PROCEDURE formal_part_opt
			| FUNCTION func_formal_part_opt RETURN subtype_mark
			)
		| constant_all_opt subtype_ind
		)
	;

protected_opt : ( PROTECTED )?
	;

constant_all_opt : ( CONSTANT | ALL )?
	;

derived_or_private_or_record 

 : abstract_opt NEW subtype_ind WITH 			| NEW subtype_ind 
	| abstract_tagged_limited_opt
		( PRIVATE 
		| record_definition

		)
	;

abstract_opt : ( ABSTRACT )?
	;

record_definition
 : RECORD component_list
 END RECORD 	| NuLL RECORD  
	;

component_list
 : NuLL SEMI  
	| component_items ( variant_part  )?
	| empty_component_items variant_part
	;

component_items : ( pragma | comp_decl )+
	;

empty_component_items :EPSILON
	;

variant_part : c=CASE discriminant_direct_name IS variant_s END CASE SEMI 	;

discriminant_direct_name : IDENTIFIER  
	;

variant_s : ( variant )+
	;

variant : w=WHEN choice_s RIGHT_SHAFT component_list

	;

choice_s : choice ( PIPE choice )*
	;

choice : OTHERS
	| discrete_with_range| expression   
	;              

discrete_with_range : mark_with_constraint| range
	;

mark_with_constraint : subtype_mark range_constraint
	;

abstract_tagged_limited_opt
 : ( ABSTRACT TAGGED | TAGGED )?
	  ( LIMITED )?
	;

local_enum_name : IDENTIFIER  
	;

enumeration_aggregate : parenth_values
	;

aliased_constant_opt : ( ALIASED )? ( CONSTANT )?
	;

generic_decl 

 : g=GENERIC generic_formal_part_opt
	( PACKAGE def_id

		( renames 
		| IS pkg_spec_part 
		)
	| PROCEDURE def_id
 formal_part_opt
		( renames 
		  
		  
		| EPSILON
		)
	| FUNCTION def_designator
 function_tail
		( renames 
		  
		  
		| EPSILON
		)
	)
	SEMI 	;

generic_formal_part_opt : ( use_clause | pragma | generic_formal_parameter )*
	;

generic_formal_parameter :
	( t=TYPE def_id

		( IS 			( LPAREN BOX RPAREN 			| RANGE BOX 			| MOD BOX 			| DELTA BOX 				( DIGITS BOX 				| 
				EPSILON)
			| DIGITS BOX 			| array_type_definition

			| access_type_definition

			| empty_discrim_opt discriminable_type_definition

			)
		| discrim_part IS discriminable_type_definition

		)
	| w=WITH ( PROCEDURE def_id
 formal_part_opt subprogram_default_opt
		| FUNCTION def_designator
 function_tail subprogram_default_opt
		| PACKAGE def_id
 IS NEW compound_name formal_package_actual_part_opt
		)
	| parameter_specification
	)
	SEMI 	;

discriminable_type_definition 

 : abstract_opt NEW subtype_ind WITH | NEW subtype_ind
	| abstract_tagged_limited_opt PRIVATE 	;

subprogram_default_opt : ( IS ( BOX | name ) )?
	;

formal_package_actual_part_opt
 : ( LPAREN ( BOX | defining_identifier_list ) RPAREN )?
	;

subprog_decl_or_rename_or_inst_or_body 

 : p=PROCEDURE def_id

		( generic_subp_inst
		| formal_part_opt
			( renames 
			| IS	( separate_or_abstract

				| body_part 
				)
			|EPSILON )
			SEMI 		)
	| f=FUNCTION def_designator

		( generic_subp_inst
		| function_tail
			( renames 
			| IS	( separate_or_abstract

				| body_part 
				)
			| EPSILON)
			SEMI 		)
	;

body_part : declarative_part block_body end_id_opt 	;

declarative_part : ( pragma | declarative_item )*
	;


declarative_item :
	( pkg=PACKAGE ( body_is
			( separate 
			| pkg_body_part end_id_opt 			)
			SEMI 		| def_id
 spec_decl_part

		)
	| tsk=TASK ( body_is
			( separate 
			| body_part 
			)
			SEMI 		| task_type_or_single_decl

		)
	| pro=PROTECTED
		( body_is
			( separate 
	       		| prot_op_bodies_opt end_id_opt 			)
		| prot_type_or_single_decl

		)
		SEMI 	| subprog_decl_or_rename_or_inst_or_body

	| decl_common
	)
	;

body_is : BODY def_id
 IS 	;

separate : SEPARATE 
	;

pkg_body_part : declarative_part block_body_opt
	;

block_body_opt : ( BEGIN handled_stmt_s )?
	;

prot_op_bodies_opt : ( entry_body
	| subprog_decl_or_body
	| pragma
	)*
	;

subprog_decl_or_body
 : p=PROCEDURE def_id
 formal_part_opt
		( IS body_part 
		| EPSILON)
		SEMI 	| f=FUNCTION def_designator
 function_tail
		( IS body_part 
		| EPSILON)
		SEMI 	;

block_body : b=BEGIN handled_stmt_s
	;

handled_stmt_s : statements except_handler_part_opt
	;

statements : ( pragma | statement )+
	;

statement : def_label_opt
	( null_stmt
	| exit_stmt
	| return_stmt
	| goto_stmt
	| delay_stmt
	| abort_stmt
	| raise_stmt
	| requeue_stmt
	| accept_stmt
	| select_stmt
	| if_stmt
	| case_stmt
	| loop_stmt SEMI 	| block END SEMI 	| statement_identifier
		( loop_stmt id_opt SEMI   
		| block end_id_opt SEMI   
		)
	| call_or_assignment
	
	)
	;

def_label_opt : ( LT_LT IDENTIFIER GT_GT )?
	;

null_stmt : s=NuLL SEMI 	;

if_stmt : s=IF cond_clause elsifs_opt
	  else_opt
	  END IF SEMI 	;

cond_clause : condition c=THEN statements
	;

condition : expression
	
	;

elsifs_opt : ( ELSIF cond_clause )*
	;

else_opt : ( ELSE statements )?
	;

case_stmt : s=CASE expression IS alternative_s END CASE SEMI 	;

alternative_s : ( case_statement_alternative )+
	;

case_statement_alternative : s=WHEN choice_s RIGHT_SHAFT statements
	;

loop_stmt : iteration_scheme_opt
		LOOP statements END LOOP  
        ;

iteration_scheme_opt : ( WHILE condition
	| FOR IDENTIFIER IN reverse_opt discrete_subtype_definition
	)?
	;

reverse_opt : ( REVERSE )?
	;

id_opt: endid=definable_operator_symbol 
	| n=compound_name 
	| EPSILON;

end_id_opt : END id_opt
	;

statement_identifier: n=IDENTIFIER COLON 	;

block : declare_opt block_body
	;

declare_opt : ( DECLARE declarative_part )?
	;

exit_stmt : s=EXIT ( label_name )? ( WHEN condition )? SEMI 	;

label_name : IDENTIFIER
	;

return_stmt : s=RETURN ( expression )? SEMI 	;

goto_stmt : s=GOTO label_name SEMI 	;

call_or_assignment :  
	name ( ASSIGN expression
	     |  EPSILON)
	SEMI 	;

entry_body : e=ENTRY def_id
 entry_body_formal_part entry_barrier IS 		body_part SEMI 	;

entry_body_formal_part : entry_index_spec_opt formal_part_opt
	;

entry_index_spec_opt :
	( LPAREN FOR def_id
 IN discrete_subtype_definition | EPSILON
	)
	;

entry_barrier : WHEN condition
	;

entry_call_stmt : name SEMI  
			     
	;

accept_stmt : a=ACCEPT def_id
 entry_index_opt formal_part_opt
		( DO handled_stmt_s end_id_opt SEMI 		| SEMI 
		)
	;

entry_index_opt : ( LPAREN expression | EPSILON
	)
	;

delay_stmt : d=DELAY until_opt expression SEMI 	;

until_opt : ( UNTIL )?
	;






select_stmt : s=SELECT
	( triggering_alternative THEN ABORT | selective_accept
	| entry_call_alternative
		( OR delay_alternative 
		| ELSE statements 
		)
	)
	END SELECT SEMI 	
	;

triggering_alternative : ( delay_stmt | entry_call_stmt ) stmts_opt
	;

abortable_part : stmts_opt
	;

entry_call_alternative : entry_call_stmt stmts_opt
	;

selective_accept : guard_opt select_alternative or_select_opt else_opt
	;

guard_opt : ( WHEN condition RIGHT_SHAFT ( pragma )* )?
	;

select_alternative  
 : accept_alternative
	| delay_alternative
	| t=TERMINATE SEMI  
	;

accept_alternative : accept_stmt stmts_opt
	;

delay_alternative : delay_stmt stmts_opt
	;

stmts_opt : ( pragma | statement )*
	;

or_select_opt : ( OR guard_opt select_alternative )*
	;

abort_stmt : a=ABORT name ( COMMA name )* SEMI 	;

except_handler_part_opt : ( EXCEPTION ( exception_handler )+ )?
	;

exception_handler : w=WHEN identifier_colon_opt except_choice_s RIGHT_SHAFT 		statements
	;

identifier_colon_opt : ( IDENTIFIER COLON )?
	;

except_choice_s : exception_choice ( PIPE exception_choice )*
	;

exception_choice : compound_name
	| OTHERS
	;

raise_stmt : r=RAISE ( compound_name )? SEMI 	;

requeue_stmt : r=REQUEUE name ( WITH ABORT )? SEMI 	;

operator_call : cs=CHAR_STRING operator_call_tail

	;

operator_call_tail 

 : LPAREN 
		  value_s RPAREN 
	;

value_s : value ( COMMA value )*
	;


expression : relation
		( a=AND ( THEN 
			)? relation
		| o=OR ( ELSE 
			)? relation
		| XOR relation
		)*
	;

relation : simple_expression
		( IN range_or_mark
		| n=NOT IN range_or_mark 
		| EQ simple_expression
		| NE simple_expression
		| LT_ simple_expression
		| LE simple_expression
		| GT simple_expression
		| GE simple_expression
		)?
	;

range_or_mark : range| subtype_mark
	;

simple_expression : signed_term
		( PLUS signed_term
		| MINUS signed_term
		| CONCAT signed_term
		)*
	;

signed_term
 : p=PLUS term 
	| m=MINUS term 
	| term
	;

term    : factor ( STAR factor
		| DIV factor
		| MOD factor
		| REM factor
		)*
	;

factor : ( NOT primary
	| ABS primary
	| primary ( EXPON primary )?
	)
	;

primary : ( name_or_qualified
	| parenthesized_primary
	| allocator
	| NuLL
	| NUMERIC_LIT
	| CHARACTER_LITERAL
	| cs=CHAR_STRING ( operator_call_tail
 )?
	)
	;





name_or_qualified: IDENTIFIER
		( DOT	( ALL
			| IDENTIFIER
			| CHARACTER_LITERAL
			| dummy=is_operator
			)
		| p=LPAREN value_s RPAREN 		| TIC ( parenthesized_primary | attribute_id )
		)*
	;

allocator : n=NEW name_or_qualified
	;

subunit : sep=SEPARATE LPAREN compound_name RPAREN 		( subprogram_body
		| package_body
		| task_body
		| protected_body
		)
	;

subprogram_body
 : p=PROCEDURE def_id
 formal_part_opt IS body_part SEMI 	| f=FUNCTION function_tail IS body_part SEMI 	;

package_body : p=PACKAGE body_is pkg_body_part end_id_opt SEMI 	;

task_body : t=TASK body_is body_part SEMI 	;
 
protected_body : p=PROTECTED body_is prot_op_bodies_opt end_id_opt SEMI 	;

ABORT            : 'abort'      ;
  ABS              : 'abs'        ;
  ABSTRACT         : 'abstract'   ;
  ACCEPT           : 'accept'     ;
  ACCESS           : 'access'     ;
  ALIASED          : 'aliased'    ;
  ALL              : 'all'        ;
  AND              : 'and'        ;
  ARRAY            : 'array'      ;
  AT               : 'at'         ;
  BEGIN            : 'begin'      ;
  BODY             : 'body'       ;
  CASE             : 'case'       ;
  CONSTANT         : 'constant'   ;
  DECLARE          : 'declare'    ;
  DELAY            : 'delay'      ;
  DELTA            : 'delta'      ;
  DIGITS           : 'digits'     ;
  DO               : 'do'         ;
  ELSE             : 'else'       ;
  ELSIF            : 'elsif'      ;
  END              : 'end'        ;
  ENTRY            : 'entry'      ;
  EXCEPTION        : 'exception'  ;
  EXIT             : 'exit'       ;
  FOR              : 'for'        ;
  FUNCTION         : 'function'   ;
  GENERIC          : 'generic'    ;
  GOTO             : 'goto'       ;
  IF               : 'if'         ;
  IN               : 'in'         ;
  IS               : 'is'         ;
  LIMITED          : 'limited'    ;
  LOOP             : 'loop'       ;
  MOD              : 'mod'        ;
  NEW              : 'new'        ;
  NOT              : 'not'        ;
  NuLL             : 'null'       ;
  OF               : 'of'         ;
  OR               : 'or'         ;
  OTHERS           : 'others'     ;
  OUT              : 'out'        ;
  PACKAGE          : 'package'    ;
  PRAGMA           : 'pragma'     ;
  PRIVATE          : 'private'    ;
  PROCEDURE        : 'procedure'  ;
  PROTECTED        : 'protected'  ;
  RAISE            : 'raise'      ;
  RANGE            : 'range'      ;
  RECORD           : 'record'     ;
  REM              : 'rem'        ;
  RENAMES          : 'renames'    ;
  REQUEUE          : 'requeue'    ;
  RETURN           : 'return'     ;
  REVERSE          : 'reverse'    ;
  SELECT           : 'select'     ;
  SEPARATE         : 'separate'   ;
  SUBTYPE          : 'subtype'    ;
  TAGGED           : 'tagged'     ;
  TASK             : 'task'       ;
  TERMINATE        : 'terminate'  ;
  THEN             : 'then'       ;
  TYPE             : 'type'       ;
  UNTIL            : 'until'      ;
  USE              : 'use'        ;
  WHEN             : 'when'       ;
  WHILE            : 'while'      ;
  WITH             : 'with'       ;
  XOR              : 'xor'        ;
COMMENT_INTRO      :       '--'    ;
DOT_DOT            :       '..'    ;
LT_LT              :       '<<'    ;
BOX                :       '<>'    ;
GT_GT              :       '>>'    ;
ASSIGN             :       ':='    ;
RIGHT_SHAFT        :       '=>'    ;
NE                 :       '/='    ;
LE                 :       '<='    ;
GE                 :       '>='    ;
EXPON              :       '**'    ;
PIPE               :       '|'     ;
CONCAT             :       '&'     ;
DOT                :       '.'     ;
EQ                 :       '='     ;
LT_                :       '<'     ;
GT                 :       '>'     ;
PLUS               :       '+'     ;
MINUS              :       '-'     ;
STAR               :       '*'     ;
DIV                :       '/'     ;
LPAREN             :       '('     ;
RPAREN             :       ')'     ;
COLON              :       ':'     ;
COMMA              :       ','     ;
SEMI               :       ';'     ;

TIC    :   '\''    ;








IDENTIFIER
            : ( 'a'| 'b'| 'c'| 'd'| 'e'| 'f'| 'g'| 'h'| 'i'| 'j'| 'k'| 'l'| 'm'| 'n'| 'o'| 'p'| 'q'| 'r'| 's'| 't'| 'u'| 'v'| 'w'| 'x'| 'y'| 'z' ) ( ('_')? ( 'a'| 'b'| 'c'| 'd'| 'e'| 'f'| 'g'| 'h'| 'i'| 'j'| 'k'| 'l'| 'm'| 'n'| 'o'| 'p'| 'q'| 'r'| 's'| 't'| 'u'| 'v'| 'w'| 'x'| 'y'| 'z'|'0'| '1'| '2'| '3'| '4'| '5'| '6'| '7'| '8'| '9') )*
	;

CHARACTER_LITERAL    : 

	'\'' ANY '\''
	;

CHAR_STRING : '"' (ANY)* '"'
	;

NUMERIC_LIT : ( DIGIT )+
		( '#' BASED_INTEGER ( '.' BASED_INTEGER )? '#'
		| ( '_' ( DIGIT )+ )+  
		)?
		( 
			( '.' ( DIGIT )+ ( '_' ( DIGIT )+ )* ( EXPONENT )?
			| EXPONENT
			)
		)?
	;



DIGIT   :  ( '0'| '1'| '2'| '3'| '4'| '5'| '6'| '7'| '8'| '9' ) ;

EXPONENT           :  ('e') ('+'|'-')? ( DIGIT )+ ;

EXTENDED_DIGIT     :  ( DIGIT | 'a'|'b'|'c'|'d'|'e'|'f' ) ;

BASED_INTEGER      :  ( EXTENDED_DIGIT ) ( ('_')? EXTENDED_DIGIT )* ;



WS_	:	(	' '
		|	'\t'
		|	'\f'

		|	(	'\r\n'  
			|	'\r'    
			|	'\n'    
			)
			
		)
		
	;


COMMENT :	( COMMENT_INTRO (ANY)* ('\n'|'\r'('\n')?) )
		
	;
