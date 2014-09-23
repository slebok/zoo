/*******************************************************************************

DESCRIPTION:
		Oracle PL/SQL Grammar for ANTLR v3, target language C#
AUTHOR:
		Andrey Kharitonkin (thikone@gmail.com)
DATE:
		02-Jan-2008
BASED ON:
		PLSQLGrammar.g for ANTLR v2
		Qazi Firdous Ahmed (qazif_ahmed@infosys.com) 
		Krupa Benhur (krupa_bg@infosys.com)
		Manojaba Banerjee (manojaba_banerjee@infosys.com)
		Infosys Technologies Ltd., Bangalore, India
		Sept 18, 2002
		This grammar is for PL/SQL.
COMMENT:
		The grammar has been mostly re-written for ANTLR v3,
		using Oracle 10g Release 2 documentation and ANTLR book.
		New SQL and PL/SQL expression rules, SQL statments
		SELECT, INSERT, UPDATE, DELETE are fully supported.
		Generated parser can parse most of valid PL/SQL and 
		it was tested with over 10 Mb of test source code.
		Let me know if something cannot be parsed by this grammar.
KNOWN ISSUES:
		At the moment only supports CREATE PACKAGE and PACKAGE BODY.
		Symbol table and gate predicates needed to distinguish
			between function call and variable usage.

It was fun learning ANTLR3 and creating this grammar, hope you enjoy it as well!

*******************************************************************************/

grammar PLSQL3;

options {
	language=CSharp;
	k=*;
	backtrack=true;
	memoize=true;
	output=AST;
}

@members {
    private bool is_sql = false;
}

start_rule
	:	(create_package)* EOF
	;

create_package
	:	'CREATE' ( 'OR' keyREPLACE )?
		( package_spec | package_body )
	;
	
package_spec
	:	keyPACKAGE package_name ( 'IS' | 'AS' ) 
		( package_obj_spec )*
		'END' (package_name)? SEMI
	;
	
package_body
	:	keyPACKAGE ( keyBODY ) package_name ( 'IS' | 'AS' )
		( package_obj_body )*
		( 'BEGIN' seq_of_statements )?  
		'END' ( package_name )? SEMI
	;

package_name
	:	( schema_name DOT )? identifier 
	;

package_obj_spec
	:	variable_declaration 
	|	type_declaration
	|	subtype_declaration 
	|	record_declaration 
	|	plsql_table_declaration 
	|	varray_declaration
	|	cursor_declaration 
	|	cursor_spec 
	|	procedure_spec 
	|	function_spec 
	|	exception_declaration 
	|	pragma_declaration
	;

variable_declaration
	:	variable_name ('CONSTANT')?
		type_spec ('NOT' 'NULL')? 
		( ( ASSIGN | 'DEFAULT' ) plsql_expression)? SEMI
	;	

type_declaration 
	:	keyTYPE type_spec 'IS' ( keyNEW )? ( type_spec ( 'NOT' 'NULL' )? | LPAREN plsql_expressions RPAREN ) SEMI
	;	

subtype_declaration 
	:	keySUBTYPE type_spec 'IS' type_spec ( 'NOT' 'NULL' | keyRANGE literal DOUBLEDOT literal )? SEMI
	;	
	
cursor_declaration
	:	keyCURSOR cursor_name
		( LPAREN parameter_specs RPAREN )?
		'IS' select_command SEMI
	;
package_obj_body
	:	variable_declaration 
	|	subtype_declaration 
	|	cursor_declaration 
	|	exception_declaration 
	|	record_declaration 
	|	plsql_table_declaration 
	|	varray_declaration
	|	procedure_body 
	|	function_body 
	|	pragma_declaration
	;

seq_of_statements
	:	statement SEMI ( statement SEMI )*
	;
	
statement
	:	assignment_statement
	|	exit_statement
	|	goto_statement
	|	case_statement
	|	if_statement 
	|	loop_statement 
	|	null_statement
	|	raise_statement
	|	return_statement
	|	sql_statement
	|	plsql_block
//	|	begin_block
	|	function_call
	;
		
plsql_block
	:	( LLABEL label_name RLABEL )?
		( ( 'DECLARE' )? (declare_spec)+ )? 
		( 'BEGIN' )
		seq_of_statements
		( 'EXCEPTION' ( exception_handler )+ )? 
		( 'END' ( label_name )? )
	;

declare_spec
	:	variable_declaration 
	|	subtype_declaration 
	|	cursor_declaration 
	|	exception_declaration 
	|	record_declaration 
	|	plsql_table_declaration 
	|	varray_declaration
	|	procedure_declaration 
	|	function_declaration
	|	type_declaration 
	|	pragma_declaration
	;

pragma_declaration
	:	keyPRAGMA 
		(	keyRESTRICT_REFERENCES LPAREN ( 'DEFAULT' | function_name ) ( COMMA pragma_param )+ RPAREN 
		|	keyEXCEPTION_INIT LPAREN exception_name COMMA literal RPAREN
		|	keyAUTONOMOUS_TRANSACTION
		|	keySERIALLY_REUSABLE
		|	keyBUILTIN LPAREN pragma_params RPAREN
		|	keyFIPSFLAG LPAREN pragma_params RPAREN
		|	keyINTERFACE LPAREN pragma_params RPAREN
		|	keyNEW_NAMES LPAREN pragma_params RPAREN
		|	keyTIMESTAMP LPAREN pragma_params RPAREN
		)
		SEMI
	;

pragma_params
	:	pragma_param ( COMMA pragma_param )*
	;

pragma_param
	:	( PLUS | MINUS )? NUMBER
	|	QUOTED_STRING
	|	identifier
	;

assignment_statement
	:	//(lvalue ASSIGN function_call) => (lvalue ASSIGN function_call)
//	|	(lvalue ASSIGN plsql_expression)  => 
		(lvalue ASSIGN plsql_expression)
//	|	function_call
	;
lvalues
	:	lvalue ( COMMA lvalue )*
	;
lvalue
	:	variable_name
	|	record_name DOT field_name
	|	plsql_table_name LPAREN subscript RPAREN ( DOT field_name )*
	|	COLON host_variable ( COLON host_variable )?
	;

field_name
	:	identifier
	;
	
subscript
	:	plsql_expression 
	;
	
host_variable
	:	identifier
	;
	
goto_statement
	:	'GOTO' label_name
	;
	
label_name
	:	identifier
	;	

exit_statement
	:	keyEXIT ( label_name )? ( 'WHEN' plsql_condition )?
	;
	
datatype
	:	'BINARY_INTEGER' 
	|	'BINARY_FLOAT'
	|	'BINARY_DOUBLE'
	|	'NATURAL' 
	|	'POSITIVE' 
	|	( 'NUMBER' | 'NUMERIC' | 'DECIMAL' | 'DEC' ) ( LPAREN NUMBER ( COMMA NUMBER )? RPAREN )?
	|	'LONG' ( 'RAW')? ( LPAREN NUMBER RPAREN )?
	|	'RAW' ( LPAREN NUMBER RPAREN )?
	|	'BOOLEAN'
	|	'DATE'
	|	keyINTERVAL keyDAY ( LPAREN NUMBER RPAREN )? 'TO' keySECOND ( LPAREN NUMBER RPAREN )?
	|	keyINTERVAL keyYEAR ( LPAREN NUMBER RPAREN )? 'TO' keyMONTH
	|	( keyTIME | keyTIMESTAMP ) ( LPAREN NUMBER RPAREN )? ( 'WITH' ( keyLOCAL )? keyTIME keyZONE)?
	|	'INTEGER'
	|	'INT'
	|	'SMALLINT'
	|	'FLOAT' ( LPAREN NUMBER RPAREN )?
	|	'REAL'
	|	'DOUBLE' keyPRECISION
	|	'CHAR'      ( keyVARYING )? ( LPAREN NUMBER ( keyBYTE | 'CHAR' )? RPAREN )? ( 'CHARACTER' 'SET' ( identifier | column_spec CHARSET_ATTR ) )?
	|	'VARCHAR'                   ( LPAREN NUMBER ( keyBYTE | 'CHAR' )? RPAREN )? ( 'CHARACTER' 'SET' ( identifier | column_spec CHARSET_ATTR ) )?
	|	'VARCHAR2'                  ( LPAREN NUMBER ( keyBYTE | 'CHAR' )? RPAREN )? ( 'CHARACTER' 'SET' ( identifier | column_spec CHARSET_ATTR ) )?
	|	'CHARACTER' ( keyVARYING )? ( LPAREN NUMBER RPAREN )?
	|	'NCHAR'     ( keyVARYING )? ( LPAREN NUMBER RPAREN )?
	|	'NVARCHAR'  ( LPAREN NUMBER RPAREN )?
	|	'NVARCHAR2' ( LPAREN NUMBER RPAREN )?
	|	'NATIONAL'  ( 'CHARACTER' | 'CHAR' ) ( keyVARYING )? ( LPAREN NUMBER RPAREN )?
	|	'MLSLABEL'
	|	'PLS_INTEGER'
	|	'BLOB'
	|	'CLOB' ( 'CHARACTER' 'SET' ( identifier | column_spec CHARSET_ATTR ) )?
	|	'NCLOB'
	|	'BFILE'
	|	'ROWID' 
	|	'UROWID' ( LPAREN NUMBER RPAREN )?
	;

type_spec
	:	datatype 
//	|	variable_name TYPE_ATTR
	|	column_spec TYPE_ATTR
//	|	package_name DOT variable_name
	|	table_spec ROWTYPE_ATTR
//	|	keyREF ( keyCURSOR | type_name )
	|	type_name ( LPAREN NUMBER RPAREN )?
	;

type_name
	:	identifier ( DOT identifier )*
	;

parameter_specs
	:	parameter_spec ( COMMA parameter_spec )*
	;

parameter_spec
	:	parameter_name ( 'IN' )? ( type_spec )?
	;	

parameter_name
	:	identifier
	;

cursor_spec
	:	keyCURSOR cursor_name 
		( LPAREN parameter_specs RPAREN )?
		keyRETURN return_type SEMI! 
	;

procedure_spec: 
	'PROCEDURE' procedure_name 
	( LPAREN arguments RPAREN )? SEMI
	;

function_spec
	:	'FUNCTION' function_name 
		( LPAREN arguments RPAREN )?
		keyRETURN return_type SEMI
	;

exception_declaration
	:	exception_name 'EXCEPTION' SEMI
	;

exception_names
	:	exception_name ( 'OR' exception_name )*
	;

exception_name
	:	( exception_package_name DOT )? identifier
	;

exception_package_name
	:	identifier
	;

	
//oracle_err_number
//	:	( PLUS | MINUS )? NUMBER
//	|	QUOTED_STRING
//	;
	
record_declaration
	:	record_type_dec 
//	|	record_var_dec
	;

record_type_dec
	:	keyTYPE type_name 'IS' keyRECORD 
		LPAREN field_specs RPAREN SEMI
	;

//record_var_dec
//	:	record_name type_name ROWTYPE_ATTR SEMI
//	;

field_specs
	:	field_spec ( COMMA field_spec )*
	;
field_spec
	:	column_name type_spec
		('NOT' 'NULL')? 
		( ( ASSIGN | 'DEFAULT' ) plsql_expression)?
	;

plsql_table_declaration
	:	table_type_dec
//	|	table_var_dec
	;

table_type_dec
	:	keyTYPE type_name 'IS' 'TABLE' 
		'OF' type_spec ( 'NOT' 'NULL' )?
		(	'INDEX' 'BY' 
			(	'BINARY_INTEGER'
			|	'PLS_INTEGER'
			|	'VARCHAR2' LPAREN integer RPAREN
			)
		)?
		SEMI
	;

table_var_dec
	:	plsql_table_name type_name SEMI
	;

plsql_table_name
	:	identifier ( DOT identifier )*
	;

varray_declaration
	:	keyTYPE type_name 'IS' 
		( keyVARRAY | keyVARYING keyARRAY ) LPAREN integer RPAREN
		'OF' type_spec ( 'NOT' 'NULL' )?
	;

procedure_declaration
	:	procedure_body
	;

procedure_body
	:	( proc_fun_start )? 'PROCEDURE'^ procedure_name 
		( LPAREN argument ( COMMA argument )* RPAREN )? 
		( 'IS' | 'AS' )
		//( keyPRAGMA keyAUTONOMOUS_TRANSACTION )?
		( ( declare_spec ) => ( declare_spec )* )
		( 'BEGIN' )
		( seq_of_statements )
		( 'EXCEPTION' ( exception_handler )* )?
		'END' ( procedure_name )? SEMI
	;

begin_block
	:	'BEGIN'
		( seq_of_statements )
		( 'EXCEPTION' ( exception_handler )+ )?
		'END'
	;

//Exception handler needs to be defined
exception_handler
	:	'WHEN' exception_names 'THEN'
		seq_of_statements
	;

proc_fun_start
	:	'CREATE' ( 'OR' keyREPLACE )?
	;

function_body
	:	( proc_fun_start )? 'FUNCTION'^ function_name 
		( LPAREN arguments RPAREN )? 
		keyRETURN return_type ( 'IS' | 'AS' )
		//( keyPRAGMA keyAUTONOMOUS_TRANSACTION )?
		( ( declare_spec ) => ( declare_spec )* )
		( 'BEGIN' )
		( seq_of_statements )
		( 'EXCEPTION' ( exception_handler )+ )?
		'END' ( function_name )? SEMI
	;

function_name
	:	identifier | QUOTED_STRING //( schema_name DOT )? identifier
	;

procedure_name
	:	identifier | QUOTED_STRING //( schema_name DOT )? identifier
	;

arguments
	:	argument ( COMMA argument )*
	;

argument
	:	argument_name ( keyOUT | 'IN' keyOUT | 'IN' )? (argument_type )?
		( ( ASSIGN | 'DEFAULT' ) plsql_expression )?
	;

argument_name
	:	identifier
	;

argument_type
	:	type_spec
	;

value
	:	( PLUS | MINUS )? NUMBER
	|	quoted_string
	|	'TRUE' | 'FALSE'
	|	'NULL'
	;

return_type
	:	type_spec
	;

function_declaration
	:	function_body
	;

function_call
	:	user_defined_function ( { input.LA(1) != LPAREN || input.LA(2) != PLUS || input.LA(3) != RPAREN }? LPAREN ( call_parameters )? RPAREN )?
//	|	//{ input.LA(1) == ID && input.LA(2) == LPAREN && input.LA(3) == ASTERISK && input.LA(4) == RPAREN }? 
//		{ is_sql }?
//		keyCOUNT LPAREN ( ASTERISK | sql_expression ) RPAREN
//	|	{ is_sql }?
//		'DISTINCT' LPAREN call_parameters RPAREN
	;

collection_function_call
	:	plsql_table_name
	;

variable_names
	:	variable_name ( COMMA variable_name )*
	;
variable_name
	:	identifier
	;

null_statement
	:	'NULL' 
	;

raise_statement
	:	keyRAISE ( exception_name )?
	;
	
return_statement
	:	keyRETURN ( plsql_expression )?
	;

loop_statement
	:	( LLABEL label_name RLABEL )?
		(	keyWHILE^ plsql_condition
		| 	(	'FOR'^
				(	( numeric_loop_param ) => numeric_loop_param
				|	( cursor_loop_param ) => cursor_loop_param 
				)
			)
		)?
		keyLOOP
		seq_of_statements
		'END' keyLOOP 
		( label_name )?
	;

numeric_loop_param
	:	index_name 'IN' ( keyREVERSE )? integer_expr DOUBLEDOT integer_expr
	;

index_name
	:	identifier
	;

//Added typespec to handle packagename.variablename for loop statement
integer_expr
	:	sql_expression
	;

cursor_name
	:	identifier
	;

cursor_loop_param
	:	record_name 'IN'
		(	cursor_name ( LPAREN plsql_expressions RPAREN )?
		|	LPAREN select_statement RPAREN
		)
	;

record_name
	:	identifier
	;

commit_statement
	:	'COMMIT'
	;

if_statement
	:	'IF'^ plsql_condition 'THEN' seq_of_statements
		(	//{ input.LA(1) != ELSE }?
			keyELSIF plsql_condition 'THEN' seq_of_statements
		)*
		( 'ELSE' seq_of_statements )?
		'END' 'IF'
	;

sql_statement
	:	sql_command
	;

sql_command
	:	to_modify_data
	|	to_control_data
	;

to_modify_data
	:	select_command
	|	insert_command
	|	update_command
	|	delete_command
	|	set_transaction_command
	;

to_control_data
	:	close_statement
	|	commit_statement
	|	fetch_statement
	|	lock_table_statement
	|	open_statement
	|	rollback_statement
	|	savepoint_statement
	;

select_command
	:	select_statement// ( 'UNION' select_statement )*
	;

select_statement
	:	//( LPAREN select_command RPAREN ) => LPAREN select_command RPAREN |
		select_expression 
	;

select_expression
	:	
		'SELECT' /*( hint )?*/ ( 'DISTINCT' | 'UNIQUE' | 'ALL' )? select_list
		( keyBULK keyCOLLECT )?
		( 'INTO' lvalues )?
		'FROM' ( table_reference_list | join_clause | LPAREN join_clause RPAREN )
		( where_clause )? ( hierarchical_query_clause )? ( group_by_clause )?
		( 'HAVING' sql_condition )? ( model_clause )?
		(	(	'UNION' ( 'ALL' )?
			|	'INTERSECT'
			|	'MINUS'
			)
			(	select_expression //LPAREN subquery RPAREN
			|	subquery
			)
		)?
		( order_by_clause )?
	;

select_list
	:	ASTERISK
	|	displayed_column ( COMMA displayed_column )*
	;

table_reference_list_from
	:	'FROM' table_reference_list
	;

table_reference_list
	:	selected_table ( COMMA selected_table )*
	;

join_clause
	:	table_name ( inner_cross_join_clause | outer_join_clause )+
	;
inner_cross_join_clause
	:	( keyINNER )? keyJOIN table_name ( 'ON' sql_condition | keyUSING LPAREN column_specs RPAREN )
	|	( keyCROSS | keyNATURAL ( keyINNER ) ) keyJOIN table_name
	;
outer_join_clause
	:	( query_partition_clause )?
		(	outer_join_type keyJOIN
		|	keyNATURAL ( outer_join_type )? keyJOIN
		)
		table_name ( query_partition_clause )?
		( 'ON' sql_condition | keyUSING LPAREN column_specs RPAREN )?
	;
query_partition_clause
	:	keyPARTITION 'BY' expression_list
	;
outer_join_type
	:	( keyFULL | keyLEFT | keyRIGHT ) ( keyOUTER )?
	;
outer_join_sign
	:	LPAREN PLUS RPAREN
	;
where_clause
	:	'WHERE' sql_condition
	;
hierarchical_query_clause
	:	( 'START' 'WITH' sql_condition )? 'CONNECT' 'BY' ( keyNOCYCLE )? sql_condition
	;
group_by_clause
	:	'GROUP' 'BY' group_by_exprs
	;
group_by_exprs
	:	group_by_expr ( COMMA group_by_expr )*
	;
group_by_expr
	:	rollup_cube_clause
	|	grouping_sets_clause
	|	grouping_expression_list
	;
rollup_cube_clause
	:	( keyROLLUP | keyCUBE ) LPAREN grouping_expression_list RPAREN
	;
grouping_sets_clause
	:	keyGROUPING keySETS LPAREN grouping_expression_list RPAREN
	;
grouping_sets_exprs
	:	grouping_sets_expr ( COMMA grouping_sets_expr )*
	;
grouping_sets_expr
	:	rollup_cube_clause | grouping_expression_list
	;
model_clause
	:	keyMODEL ( cell_reference_options )
		( return_rows_clause )?
		( reference_model )+ main_model
	;
cell_reference_options
	:	( ( keyIGNORE | keyKEEP ) keyNAV )?
		( 'UNIQUE' ( keyDIMENSION | keySINGLE keyREFERENCE ) )?
	;
return_rows_clause
	:	keyRETURN ( keyUPDATED | 'ALL' ) 'ROWS'
	;
reference_model
	:	keyREFERENCE reference_model_name 'ON' LPAREN subquery RPAREN
		model_column_clauses ( cell_reference_options )
	;
reference_model_name
	:	identifier
	;
main_model
	:	( keyMAIN main_model_name )? model_column_clauses
		( cell_reference_options ) model_rules_clause
	;
main_model_name
	:	identifier
	;
model_column_clauses
	:	( query_partition_clause ( column_spec )? )?
		keyDIMENSION 'BY' LPAREN model_columns RPAREN
		keyMEASURES LPAREN model_columns RPAREN
	;
model_columns
	:	model_column ( COMMA model_column )*
	;
model_column
	:	sql_expression ( ( 'AS' )? column_spec )?
	;
model_rules_clause
	:	( keyRULES ( 'UPDATE' | keyUPSERT ( 'ALL' )? )? ( ( keyAUTOMATIC | keySEQUENTIAL ) 'ORDER' )? )?
		( keyITERATE LPAREN NUMBER RPAREN ( keyUNTIL LPAREN sql_condition RPAREN )? )?
		LPAREN model_rules_exprs RPAREN
	;
model_rules_exprs
	:	model_rules_expr ( COMMA model_rules_expr )*
	;
model_rules_expr
	:	( 'UPDATE' | keyUPSERT ( 'ALL' )? )? cell_assignment ( order_by_clause )? EQ sql_expression
	;
cell_assignment
	:	measure_column LBRACK ( multi_column_for_loop | cell_assignment_exprs ) RBRACK
	;
cell_assignment_exprs
	:	cell_assignment_expr ( COMMA cell_assignment_expr )*
	;
cell_assignment_expr
	:	sql_condition | sql_expression | single_column_for_loop
	;
measure_column
	:	column_name
	;
single_column_for_loop
	:	'FOR' column_name
		(	'IN' LPAREN ( literals | subquery ) RPAREN
		|	( 'LIKE' pattern )? 'FROM' literal 'TO' literal ( keyINCREMENT | keyDECREMENT ) literal
		)
	;
literal
	:	( PLUS | MINUS )? NUMBER
	|	QUOTED_STRING
	;
literals
	:	literal ( COMMA literal )*
	;
bracket_literals
	:	LPAREN literals RPAREN
	;
bracket_literals_list
	:	bracket_literals ( COMMA bracket_literals )*
	;
pattern
	:	QUOTED_STRING
	;
multi_column_for_loop
	:	'FOR' LPAREN column_specs RPAREN 'IN' LPAREN ( bracket_literals_list | subquery ) RPAREN
	;
order_by_clause
	:	'ORDER' ( keySIBLINGS )? 'BY' order_by_exprs
	;
order_by_exprs
	:	order_by_expr ( COMMA order_by_expr )*
	;
order_by_expr
	:	(	sql_expression
//		|	position
//		|	column_alias
		)
		( 'ASC' | 'DESC' )? ( keyNULLS keyFIRST | keyNULLS keyLAST )?
	;
for_update_clause
	:	'FOR' 'UPDATE' ( 'OF' column_specs )? ( keyWAIT integer | 'NOWAIT' )?
	;

where_condition_whole
	:	'WHERE' sql_condition
	;

where_condition
	:	sql_condition
	;

displayed_column
	:	(	column_spec DOT ASTERISK
//		|	keyCOUNT LPAREN ( ASTERISK | 'DISTINCT' LPAREN sql_expression RPAREN ) RPAREN
//		|	
		|	sql_expression
		)
		( alias )?
	;

schema_name
	:	sql_identifier
	;

table_name
	:	sql_identifier
	;

nested_expressions
	:	nested_expression ( COMMA nested_expression )*
	;

nested_expression
	:	{  is_sql }? sql_expression
	|	{ !is_sql }? plsql_expression
	;
plsql_condition
		@init { is_sql = false; }
	:	expr_bool
	;

plsql_expressions
	:	plsql_expression ( COMMA plsql_expression )*
	;

plsql_expression
		@init { is_sql = false; }
	:	expr_bool
	;


expr_bool
	:	expr_or ( 'OR' expr_or )*
	;
expr_or
	:	expr_and ( 'AND' expr_and )*
	;
expr_and
	:	( 'NOT' )? expr_not
	;
expr_not
	:	expr_add 
		(	relational_op expr_add
		|	FOUND_ATTR | NOTFOUND_ATTR | ISOPEN_ATTR | ROWCOUNT_ATTR | BULK_ROWCOUNT_ATTR
		|	'IS' ( 'NOT' )? 'NULL'
		|	( 'NOT' )? 'LIKE' expr_add
		|	( 'NOT' )? 'BETWEEN' expr_add 'AND' expr_add
		|	( 'NOT' )? 'IN' LPAREN nested_expressions RPAREN
		)*
	;

boolean_literal
	:	'TRUE' | 'FALSE'
	;

sql_expressions
	:	sql_expression ( COMMA sql_expression )*
	;
sql_expression
		@init { is_sql = true; }
	:	expr_add
	;
expr_add
	:	expr_mul ( ( PLUS | MINUS | DOUBLEVERTBAR ) expr_mul )*
	;
expr_mul
	:	expr_sign ( ( ASTERISK | DIVIDE ) expr_sign )*
	;
expr_sign
	:	( PLUS | MINUS )? expr_pow
	;
expr_pow
	:	expr_expr ( EXPONENT expr_expr )*
	;
expr_expr
	:	( expr_paren ) => expr_paren
	|	( function_expression ) => function_expression
//	|	( compound_expression ) => compound_expression
	|	( case_expression ) => case_expression
	|	( cursor_expression ) => cursor_expression
	|	( simple_expression ) => simple_expression
	|	( select_expression ) => select_expression
//	|	( special_expression ) => special_expression
//	|	datetime_expression
//	|	interval_expression
//	|	object_access_expression
//	|	scalar_subquery_expression
//	|	model_expression
//	|	type_constructor_expression
//	|	variable_expression
//	:	'NULL' | NUMBER | QUOTED_STRING | IDENTIFIER
	;
simple_expression
	:	boolean_literal
	|	'SQL' ( FOUND_ATTR | NOTFOUND_ATTR | ISOPEN_ATTR | ROWCOUNT_ATTR | BULK_ROWCOUNT_ATTR )
	|	( column_spec ) => column_spec
	|	QUOTED_STRING
	|	NUMBER
//	|	sequence_name DOT ( 'CURRVAL' | 'NEXTVAL' )
//	|	'ROWID'
//	|	'ROWNUM'
	|	'NULL'
	;
compound_expression
//	:	expr_paren
//	|	expr_sign
	:	expr_prior
//	|	expr_add
//	|	expr_cat
	;
expr_paren
	:	LPAREN nested_expression RPAREN
	;
expr_prior
	:	'PRIOR' expr_add
	;
case_expression
	:	'CASE' ( simple_case_expression | searched_case_expression ) ( else_case_expression )? 'END'
	;
simple_case_expression
	:	nested_expression ( 'WHEN' nested_expression 'THEN' nested_expression )+
	;
searched_case_expression
	:	( 'WHEN' nested_condition 'THEN' nested_expression )+
	;
else_case_expression
	:	'ELSE' nested_expression
	;
case_statement
	:	( label_name )? 'CASE'^ ( simple_case_statement | searched_case_statement ) ( else_case_statement )? 'END' 'CASE' ( label_name )?
	;
simple_case_statement
	:	plsql_expression ( 'WHEN' plsql_expression 'THEN' seq_of_statements )+
	;
searched_case_statement
	:	( 'WHEN' plsql_expression 'THEN' seq_of_statements )+
	;
else_case_statement
	:	'ELSE' seq_of_statements
	;
cursor_expression
	:	keyCURSOR LPAREN subquery RPAREN
	;
datetime_expression
	:	sql_expression 'AT'
		(	keyLOCAL
		|	keyTIME keyZONE ( keyDBTIMEZONE | keySESSIONTIMEZONE | sql_expression )
		)
	;
function_expression
	:	function_call ( DOT nested_expression )?
	|	{ is_sql }?
		(	keyCOUNT LPAREN ( ASTERISK | nested_expression ) RPAREN
		|	'DISTINCT' ( LPAREN nested_expression RPAREN | nested_expression )
		)
	;
special_expression
	:	{ is_sql }?
		(	keyCOUNT LPAREN ( ASTERISK | nested_expression ) RPAREN
		|	'DISTINCT' LPAREN nested_expression RPAREN
		)
	;
interval_expression
	:	sql_expression
		(	keyDAY ( LPAREN leading_field_precision RPAREN )? 'TO' keySECOND ( LPAREN fractional_second_precision RPAREN )?
		|	keyYEAR ( LPAREN leading_field_precision RPAREN )? 'TO' keyMONTH
		)
	;
leading_field_precision
	:	integer // TODO validate digit from 0 to 9
	;
fractional_second_precision
	:	integer // TODO validate digit from 0 to 9
	;
object_access_expression
	:
	;
scalar_subquery_expression
	:
	;
model_expression
	:
	;
type_constructor_expression
	:
	;
variable_expression
	:
	;
sequence_name
	:	identifier
	;
integer
	:	NUMBER
	;


alias
	:	( 'AS' )? sql_identifier
	;

column_specs
	:	column_spec ( COMMA column_spec )*
	;

column_spec
	:	sql_identifier ( DOT sql_identifier )* 
//	|	{ is_sql }?
//		(	ASTERISK
//		|	sql_identifier ( DOT sql_identifier )* ( DOT ASTERISK )
//		)
//		( ( schema_name DOT )? table_name DOT )? column_name
	;

column_name
	:	sql_identifier
	;
nested_table
	:	sql_identifier
	;
nested_table_column_name
	:	( schema_name DOT )? table_name DOT nested_table DOT column_name
	;

user_defined_function
	:	sql_identifier ( DOT sql_identifier )* ( DOT ( 'EXISTS' | 'PRIOR' | 'DELETE' ) )? //( ( schema_name DOT )? package_name DOT )? identifier // sql_identifier ( DOT sql_identifier )*
	;

//function
//	:	user_defined_function
//		number_function
//	|	char_function
//	|	group_function
//	|	conversion_function
//	|	other_function
//	;

selected_table
	:	( table_spec | ( 'TABLE' | keyTHE )? subquery ) ( alias )?
	;

table_spec
	:	( schema_name DOT )? table_name ( AT_SIGN link_name )?
	;

table_alias
	:	( schema_name DOT )? table_name ( AT_SIGN link_name )? ( alias )?
	;

link_name
	:	sql_identifier
	;
nested_condition
	:	{  is_sql }? condition_or
	|	{ !is_sql }? expr_bool
	;
sql_condition
		@init { is_sql = true; }
	:	condition_or
//	|	column 'IS' 'NOT' 'NULL' // TODO must be any boolean expression with table columns
	;
condition_paren
	:	LPAREN sql_condition RPAREN
	;
condition_or
	:	condition_and ( 'OR' condition_and )*
	;
condition_and
	:	condition_not ( 'AND' condition_not )*
	;
condition_not
	:	'NOT' condition_expr
	|	condition_expr
	;
condition_expr
	:	condition_exists
	|	condition_is
	|	condition_comparison
	|	condition_group_comparison
	|	condition_in
	|	condition_is_a_set
	|	condition_is_any
	|	condition_is_empty
	|	condition_is_of_type
	|	condition_is_present
	|	condition_like
	|	condition_memeber
	|	condition_between
	|	condition_regexp_like
	|	condition_submultiset
	|	condition_equals_path
	|	condition_under_path
	|	condition_paren
	;
condition_exists
	:	'EXISTS' LPAREN select_command RPAREN
	;
condition_is
	:	sql_expression 'IS' ( 'NOT' )? ( keyNAN | keyINFINITE | 'NULL' )
	;
condition_comparison
	:	LPAREN sql_expressions RPAREN ( outer_join_sign )? ( EQ | NOT_EQ ) LPAREN select_command RPAREN ( outer_join_sign )?
	|	( 'PRIOR' )? sql_expression ( outer_join_sign )? ( EQ | NOT_EQ | GTH | GEQ | LTH | LEQ ) ( 'PRIOR' )? ( sql_expression | LPAREN select_command RPAREN ) ( outer_join_sign )?
	;
condition_group_comparison
	:	LPAREN sql_expressions RPAREN ( EQ | NOT_EQ ) ( 'ANY' | keySOME | 'ALL' ) LPAREN ( grouping_expression_list | select_command ) RPAREN
	|	sql_expression ( EQ | NOT_EQ | GTH | GEQ | LTH | LEQ ) ( 'ANY' | keySOME | 'ALL' ) LPAREN ( sql_expressions | select_command ) RPAREN
	;
condition_in
	:	LPAREN sql_expressions RPAREN ( 'NOT' )? 'IN' LPAREN ( grouping_expression_list | select_command ) RPAREN
	|	sql_expression ( 'NOT' )? 'IN' LPAREN ( expression_list | select_command ) RPAREN
	;
condition_is_a_set
	:	nested_table_column_name 'IS' ( 'NOT' )? keyA 'SET'
	;
condition_is_any
	:	( column_name 'IS' )? 'ANY'
	;
condition_is_empty
	:	nested_table_column_name 'IS' ( 'NOT' )? keyEMPTY
	;
condition_is_of_type
	:	sql_expression 'IS' ( 'NOT' )? 'OF' ( keyTYPE )? LPAREN type_name RPAREN
	;
condition_is_of_type_names
	:	condition_is_of_type_name ( COMMA condition_is_of_type_name )*
	;
condition_is_of_type_name
	:	( keyONLY )? type_name
	;
condition_is_present
	:	cell_reference 'IS' keyPRESENT
	;
condition_like
	:	sql_expression ( 'NOT' )? ( 'LIKE' | keyLIKEC | keyLIKE2 | keyLIKE4 ) sql_expression ( keyESCAPE sql_expression )?
	;
condition_memeber
	:	sql_expression ( 'NOT' )? keyMEMBER ( 'OF' )? nested_table_column_name
	;
condition_between
	:	sql_expression ( 'NOT' )? 'BETWEEN' sql_expression 'AND' sql_expression
	;
condition_regexp_like
	:	keyREGEXP_LIKE LPAREN call_parameters RPAREN
	;
condition_submultiset
	:	nested_table_column_name ( 'NOT' )? keySUBMULTISET ( 'OF' )? nested_table_column_name
	;
condition_equals_path
	:	keyEQUALS_PATH LPAREN column_name COMMA path_string ( COMMA correlation_integer )? RPAREN
	;
condition_under_path
	:	keyUNDER_PATH LPAREN column_name ( COMMA levels )? COMMA path_string ( COMMA correlation_integer )? RPAREN
	;
levels
	:	integer
	;
correlation_integer
	:	integer
	;
path_string
	:	QUOTED_STRING
	;
grouping_expression_list
	:	expression_list ( COMMA expression_list )*
	;
expression_list
	:	LPAREN sql_expressions RPAREN
	|	sql_expressions
	;
cell_reference
	:	sql_identifier
	;
call_parameters
	:	call_parameter ( COMMA call_parameter )*
	;
call_parameter
	:	( parameter_name ARROW )? nested_expression
	;

relational_op
	:	EQ | LTH | GTH | NOT_EQ | LEQ | GEQ
	;

exp_set
	:	( sql_expression ) => sql_expression
	|	subquery
	;

subquery
	:	LPAREN select_command RPAREN
	;

connect_clause
	:	( 'START' 'WITH' sql_condition )?
		'CONNECT' 'BY' 
		(	'PRIOR' sql_expression relational_op sql_expression
		|	sql_expression relational_op sql_expression 'PRIOR'
		)
		(	( ( 'PRIOR' )? sql_condition ) => ('PRIOR')? sql_condition
		|	sql_expression relational_op ( 'PRIOR' )? sql_expression ( 'AND' sql_condition )?
		)
		( 'START' 'WITH' sql_condition )?
	;

group_clause
	:	'GROUP' 'BY' sql_expression ( COMMA sql_expression )* ( 'HAVING' sql_condition )?
	;

set_clause
	:	( ( 'UNION' 'ALL' ) | 'INTERSECT' | 'MINUS' ) select_command 
	;

order_clause
	:	'ORDER' 'BY' sorted_def ( COMMA sorted_def )*
	;

sorted_def
	:	( ( sql_expression ) => sql_expression | ( NUMBER ) => NUMBER ) ( 'ASC' | 'DESC' )?
	;

update_clause
	:	'FOR' 'UPDATE' ( 'OF' column_name ( COMMA column_name )* )? ( 'NOWAIT' )?
	;

insert_command
	:	'INSERT' 'INTO' table_reference_list
		( LPAREN column_specs RPAREN )?
		(	'VALUES' LPAREN plsql_expressions RPAREN
		|	select_statement
		)
		( returning_clause )?
	;

update_command
	:	'UPDATE' selected_table
		'SET' 
		(	update_nested_column_specs
		|	update_column_specs
		)
		(	'WHERE'
			(	keyCURRENT_OF cursor_name
			|	sql_condition
			)
		)?
		( returning_clause )?
	;

update_column_specs
	:	update_column_spec ( COMMA update_column_spec )*
	;

update_column_spec
	:	column_spec EQ sql_expression
	;

update_nested_column_specs
	:	update_nested_column_spec ( COMMA update_nested_column_spec )*
	;

update_nested_column_spec
	:	LPAREN column_specs RPAREN EQ subquery
	;

delete_command
	:	'DELETE' ( 'FROM' )? selected_table
		(	'WHERE'
			(	keyCURRENT_OF cursor_name
			|	sql_condition
			)
		)?
		( returning_clause )?
	;

returning_clause
	:	( keyRETURN | keyRETURNING ) select_list ( keyBULK keyCOLLECT )? 'INTO' lvalues
	;

set_transaction_command
	:	'SET' keyTRANSACTION keyREAD keyONLY
	;

close_statement
	:	keyCLOSE cursor_name
	;

fetch_statement
	:	'FETCH' cursor_name 'INTO' 
		(	variable_names
		|	record_name
		)
	;

lock_table_statement
	:	'LOCK' 'TABLE' table_reference_list
		'IN' lock_mode 'MODE' ( 'NOWAIT' )?
	;

lock_mode
	:	'ROW' 'SHARE'
	|	'ROW' 'EXCLUSIVE'
	|	'SHARE' 'UPDATE'
	|	'SHARE'
	|	'SHARE' 'ROW' 'EXCLUSIVE'
	|	'EXCLUSIVE'
	;

open_statement
	:	keyOPEN cursor_name ( LPAREN plsql_expressions RPAREN )?
	;

rollback_statement
	:	keyROLLBACK ( keyWORK )?
		( 'TO' ( 'SAVEPOINT' )? savepoint_name )?
		( 'COMMENT' quoted_string )?
	;

savepoint_statement
	:	'SAVEPOINT' savepoint_name
	;

savepoint_name
	:	identifier
	;

identifier
	:	ID
	|	DOUBLEQUOTED_STRING 
//	|	keyword
   	;

quoted_string
	:	QUOTED_STRING
	;

match_string
	:	QUOTED_STRING
	;
keyA                             : {(this.input).LT(1).Text.ToUpper() == "A"}? ID;
keyAUTOMATIC                     : {(this.input).LT(1).Text.ToUpper() == "AUTOMATIC"}? ID;
keyCOUNT                         : {(this.input).LT(1).Text.ToUpper() == "COUNT"}? ID;
keyCROSS                         : {(this.input).LT(1).Text.ToUpper() == "CROSS"}? ID;
keyCUBE                          : {(this.input).LT(1).Text.ToUpper() == "CUBE"}? ID;
keyCURRENT_OF                    : {(this.input).LT(1).Text.ToUpper() == "CURRENT_OF"}? ID;
keyDAY                           : {(this.input).LT(1).Text.ToUpper() == "DAY"}? ID;
keyDBTIMEZONE                    : {(this.input).LT(1).Text.ToUpper() == "DBTIMEZONE"}? ID;
keyDECREMENT                     : {(this.input).LT(1).Text.ToUpper() == "DECREMENT"}? ID;
keyDIMENSION                     : {(this.input).LT(1).Text.ToUpper() == "DIMENSION"}? ID;
keyEMPTY                         : {(this.input).LT(1).Text.ToUpper() == "EMPTY"}? ID;
keyEQUALS_PATH                   : {(this.input).LT(1).Text.ToUpper() == "EQUALS_PATH"}? ID;
keyESCAPE                        : {(this.input).LT(1).Text.ToUpper() == "ESCAPE"}? ID;
keyFIRST                         : {(this.input).LT(1).Text.ToUpper() == "FIRST"}? ID;
keyFULL                          : {(this.input).LT(1).Text.ToUpper() == "FULL"}? ID;
keyGROUPING                      : {(this.input).LT(1).Text.ToUpper() == "GROUPING"}? ID;
keyIGNORE                        : {(this.input).LT(1).Text.ToUpper() == "IGNORE"}? ID;
keyINCREMENT                     : {(this.input).LT(1).Text.ToUpper() == "INCREMENT"}? ID;
keyINFINITE                      : {(this.input).LT(1).Text.ToUpper() == "INFINITE"}? ID;
keyINNER                         : {(this.input).LT(1).Text.ToUpper() == "INNER"}? ID;
keyINTERVAL                      : {(this.input).LT(1).Text.ToUpper() == "INTERVAL"}? ID;
keyITERATE                       : {(this.input).LT(1).Text.ToUpper() == "ITERATE"}? ID;
keyJOIN                          : {(this.input).LT(1).Text.ToUpper() == "JOIN"}? ID;
keyKEEP                          : {(this.input).LT(1).Text.ToUpper() == "KEEP"}? ID;
keyLAST                          : {(this.input).LT(1).Text.ToUpper() == "LAST"}? ID;
keyLEFT                          : {(this.input).LT(1).Text.ToUpper() == "LEFT"}? ID;
keyLIKE2                         : {(this.input).LT(1).Text.ToUpper() == "LIKE2"}? ID;
keyLIKE4                         : {(this.input).LT(1).Text.ToUpper() == "LIKE4"}? ID;
keyLIKEC                         : {(this.input).LT(1).Text.ToUpper() == "LIKEC"}? ID;
keyLOCAL                         : {(this.input).LT(1).Text.ToUpper() == "LOCAL"}? ID;
keyMAIN                          : {(this.input).LT(1).Text.ToUpper() == "MAIN"}? ID;
keyMEASURES                      : {(this.input).LT(1).Text.ToUpper() == "MEASURES"}? ID;
keyMEMBER                        : {(this.input).LT(1).Text.ToUpper() == "MEMBER"}? ID;
keyMODEL                         : {(this.input).LT(1).Text.ToUpper() == "MODEL"}? ID;
keyMONTH                         : {(this.input).LT(1).Text.ToUpper() == "MONTH"}? ID;
keyNAN                           : {(this.input).LT(1).Text.ToUpper() == "NAN"}? ID;
keyNATURAL                       : {(this.input).LT(1).Text.ToUpper() == "NATURAL"}? ID;
keyNAV                           : {(this.input).LT(1).Text.ToUpper() == "NAV"}? ID;
keyNOCYCLE                       : {(this.input).LT(1).Text.ToUpper() == "NOCYCLE"}? ID;
keyNULLS                         : {(this.input).LT(1).Text.ToUpper() == "NULLS"}? ID;
keyONLY                          : {(this.input).LT(1).Text.ToUpper() == "ONLY"}? ID;
keyOUTER                         : {(this.input).LT(1).Text.ToUpper() == "OUTER"}? ID;
keyPARTITION                     : {(this.input).LT(1).Text.ToUpper() == "PARTITION"}? ID;
keyPRECISION                     : {(this.input).LT(1).Text.ToUpper() == "PRECISION"}? ID;
keyPRESENT                       : {(this.input).LT(1).Text.ToUpper() == "PRESENT"}? ID;
keyREFERENCE                     : {(this.input).LT(1).Text.ToUpper() == "REFERENCE"}? ID;
keyREGEXP_LIKE                   : {(this.input).LT(1).Text.ToUpper() == "REGEXP_LIKE"}? ID;
//keyRETURN                        : {(this.input).LT(1).Text.ToUpper() == "RETURN"}? ID;
keyRIGHT                         : {(this.input).LT(1).Text.ToUpper() == "RIGHT"}? ID;
keyROLLUP                        : {(this.input).LT(1).Text.ToUpper() == "ROLLUP"}? ID;
keyRULES                         : {(this.input).LT(1).Text.ToUpper() == "RULES"}? ID;
keySECOND                        : {(this.input).LT(1).Text.ToUpper() == "SECOND"}? ID;
keySECONDS                       : {(this.input).LT(1).Text.ToUpper() == "SECONDS"}? ID;
keySEQUENTIAL                    : {(this.input).LT(1).Text.ToUpper() == "SEQUENTIAL"}? ID;
keySESSIONTIMEZONE               : {(this.input).LT(1).Text.ToUpper() == "SESSIONTIMEZONE"}? ID;
keySETS                          : {(this.input).LT(1).Text.ToUpper() == "SETS"}? ID;
keySIBLINGS                      : {(this.input).LT(1).Text.ToUpper() == "SIBLINGS"}? ID;
keySINGLE                        : {(this.input).LT(1).Text.ToUpper() == "SINGLE"}? ID;
keySOME                          : {(this.input).LT(1).Text.ToUpper() == "SOME"}? ID;
keySUBMULTISET                   : {(this.input).LT(1).Text.ToUpper() == "SUBMULTISET"}? ID;
keyTIME                          : {(this.input).LT(1).Text.ToUpper() == "TIME"}? ID;
keyTIMESTAMP                     : {(this.input).LT(1).Text.ToUpper() == "TIMESTAMP"}? ID;
keyTHE                           : {(this.input).LT(1).Text.ToUpper() == "THE"}? ID;
keyUNDER_PATH                    : {(this.input).LT(1).Text.ToUpper() == "UNDER_PATH"}? ID;
keyUNTIL                         : {(this.input).LT(1).Text.ToUpper() == "UNTIL"}? ID;
keyUPDATED                       : {(this.input).LT(1).Text.ToUpper() == "UPDATED"}? ID;
keyUPSERT                        : {(this.input).LT(1).Text.ToUpper() == "UPSERT"}? ID;
keyWAIT                          : {(this.input).LT(1).Text.ToUpper() == "WAIT"}? ID;
keyYEAR                          : {(this.input).LT(1).Text.ToUpper() == "YEAR"}? ID;
keyZONE                          : {(this.input).LT(1).Text.ToUpper() == "ZONE"}? ID;

keyARRAY                         : {(this.input).LT(1).Text.ToUpper() == "ARRAY"}? ID;
keyAUTONOMOUS_TRANSACTION        : {(this.input).LT(1).Text.ToUpper() == "AUTONOMOUS_TRANSACTION"}? ID;
keyBODY                          : {(this.input).LT(1).Text.ToUpper() == "BODY"}? ID;
keyBUILTIN                       : {(this.input).LT(1).Text.ToUpper() == "BUILTIN"}? ID;
keyBULK                          : {(this.input).LT(1).Text.ToUpper() == "BULK"}? ID;
keyBYTE                          : {(this.input).LT(1).Text.ToUpper() == "BYTE"}? ID;
keyCLOSE                         : {(this.input).LT(1).Text.ToUpper() == "CLOSE"}? ID;
keyCOLLECT                       : {(this.input).LT(1).Text.ToUpper() == "COLLECT"}? ID;
keyCURSOR                        : {(this.input).LT(1).Text.ToUpper() == "CURSOR"}? ID;
keyELSIF                         : 'ELSIF'; //{(this.input).LT(1).Text.ToUpper() == "ELSIF"}? ID;
keyEXCEPTION_INIT                : {(this.input).LT(1).Text.ToUpper() == "EXCEPTION_INIT"}? ID;
keyEXIT                          : {(this.input).LT(1).Text.ToUpper() == "EXIT"}? ID;
keyFIPSFLAG                      : {(this.input).LT(1).Text.ToUpper() == "FIPSFLAG"}? ID;
keyFUNCTION                      : 'FUNCTION'; //{(this.input).LT(1).Text.ToUpper() == "FUNCTION"}? ID;
keyINTERFACE                     : {(this.input).LT(1).Text.ToUpper() == "INTERFACE"}? ID;
keyLOOP                          : 'LOOP'; //{(this.input).LT(1).Text.ToUpper() == "LOOP"}? ID;
keyNEW                           : {(this.input).LT(1).Text.ToUpper() == "NEW"}? ID;
keyNEW_NAMES                     : {(this.input).LT(1).Text.ToUpper() == "NEW_NAMES"}? ID;
keyOPEN                          : {(this.input).LT(1).Text.ToUpper() == "OPEN"}? ID;
keyOUT                           : 'OUT'; //{(this.input).LT(1).Text.ToUpper() == "OUT"}? ID;
keyPACKAGE                       : 'PACKAGE'; //{(this.input).LT(1).Text.ToUpper() == "PACKAGE"}? ID;
keyPRAGMA                        : 'PRAGMA'; //{(this.input).LT(1).Text.ToUpper() == "PRAGMA"}? ID;
keyRAISE                         : 'RAISE'; //{(this.input).LT(1).Text.ToUpper() == "RAISE"}? ID;
keyRANGE                         : {(this.input).LT(1).Text.ToUpper() == "RANGE"}? ID;
keyREAD                          : {(this.input).LT(1).Text.ToUpper() == "READ"}? ID;
keyRECORD                        : 'RECORD'; //{(this.input).LT(1).Text.ToUpper() == "RECORD"}? ID;
keyREF                           : {(this.input).LT(1).Text.ToUpper() == "REF"}? ID;
keyREPLACE                       : {(this.input).LT(1).Text.ToUpper() == "REPLACE"}? ID;
keyRESTRICT_REFERENCES           : {(this.input).LT(1).Text.ToUpper() == "RESTRICT_REFERENCES"}? ID;
keyRETURN                        : 'RETURN'; //{(this.input).LT(1).Text.ToUpper() == "RETURN"}? ID;
keyRETURNING                     : 'RETURNING'; //{(this.input).LT(1).Text.ToUpper() == "RETURNING"}? ID;
keyREVERSE                       : {(this.input).LT(1).Text.ToUpper() == "REVERSE"}? ID;
keyROLLBACK                      : 'ROLLBACK'; //{(this.input).LT(1).Text.ToUpper() == "ROLLBACK"}? ID;
keySERIALLY_REUSABLE             : {(this.input).LT(1).Text.ToUpper() == "SERIALLY_REUSABLE"}? ID;
keySUBTYPE                       : {(this.input).LT(1).Text.ToUpper() == "SUBTYPE"}? ID;
keyTRANSACTION                   : {(this.input).LT(1).Text.ToUpper() == "TRANSACTION"}? ID;
keyTYPE                          : {(this.input).LT(1).Text.ToUpper() == "TYPE"}? ID;
keyUSING                         : {(this.input).LT(1).Text.ToUpper() == "USING"}? ID;
keyVARRAY                        : {(this.input).LT(1).Text.ToUpper() == "VARRAY"}? ID;
keyVARYING                      : {(this.input).LT(1).Text.ToUpper() == "VARYING"}? ID;
keyWHILE                         : 'WHILE'; //{(this.input).LT(1).Text.ToUpper() == "WHILE"}? ID;
keyWORK                          : {(this.input).LT(1).Text.ToUpper() == "WORK"}? ID;

sql_identifier
	:	identifier
	|	'ROWID'
//	|	'ROWNUM'
	;

QUOTED_STRING
	:	( 'n' )? '\'' ( '\'\'' | ~('\'') )* '\''
	;
ID /*options { testLiterals=true; }*/
    :	'A' .. 'Z' ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' )*
    |	DOUBLEQUOTED_STRING
    ;
SEMI
	:	';'
	;
COLON
	:	':'
	;
DOUBLEDOT
	:	POINT POINT
	;
DOT
	:	POINT
	;
fragment
POINT
	:	'.'
	;
COMMA
	:	','
	;
EXPONENT
	:	'**'
	;
ASTERISK
	:	'*'
	;
AT_SIGN
	:	'@'
	;
RPAREN
	:	')'
	;
LPAREN
	:	'('
	;
RBRACK
	:	']'
	;
LBRACK
	:	'['
	;
PLUS
	:	'+'
	;
MINUS
	:	'-'
	;
DIVIDE
	:	'/'
	;
EQ
	:	'='
	;
PERCENTAGE
	:	'%'
	;
LLABEL
	:	'<<'
	;
RLABEL
	:	'>>'
	;
ASSIGN
	:	':='
	;
ARROW
	:	'=>'
	;
VERTBAR
	:	'|'
	;
DOUBLEVERTBAR
	:	'||'
	;
NOT_EQ
	:	'<>' | '!=' | '^='
	;
LTH
	:	'<'
	;
LEQ
	:	'<='
	;
GTH
	:	'>'
	;
GEQ
	:	'>='
	;
NUMBER
	:	//( PLUS | MINUS )?
		(	( N POINT N ) => N POINT N
		|	POINT N
		|	N
		)
		( 'E' ( PLUS | MINUS )? N )?
    ;
fragment
N
	: '0' .. '9' ( '0' .. '9' )*
	;
QUOTE
	:	'\''
	;
fragment
DOUBLEQUOTED_STRING
	:	'"' ( ~('"') )* '"'
	;
WS	:	(' '|'\r'|'\t'|'\n') {$channel=HIDDEN;}
	;
SL_COMMENT
	:	'--' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
	;
ML_COMMENT
	:	'/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
	;
TYPE_ATTR
	:	'%TYPE'
	;
ROWTYPE_ATTR
	:	'%ROWTYPE'
	;
NOTFOUND_ATTR
	:	'%NOTFOUND'
	;
FOUND_ATTR
	:	'%FOUND'
	;
ISOPEN_ATTR
	:	'%ISOPEN'
	;
ROWCOUNT_ATTR
	:	'%ROWCOUNT'
	;
BULK_ROWCOUNT_ATTR
	:	'%BULK_ROWCOUNT'
	;
CHARSET_ATTR
	:	'%CHARSET'
	;
