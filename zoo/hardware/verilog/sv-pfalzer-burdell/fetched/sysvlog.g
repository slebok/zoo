header {
package parser.sv;
import  parser.Message;
}
options {
    language="Java";
}

//-----------------------------------------------------------------------------
// The SysVlog parser
//-----------------------------------------------------------------------------

class SysVlogParser extends Parser;
options {
    k = 2;                     
    exportVocab = SysVlog;       
}
{
	public static boolean stDebug = false;
	public static boolean stQuick = true;	//non_port_module_item only seeks instantiations
	
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
	public static Tracker	stTracker = new Tracker();

    public void consume() throws TokenStreamException {
		if (stDebug) {
        //if (0 == inputState.guessing) {
            Token tok = LT(1);
            int tc = tok.getType();
           	int ln = tok.getLine();
           	System.out.println("DBG:"+ln+":consume:"+tc+": "+tok.getText());
           	System.out.flush();
        //}
		}
        super.consume();
    }

	//Debug
    public int LA(int i) throws TokenStreamException {
/**/
		if (stDebug) {
		//if (0 == inputState.guessing) {
        	Token tok = LT(i);
            int tc = tok.getType();
            int ln = tok.getLine();
            System.out.println("DBG:" + ln + ":LA(" + i + "):"+tc+"= " + tok.getText());
        	System.out.flush();
		//}
		}
/**/
        return super.LA(i);
    }

    /**Print message unless it was already handled.*/
    public void reportError(RecognitionException ex) {
        if (false == parser.ExceptionBase.class.isInstance(ex)) {
            Message.message(ex);
        }
    }

    public void reportError(String s) {
        Message.syntaxError(s);
    }

    public void reportWarning(String s) {
		Message.syntaxWarning(s);
    }
}

//A.1 Source text
//A.1.1 Library source text
library_text
:	(library_descriptions)*
;

library_descriptions
:	library_declaration
| 	include_statement
| 	config_declaration
| 	SEMI
;

library_declaration
:	"library" library_identifier file_path_spec (COMMA file_path_spec)*
		("-incdir" file_path_spec (COMMA file_path_spec)* )? SEMI
;

file_path_spec
:	file_path
;

// kwp: Did not see file_spec in LRM, so we'll guess
file_path
:	STRING
|	LT_ identifier (SLASH identifier)* GT
;

include_statement
:	"include" file_path_spec SEMI
;

//A.1.2 Configuration source text
config_declaration
:	"config" config_identifier SEMI
		design_statement
		(config_rule_statement)*
		"endconfig" (COLON config_identifier)?
;

design_statement
:	"design" ( (library_identifier DOT )? cell_identifier )* SEMI
;

config_rule_statement
:	default_clause liblist_clause
|	(inst_clause | cell_clause) (liblist_clause | use_clause)
| 	SEMI
;

default_clause
:	"default"
;

inst_clause
:	"instance" inst_name
;

inst_name
:	topmodule_identifier (DOT instance_identifier)*
;

cell_clause
:	"cell" ( library_identifier DOT )? cell_identifier
;

liblist_clause
:	"liblist" (library_identifier)*
;

use_clause
:	"use" ( library_identifier DOT )? cell_identifier ( COLON "config" )?
;

//A.1.3 Module and primitive source text
source_text
:	( options{greedy=true;}: timeunits_declaration )? ( description )*
		EOF
;

description
:	(attribute_instances module_keyword)=> module_declaration
|	(attribute_instances "package")=> package_declaration
| 	(attribute_instances "primitive")=> udp_declaration
| 	(interface_declaration)=> interface_declaration
| 	(program_declaration)=> program_declaration
| 	(attribute_instances package_item)=> attribute_instances package_item
| 	attribute_instances bind_directive
;

/* Pull off common prefix
 */
module_header_prefix
{Token mid=null;}
:	attribute_instances module_keyword ( lifetime )? 
		mid=module_identifier {stTracker.addModule(mid);}
		( parameter_port_list )?
;

module_nonansi_header
:	module_header_prefix
		list_of_ports SEMI
;

module_ansi_header
:	module_header_prefix
		( list_of_port_declarations )? SEMI
;

/*	TODO: Note2:
 *	module_declaration has lots of common prefix (nondeterminism), so
 *	just break alternatives and use blind/expensive predicates...
 */
module_declaration_1
:	module_nonansi_header (options{greedy=true;}: timeunits_declaration )? 
		( module_item )*
		"endmodule" {stTracker.endModule();}
		( COLON module_identifier )?
;

module_declaration_2
: 	module_ansi_header (options{greedy=true;}: timeunits_declaration )? 
    	non_port_module_item_star
		"endmodule" {stTracker.endModule();}
		( COLON module_identifier )?
;

module_declaration_3
:	module_header_prefix LPAREN DOT_STAR RPAREN SEMI
		(options{greedy=true;}: timeunits_declaration )? 
		module_item_star
		"endmodule" {stTracker.endModule();}
		( COLON module_identifier )?
;

module_declaration_4
: 	"extern" module_nonansi_header
;

module_declaration_5
: 	"extern" module_ansi_header
;

module_declaration
:	(module_declaration_5)=> module_declaration_5
|	(module_declaration_4)=> module_declaration_4
|	(module_declaration_3)=> module_declaration_3
|	(module_declaration_2)=> module_declaration_2
|	module_declaration_1
;

module_keyword
:	"module" 
| 	"macromodule"
;

interface_header_prefix
{Token id=null;}
:	attribute_instances "interface" ( lifetime )? 
            id=interface_identifier
            {
                stTracker.addInterface(id);
            }
            ( parameter_port_list )?
;

interface_nonansi_header
:	interface_header_prefix list_of_ports SEMI
;

interface_ansi_header
:	interface_header_prefix ( list_of_port_declarations )? SEMI
;

//See Note2
interface_declaration_1
:	interface_nonansi_header 
		(options{greedy=true;}: timeunits_declaration )? 
		( interface_item )* "endinterface" ( COLON interface_identifier )?
;
interface_declaration_2
: 	interface_ansi_header (options{greedy=true;}: timeunits_declaration )? 
		( non_port_interface_item )* "endinterface" 
		( COLON interface_identifier )?
;
interface_declaration_3
{Token id=null;}
: 	attribute_instances "interface" id=interface_identifier 
                {
                    stTracker.addInterface(id);
                }
		LPAREN DOT_STAR RPAREN SEMI
 		(options{greedy=true;}: timeunits_declaration )? 
		( interface_item )*
		"endinterface" ( COLON interface_identifier )?
;
interface_declaration_4
: 	"extern" interface_nonansi_header
;
interface_declaration_5
: 	"extern" interface_ansi_header
;
interface_declaration
:	(interface_declaration_5)=> interface_declaration_5 
|	(interface_declaration_4)=> interface_declaration_4 
|	(interface_declaration_3)=> interface_declaration_3 
|	(interface_declaration_2)=> interface_declaration_2 
|	interface_declaration_1
;

program_header_prefix
:	attribute_instances "program" ( lifetime )? program_identifier
		( parameter_port_list )?
;

program_nonansi_header
:	program_header_prefix list_of_ports SEMI
;

program_ansi_header
:	program_header_prefix ( list_of_port_declarations )? SEMI
;

//See Note2
program_declaration_1
:	program_nonansi_header 
		(options{greedy=true;}: timeunits_declaration )? 
		( program_item )*
		"endprogram" ( COLON program_identifier )?
;
program_declaration_2
: 	program_ansi_header
		(options{greedy=true;}: timeunits_declaration )? 
		( non_port_program_item )*
		"endprogram" ( COLON program_identifier )?
;
program_declaration_3
: 	attribute_instances "program" program_identifier 
		LPAREN DOT_STAR RPAREN SEMI
		(options{greedy=true;}:  timeunits_declaration )? ( program_item )*
		"endprogram" ( COLON program_identifier )?
;
program_declaration_4
: 	"extern" program_nonansi_header
;
program_declaration_5
: 	"extern" program_ansi_header
;
program_declaration
:	(program_declaration_5)=> program_declaration_5 
|	(program_declaration_4)=> program_declaration_4 
|	(program_declaration_3)=> program_declaration_3 
|	(program_declaration_2)=> program_declaration_2 
|	program_declaration_1
;

class_declaration
:	( "virtual" )? "class" ( lifetime )? class_identifier 
		( parameter_port_list )? 
		( "extends" class_type ( LPAREN list_of_arguments RPAREN )? )? SEMI
		( class_item )*
		"endclass" (COLON class_identifier)?
;

package_declaration
:	attribute_instances "package" package_identifier SEMI
		(options{greedy=true;}: timeunits_declaration )? 
		( attribute_instances package_item )*
		"endpackage" ( COLON package_identifier )?
;

timeunits_declaration
:	"timeunit" time_literal SEMI
		(options{greedy=true;}: "timeprecision" time_literal SEMI)?
| 	"timeprecision" time_literal SEMI
		(options{greedy=true;}: "timeunit" time_literal SEMI)?
;

//A.1.4 Module parameters and ports
parameter_port_list
: 	(POUND LPAREN RPAREN)=> POUND LPAREN RPAREN	
|	POUND LPAREN 
		(	(parameter_port_declaration)=> parameter_port_declaration 
		|	list_of_param_assignments
		)
		( COMMA parameter_port_declaration )* RPAREN
;

parameter_port_declaration
:	parameter_declaration
| 	data_type list_of_param_assignments
| 	"type" list_of_type_assignments
;

list_of_ports
:	LPAREN port ( COMMA port )* RPAREN
;

list_of_port_declarations
:	LPAREN ( attribute_instances ansi_port_declaration 
		( COMMA attribute_instances ansi_port_declaration )* )? RPAREN
;

port_declaration
:	attribute_instances 
		(	inout_declaration
		| 	input_declaration
		| 	output_declaration
		| 	ref_declaration
		| 	interface_port_declaration
		)
;

port
:	(options{greedy=true;}: port_expression )?
| 	DOT port_identifier 
		LPAREN (options{greedy=true;}: port_expression )? RPAREN
;

port_expression
: 	( port_reference (options{greedy=true;}: COMMA port_reference )* )*
;

port_reference
:	port_identifier constant_select
;

port_direction
:	"input" | "output" | "inout" | "ref"
;

net_port_header
:	( port_direction )? port_type
;

variable_port_header
:	( port_direction )? data_type
;

interface_port_header
:	interface_identifier ( DOT modport_identifier )?
| 	"interface" ( DOT modport_identifier )?
;

//See Note2
ansi_port_declaration_1
:	( (net_port_header)=>net_port_header | interface_port_header )? 
		port_identifier ( unpacked_dimension )*
;
ansi_port_declaration_2
: 	(options{greedy=true;}:  variable_port_header )? 
		port_identifier variable_dimension 
		( EQ constant_expression )?
;
ansi_port_declaration_3
: 	( (net_port_header)=>net_port_header | variable_port_header )? 
		DOT port_identifier LPAREN ( expression )? RPAREN
;
ansi_port_declaration	//OK
:	(ansi_port_declaration_2)=> ansi_port_declaration_2
|	(ansi_port_declaration_1)=> ansi_port_declaration_1
|	ansi_port_declaration_3
;

//A.1.5 Module items
module_common_item
:	(module_or_generate_item_declaration)=>
		module_or_generate_item_declaration
| 	(interface_instantiation)=> interface_instantiation
|	program_instantiation
| 	concurrent_assertion_item
| 	bind_directive
| 	continuous_assign
| 	net_alias
| 	initial_construct
| 	final_construct
| 	always_construct
;

//TODO: fix expensive/time syntactic predicate
module_item
:	(port_declaration SEMI)=> port_declaration SEMI
| 	non_port_module_item
;

/*
module_or_generate_item
:	attribute_instances parameter_override
//kwp | 	attribute_instances gate_instantiation
//kwp | 	attribute_instances udp_instantiation
| 	attribute_instances module_instantiation
		(module_identifier ( parameter_value_assignment )? 
			name_of_instance LPAREN)=> module_instantiation
| 	attribute_instances module_common_item
;
*/
module_or_generate_item
:	attribute_instances 
		(	parameter_override
		| 	(module_identifier (POUND | (name_of_instance LPAREN)))=>
				module_instantiation
		|   (gate_instantiation_predict)=> gate_instantiation
		| 	module_common_item
		)
;

module_or_generate_item_declaration
:	package_or_generate_item_declaration
| 	genvar_declaration
| 	(clocking_declaration)=> clocking_declaration
| 	"default" "clocking" clocking_identifier SEMI
;

quick_non_port_module_item_star
:	(	(module_identifier (POUND | (name_of_instance LPAREN)))=>
			module_instantiation
	|	(gate_instantiation_predict)=> gate_instantiation
	|	{LA(1) != LITERAL_endmodule}? .
	)*
;

module_item_star
:	{stQuick}? quick_non_port_module_item_star
|	(module_item)*
;

non_port_module_item_star
:	{stQuick}? quick_non_port_module_item_star
|	(non_port_module_item)*
;

non_port_module_item
: 	(module_or_generate_item)=> module_or_generate_item
|	generated_module_instantiation
//kwp| 	specify_block
| 	(module_declaration)=> module_declaration
| 	(program_declaration)=> program_declaration
| 	attribute_instances specparam_declaration
| 	timeunits_declaration
;

parameter_override
:	"defparam" list_of_defparam_assignments SEMI
;

bind_directive
:	"bind" hierarchical_identifier 
	constant_select bind_instantiation SEMI
;

bind_instantiation
:	(program_instantiation)=> program_instantiation
| 	(module_instantiation)=> module_instantiation
| 	interface_instantiation
;

//A.1.6 Interface items
interface_or_generate_item
:	attribute_instances 
		(	module_common_item
		| 	modport_declaration
		| 	extern_tf_declaration
		)
;

extern_tf_declaration
:	"extern" method_prototype SEMI
| 	"extern" "forkjoin" task_prototype SEMI
;

interface_item
:	(port_declaration SEMI)=> port_declaration SEMI
| 	non_port_interface_item
;

non_port_interface_item
:	generated_interface_instantiation
| 	(attribute_instances specparam_declaration)=>
	 	attribute_instances specparam_declaration
| 	(interface_or_generate_item)=> interface_or_generate_item
| 	(program_declaration)=> program_declaration
| 	interface_declaration
| 	timeunits_declaration
;

//A.1.7 Program items
program_item
:	(port_declaration SEMI)=> port_declaration SEMI
| 	non_port_program_item
;

non_port_program_item
:	attribute_instances 
		(	continuous_assign
		| 	(concurrent_assertion_item)=> concurrent_assertion_item
		| 	module_or_generate_item_declaration
		| 	specparam_declaration
		| 	initial_construct
		| 	timeunits_declaration
		)
;

//A.1.8 Class items
class_item
:	attribute_instances 
		(	(class_property)=> class_property
		| 	(class_method)=> class_method
		| 	class_constraint
		| 	type_declaration
		| 	class_declaration
		| 	timeunits_declaration
		)
|	SEMI
;

class_property
:	((options{greedy=true;}: property_qualifier )* data_declaration)=>
		(options{greedy=true;}: property_qualifier )* data_declaration
| 	"const" (options{greedy=true;}: class_item_qualifier )* data_type 
		const_identifier ( EQ constant_expression )? SEMI
;

class_method
:	( method_qualifier )* 
		(	task_declaration
		| 	(function_declaration)=> function_declaration
		| 	class_constructor_declaration
		)
| 	"extern" ( method_qualifier )* 
		(	method_prototype SEMI
		| 	class_constructor_prototype
		)
;

class_constructor_prototype
:	"function" "new" LPAREN ( tf_port_list )? RPAREN SEMI
;

class_constraint
:	(constraint_prototype)=> constraint_prototype
| 	constraint_declaration
;

class_item_qualifier
:	"static"
| 	"protected"
| 	"local"
;

property_qualifier
:	"rand"
| 	"randc"
| 	class_item_qualifier
;

method_qualifier
:	"virtual"
| 	class_item_qualifier
;

method_prototype
:	task_prototype SEMI
| 	function_prototype SEMI
;

class_constructor_declaration
:	"function" ( class_scope )? "new" 
		( LPAREN ( tf_port_list )? RPAREN )? SEMI
		(options{greedy=true;}: block_item_declaration )*
		( "super" DOT "new" ( LPAREN list_of_arguments RPAREN )? SEMI )?
		( function_statement_or_null )*
		"endfunction" ( COLON "new" )?
;

//A.1.9 Constraints
constraint_declaration
:	( "static" )? "constraint" constraint_identifier constraint_block
;

constraint_block
:	LCURLY ( constraint_block_item )* RCURLY
;

constraint_block_item
:	"solve" identifier_list "before" identifier_list SEMI
| 	constraint_expression
;

constraint_expression
:	(expression_or_dist SEMI)=> expression_or_dist SEMI
| 	expression MINUS_GT constraint_set
| 	"if" LPAREN expression RAPREN constraint_set 
		(options{greedy=true;}: "else" constraint_set )?
| 	"foreach" 
		LPAREN array_identifier LBRACK loop_variables RBRACK RPAREN constraint_set
;

constraint_set
:	(constraint_expression)=> constraint_expression
| 	LCURLY ( constraint_expression )* RCURLY
;

dist_list
:	dist_item ( COMMA dist_item )*
;

dist_item
:	value_range ( dist_weight )?
;

dist_weight
:	COLON_EQ expression
| 	COLON_SLASH expression
;

constraint_prototype
:	( "static" )? "constraint" constraint_identifier SEMI
;

extern_constraint_declaration
:	( "static" )? "constraint" class_scope constraint_identifier constraint_block
;

identifier_list
:	identifier ( COMMA identifier )*
;

//A.1.10 Package items
package_item
:	package_or_generate_item_declaration
| 	specparam_declaration
| 	anonymous_program
| 	timeunits_declaration
;

package_or_generate_item_declaration
:	net_declaration
| 	(data_declaration)=> data_declaration
| 	task_declaration
| 	(function_declaration)=> function_declaration
| 	dpi_import_export
| 	extern_constraint_declaration
| 	class_declaration
| 	class_constructor_declaration
| 	parameter_declaration SEMI
| 	local_parameter_declaration
| 	covergroup_declaration
| 	overload_declaration
| 	concurrent_assertion_item_declaration
| 	SEMI
;

anonymous_program
:	"program" SEMI ( anonymous_program_item )* "endprogram"
;

anonymous_program_item
:	task_declaration
| 	(function_declaration)=> function_declaration
| 	class_declaration
| 	covergroup_declaration
| 	class_constructor_declaration
| 	SEMI
;

//A.2 Declarations
//A.2.1 Declaration types
//A.2.1.1 Module parameter declarations
local_parameter_declaration
:	"localparam" data_type_or_implicit list_of_param_assignments SEMI
;

parameter_declaration
:	"parameter" data_type_or_implicit list_of_param_assignments
| 	"parameter" "type" list_of_type_assignments
;

specparam_declaration
:	"specparam" ( packed_dimension )? list_of_specparam_assignments SEMI
;

//A.2.1.2 Port declarations
inout_declaration
:	"inout" port_type list_of_port_identifiers
;

input_declaration	//OK
: 	("input" data_type list_of_variable_identifiers)=>
	 	"input" data_type list_of_variable_identifiers
|	"input" port_type list_of_port_identifiers
;

output_declaration	//OK
: 	("output" data_type list_of_variable_port_identifiers)=>
	 	"output" data_type list_of_variable_port_identifiers
|	"output" port_type list_of_port_identifiers
;

interface_port_declaration
:	interface_identifier list_of_interface_identifiers
| 	interface_identifier DOT modport_identifier list_of_interface_identifiers
;

ref_declaration
:	"ref" data_type list_of_port_identifiers
;

//A.2.1.3 Type declarations
data_declaration
:	( "const" )? ( lifetime )? variable_declaration
| 	type_declaration
| 	package_import_declaration
| 	virtual_interface_declaration
;

package_import_declaration
:	"import" package_import_item ( COMMA package_import_item )* SEMI
;

package_import_item
:	package_identifier COLON2 (identifier | STAR)
;

genvar_declaration
:	"genvar" list_of_genvar_identifiers SEMI
;

net_declaration
:	net_type_or_trireg ( drive_strength | charge_strength )? 
		( "vectored" | "scalared" )?
		( signing )? ( packed_dimension )* ( delay3 )? 
		list_of_net_decl_assignments SEMI
;

type_declaration
:	"typedef" 
		(	(data_type type_identifier variable_dimension SEMI)=>
				data_type type_identifier variable_dimension SEMI
		| 	interface_instance_identifier DOT 
				type_identifier type_identifier SEMI
		| 	( "enum" | "struct" | "union" | "class" )? type_identifier SEMI
		)
;

variable_declaration
:	data_type list_of_variable_decl_assignments SEMI
;

lifetime
:	"static" | "automatic"
;

//A.2.2 Declaration data types
//A.2.2.1 Net and variable types
casting_type
:	simple_type 
|	number //| 	size 
| 	signing
;

data_type
:	integer_vector_type ( signing )? ( packed_dimension )*
| 	integer_atom_type ( signing )?
| 	non_integer_type
| 	struct_union ( "packed" ( signing )? )? 
		LCURLY struct_union_member ( struct_union_member )* RCURLY
		( packed_dimension )*
| 	"enum" ( enum_base_type )? 
		LCURLY enum_name_declaration 
		( COMMA enum_name_declaration )* RCURLY
| 	"string"
| 	"chandle"
| 	"virtual" ( "interface" )? interface_identifier
| 	(class_type)=> class_type
| 	(ps_covergroup_identifier)=> ps_covergroup_identifier
| 	( (class_scope)=> class_scope | package_scope )? type_identifier 
		( packed_dimension )*
| 	"event"
;

data_type_or_implicit
:	(data_type)=> data_type
| 	( signing )? ( packed_dimension )*
;

enum_base_type
:	integer_atom_type ( signing )?
| 	integer_vector_type ( signing )? ( packed_dimension )?
| 	type_identifier ( packed_dimension )?
;

enum_name_declaration
:	enum_identifier 
		( LBRACK integral_number ( COLON integral_number )? RBRACK )? 
		( EQ constant_expression )?
;

class_scope
:	class_type COLON2
;

class_type
:	ps_class_identifier ( parameter_value_assignment )?
		(options{greedy=true;}:  COLON2 class_identifier 
		( parameter_value_assignment )? )*
;

integer_type
:	integer_vector_type | integer_atom_type
;

integer_atom_type
:	"byte" | "shortint" | "int" | "longint" | "integer" | "time"
;

integer_vector_type
:	"bit" | "logic" | "reg"
;

non_integer_type
:	"shortreal" | "real" | "realtime"
;

net_type
:	"supply0" | "supply1" | "tri" | "triand" | "trior" | "tri0" 
	| "tri1" | "wire" | "wand" | "wor"
;

port_type
:	( net_type_or_trireg )? ( signing )? ( packed_dimension )*
;

net_type_or_trireg
:	net_type | "trireg" //TODO? | "reg"  //added "reg"; not in LRM?
;

signing
:	"signed" | "unsigned"
;

simple_type
:	integer_type | non_integer_type | ps_type_identifier
;

struct_union_member
:	attribute_instances data_type_or_void list_of_variable_identifiers SEMI
;

data_type_or_void
:	data_type | "void"
;

struct_union
:	"struct" | "union" ( "tagged" )?
;

//A.2.2.2 Strengths
drive_strength
:	LPAREN strength0 COMMA 
		(	strength1 RPAREN
		| 	"highz1" RPAREN
		)
| 	LPAREN strength1 COMMA 
		(	strength0 RPAREN
		| 	"highz0" RPAREN
		)
| 	LPAREN "highz0" COMMA strength1 RPAREN
| 	LPAREN "highz1" COMMA strength0 RPAREN
;

strength0
:	"supply0" | "strong0" | "pull0" | "weak0"
;

strength1
:	"supply1" | "strong1" | "pull1" | "weak1"
;

charge_strength
:	LPAREN "small" RPAREN 
| 	LPAREN "medium" RPAREN 
| 	LPAREN "large" RPAREN
;

//A.2.2.3 Delays
delay3
:	POUND delay_value 
| 	POUND LPAREN mintypmax_expression 
		( COMMA mintypmax_expression ( COMMA mintypmax_expression )? )? RPAREN
;

//NOTE: Obvious conflict w/ delay3, so simplify
//delay2
//:	# delay_value | # ( mintypmax_expression [ , mintypmax_expression ] )
delay2: delay3
;

/*
delay_value
:	unsigned_number
| 	real_number
| 	ps_identifier
| 	time_literal
;
*/
delay_value
:	number
| 	ps_identifier
| 	time_literal
;

//A.2.3 Declaration lists
list_of_defparam_assignments
:	defparam_assignment ( COMMA defparam_assignment )*
;

list_of_genvar_identifiers
:	genvar_identifier ( COMMA genvar_identifier )*
;

list_of_interface_identifiers
:	interface_identifier ( unpacked_dimension )*
		( COMMA interface_identifier ( unpacked_dimension )* )*
;

list_of_net_decl_assignments
:	net_decl_assignment ( COMMA net_decl_assignment )*
;

list_of_net_identifiers
:	net_identifier ( unpacked_dimension )*
		( COMMA net_identifier ( unpacked_dimension )* )*
;

list_of_param_assignments
:	param_assignment (options{greedy=true;}: COMMA param_assignment )*
;

list_of_port_identifiers
:	port_identifier ( unpacked_dimension )*
		( COMMA port_identifier ( unpacked_dimension )* )*
;
list_of_udp_port_identifiers
:	port_identifier ( COMMA port_identifier )*
;

list_of_specparam_assignments
:	specparam_assignment ( COMMA specparam_assignment )*
;

list_of_tf_variable_identifiers
:	port_identifier variable_dimension ( EQ expression )?
		( COMMA port_identifier variable_dimension ( EQ expression )? )*
;

list_of_type_assignments
:	type_assignment (options{greedy=true;}: COMMA type_assignment )*
;

list_of_variable_decl_assignments
:	variable_decl_assignment ( COMMA variable_decl_assignment )*
;

list_of_variable_identifiers
:	variable_identifier variable_dimension
		( COMMA variable_identifier variable_dimension )*
;

list_of_variable_port_identifiers
:	port_identifier variable_dimension ( EQ constant_expression )?
		( COMMA port_identifier variable_dimension ( EQ constant_expression )? )*
;

list_of_virtual_interface_decl
:	variable_identifier ( EQ interface_instance_identifier )?
		( COMMA variable_identifier ( EQ interface_instance_identifier )? )*
;

//A.2.4 Declaration assignments
defparam_assignment
:	hierarchical_parameter_identifier EQ constant_mintypmax_expression
;

net_decl_assignment
:	net_identifier ( unpacked_dimension )* ( EQ expression )?
;

param_assignment
:	parameter_identifier ( unpacked_dimension )* EQ constant_param_expression
;

//specparam_assignment
//:	specparam_identifier EQ constant_mintypmax_expression
//| 	pulse_control_specparam
//;
specparam_assignment
:	specparam_identifier EQ constant_mintypmax_expression
;

type_assignment
:	type_identifier EQ data_type
;

//pulse_control_specparam
//:	
//PATHPULSE$ = ( reject_limit_value [ , error_limit_value ] ) ;
//| PATHPULSE$specify_input_terminal_descriptor$specify_output_terminal_descriptor
//= ( reject_limit_value [ , error_limit_value ] ) ;
//error_limit_value
//:	limit_value
//reject_limit_value
//:	limit_value
//limit_value
//:	constant_mintypmax_expression

variable_decl_assignment
:	variable_identifier variable_dimension ( EQ expression )?
| 	dynamic_array_variable_identifier LBRACK RBRACK (EQ dynamic_array_new)?
| 	(class_variable_identifier ( EQ class_new )?)=>
| 	( covergroup_variable_identifier )? EQ 
		"new" ( LPAREN list_of_arguments RAPREN )?
;

class_new
:	"new" ( 
		(	( LPAREN list_of_arguments RPAREN )=> 
				LPAREN list_of_arguments RPAREN
		| 	expression 
		) )?
;

dynamic_array_new
:	"new" LBRACK expression RBRACK ( LPAREN expression RPAREN )?
;

//A.2.5 Declaration ranges
unpacked_dimension
:	(LBRACK constant_range RBRACK)=>
		LBRACK constant_range RBRACK
| 	LBRACK constant_expression RBRACK
;

packed_dimension
:	LBRACK constant_range RBRACK
| 	unsized_dimension
;

associative_dimension
:	LBRACK data_type RBRACK
| 	LBRACK STAR RBRACK
;

variable_dimension
:	(( sized_or_unsized_dimension )*)=> ( sized_or_unsized_dimension )*
| 	associative_dimension
| 	queue_dimension
;

queue_dimension
:	LBRACK DOLLAR ( COLON constant_expression )? RBRACK
;

unsized_dimension
:	LBRACK RBRACK
;

sized_or_unsized_dimension
:	unpacked_dimension | unsized_dimension
;

//A.2.6 Function declarations
function_data_type
:	data_type | "void"
;

function_data_type_or_implicit
:	(function_data_type)=> function_data_type
|   ( signing )? ( packed_dimension )*
;

function_declaration
:	"function" ( lifetime )? function_body_declaration
;

/*
function_body_declaration
:	function_data_type_or_implicit
	( ((interface_identifier DOT) | class_scope) )? function_identifier SEMI
	( tf_item_declaration )*
	( function_statement_or_null )?
	"endfunction" ( COLON function_identifier )?
| 	function_data_type_or_implicit
	( ((interface_identifier DOT) | class_scope) )? function_identifier 
	LPAREN ( tf_port_list )? RPAREN SEMI
	( block_item_declaration )*
	( function_statement_or_null )*
	"endfunction" ( COLON function_identifier )?
;
*/
function_body_declaration
:	function_body_declaration_1
		(	SEMI (function_body_declaration_2)*
		|	LPAREN ( tf_port_list )? RPAREN SEMI 
				(function_body_declaration_3)*
		)
		"endfunction" ( COLON function_identifier )?
;

//Need to disambiguate
function_body_declaration_2
:	(	(tf_item_declaration)=> tf_item_declaration
	|	function_statement_or_null
	)
;
function_body_declaration_3
:	(	(block_item_declaration)=> block_item_declaration
	|	function_statement_or_null
	)
;

function_body_declaration_1
:	function_data_type_or_implicit
		( ((interface_identifier DOT) | class_scope) )? 
		function_identifier
;

function_prototype
:	"function" function_data_type function_identifier 
		LPAREN ( tf_port_list )? RPAREN
;

dpi_import_export
:	"import" "\"DPI\"" 
		(	(dpi_import_export_1)=> dpi_import_export_1
		| 	dpi_import_export_2
		)
| 	"export" "\"DPI\"" 
		(	(( c_identifier EQ )?  "function")=>
				( c_identifier EQ )?  "function" function_identifier SEMI
		| 	( c_identifier EQ )?  "task" task_identifier SEMI
		)
;
dpi_import_export_1
: 	( dpi_function_import_property )? 
		( c_identifier EQ )? dpi_function_proto SEMI
;
dpi_import_export_2
: 	( dpi_task_import_property )? 
		( c_identifier EQ )? dpi_task_proto SEMI
;

dpi_function_import_property
:	"context" | "pure"
;

dpi_task_import_property
:	"context"
;

dpi_function_proto
:	function_prototype
;

dpi_task_proto
:	task_prototype
;

//A.2.7 Task declarations
task_declaration
:	"task" ( lifetime )? task_body_declaration
;

task_body_declaration
:	task_body_declaration_LF1
		(	(	SEMI
				(options{greedy=true;}: tf_item_declaration )*
			)
		|
 			(	LPAREN ( tf_port_list )? RPAREN SEMI
				(options{greedy=true;}: block_item_declaration )*
			)
		)
		( statement_or_null )*
		"endtask" ( COLON task_identifier )?
;

task_body_declaration_LF1
:	( (interface_identifier DOT) | class_scope )? task_identifier
;

tf_item_declaration
:	(block_item_declaration)=> block_item_declaration
| 	tf_port_declaration
;

tf_port_list
:	tf_port_item ( COMMA tf_port_item )*
;

tf_port_item
:	attribute_instances
		( tf_port_direction )? data_type_or_implicit
		port_identifier variable_dimension ( EQ expression )?
;

tf_port_direction
:	port_direction | ("const" "ref")
;

tf_port_declaration
:	attribute_instances tf_port_direction 
		data_type_or_implicit list_of_tf_variable_identifiers SEMI
;

task_prototype
:	"task" task_identifier LPAREN ( tf_port_list )? RPAREN
;

//A.2.8 Block item declarations
block_item_declaration
:	attribute_instances 
		(	data_declaration
		| 	local_parameter_declaration
		| 	(	parameter_declaration SEMI)
		| 	overload_declaration
		)
;

overload_declaration
:	"bind" overload_operator "function" data_type function_identifier
		LPAREN overload_proto_formals RAPREN SEMI
;

overload_operator
:	PLUS | PLUS2 | MINUS | MINUS2 | STAR | STAR2 | SLASH 
| 	PERCENT | EQ2 | NOT_EQ | LT_ | LT_EQ | GT | GT_EQ | EQ
;

overload_proto_formals
:	data_type (COMMA data_type)*
;

//A.2.9 Interface declarations
virtual_interface_declaration
:	"virtual" ( "interface" )? interface_identifier 
		list_of_virtual_interface_decl SEMI
;

modport_declaration
:	"modport" modport_item ( COMMA modport_item )* SEMI
;

modport_item
:	modport_identifier LPAREN modport_ports_declaration 
		( COMMA modport_ports_declaration )* RPAREN
;

modport_ports_declaration
:	attribute_instances
		(	modport_simple_ports_declaration
		| 	modport_hierarchical_ports_declaration
		| 	modport_tf_ports_declaration
		| 	modport_clocking_declaration
		)
;

modport_clocking_declaration
:	"clocking" clocking_identifier
;

modport_simple_ports_declaration
:	port_direction modport_simple_port 
		(options{greedy=true;}: COMMA modport_simple_port )*
;

modport_simple_port
:	port_identifier
| 	DOT port_identifier LPAREN ( expression )? RPAREN
;

modport_hierarchical_ports_declaration
:	interface_instance_identifier 
		( LBRACK constant_expression RBRACK )? DOT modport_identifier
;

modport_tf_ports_declaration
:	import_export modport_tf_port 
		(options{greedy=true;}: COMMA modport_tf_port )*
;

modport_tf_port
:	method_prototype
| 	tf_identifier
;

import_export
:	"import" | "export"
;

concurrent_assertion_item
:	( block_identifier COLON )? concurrent_assertion_statement
;

concurrent_assertion_statement
:	assert_property_statement
| 	assume_property_statement
| 	cover_property_statement
;

assert_property_statement
:	"assert" "property" LPAREN property_spec RPAREN action_block
;

assume_property_statement
:	"assume" "property" LPAREN property_spec RPAREN SEMI
;

cover_property_statement
:	"cover" "property" LPAREN property_spec RPAREN statement_or_null
;

expect_property_statement
:	"expect" LPAREN property_spec RPAREN action_block
;

property_instance
:	ps_property_identifier ( LPAREN ( actual_arg_list )? RPAREN )?
;

concurrent_assertion_item_declaration
:	property_declaration
| 	sequence_declaration
;

property_declaration
:	"property" property_identifier 
		( LPAREN ( list_of_formals )? RPAREN )? SEMI
		(options{greedy=true;}: assertion_variable_declaration )*
		property_spec SEMI
		"endproperty" ( COLON property_identifier )?
;

property_spec
:	(options{greedy=true;}: clocking_event )? 
		( "disable" "iff" LPAREN expression_or_dist RPAREN)? property_expr
;

//Removed left-recursion: http://en.wikipedia.org/wiki/Left_recursion
property_expr
:	property_expr_b (options{greedy=true;}: property_expr_a)*
;
//--remove-left-beta
property_expr_b
: 	(LPAREN property_expr RPAREN)=> LPAREN property_expr RPAREN
| 	(property_instance)=> property_instance
| 	(clocking_event property_expr)=> clocking_event property_expr
|	sequence_expr
		((BAR_MINUS_GT | BAR_EQ_GT) property_expr)?
| 	"not" property_expr
| 	"if" LPAREN expression_or_dist RPAREN property_expr 
		(options{greedy=true;}: "else" property_expr )?
;
//--remove-left-alpha
property_expr_a
: 	"or" property_expr
| 	"and" property_expr
;

sequence_declaration
:	"sequence" sequence_identifier 
		( LPAREN ( list_of_formals )? RPAREN )? SEMI
		(options{greedy=true;}: assertion_variable_declaration )*
		sequence_expr SEMI
		"endsequence" ( COLON sequence_identifier )?
;

//Removed left-recursion: http://en.wikipedia.org/wiki/Left_recursion
sequence_expr
:	sequence_expr_b (options{greedy=true;}: sequence_expr_a)*
;
//--remove-left-beta
sequence_expr_b_1
:	expression_or_dist 
		(	(boolean_abbrev)?
		| 	"throughout" sequence_expr
		)
;
sequence_expr_b_2
: 	LPAREN expression_or_dist 
		(COMMA sequence_match_item)* RPAREN (boolean_abbrev)?
;
sequence_expr_b
:	cycle_delay_range sequence_expr 
		(options{greedy=true;}: cycle_delay_range sequence_expr)*
| 	(sequence_expr_b_1)=> sequence_expr_b_1
| 	(sequence_expr_b_2)=> sequence_expr_b_2
| 	sequence_instance (sequence_abbrev)?
| 	LPAREN sequence_expr (COMMA sequence_match_item)* RPAREN 
		(sequence_abbrev)?
| 	"first_match" LPAREN sequence_expr (COMMA sequence_match_item)* RPAREN
| 	clocking_event sequence_expr
;
//--remove-left-alpha
sequence_expr_a
: 	cycle_delay_range sequence_expr 
		(options{greedy=true;}: cycle_delay_range sequence_expr)*
| 	"and" sequence_expr
| 	"intersect" sequence_expr
| 	"or" sequence_expr
| 	"within" sequence_expr
;

cycle_delay_range
:	POUND2 integral_number
| 	POUND2 identifier
| 	POUND2 LPAREN constant_expression RPAREN
| 	POUND2 LBRACK cycle_delay_const_range_expression RBRACK
;

sequence_method_call
:	sequence_instance DOT method_identifier
;

sequence_match_item
:	(operator_assignment)=> operator_assignment
| 	(inc_or_dec_expression)=> inc_or_dec_expression
| 	subroutine_call
;

sequence_instance
:	ps_sequence_identifier ( LPAREN ( actual_arg_list )? RPAREN )?
;

formal_list_item
:	formal_identifier ( EQ actual_arg_expr )?
;

list_of_formals
:	formal_list_item (COMMA formal_list_item )*
;

actual_arg_list
:	actual_arg_expr (COMMA actual_arg_expr )*
| 	DOT formal_identifier LPAREN actual_arg_expr RPAREN 
		( COMMA DOT formal_identifier LPAREN actual_arg_expr RPAREN )*
;

actual_arg_expr
:	(event_expression)=> event_expression
| 	DOLLAR
;

boolean_abbrev
:	consecutive_repetition
| 	non_consecutive_repetition
| 	goto_repetition
;

sequence_abbrev
:	consecutive_repetition
;

consecutive_repetition
:	LBRACK STAR const_or_range_expression RBRACK
;

non_consecutive_repetition
:	LBRACK EQ const_or_range_expression RBRACK
;

goto_repetition
:	LBRACK MINUS_GT const_or_range_expression RBRACK
;

const_or_range_expression
:	(constant_expression)=> constant_expression
| 	cycle_delay_const_range_expression
;

cycle_delay_const_range_expression
:	constant_expression COLON 
		(	(constant_expression)=> constant_expression
		| 	DOLLAR
		)
;

expression_or_dist
:	expression ( "dist" LCURLY dist_list RCURLY )?
;

assertion_variable_declaration
:	data_type list_of_variable_identifiers SEMI
;

//A.2.11 Covergroup declarations
covergroup_declaration
:	"covergroup" covergroup_identifier 
		( LPAREN ( tf_port_list )? RPAREN )? ( coverage_event )? SEMI
		( coverage_spec_or_option SEMI )*
		"endgroup" ( COLON covergroup_identifier )?
;

coverage_spec_or_option
:	attribute_instances 
		(	coverage_spec
		| 	coverage_option SEMI
		)
;

coverage_option
:	"option" DOT member_identifier EQ expression
| 	"type_option" DOT member_identifier EQ expression
;

coverage_spec
:	(cover_point)=> cover_point
| 	cover_cross
;

coverage_event
:	clocking_event
| 	AT2 LPAREN block_event_expression RPAREN
;

//Removed left-recursion: http://en.wikipedia.org/wiki/Left_recursion
block_event_expression 
:	block_event_expression_b 
		(options{greedy=true;}: block_event_expression_a)*
;
//--remove-left-beta
block_event_expression_b 
: 	"begin" hierarchical_btf_identifier
| 	"end" hierarchical_btf_identifier
;
//--remove-left-alpha
block_event_expression_a 
:	"or" block_event_expression
;

hierarchical_btf_identifier
:	(hierarchical_tf_identifier)=> hierarchical_tf_identifier
| 	(hierarchical_block_identifier)=> hierarchical_block_identifier
| 	hierarchical_identifier ( class_scope )? method_identifier
;

cover_point
:	( cover_point_identifier COLON )? 
		"coverpoint" expression ( "iff" LPAREN expression RPAREN )? bins_or_empty
;

bins_or_empty
:	LCURLY attribute_instances ( bins_or_options SEMI )? RCURLY
| 	SEMI
;

bins_or_options_1
: 	( "wildcard" )? bins_keyword bin_identifier 
		( 	(( LBRACK RBRACK )? EQ trans_list )=>
		 		( LBRACK RBRACK )? EQ trans_list 
					( "iff" LPAREN expression RPAREN )?
		|	( LBRACK ( expression )? RBRACK )? EQ LCURLY range_list RCURLY 
				( "iff" LPAREN expression RPAREN )?
		)
;
bins_or_options_2
: 	bins_keyword bin_identifier 
		( 	(EQ "default" "sequence")=>
		 		EQ "default" "sequence" ( "iff" LPAREN expression RPAREN )?
		|	( LBRACK ( expression )? RBRACK )? EQ "default" 
				( "iff" LPAREN expression RPAREN )?
		)
;
bins_or_options
:	coverage_option
| 	(bins_or_options_1)=> bins_or_options_1
|	bins_or_options_2
;

bins_keyword
:	"bins" | "illegal_bins" | "ignore_bins"
;

range_list
:	value_range ( COMMA value_range )*
;

trans_list
:	LPAREN trans_set RPAREN (COMMA LPAREN trans_set RPAREN)*
;

trans_set
:	trans_range_list EQ_GT trans_range_list ( EQ_GT trans_range_list )*
;

trans_range_list
:	trans_item
		(LBRACK (STAR | MINUS_GT | EQ) repeat_range RBRACK)?
;

trans_item
:	range_list
;

repeat_range
:	expression (COLON expression)?
;

cover_cross
:	(cover_point_identifier COLON)? "cross" list_of_coverpoints 
		( "iff" LPAREN expression RPAREN )? select_bins_or_empty
;

list_of_coverpoints
:	cross_item (COMMA cross_item)+
;

cross_item
:	(cover_point_identifier)=> cover_point_identifier
| 	variable_identifier
;

select_bins_or_empty
:	LCURLY ( bins_selection_or_option SEMI )* RCURLY
| 	SEMI
;

bins_selection_or_option
:	attribute_instances 
		(	coverage_option
		| 	bins_selection
		)
;

bins_selection
:	bins_keyword bin_identifier EQ select_expression 
		( "iff" LPAREN expression RPAREN )?
;

//Removed left-recursion: http://en.wikipedia.org/wiki/Left_recursion
select_expression
:	select_expression_b (options{greedy=true;}: select_expression_a)*
;
//--remove-left-beta
select_expression_b
:	select_condition
| 	NOT select_condition
| 	LPAREN select_expression RPAREN
;
//--remove-left-alpha
select_expression_a
: 	AND2 select_expression
| 	OR2 select_expression
;

select_condition
:	"binsof" LPAREN bins_expression RPAREN 
		( "intersect" LCURLY open_range_list RCURLY )?
;

bins_expression
: 	(cover_point_identifier ( DOT bin_identifier )?)=>
	 	cover_point_identifier ( DOT bin_identifier )?
|	variable_identifier
;

open_range_list
:	open_value_range ( COMMA open_value_range )*
;

open_value_range
:	value_range
;

//NOTE: simplify gate/switch types
gate_switch_type:
	"cmos" | "rcmos" 
		| "bufif0" | "bufif1" | "notif0" | "notif1" 
		| "nmos" | "pmos" | "rnmos" | "rpmos"
		| "and" | "nand" | "or" | "nor" | "xor" | "xnor"
		| "buf" | "not"
		| "tranif0" | "tranif1" | "rtranif0" | "rtranif1"
		| "tran" | "rtran"
;

//NOTE: only used in predicate to eliminate false trigger on "or"
//which can also be part of "always @(... or ...)"
gate_instantiation_predict
:	gate_switch_type (delay3)? (name_of_instance)? LPAREN
;

gate_instantiation
:	gate_switch_type (delay3)? 
		gate_switch_instance (COMMA gate_switch_instance)* SEMI
;

gate_switch_instance
:	(name_of_instance)? 
		LPAREN (options{greedy=true;}:  list_of_port_connections )? RPAREN
;

//kwp //A.3 Primitive instances
//kwp //A.3.1 Primitive instantiation and instances
//kwp gate_instantiation
//kwp :	cmos_switchtype [delay3] cmos_switch_instance { , cmos_switch_instance } ;
//kwp | 	enable_gatetype [drive_strength] [delay3] enable_gate_instance { , enable_gate_instance } ;
//kwp | 	mos_switchtype [delay3] mos_switch_instance { , mos_switch_instance } ;
//kwp | 	n_input_gatetype [drive_strength] [delay2] n_input_gate_instance { , n_input_gate_instance } ;
//kwp | 	n_output_gatetype [drive_strength] [delay2] n_output_gate_instance
//kwp 	{ , n_output_gate_instance } ;
//kwp | 	pass_en_switchtype [delay2] pass_enable_switch_instance { , pass_enable_switch_instance } ;
//kwp | 	pass_switchtype pass_switch_instance { , pass_switch_instance } ;
//kwp | 	pulldown [pulldown_strength] pull_gate_instance { , pull_gate_instance } ;
//kwp | 	pullup [pullup_strength] pull_gate_instance { , pull_gate_instance } ;
//kwp cmos_switch_instance
//kwp :	[ name_of_instance ] ( output_terminal , input_terminal ,
//kwp ncontrol_terminal , pcontrol_terminal )
//kwp enable_gate_instance
//kwp :	[ name_of_instance ] ( output_terminal , input_terminal , enable_terminal )
//kwp mos_switch_instance
//kwp :	[ name_of_instance ] ( output_terminal , input_terminal , enable_terminal )
//kwp n_input_gate_instance
//kwp :	[ name_of_instance ] ( output_terminal , input_terminal { , input_terminal } )
//kwp n_output_gate_instance
//kwp :	[ name_of_instance ] ( output_terminal { , output_terminal } ,
//kwp input_terminal )
//kwp pass_switch_instance
//kwp :	[ name_of_instance ] ( inout_terminal , inout_terminal )
//kwp pass_enable_switch_instance
//kwp :	[ name_of_instance ] ( inout_terminal , inout_terminal ,
//kwp enable_terminal )
//kwp pull_gate_instance
//kwp :	[ name_of_instance ] ( output_terminal )
//kwp A.3.2 Primitive strengths
//kwp pulldown_strength
//kwp :	
//kwp ( strength0 , strength1 )
//kwp Accellera
//kwp Extensions to Verilog-2001 SystemVerilog 3.1a
//kwp Copyright 2004 Accellera. All rights reserved. 467
//kwp | ( strength1 , strength0 )
//kwp | ( strength0 )
//kwp pullup_strength
//kwp :	
//kwp ( strength0 , strength1 )
//kwp | ( strength1 , strength0 )
//kwp | ( strength1 )
//kwp A.3.3 Primitive terminals
//kwp enable_terminal
//kwp :	expression
//kwp inout_terminal
//kwp :	net_lvalue
//kwp input_terminal
//kwp :	expression
//kwp ncontrol_terminal
//kwp :	expression
//kwp output_terminal
//kwp :	net_lvalue
//kwp pcontrol_terminal
//kwp :	expression
//kwp A.3.4 Primitive gate and switch types
//kwp cmos_switchtype
//kwp :	cmos | rcmos
//kwp enable_gatetype
//kwp :	bufif0 | bufif1 | notif0 | notif1
//kwp mos_switchtype
//kwp :	nmos | pmos | rnmos | rpmos
//kwp n_input_gatetype
//kwp :	and | nand | or | nor | xor | xnor
//kwp n_output_gatetype
//kwp :	buf | not
//kwp pass_en_switchtype
//kwp :	tranif0 | tranif1 | rtranif1 | rtranif0
//kwp pass_switchtype
//kwp :	tran | rtran

//A.4 Module, interface and generated instantiation
//A.4.1 Instantiation
//A.4.1.1 Module instantiation
module_instantiation
{ Token mid=null; Token hi=null;}
:	mid=module_identifier 
		(POUND delay_value)? (parameter_value_assignment)? 
		hi=hierarchical_instance 		{stTracker.addInstance(mid,hi);}
		(COMMA hi=hierarchical_instance {stTracker.addInstance(mid,hi);} )* 
		SEMI
;

parameter_value_assignment
:	POUND LPAREN (list_of_parameter_assignments)? RPAREN
;

list_of_parameter_assignments
:	ordered_parameter_assignment ( COMMA ordered_parameter_assignment )*
| 	named_parameter_assignment ( COMMA named_parameter_assignment )*
;

ordered_parameter_assignment
:	param_expression
;

named_parameter_assignment
:	DOT parameter_identifier LPAREN ( param_expression )? RPAREN
;

hierarchical_instance returns [Token noi]
{ noi=null;}
:	noi=name_of_instance LPAREN 
		(options{greedy=true;}:  list_of_port_connections )? RPAREN
;

name_of_instance returns [Token id]
{ id = null;}
:	id=instance_identifier ( unpacked_dimension )*
;

list_of_port_connections
:	(ordered_port_connection ( COMMA ordered_port_connection )*)=>
		ordered_port_connection ( COMMA ordered_port_connection )*
| 	named_port_connection ( COMMA named_port_connection )*
;

ordered_port_connection
:	attribute_instances ( expression )?
;

named_port_connection
:	attribute_instances
	(	(DOT port_identifier ( LPAREN ( expression )? RPAREN )? )
 	|	DOT_STAR
	)
;

//A.4.1.2 Interface instantiation
//NOTE/TODO: syntactically, this is indistinguishable from module-instance.
interface_instantiation
:	interface_identifier ( parameter_value_assignment )?
	hierarchical_instance 
        ( COMMA hierarchical_instance )* 
        SEMI
;

//A.4.1.3 Program instantiation
program_instantiation
:	program_identifier ( parameter_value_assignment )?
	hierarchical_instance ( COMMA hierarchical_instance )* ;

//A.4.2 Generated instantiation
//A.4.2.1 Generated module instantiation
generated_module_instantiation
:	"generate" ( generate_module_item )* "endgenerate"
|	( generate_module_item )+
;

generate_module_item
:	generate_module_conditional_statement
| 	generate_module_case_statement
| 	generate_module_loop_statement
|   ( (generate_block_identifier COLON) | "begin")=>
 		( generate_block_identifier COLON)? generate_module_block
| 	module_or_generate_item
;

generate_module_conditional_statement
:	"if" LPAREN constant_expression RPAREN 
		generate_module_item 
		(options{greedy=true;}: "else" generate_module_item )?
;

generate_module_case_statement
:	"case" LPAREN constant_expression RPAREN 
	genvar_module_case_item ( genvar_module_case_item )* "endcase"
;

genvar_module_case_item
:	constant_expression (COMMA constant_expression )* COLON generate_module_item
| 	"default" (COLON)? generate_module_item
;

generate_module_loop_statement
:	"for" LPAREN genvar_decl_assignment SEMI constant_expression SEMI 
	genvar_assignment RPAREN generate_module_named_block
;

genvar_assignment
:	genvar_identifier assignment_operator constant_expression
| 	inc_or_dec_operator genvar_identifier
| 	genvar_identifier inc_or_dec_operator
;

genvar_decl_assignment
:	( "genvar" )? genvar_identifier EQ constant_expression
;

generate_module_named_block
:	"begin" COLON generate_block_identifier ( generate_module_item )* 
	"end" ( COLON generate_block_identifier )?
| 	generate_block_identifier COLON generate_module_block
;

generate_module_block
:	"begin" ( COLON generate_block_identifier )? 
	( generate_module_item )* "end" ( COLON generate_block_identifier )?
;

//A.4.2.2 Generated interface instantiation
generated_interface_instantiation
:	"generate" ( generate_interface_item )* "endgenerate"
;

generate_interface_item
:	generate_interface_conditional_statement
| 	generate_interface_case_statement
| 	generate_interface_loop_statement
| 	(interface_or_generate_item)=> interface_or_generate_item
| 	( generate_block_identifier COLON )? generate_interface_block
;

generate_interface_conditional_statement
:	"if" LPAREN constant_expression RPAREN generate_interface_item 
		(options{greedy=true;}: "else" generate_interface_item )?
;

generate_interface_case_statement
:	"case" LPAREN constant_expression RAPREN genvar_interface_case_item 
	( genvar_interface_case_item )* "endcase"
;

genvar_interface_case_item
:	constant_expression ( COMMA constant_expression )* 
	COLON generate_interface_item
| 	"default" ( COLON )? generate_interface_item
;

generate_interface_loop_statement
:	"for" LPAREN genvar_decl_assignment SEMI constant_expression SEMI
	genvar_assignment RAPREN
	generate_interface_named_block
;

generate_interface_named_block
:	"begin" COLON generate_block_identifier 
	( generate_interface_item )* "end" ( COLON generate_block_identifier )?
| 	generate_block_identifier COLON generate_interface_block
;

generate_interface_block
:	"begin" ( COLON generate_block_identifier )?
	( generate_interface_item )*
	"end" ( COLON generate_block_identifier )?
;

//NOTE: a very crude udp_declaration, but enough for Tracker use.
udp_declaration
{ Token udp=null;}
:	attribute_instances "primitive" udp=udp_identifier {stTracker.addUdp(udp);}
		({LA(1) != LITERAL_endprimitive}? .)+
	"endprimitive" (COLON udp_identifier)?
;


//A.6 Behavioral statements
//A.6.1 Continuous assignment and net alias statements
continuous_assign
:	("assign" ( delay3 )? list_of_net_assignments SEMI)=>
		"assign" ( delay3 )? list_of_net_assignments SEMI
| 	"assign" ( delay_control )? list_of_variable_assignments SEMI
//kwp :	"assign" [ drive_strength ] [ delay3 ] list_of_net_assignments ;
//kwp | 	"assign" [ delay_control ] list_of_variable_assignments ;
;

list_of_net_assignments
:	net_assignment (COMMA net_assignment )*
;

list_of_variable_assignments
:	variable_assignment (options{greedy=true;}: COMMA variable_assignment )*
;

net_alias
:	"alias" net_lvalue EQ net_lvalue (EQ net_lvalue )* SEMI
;

net_assignment
:	net_lvalue EQ expression
;

//A.6.2 Procedural blocks and assignments
final_construct
:	"final" function_statement
;

initial_construct
:	"initial" statement_or_null
;

always_construct
:	always_keyword statement
;

always_keyword
:	"always" | "always_comb" | "always_latch" | "always_ff"
;

blocking_assignment
:	variable_lvalue EQ ( delay_or_event_control )? expression
//kwp | 	hierarchical_dynamic_array_variable_identifier = dynamic_array_new
//kwp | 	[ implicit_class_handle . | class_scope | package_scope ] hierarchical_variable_identifier
//kwp 	select = class_new
//kwp | 	operator_assignment
;

operator_assignment
:	variable_lvalue assignment_operator expression
;

assignment_operator
:	EQ | PLUS_EQ | MINUS_EQ | STAR_EQ | SLASH_EQ | PERCENT_EQ | AND_EQ 
| 	OR_EQ | CARET_EQ | LT2_EQ | GT2_EQ | LT3_EQ | GT3_EQ
;

nonblocking_assignment
:	variable_lvalue LT_EQ ( delay_or_event_control )? expression
;

procedural_continuous_assignment
:	"assign" variable_assignment
//kwp | 	deassign variable_lvalue
//kwp | 	force variable_assignment
//kwp | 	force net_assignment
//kwp | 	release variable_lvalue
//kwp | 	release net_lvalue
;

variable_assignment
:	variable_lvalue EQ expression
;

//A.6.3 Parallel and sequential blocks
action_block
: 	(options{greedy=true;}: ( statement )?  "else")? statement_or_null
;

seq_block
:	"begin" ( COLON block_identifier )? 
		//NOTE: the following allows decls and statements to be reordered.  More lax than LRM.
		(	(block_item_declaration)=> block_item_declaration
		|	statement_or_null
		)*
		"end" ( COLON block_identifier )?
;

par_block
:	"fork" ( COLON block_identifier )? 
		//NOTE: the following allows decls and statements to be reordered.  More lax than LRM.
		(	(block_item_declaration)=> block_item_declaration
		|	statement_or_null
		)*
		join_keyword ( COLON block_identifier )?
;

join_keyword
:	"join" | "join_any" | "join_none"
;

//A.6.4 Statements
statement_or_null
:	(statement)=> statement
| 	attribute_instances SEMI
;

statement
:	(options{greedy=true;}: block_identifier COLON )? 
		attribute_instances statement_item
;

statement_item
:	(variable_lvalue EQ)=> blocking_assignment SEMI
|	(nonblocking_assignment SEMI)=> nonblocking_assignment SEMI
|	procedural_continuous_assignment SEMI
|	(case_statement)=> case_statement
|	conditional_statement
|	(inc_or_dec_expression SEMI)=> inc_or_dec_expression SEMI
|	(subroutine_call_statement)=> subroutine_call_statement
//kwp |	disable_statement
//kwp |	event_trigger
|	loop_statement
|	jump_statement
|	par_block
|	(clocking_drive SEMI)=> clocking_drive SEMI
|	procedural_timing_control_statement
|	seq_block
|	wait_statement
|	procedural_assertion_statement
//kwp |	randsequence_statement
//kwp |	randcase_statement
//kwp |	expect_property_statement
;

function_statement
:	statement
;

function_statement_or_null
:	(function_statement)=> function_statement
| 	attribute_instances SEMI
;

variable_identifier_list
:	variable_identifier (COMMA variable_identifier )*
;

//A.6.5 Timing control statements
procedural_timing_control_statement
:	procedural_timing_control statement_or_null
;

delay_or_event_control
:	delay_control
| 	event_control
| 	"repeat" LPAREN expression RPAREN event_control
;

delay_control
:	POUND delay_value
| 	POUND LPAREN mintypmax_expression RPAREN
;

event_control
:	AT hierarchical_event_identifier
| 	(AT LPAREN STAR)=> AT LPAREN STAR RPAREN
| 	AT LPAREN event_expression RPAREN 
| 	AT_STAR
//| 	AT sequence_instance
;

edge_identifier
:	"posedge" | "negedge"
;

/*
event_expression
:	( edge_identifier )? expression ( "iff" expression )?
//| 	sequence_instance ( "iff" expression )?
| 	event_expression ("or" | COMMA) event_expression
;
*/
event_expression
: 	event_expression_1 
		(options{greedy=true;}: ("or" | COMMA) event_expression_1)*
;
event_expression_1
:	( edge_identifier )? expression ( "iff" expression )?
;

procedural_timing_control
:	delay_control
| 	event_control
| 	cycle_delay
;

jump_statement
:	"return" ( expression )? SEMI
| 	"break" SEMI
| 	"continue" SEMI
;

wait_statement
:	"wait" LPAREN expression RPAREN statement_or_null
| 	"wait" "fork" SEMI
| 	"wait_order" LPAREN hierarchical_identifier 
	( COMMA hierarchical_identifier )? RPAREN action_block
;

//kwp event_trigger
//kwp :	
//kwp -> hierarchical_event_identifier ;
//kwp |->> [ delay_or_event_control ] hierarchical_event_identifier ;
//kwp disable_statement
//kwp :	
//kwp disable hierarchical_task_identifier ;
//kwp | disable hierarchical_block_identifier ;
//kwp | disable fork ;

//A.6.6 Conditional statements
conditional_statement
: 	unique_priority_if_statement
;

//A superset of conditional_statement
unique_priority_if_statement
:	( unique_priority )? "if" LPAREN cond_predicate RPAREN statement_or_null
		(options{greedy=true;}: 
			"else" "if" LPAREN cond_predicate RPAREN statement_or_null )*
		(options{greedy=true;}: "else" statement_or_null )?
;

unique_priority
:	"unique" | "priority"
;

cond_predicate
:	expression_or_cond_pattern ( AND2 expression_or_cond_pattern )*
;

expression_or_cond_pattern
: 	cond_pattern
;

cond_pattern
:	expression ("matches" pattern)?
;

//A.6.7 Case statements
case_statement
:	( unique_priority )? case_keyword LPAREN expression RPAREN 
	(	(case_item ( case_item )* ) //"endcase")
	|	("matches" case_pattern_item ( case_pattern_item )*)
	)
	"endcase"
;

case_keyword
:	"case" | "casez" | "casex"
;

case_item
:	expression (COMMA expression )* COLON statement_or_null
| 	"default" (COLON)? statement_or_null
;

case_pattern_item
:	pattern ( AND2 expression )? COLON statement_or_null
| 	"default" (COLON)? statement_or_null
;

randcase_statement
:	"randcase" randcase_item ( randcase_item )* "endcase"
;

randcase_item
:	expression COLON statement_or_null
;

//A.6.7.1 Patterns
pattern
:	variable_identifier
| 	DOT_STAR
| 	DOT constant_expression
| 	"tagged" member_identifier ( pattern )?
| 	(LCURLY pattern (COMMA pattern )* RCURLY)=>
 		LCURLY pattern (COMMA pattern )* RCURLY
| 	LCURLY member_identifier COLON pattern 
		(COMMA member_identifier COLON pattern )* RCURLY
;

//A.6.8 Looping statements
loop_statement
:	"forever" statement_or_null
| 	"repeat" LPAREN expression RPAREN statement_or_null
| 	"while" LPAREN expression RPAREN statement_or_null
| 	"for" LPAREN for_initialization SEMI expression SEMI for_step RPAREN
	statement_or_null
| 	"do" statement_or_null "while" LPAREN expression RPAREN SEMI
| 	"foreach" LPAREN array_identifier 
		(options{greedy=true;}: loop_variables )? RPAREN statement
;

for_initialization
:	(list_of_variable_assignments)=> list_of_variable_assignments
| 	data_type list_of_variable_assignments 
		(COMMA data_type list_of_variable_assignments )*
;

for_step
:	for_step_assignment (COMMA for_step_assignment )*
;

for_step_assignment
:	(operator_assignment)=> operator_assignment
| 	inc_or_dec_expression
;

loop_variables
:	( index_variable_identifier )? 
	(COMMA (index_variable_identifier )? )*
;

//A.6.9 Subroutine call statements
subroutine_call_statement 
: 	subroutine_call SEMI
| 	"void" TIC LPAREN function_subroutine_call RPAREN SEMI
;

//A.6.10 Assertion statements
procedural_assertion_statement
//kwp:	concurrent_assertion_statement
: 	immediate_assert_statement
;

immediate_assert_statement
:	"assert" LPAREN expression RPAREN action_block
;

//A.6.11 Clocking block
clocking_declaration
:	( "default" )? "clocking" ( clocking_identifier )? clocking_event SEMI
	( clocking_item )*
	"endclocking" ( COLON clocking_identifier )?
;

clocking_event
:	AT identifier
| 	AT LPAREN event_expression RPAREN
;

clocking_item
: 	"default" default_skew SEMI
| 	clocking_direction list_of_clocking_decl_assign SEMI
//kwp: | 	attribute_instances concurrent_assertion_item_declaration
;

default_skew
:  	"input" clocking_skew ("output" clocking_skew)?
| 	"output" clocking_skew
;

clocking_direction
: 	"input" ( clocking_skew )? ("output" ( clocking_skew )? )?
| 	"output" ( clocking_skew )?
| 	"inout"
;

list_of_clocking_decl_assign
:	clocking_decl_assign (COMMA clocking_decl_assign )*
;

clocking_decl_assign
:	signal_identifier (EQ hierarchical_identifier )?
;

clocking_skew
:	edge_identifier ( delay_control )?
| 	delay_control
;

clocking_drive
:	clockvar_expression LT_EQ ( cycle_delay )? expression
| 	cycle_delay clockvar_expression LT_EQ expression
;

cycle_delay
:	POUND2 number //integral_number
| 	POUND2 identifier
| 	POUND2 LPAREN expression RPAREN
;

clockvar
:	hierarchical_identifier
;

clockvar_expression
:	clockvar select
;


//A.8 Expressions
//A.8.1 Concatenations
concatenation
:	LCURLY 
		( 	(array_member_label COLON expression 
				(COMMA array_member_label COLON expression )*)=>
				 	array_member_label COLON expression 
						(COMMA array_member_label COLON expression )*
		| 	struct_member_label COLON expression 
				(COMMA struct_member_label COLON expression )*
		|	expression (COMMA expression )* 
		)
		RCURLY
;

constant_concatenation
:	LCURLY 
		( 	(array_member_label COLON constant_expression 
				(COMMA array_member_label COLON constant_expression )*)=>
				 	array_member_label COLON constant_expression 
						(COMMA array_member_label COLON constant_expression )*
		| 	struct_member_label COLON constant_expression 
				(COMMA struct_member_label COLON constant_expression )*
		|	constant_expression (COMMA constant_expression )* 
		)
		RCURLY
;

struct_member_label
:	"default"
| 	(type_identifier)=> type_identifier
| 	variable_identifier
;

array_member_label
:	"default"
| 	(type_identifier)=> type_identifier
| 	constant_expression
;

constant_multiple_concatenation
:	LCURLY constant_expression constant_concatenation RCURLY
;

/*TODO
module_path_concatenation
:	LCURLY module_path_expression (COMMA module_path_expression )* RCURLY
;

module_path_multiple_concatenation
:	LCURLY constant_expression module_path_concatenation RCURLY
;
*/

multiple_concatenation
:	LCURLY expression concatenation RCURLY
;

streaming_expression
:	LCURLY stream_operator 
		(options{greedy=true;}: slice_size )? stream_concatenation RCURLY
;

stream_operator
:	GT2 | LT2
;

slice_size
:	(ps_type_identifier )=> ps_type_identifier
| 	constant_expression
;

stream_concatenation
:	LCURLY stream_expression (COMMA stream_expression )* RCURLY
;

stream_expression
:	expression ( "with" LBRACK array_range_expression RBRACK )?
;

array_range_expression
:	expression
	( 	COLON expression
	| 	PLUS_COLON expression
	| 	MINUS_COLON expression
	)?
;

empty_queue
:	LCURLY RCURLY
;

//A.8.2 Subroutine calls
constant_function_call
:	function_subroutine_call
;

tf_call
:	ps_or_hierarchical_tf_identifier attribute_instances 
	( LPAREN list_of_arguments RPAREN )?
;

system_tf_call
:	system_tf_identifier ( LPAREN list_of_arguments RPAREN )?
;

subroutine_call
:	tf_call
| 	system_tf_call
//| 	method_call
//| 	randomize_call
;

function_subroutine_call
:	subroutine_call
;

list_of_arguments
:	(	(( expression )? (options{greedy=true;}: 
		COMMA ( expression )? )*  )
	|	(DOT identifier LPAREN ( expression )? RPAREN )
	)
	( COMMA DOT identifier LPAREN ( expression )? RPAREN )*
;

method_call
:	method_call_root DOT method_call_body
;

method_call_body
: 	(built_in_method_call)=> built_in_method_call
|	method_identifier attribute_instances 
		( LPAREN list_of_arguments RPAREN )?
;

built_in_method_call
:	array_manipulation_call
| 	randomize_call
;

array_manipulation_call
:	array_method_name attribute_instances
	( LPAREN list_of_arguments RPAREN )?
	( "with" LPAREN expression RPAREN )?
;

// "randomize" not keyword in LRM; but not defined either.
randomize_call
:	"randomize" attribute_instances
	( LPAREN ( variable_identifier_list | "null" )? RPAREN )?
	( "with" constraint_block )?
;

method_call_root
:	(expression )=> expression
| 	implicit_class_handle
;

array_method_name
:	method_identifier | "unique" | "and" | "or" | "xor"
;

//A.8.3 Expressions
inc_or_dec_expression
:	inc_or_dec_operator attribute_instances variable_lvalue
| 	variable_lvalue attribute_instances inc_or_dec_operator
;

/* kwp: simplified and moved up to expression
conditional_expression
:	cond_predicate QMARK attribute_instances expression COLON expression
;
*/

/* kwp: aliased to "expression"
constant_expression
:	constant_primary
| 	unary_operator attribute_instances constant_primary
| 	constant_expression binary_operator attribute_instances 
	constant_expression
| 	constant_expression QMARK attribute_instances constant_expression 
	COLON constant_expression
;
*/
constant_expression
: expression
;

constant_mintypmax_expression
: 	constant_expression (COLON constant_expression COLON constant_expression)?
;

constant_param_expression
:	(constant_mintypmax_expression)=> 
		constant_mintypmax_expression 
| 	data_type 
| 	DOLLAR
;

param_expression
:	(mintypmax_expression )=> mintypmax_expression
| 	data_type
;

constant_range_expression
: 	(constant_part_select_range)=> constant_part_select_range
|	constant_expression
;

constant_part_select_range
:	(constant_expression COLON)=> constant_range
| 	constant_indexed_range
;

constant_range
:	constant_expression COLON constant_expression
;

constant_indexed_range
:	constant_expression (PLUS_COLON | MINUS_COLON) constant_expression
;

/* kwp: remove left recursion
expression
:	primary
| 	unary_operator attribute_instances primary
| 	inc_or_dec_expression
| 	LPAREN operator_assignment RPAREN
| 	expression binary_operator attribute_instances expression
| 	conditional_expression
| 	inside_expression
| 	tagged_union_expression
;
*/
expression_1
:	primary
| 	unary_operator attribute_instances primary
| 	inc_or_dec_expression
| 	LPAREN operator_assignment RPAREN
//| 	expression binary_operator attribute_instances expression
//| 	conditional_expression
//| 	inside_expression
| 	tagged_union_expression
;
expression_2
:	binary_operator attribute_instances expression
|	QMARK attribute_instances expression COLON expression
//|	"inside" ( open_range_list )* (expression_2)?
;
expression
:	expression_1 (options{greedy=true;}: expression_2)?
;

/* kwp: merged into expression_2
conditional_expression
:	cond_predicate QMARK attribute_instances expression COLON expression
;
*/

tagged_union_expression
:	"tagged" member_identifier LBRACK expression RBRACK
;

/* kwp: merged into expression_2
inside_expression
:	expression "inside" ( open_range_list )*
;
*/

value_range
:	expression
| 	LBRACK expression COLON expression RBRACK
;

mintypmax_expression
: 	expression (COLON expression COLON expression)?
;

/* kwp: TODO
module_path_conditional_expression
:	module_path_expression QMARK attribute_instances
	module_path_expression COLON module_path_expression
;

module_path_expression
:	module_path_primary
| 	unary_module_path_operator attribute_instances module_path_primary
| 	module_path_expression binary_module_path_operator attribute_instances
	module_path_expression
| 	module_path_conditional_expression
;

module_path_mintypmax_expression
: 	module_path_expression 
	(COLON module_path_expression COLON module_path_expression)?
;
*/

range_expression
: 	(	(constant_expression COLON) 
	| 	(expression (PLUS_COLON | MINUS_COLON))
	)=> part_select_range
|	expression 
;

part_select_range
:	(constant_expression COLON)=> constant_range 
| 	indexed_range
;

indexed_range
:	expression (PLUS_COLON | MINUS_COLON) constant_expression
;

//A.8.4 Primaries
constant_primary
:	primary_literal
| 	ps_parameter_identifier
| 	ps_specparam_identifier
| 	genvar_identifier
| 	( package_scope | class_scope )? enum_identifier
| 	(LCURLY constant_expression LCURLY)=> constant_multiple_concatenation
| 	constant_concatenation
| 	constant_function_call
| 	LPAREN constant_mintypmax_expression RPAREN
| 	constant_cast
;

/*
module_path_primary
:	number
| 	identifier
| 	module_path_concatenation
| 	module_path_multiple_concatenation
| 	function_subroutine_call
| 	( module_path_mintypmax_expression )
;
*/

primary_1
:   ( (implicit_class_handle DOT) | class_scope | package_scope )? hierarchical_identifier select
;

primary
:	primary_literal
| 	(primary_1)=> primary_1
| 	(function_subroutine_call)=> function_subroutine_call
| 	empty_queue
| 	(LCURLY expression LCURLY)=> multiple_concatenation
| 	concatenation
//infinite recursion| 	function_subroutine_call
| 	LPAREN mintypmax_expression RPAREN
| 	cast
| 	streaming_expression
//kwp: | 	sequence_method_call
| 	DOLLAR
| 	"null"
;

/*
time_literal
:	unsigned_number time_unit
| 	fixed_point_number time_unit
*/
time_literal
:	number time_unit
;

time_unit
//NOTE: these are not keywords::	"s" | "ms" | "us" | "ns" | "ps" | "fs" | "step"
:	SIMPLE_IDENTIFIER
;

implicit_class_handle
:	"this" (DOT "super")?
| 	"super" 
;

/*
select
:	( LBRACK expression RBRACK )* ( LBRACK part_select_range RBRACK )?
;
*/
//TODO: expensive syntactic predicate
select
:	(options{greedy=true;}: LBRACK 
		(	(part_select_range)=> part_select_range
		|	expression 
		) 
	RBRACK )*
;

/*
constant_select
:	( LBRACK constant_expression RBRACK )* 
	( LBRACK constant_part_select_range RBRACK )?
;
*/
//TODO: expensive syntactic predicate
constant_select
:	( LBRACK 
		(	(constant_part_select_range)=> constant_part_select_range
		|	constant_expression 
		) 
	RBRACK )*
;

primary_literal
:	number 
| 	time_literal 
|	unbased_unsized_literal 
| 	string_literal
;

constant_cast
:	cast
;
/*
:	casting_type BACK_TIC LPAREN constant_expression RPAREN
| 	casting_type BACK_TIC constant_concatenation
| 	casting_type BACK_TIC constant_multiple_concatentation
;
*/

cast
:	casting_type BACK_TIC LPAREN expression RPAREN
| 	casting_type BACK_TIC concatenation
//| 	casting_type BACK_TIC multiple_concatentation
;

//A.8.5 Expression left-side values
net_lvalue
:	ps_or_hierarchical_net_identifier constant_select
| 	LCURLY net_lvalue ( COMMA net_lvalue )* RCURLY
;

/*
variable_lvalue
:	( (implicit_class_handle DOT) | package_scope )? 
	hierarchical_variable_identifier select
| 	LCURLY variable_lvalue ( COMMA variable_lvalue )* RCURLY
;
*/
variable_lvalue
:	hierarchical_variable_identifier select
| 	LCURLY variable_lvalue ( COMMA variable_lvalue )* RCURLY
;

//A.8.6 Operators
unary_operator
:	PLUS | MINUS | NOT | TILDE | AND | TILDE_AND | OR | TILDE_OR 
	| CARET | TILDE_CARET
;

binary_operator
:	PLUS | MINUS | STAR | SLASH | PERCENT | EQ2 | NOT_EQ | EQ3 
	| NOT_EQ2 | EQ_QMARK_EQ | NOT_QMARK_EQ | AND2 | OR2 | STAR2
	| LT_ | LT_EQ | GT | GT_EQ | AND | OR | CARET | TILDE_CARET 
	| GT2 | LT2 | GT3 | LT3
;

inc_or_dec_operator
:	PLUS2 | MINUS2
;

unary_module_path_operator
:	NOT | TILDE | AND | TILDE_AND | OR | TILDE_OR | CARET | TILDE_CARET 
;

binary_module_path_operator
:	EQ2 | NOT_EQ | AND2 | OR2 | AND | OR | CARET | TILDE_CARET
;

//A.8.7 Numbers
/*
#number
#:	integral_number
#| 	real_number
#;
#
#integral_number
#:	decimal_number
#| 	octal_number
#| 	binary_number
#| 	hex_number
#;
#
#decimal_number
#:	unsigned_number
#| 	( size )? decimal_base unsigned_number
#| 	( size )? decimal_base x_digit ("_")*
#| 	( size )? decimal_base z_digit ("_")*
#;
#
#binary_number
#:	( size )? binary_base binary_value
#;
#
#octal_number
#:	( size )? octal_base octal_value
#;
#
#hex_number
#:	( size )? hex_base hex_value
#;
#
#sign
#:	PLUS | MINUS
#;
#
#size
#:	non_zero_unsigned_number
#;
#
#non_zero_unsigned_number
#:	non_zero_decimal_digit ( "_" | decimal_digit)*
#;
#
#real_number
#:	fixed_point_number
#| 	unsigned_number ( DOT unsigned_number )? exp ( sign )? unsigned_number
#;
#
#fixed_point_number
#:	unsigned_number DOT unsigned_number
#;
#
#exp
#:	"e" | "E"
#;
#
#unsigned_number
#:	decimal_digit ( "_" | decimal_digit )*
#;
#
#binary_value
#:	binary_digit ( "_" | binary_digit )*
#;
#
#octal_value
#:	octal_digit ( "_" | octal_digit )*
#;
#
#hex_value
#:	hex_digit ( "_" | hex_digit )*
#;
#
#decimal_base
#:	BACK_TIC ("s"|"S")? ("d"|"D")
#;
#
#binary_base
#:	BACK_TIC ("s"|"S")? ("b"|"B")
#;
#
#octal_base
#:	BACK_TIC ("s"|"S")? ("o"|"O")
#;
#
#hex_base
#:	BACK_TIC ("s"|"S")? ("h"|"H")
#;
#
#non_zero_decimal_digit
#:	"1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
#;
#
#decimal_digit
#:	"0" | non_zero_decimal_digit
#;
#
#binary_digit
#:	x_digit | z_digit | "0" | "1"
#;
#
#octal_digit
#:	x_digit | z_digit | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7"
#;
#
#hex_digit
#:	x_digit | z_digit 
#	| decimal_digit
#	| "a" | "b" | "c" | "d" | "e" | "f" | "A" | "B" | "C" | "D" | "E" | "F"
#;
#
#x_digit
#:	"x" | "X"
#;
#
#z_digit
#:	"z" | "Z" | "?"
#;
#
#z_or_x
#:	z_digit
#|	x_digit
#;
#
#unbased_unsized_literal
#:	TIC ("0" | "1" | z_or_x)
#;
*/

unbased_unsized_literal
:	UNBASED_UNSIZED_LITERAL	
;

number
:	NUMBER
;

integral_number
:	NUMBER
;

//A.8.8 Strings
string_literal
:  	STRING 
;

//A.9.1 Attributes
attribute_instances
:	(options{greedy=true;}: attribute_instance)*
;

attribute_instance
:	LPAREN STAR attr_spec (COMMA attr_spec)* STAR RPAREN
;

attr_spec
:	attr_name (EQ constant_expression)?
;

attr_name
:	identifier
;

identifier returns [Token id]
{ id = null;}
:	id1:SIMPLE_IDENTIFIER	{id = id1;}
|	id2:ESCAPED_IDENTIFIER	{id = id2;}
;

c_identifier
:	SIMPLE_IDENTIFIER
;

array_identifier
:	identifier
;
block_identifier
:	identifier
;
bin_identifier
:	identifier
;
cell_identifier
:	identifier
;
class_identifier
:	identifier
;
class_variable_identifier
:	variable_identifier
;
clocking_identifier
:	identifier
;
config_identifier
:	identifier
;
constraint_identifier
:	identifier
;
covergroup_identifier
:	identifier
;
covergroup_variable_identifier
:	variable_identifier
;
cover_point_identifier
:	identifier
;
dynamic_array_variable_identifier
:	variable_identifier
;
enum_identifier
:	identifier
;

formal_identifier
:	identifier
;
function_identifier
:	identifier
;
generate_block_identifier
:	identifier
;
genvar_identifier
:	identifier
;
hierarchical_block_identifier
:	hierarchical_identifier
;
hierarchical_dynamic_array_variable_identifier
:	hierarchical_variable_identifier
;
hierarchical_event_identifier
:	hierarchical_identifier
;

hierarchical_identifier
:	( "$root" DOT )? identifier 
		(	((LBRACK constant_expression RBRACK)+ DOT)=>
				(LBRACK constant_expression RBRACK)+ hierarchical_identifier_1
		|	(hierarchical_identifier_1)?
		)
;
//NOTE: Need to make sure DOT is after [expr] in predicate; else,
//      greediness will select alternative just based on [expr].
hierarchical_identifier_1
:	(DOT identifier (LBRACK constant_expression RBRACK)+ DOT)=>
		DOT identifier (LBRACK constant_expression RBRACK)+ 
			(hierarchical_identifier_1)+
|	DOT identifier (hierarchical_identifier_1)*
;

hierarchical_net_identifier
:	hierarchical_identifier
;
hierarchical_parameter_identifier
:	hierarchical_identifier
;
hierarchical_task_identifier
:	hierarchical_identifier
;
hierarchical_tf_identifier
:	hierarchical_identifier
;
hierarchical_variable_identifier
:	hierarchical_identifier
;
index_variable_identifier
:	identifier
;
interface_identifier returns [Token id]
{ id = null;}
:	id=identifier
;
interface_instance_identifier returns [Token id]
{ id = null;}
:	id=identifier
;
inout_port_identifier
:	identifier
;
input_port_identifier
:	identifier
;
instance_identifier returns [Token id]
{ id = null;}
:	id=identifier
;
library_identifier
:	identifier
;
member_identifier
:	identifier
;
method_identifier
:	identifier
;
modport_identifier returns [Token id]
{ id = null;}
:	id=identifier
;
module_identifier returns [Token id]
{ id = null;}
:	id=identifier
;
net_identifier
:	identifier
;
output_port_identifier
:	identifier
;
package_identifier
:	identifier
;

const_identifier
:	identifier
;

package_scope
:	(package_identifier | "$unit") COLON2
;

parameter_identifier
:	identifier
;
port_identifier
:	identifier
;
program_identifier
:	identifier
;
property_identifier
:	identifier
;
ps_class_identifier
:	(options{greedy=true;}: package_scope )? class_identifier
;
ps_covergroup_identifier
:	( package_scope )? covergroup_identifier
;
ps_identifier
:	( package_scope )? identifier
;
ps_or_hierarchical_net_identifier
:	(( package_scope )? net_identifier )=> ( package_scope )? net_identifier
| 	hierarchical_net_identifier
;
ps_or_hierarchical_tf_identifier
:	(( package_scope )? tf_identifier )=> ( package_scope )? tf_identifier
| 	hierarchical_tf_identifier
;
ps_parameter_identifier
:	( package_scope )? parameter_identifier
;
ps_property_identifier
:	( package_scope )? property_identifier
;
ps_sequence_identifier
:	( package_scope )? sequence_identifier
;
ps_specparam_identifier
:	( package_scope )? specparam_identifier
;
ps_type_identifier
:	( package_scope )? type_identifier
;
sequence_identifier
:	identifier
;
signal_identifier
:	identifier
;
specparam_identifier
:	identifier
;
system_tf_identifier
:   SYSTEM_TF_IDENTIFIER
;
task_identifier
:	identifier
;
tf_identifier
:	identifier
;
terminal_identifier
:	identifier
;
topmodule_identifier
:	identifier
;
type_identifier
:	identifier
;
udp_identifier returns [Token id]
{ id = null;}
:	id=identifier
;
variable_identifier
:	identifier
;

class SysVlogLexer extends Lexer;
options {
	k = 4;
    testLiterals = false;   // don't automatically test for literals
}
{
    public char LA(int i) throws CharStreamException {
		char c = super.LA(i);
		return c;
    }
}

AND			: "&"	;
AND2		: "&&"	;
AND_EQ		: "&="	;
AT			: "@"	;
AT2			: "@@"	;
AT_STAR		: "@*"	;
BACK_TIC	: "`"	;
CARET		: "^"	;
CARET_EQ	: "^="	;

/* Case where ://, a : followed by line comment.
 */
protected
COLON		: ":" 	;

protected
COLON2		: "::"	;

protected
COLON_EQ	: ":="	;

protected
COLON_SLASH : ":/";

COLON_TOKENS
: 	':' (	{LA(2) != '/'}? '/'	{ $setType(COLON_SLASH);} 
		|	':' { $setType(COLON2); }
		|	'=' { $setType(COLON_EQ); }
		|	{ $setType(COLON); }
		)
;

COMMA		: "," 	;
DOLLAR      : "$"   ;
DOT			: "." 	;
DOT_STAR	: ".*"	;
EQ			: "="	;
EQ_GT		: "=>"  ;
EQ2			: "=="	;
EQ3			: "==="	;
EQ_QMARK_EQ	: "=?="	;
GT			: ">"	;
GT2			: ">>"	;
GT2_EQ		: ">>="	;
GT3			: ">>>"	;
GT3_EQ		: ">>>=";
GT_EQ		: ">="	;
LBRACK		: "["   ;
LCURLY		: "{"	;
LPAREN		: "(" 	;
LT2			: "<<"	;
LT2_EQ		: "<<="	;
LT3			: "<<<"	;
LT3_EQ		: "<<<=";
LT_			: "<"	;
LT_EQ		: "<="	;
MINUS		: "-"	;
MINUS2		: "--"	;
MINUS_COLON : "-:"	;
MINUS_EQ	: "-="	;
MINUS_GT	: "->"	;
NOT			: "!"	;
NOT_EQ		: "!="	;
NOT_EQ2		: "!=="	;
NOT_QMARK_EQ: "!?="	;
OR			: "|"	;
OR2			: "||"	;
OR_EQ		: "|="	;
PERCENT     : "%"	;
PERCENT_EQ	: "%="	;
PLUS		: "+"	;
PLUS2		: "++"	;
PLUS_COLON	: "+:"	;
PLUS_EQ		: "+="	;
POUND		: "#"	;
POUND2		: "##"	;
QMARK		: "?"	;
RBRACK		: "]"   ;
RCURLY		: "}"	;
RPAREN		: ")" 	;
SEMI		: ";" 	;
SLASH		: "/"	;
SLASH_EQ	: "/="	;
STAR        : "*"	;
STAR2       : "**"	;
STAR_EQ		: "*=" 	;
TILDE		: "~"	;
TILDE_AND	: "~&"	;
TILDE_CARET : "~^" | "^~";
TILDE_OR	: "~|"	;

TIC_DIRECTIVE
	:	'`' id:RAW_IDENTIFIER
			( 	{id.getText().equals("line")}?  TIC_LINE
			)
			{$setType(Token.SKIP);}
	;

protected
TIC_LINE
	:	(WS_)+ lnum:UNSIZED_NUMBER (WS_)+ fname:STRING 
			(WS_)+ UNSIZED_NUMBER (WS_)* '\n'
		{
			setFilename(fname.getText().replace("\"",""));
			setLine(Integer.parseInt(lnum.getText()));
			$setType(Token.SKIP);
		}
	;

STRING
:	"\"" ( '\\' . | ~('\\'|'"') )* "\""
;

protected 
RAW_IDENTIFIER 
: ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')* 
;

SIMPLE_IDENTIFIER
options {testLiterals=true;}
:	RAW_IDENTIFIER
;

ESCAPED_IDENTIFIER
:	'\\' (~(' '|'\t'|'\n'|'\r'|'\f'))* (WS_ | NEWLINE)
;

SYSTEM_TF_IDENTIFIER
: '$' ('$'|'a'..'z'|'A'..'Z'|'_'|'0'..'9')+ 
;

// a dummy rule to force vocabulary to be all characters (except special
//   ones that ANTLR uses internally (0 to 2)
protected
VOCAB 
:	'\3'..'\377'
;

protected
NUMBER 
:	(SIZED_NUMBER)=> SIZED_NUMBER 
|	UNSIZED_NUMBER
;

protected
SIZED_NUMBER :
	(SIZE (WS_)*)? BASE (WS_)* SIZED_DIGIT (SIZED_DIGIT | '_')*
	;

protected
SIZE :
	(DIGIT)+
	;


protected
TIC : '\''
;

protected
BASE :
	TIC ( 'd' | 'D' | 'h' | 'H' | 'o' | 'O' | 'b' | 'B' )
	;

protected
UNSIZED_LITERAL
:	('0' | '1' | 'x' | 'X' | 'z' | 'Z' | '?')
;

protected
UNBASED_UNSIZED_LITERAL
:	TIC UNSIZED_LITERAL
;

BASE_OR_TIC_OR_NUMBER
:	(SIZED_NUMBER)=> SIZED_NUMBER {$setType(NUMBER);} 
|	TIC	(	UNSIZED_LITERAL	{$setType(UNBASED_UNSIZED_LITERAL);}
		|	{$setType(TIC);}
		)
|	UNSIZED_NUMBER {$setType(NUMBER);}
;

protected
SIZED_DIGIT :
	DIGIT | HEXDIGIT | 'x' | 'X' | 'z' | 'Z' | '?'
	;

protected
UNSIZED_NUMBER :
	DIGIT (DIGIT | '_')* ( '.' (DIGIT | '_')* )? (EXPONENT)?
        ;

protected
DIGIT :
        ('0'..'9')
        ;

protected
HEXDIGIT :
        ('A'..'F'|'a'..'f')
        ;

protected
EXPONENT :
        ('e'|'E') ('+'|'-')? ('0'..'9')+
        ;

WS_
:	(' '|'\r'|'\t'|('\013'..'\014'))	{$setType(Token.SKIP);}
;

NEWLINE
:	'\n' {$setType(Token.SKIP); newline();}
;

    // Single-line comments
SL_COMMENT :
        "//" (~'\n')* ('\n')?
        { 	$setType(Token.SKIP); 
			newline();
		}
        ;

    // multiple-line comments
ML_COMMENT
    :    "/*"
        (    { LA(2)!='/' }? '*'
        |    '\n' { newline(); }
        |    ~('*'|'\n')
        )*
        "*/"
        { $setType(Token.SKIP); }
    ;
