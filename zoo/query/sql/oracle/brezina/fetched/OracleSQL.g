/*******************************************************************************

DESCRIPTION:
		Grammar for Oracle's SELECT statement for ANTLR v3, target C language		
AUTHOR:
		Ivan.Brezina (ibre5041@ibrezina.net)
DATE:
		MAY 2011
BASED ON:
		PLSQL3.g Andrey Kharitonkin (thikone@gmail.com)
		PLSQLGrammar.g for ANTLR v2
		Qazi Firdous Ahmed (qazif_ahmed@infosys.com) 
		Krupa Benhur (krupa_bg@infosys.com)
		Manojaba Banerjee (manojaba_banerjee@infosys.com)
		Infosys Technologies Ltd., Bangalore, India
		Sept 18, 2002
		This grammar is for PL/SQL.
COMMENT:
		This grammar file is based on freely downloadable
		file PLSQL3.g. I extracted only those rules that
		are mandatory for DML statements. PL/SQL support was removed
		and should be handled by a separate grammar.
		This grammar was tested on a quite large set of SQL statements
		and handles many "undocumented" Oracle's behaviours.
ORIGINAL COMMENT:
		The grammar has been mostly re-written for ANTLR v3,
		using Oracle 10g Release 2 documentation and ANTLR book.
		New SQL and PL/SQL expression rules, SQL statments
		SELECT, INSERT, UPDATE, DELETE are fully supported.
		Generated parser can parse most of valid PL/SQL and 
		it was tested with over 10 Mb of test source code.
		Let me know if something cannot be parsed by this grammar.
KNOWN ISSUES:
		XQUERIES are unsupported.
		Some keywords are treated as reserved ones. If you really insist on idetifiers
			like: MODEL, JOIN, OUTER or PARTITION put them into double quotes. 
		"AS OF SNAPSHOT(:X)" construct is not supported yet.
		Some build-in functions having non-standart calling convention
			are unsupported too.
*******************************************************************************/

grammar OracleSQL;

options {
	language=C;
	backtrack=true;
	memoize=true;
	output=AST;
}

tokens {
    T_UNKNOWN = 't_unknown';
    T_RESERVED = 't_reserved';
    // Identifier subtypes AST leafs 
    T_TABLE_ALIAS = 't_table_alias';
    T_COLUMN_ALIAS = 't_column_alias';
    T_COLUMN_NAME = 't_column_name';
    T_TABLE_NAME = 't_table_name';
    T_SCHEMA_NAME = 't_schema_name';
    T_FUNCTION_NAME = 't_function_name';
    T_PACKAGE_NAME = 't_package_name';
    T_DBLINK_NAME = 't_dblink_name';
    T_BINDVAR_NAME = 't_bindvar_name';

    //Alias type(declaration, usage)
    T_DECL = 't_decl';
    T_USE  = 't_use';
    
    //Tree nodes
    T_WITH = 't_with';
    T_SELECT = 't_select'; 
    T_SUBQUERY = 't_subquery';   
    T_TABLE_CAST = 't_table_cast';
    T_COLUMN_LIST = 't_column_list';
    T_SELECT_COLUMN = 't_select_column';
    T_FROM = 't_from';
    //T_SELECTED_TABLE = 'selected_table';
    T_WHERE = 't_where';
    T_HIERARCHICAL = 't_hierarchical';
    T_GROUP_BY = 't_group_by';
    T_MODEL = 't_model';
    T_UNION = 't_union';
    T_ORDER_BY_CLAUSE='t_order_by';
    T_FOR_UPDATE_CLAUSE='t_for_update';

    T_OPERATOR_UNARY='t_operator_unary';
    T_OPERATOR_BINARY='t_operator_binary';
    T_OPERATOR_PART='t_operator_part';
    T_COND_OR='t_cond_or';
    T_COND_OR_SEQ='t_cond_or_seq';
    T_COND_AND='t_cond_and';
    T_COND_AND_SEQ='t_cond_and_seq';
    T_COND_NOT='t_cond_not';
    T_COND_EXISTS='t_cond_exists';
    T_COND_IS='t_cond_is';
    T_COND_COMPARISON='t_cond_comparison';
    T_COND_GROUP_COMPARISON='t_cond_group_comparison';
    T_COND_IN='t_cond_in';
    T_COND_IS_A_SET='t_cond_is_a_set';
    T_COND_IS_ANY='t_cond_is_any';
    T_COND_IS_EMPTY='t_cond_is_empty';
    T_COND_IS_OF_TYPE='t_cond_is_of_type';
    T_COND_IS_PRESENT='t_cond_is_present';
    T_COND_LIKE='t_cond_like';
    T_COND_MEMEBER='t_cond_memeber';
    T_COND_BETWEEN='t_cond_between';
    T_COND_REGEXP_LIKE='t_cond_regexp_like';
    T_COND_SUBMULTISET='t_cond_submultiset';
    T_COND_EQUALS_PATH='t_cond_equals_path';
    T_COND_UNDER_PATH='t_cond_under_path';
    T_COND_PAREN='t_cond_paren';
}

@lexer::includes {
#include "macros.h"
#include "error_handler.h"
}

@parser::includes {
#include "macros.h"
#include "error_handler.h"
}
        
@lexer::apifuncs {
//            RECOGNIZER->displayRecognitionError = myDisplayRecognitionLexerError;
}

@parser::apifuncs {
//            RECOGNIZER->displayRecognitionError = myDisplayRecognitionParserError;
}
        
start_rule
	: (
            select_statement
        |	update_statement
        |	insert_statement
        |	merge_statement
        |	delete_statement            
        )            
        (SEMI|EOF)
        ;      
/* ================================================================================
   DELETE Statement
   ================================================================================ */
delete_statement
    : r_delete r_from?
        (
            dml_table_expression_clause
        |      k_only LPAREN dml_table_expression_clause RPAREN
        )
        t_alias[T_DECL]? where_clause? returning_clause? error_logging_clause?
    ;

/* ================================================================================
   MERGE Statement
   ================================================================================ */
merge_statement
	: k_merge r_into (schema_name DOT)? table_name t_alias[T_DECL]?
        k_using
        (
            subquery
        |	(schema_name DOT)? table_name
        )
        t_alias[T_DECL]? r_on LPAREN sql_condition RPAREN
        (
            (k_when k_matched) => merge_update_clause merge_insert_clause?
        |
            (k_when r_not k_matched) => merge_insert_clause merge_update_clause?
        )?
        error_logging_clause?
    ;

merge_update_clause
	: k_when k_matched r_then r_update r_set column_spec EQ (r_default | sql_expression)
        (COMMA column_spec EQ (r_default | sql_expression))*
        where_clause? (r_delete where_clause)?
    ;

merge_insert_clause
	: k_when r_not k_matched r_then r_insert (LPAREN column_specs RPAREN)?
        r_values LPAREN (r_default | sql_expression) (COMMA (r_default | sql_expression))* RPAREN
        where_clause? 
    ;

/* ================================================================================
   INSERT Statement
   ================================================================================ */
insert_statement
	: r_insert (single_table_insert | multi_table_insert)
    ;
single_table_insert
	: insert_into_clause ( values_clause returning_clause? | select_statement | subquery ) error_logging_clause?
    ;
insert_into_clause
	: r_into dml_table_expression_clause t_alias[T_DECL]? ( LPAREN column_specs RPAREN )?
	;
values_clause
	: r_values LPAREN ( r_default | sql_expression) ( COMMA (r_default | sql_expression))* RPAREN
    ;
returning_clause
    : ( k_return | k_returning ) sql_expression (COMMA sql_expression)* r_into data_item (COMMA data_item)*
    ;
multi_table_insert
	: (
            r_all ( insert_into_clause values_clause? error_logging_clause? )+
        |   conditional_insert_clause
        )
        subquery
    ;
conditional_insert_clause
	: ( r_all | k_first )?
        ( k_when sql_condition r_then ( insert_into_clause values_clause? )+ )+
        r_else ( insert_into_clause values_clause? )+
    ;
dml_table_expression_clause
	:	
		( schema_name DOT)? table_name ( partition_extension_clause | AT_SIGN dblink_name)?
	|	subquery subquery_restricrion_clause? (pivot_clause|unpivot_clause)?
	|	LPAREN subquery subquery_restricrion_clause? RPAREN
	|	table_collection_clause
	;
error_logging_clause
	: k_log k_errors ( r_into (schema_name DOT)? table_name)? (LPAREN simple_expression RPAREN)? (k_reject k_limit (NUMBER | k_unlimited))?
    ;
data_item
	: sql_identifier[T_UNKNOWN,0]
    | bind_variable
    ;

/* ================================================================================
   UPDATE Statement
   ================================================================================ */
update_statement
	: r_update ( k_only LPAREN dml_table_expression_clause RPAREN | dml_table_expression_clause) t_alias[T_DECL]?
		update_set_clause where_clause? returning_clause? error_logging_clause?;

update_set_clause
	: r_set
        (
            k_value LPAREN t_alias[T_DECL] RPAREN EQ ( sql_expression | subquery)
        |	(
                (update_set_clause_part1 | update_set_clause_part2 )
            	(COMMA (update_set_clause_part1 | update_set_clause_part2))*
            )
        )
    ;
update_set_clause_part1
	:	LPAREN column_specs RPAREN EQ subquery
    ;
update_set_clause_part2
	:	column_spec EQ ( r_default | subquery | sql_expression)
	;	
/* ================================================================================
   SELECT Statement
   ================================================================================ */
select_statement
	:
	subquery_factoring_clause?
	(
	(    
	sel=r_select /*( hint )?*/ ( r_distinct | r_unique| r_union | r_all )? select_list
	( r_into data_item (COMMA data_item)*)?
	r_from
//        ( table_reference_list | join_clause | LPAREN join_clause RPAREN )
	table_reference_list        
	( where_clause )?
	( hierarchical_query_clause )?
	( group_by_clause )?
	( (k_model (k_main|k_partition|k_dimension) ) => model_clause )?
	( union_clause )*
	( fu1=for_update_clause )?        
	( order_by_clause )?
	( fu2=for_update_clause )?
	->	^('t_select'
		subquery_factoring_clause?
		$sel r_distinct? r_unique? r_union? r_all?            
		select_list
		^('t_from' r_from table_reference_list/*? join_clause?*/)
		where_clause?
		hierarchical_query_clause?
		group_by_clause?
		model_clause?
		union_clause*
 		$fu1?    
		order_by_clause?
		$fu2?
		)
    )
    | subquery -> ^('t_subquery' subquery)
	)
	;
/* ================================================================================
   subquery factoring
   ================================================================================ */
subquery_factoring_clause
	:
	with=r_with
// NOTE: these two lines were commented out just to preserve COMMAs in parse tree        
//	si1=sql_identifier[T_UNKNOWN,0] (lp1=LPAREN sl1=select_list rp1=RPAREN)? as1=r_as sq1=subquery  
//	(COMMA si2=sql_identifier[T_UNKNOWN,0] (lp2=LPAREN sl2=select_list rp2=RPAREN)? as2=r_as sq2=subquery)*
	subquery_factoring_clause_part_first subquery_factoring_clause_part_next*
	search_clause?
	cycle_clause?
		->^('t_with' $with subquery_factoring_clause_part_first subquery_factoring_clause_part_next* search_clause? cycle_clause?)
    ;
subquery_factoring_clause_part_first
	:	t_alias[T_DECL] (LPAREN select_list RPAREN)? r_as subquery
    ;
subquery_factoring_clause_part_next
	:	COMMA t_alias[T_DECL] (LPAREN select_list RPAREN)? r_as subquery
    ;

search_clause
	: k_search ( k_depth | k_breadth ) k_first r_by
 	( c_alias r_asc ? r_desc ? (k_nulls k_first)? (k_nulls k_last)? )
 	( COMMA c_alias r_asc ? r_desc ? (k_nulls k_first)? (k_nulls k_last)? )*
	r_set sql_identifier[T_UNKNOWN,0]
	;

cycle_clause
	: k_cycle c_alias ( COMMA c_alias)* r_set sql_identifier[T_UNKNOWN,0] r_to literal r_default literal
	;

/* ================================================================================
   Query column list specs (ie. everything between "SELECT" ... "FROM"
   ================================================================================ */
select_list
//	: displayed_column (COMMA displayed_column)*
	: displayed_column_part_first displayed_column_part_next*
		-> ^('t_column_list' displayed_column_part_first displayed_column_part_next*)
	;
displayed_column_part_first
	: displayed_column
    ;
displayed_column_part_next
	: c=COMMA displayed_column
    ;        
displayed_column
	: (
        asterisk1=ASTERISK
		| (schema_name d1=DOT)? table=t_alias[T_USE] d2=DOT asterisk2=ASTERISK
		| sql_expression
		)   
		c_alias?
        -> ^('t_select_column' $asterisk1? schema_name? $d1? $table? $d2? $asterisk2? sql_expression? c_alias? )
    ;
sql_expression
	:	expr_add
	;
expr_add
	:	expr_mul ( ( PLUS | MINUS | doublevertbar ) expr_mul )*
	;
expr_mul
	:	expr_sign ( ( ASTERISK | DIVIDE ) expr_sign )*
	;
expr_sign // in fact this is not "sign" but unary operator
	:	( PLUS | MINUS | r_prior | k_connect_by_root )? expr_expr
	;
expr_expr
	:	(extract_datetime_expression) => extract_datetime_expression
	|	interval_x_to_y
	|	datetime_expression
	|	interval_expression
	|	( expr_paren ) => expr_paren
	|	( k_cursor LPAREN ) => cursor_expression 
	|	( k_cast LPAREN) => cast_expression
	|	( k_cluster_set LPAREN ) => special_expression
	|	object_access_expression
	|	( case_expression ) => case_expression
	|	( special_function ) => special_function
	|	( analytic_function ) => analytic_function
	|	( aggregate_function ) => aggregate_function
	|	( function_expression ) => function_expression
//	|	( compound_expression ) => compound_expression
	|	( simple_expression ) => simple_expression
//	|	( select_expression ) => select_expression replaced with subquery
//	|	scalar_subquery_expression
//	|	model_expression
//	|	type_constructor_expression
//	|	variable_expression
//	:	r_null | NUMBER | QUOTED_STRING | IDENTIFIER
	|	( LPAREN (r_select | r_with ) ) => subquery
	;
expr_paren
	:	LPAREN nested_expression RPAREN
	;
nested_expression
	:	sql_expression
	;
function_expression
 	:	(function_spec|analytic_function_name) LPAREN call_parameters? RPAREN
	;

call_parameters
	: ASTERISK
	| call_parameter ( COMMA call_parameter )*
	;
call_parameter
	:	 ( parameter_name ARROW )? nested_expression
	;
parameter_name
	:	identifier[T_UNKNOWN,0]
	;
// This rule repsents some of Oracle's internal functions with non-common calling convention
// like: TRIM( BOTH ' ' FROM X)
// look at aggregate_function and analytic_function for other examples
// TODO: VARIANCE, VAR_SAMP, VAR_POP, TREAT, TRANSLATE, SUM, STDDEV_SAMP, STDDEV_POP, STDDEV, ROW_NUMBER,
// REGR_*, RATIO_TO_REPORT, PREDICTION_SET, PREDICTION_PROBABILITY, PREDICTION_DETAILS, PREDICTION_COST,
// PREDICTION_BOUNDS, PREDICTION, NTILE, NTH_VALUE, MIN, MEDIAN, MAX, LNNVL, LISTAGG, LEAD, LAST_VALUE,
// LAST, LAG, FIRST_VALUE, FIRST, FEATURE_VALUE, FEATURE_SET, FEATURE_ID, DECOMPOSE, CUME_DIST, CUBE_TABLEC,
// COVAR_SAMP, COVAR_POP, COUNT, CORR, COLLECT, CLUSTER_SET, CLUSTER_PROBABILITY, CLUSTER_ID, CHR, CAST,
// AVG, 
special_function
	:
	(	
        k_trim
        LPAREN
			( ( k_leading | k_trailing | k_both)? QUOTED_STRING? r_from )?
			sql_expression
        RPAREN
	)
	| (r_set LPAREN sql_expression RPAREN)
	| (k_lnnvl LPAREN sql_condition RPAREN)	
    ;

case_expression
	:	r_case ( simple_case_expression | searched_case_expression ) ( else_case_expression )? k_end
	;
cursor_expression
	:	k_cursor subquery
	;
simple_case_expression
	:	nested_expression ( k_when nested_expression r_then nested_expression )+
	;
searched_case_expression
	:	( k_when sql_condition r_then nested_expression )+
	;
else_case_expression
	:	r_else nested_expression
	;

object_access_expression
	:
	(
		LPAREN sql_expression RPAREN DOT
	|	table_name DOT
	|	function_expression DOT
	)
	(identifier[T_UNKNOWN,0] DOT)*
	function_expression
	;
simple_expression
	:	boolean_literal
	|	k_sql ( FOUND_ATTR | NOTFOUND_ATTR | ISOPEN_ATTR | ROWCOUNT_ATTR | BULK_ROWCOUNT_ATTR )
	|	( cell_assignment ) => cell_assignment // this is used only in model_clause s[PROD= 'A' ] = S[ 'a' ] + 1
	|	( column_spec ) => column_spec
	|	timestamp_expression        
	|	quoted_string
	|	NUMBER
	;        
query_block
	:	r_select /*( hint )?*/ ( r_distinct | r_unique | r_all )? select_list
		r_from table_reference_list
		( where_clause )?
		( hierarchical_query_clause )?
		( group_by_clause )?
        ( (k_model (k_main|k_partition|k_dimension) ) => model_clause )?
	;
// a subquery can be followed by same statements like SELECT rule
subquery
	:	LPAREN select_statement RPAREN
        ( group_by_clause )?
        ( (k_model (k_main|k_partition|k_dimension) ) => model_clause )?
        ( union_clause )*
        ( fu1=for_update_clause )?        
        ( order_by_clause )?
        ( fu2=for_update_clause )?
	|	LPAREN subquery RPAREN
        ( group_by_clause )?
        ( (k_model (k_main|k_partition|k_dimension) ) => model_clause )?
        ( union_clause )*
        ( fu1=for_update_clause )?        
        ( order_by_clause )?
        ( fu2=for_update_clause )?        
	;

timestamp_expression
	:	(r_date | k_timestamp) quoted_string
    ;
interval_x_to_y
	: k_interval
        (
            (
                ( quoted_string | bind_variable)
                ( k_year | k_month )
                ( LPAREN precision RPAREN )?
                ( k_to (k_year | k_month ))?
            )
        |
            (   
                ( quoted_string | bind_variable)
                ( k_day | k_hour | k_minute | k_second )
                (LPAREN precision (COMMA precision)? RPAREN)?
                (k_to ( k_day | k_hour | k_minute | k_second ) (LPAREN precision RPAREN)? )?
            )
        )
	;
precision
	: NUMBER
    | bind_variable
	;

extract_datetime_expression
	:	k_extract
        LPAREN
        (	k_year
        |	k_month
        |	k_day
        |	k_hour
        |	k_minute
        |	k_second
        |	k_timezone_hour
        |	k_timezone_minute
        |	k_timezone_region
        |	k_timezone_abbr
        )
        r_from
        sql_expression
        RPAREN
    ;
datetime_expression
	:
        ( function_expression | cast_expression | simple_expression )
        k_at (k_local | k_time k_zone ( quoted_string | k_dbtimezone | k_sessiontimezone | sql_expression ));

interval_expression
	:
		LPAREN ( function_expression | cast_expression | simple_expression ) MINUS ( function_expression | cast_expression | simple_expression ) RPAREN
		(	k_day (LPAREN NUMBER RPAREN)? r_to k_second (LPAREN NUMBER RPAREN)?
		|	k_year (LPAREN NUMBER RPAREN)? r_to k_month (LPAREN NUMBER RPAREN)?
		)
	;
/* ================================================================================
   Special expressions
   ================================================================================ */
special_expression
	:	cluster_set_clause
	;        
cluster_set_clause
	:	k_cluster_set LPAREN column_spec (COMMA column_spec)? (COMMA NUMBER)? k_using (column_specs|ASTERISK) RPAREN
	;

cast_expression
	:	k_cast LPAREN (sql_expression | k_multiset subquery) r_as (datatype_name|column_spec) RPAREN
	;	
datatype_name
	:	k_binary_integer 
	|	k_binary_float
	|	k_binary_double
	|	k_natural
	|	k_positive
	|	( r_number | k_numeric | r_decimal | k_dec ) ( LPAREN NUMBER ( COMMA NUMBER )? RPAREN )?
	|	r_long ( r_raw)? ( LPAREN NUMBER RPAREN )?
	|	r_raw ( LPAREN NUMBER RPAREN )?
	|	k_boolean
	|	r_date
	|	k_interval k_day ( LPAREN NUMBER RPAREN )? r_to k_second ( LPAREN NUMBER RPAREN )?
	|	k_interval k_year ( LPAREN NUMBER RPAREN )? r_to k_month
	|	( k_time | k_timestamp ) ( LPAREN NUMBER RPAREN )? ( r_with ( k_local )? k_time k_zone )?
	|	r_integer
	|	k_int
	|	r_smallint
	|	r_float ( LPAREN NUMBER RPAREN )?
	|	k_real
	|	k_double k_precision
	|	r_char      ( k_varying )? ( LPAREN NUMBER ( k_byte | r_char )? RPAREN )? ( k_character r_set ( identifier[T_UNKNOWN,0] | column_spec CHARSET_ATTR ) )?
	|	r_varchar                  ( LPAREN NUMBER ( k_byte | r_char )? RPAREN )? ( k_character r_set ( identifier[T_UNKNOWN,0] | column_spec CHARSET_ATTR ) )?
	|	r_varchar2                 ( LPAREN NUMBER ( k_byte | r_char )? RPAREN )? ( k_character r_set ( identifier[T_UNKNOWN,0] | column_spec CHARSET_ATTR ) )?
	|	k_character ( k_varying )? ( LPAREN NUMBER RPAREN )?
	|	k_nchar     ( k_varying )? ( LPAREN NUMBER RPAREN )?
	|	k_nvarchar  ( LPAREN NUMBER RPAREN )?
	|	k_nvarchar2 ( LPAREN NUMBER RPAREN )?
	|	k_national  ( k_character | r_char ) ( k_varying )? ( LPAREN NUMBER RPAREN )?
	|	k_mlslabel
	|	k_pls_integer
	|	k_blob
	|	k_clob ( k_character r_set ( identifier[T_UNKNOWN,0] | column_spec CHARSET_ATTR ) )?
	|	k_nclob
	|	k_bfile
	|	r_rowid 
	|	k_urowid ( LPAREN NUMBER RPAREN )?
	;

boolean_literal
	:	r_true | r_false
	;

t_alias[int aliasUsage]
	:	sql_identifier[T_TABLE_ALIAS,aliasUsage]
	;

c_alias
	:	r_as? sql_identifier[T_COLUMN_ALIAS,T_DECL]
	|	r_as
	;

column_spec
	: ((schema_name DOT)? t_alias[T_USE] DOT)? column_name outer_join_sign?
	// In fact with nested objects sequence of identifiers and DOT can be "infinite"
	| schema_name DOT package_name DOT identifier[T_UNKNOWN,0] DOT identifier[T_UNKNOWN,0]
	| pseudo_column
	| bind_variable
	;

//TODO more pseudocolumns here - especially those who are reserved words
pseudo_column
	: r_null
    | r_sysdate
    | r_user
//	| r_rowid
//	| r_rownum
	| r_level				// hierarchical query
	// | k_connect_by_isleaf
	// | k_connect_by_iscycle
	// | k_versions_starttime	// flashback query
	// | k_versions_starscn
	// | k_versions_endtime
	// | k_versions_endscn 
	// | k_versions_xid 
	// | k_versions_operation
	// | k_column_value	// XMLTABLE query
	// | k_object_id		// 
	// | k_object_value	//
	// | k_ora_rowscn		//
	// | k_xmldata
	;

function_name
	: sql_identifier[T_FUNCTION_NAME,0]
    ;

function_spec
 	: schema_name DOT package_name DOT function_name
	| schema_name DOT function_name
	| function_name
	;

identifier[int identifierClass, int usageType]
	:	i=ID                  { $i->user1 = identifierClass; $i->user2 = usageType; }
	;
// NOTE there can a space between COLON and identifier like ': 2'
bind_variable
 	:	i=BINDVAR             { $i->user1 = T_BINDVAR_NAME; $i->user2 = 0; }
	|	c=COLON               { $c->user1 = T_BINDVAR_NAME; $c->user2 = 0; }
		n=NUMBER              { $n->user1 = T_BINDVAR_NAME; $n->user2 = 0; }
	;

sql_identifier[int identifierClass, int usageType]
	:	i=identifier[identifierClass, usageType]
	|	k=keyword[identifierClass, usageType]
	|	ri=r_rowid 
	|	rn=r_rownum
	;

/* ================================================================================
   Query tables specs (ie. everything between "FROM" ... "WHERE"
   ================================================================================ */
table_reference_list
	:	(
			(join_clause|table_reference) (COMMA (join_clause|table_reference))*
		)
//	->('t_from' join_clause? LPAREN? join_clause? RPAREN? table_reference?
//                (COMMA (join_clause|(LPAREN join_clause RPAREN)|table_reference))*
//	)   
	;            
table_reference
	:	((k_only LPAREN query_table_expression RPAREN)
	|	query_table_expression /*( pivot_clause | unpivot_clause )?*/) flashback_query_clause? t_alias[T_DECL]?
	;
query_table_expression
	:	//query_name
		( schema_name DOT)? table_name ( partition_extension_clause | AT_SIGN dblink_name)? sample_clause? (pivot_clause|unpivot_clause)?
	|	subquery subquery_restricrion_clause? (pivot_clause|unpivot_clause)?
	|	LPAREN subquery subquery_restricrion_clause? (pivot_clause|unpivot_clause)? RPAREN
//TODO add subquery_restricrion_clause into subquery
	|	table_collection_clause (pivot_clause|unpivot_clause)?
	;
flashback_query_clause
	:	( k_versions r_between ( k_scn |k_timestamp) (sql_expression| k_mivalue ) r_and (sql_expression| k_maxvalue ))?
		r_as r_of ( k_scn |k_timestamp) sql_expression
	;
sample_clause
	:	k_sample k_block ? LPAREN sample_percent (COMMA sample_percent)? RPAREN ( k_seed LPAREN seed_value RPAREN)?
	;
partition_extension_clause
	:	k_partition (( LPAREN partition RPAREN ) | ( r_for LPAREN partition_key_value (COMMA partition_key_value)* RPAREN))
    |	k_subpartition (( LPAREN partition RPAREN ) | ( r_for LPAREN subpartition_key_value (COMMA subpartition_key_value)* RPAREN))
	;
subquery_restricrion_clause
	:	r_with ((k_read k_only) | (r_check r_option ( k_constraint constraint)?))
	;
table_collection_clause
	:	( r_table | k_the ) /*LPAREN*/ collection_expression /*RPAREN*/ outer_join_sign?
        -> ^('t_table_cast' r_table? k_the? collection_expression outer_join_sign?)
    ;
join_clause
	:	(LPAREN join_clause RPAREN|table_reference) (inner_cross_join_clause|outer_join_clause)+
    |   LPAREN join_clause RPAREN
	;
inner_cross_join_clause
	:	k_inner? k_join table_reference ((r_on sql_condition)|(k_using LPAREN column_specs RPAREN))*
    |	(k_cross | k_natural k_inner?) (k_join table_reference)
	;        
outer_join_clause
	:	( query_partition_clause )?
		(	outer_join_type k_join
		|	k_natural ( outer_join_type )? k_join
		)
		table_reference ( query_partition_clause )? ( r_on sql_condition | k_using LPAREN column_specs RPAREN )?
	;
query_partition_clause
	:	k_partition r_by expression_list
	;
outer_join_type
 	:	( k_full | k_left | k_right ) ( k_outer )?
	;        

sample_percent
	:	NUMBER
	|	bind_variable
	;
seed_value
	:	NUMBER
	|	bind_variable        
	;
outer_join_sign
	:	LPAREN PLUS RPAREN
	;
table_name
	:	sql_identifier[T_TABLE_NAME,0]
	;
schema_name
	:	sql_identifier[T_SCHEMA_NAME,0]
	;
package_name
	:	sql_identifier[T_PACKAGE_NAME,0]
	;
dblink_name
 	:	sql_identifier[T_DBLINK_NAME,0]
 	;
column_specs
	:	column_spec ( COMMA column_spec )*
	;
partition
	:	identifier[T_UNKNOWN,0]        
	;
partition_key_value
	:	identifier[T_UNKNOWN,0] | NUMBER
	;
subpartition_key_value
	:	identifier[T_UNKNOWN,0] | NUMBER
	;
constraint
	:	sql_identifier[T_UNKNOWN,0]
	;
collection_expression
	: subquery
    | LPAREN (cast_expression|function_expression) RPAREN
    | LPAREN column_spec RPAREN /* TODO collection constructor (+) */
	;

// here start original JOIN related rules
// I left them for historical reasons. For example I could not find any reference
// for the keyword "THE" in the latest 11gR2 SQL reference
// table_reference_list
// 	:	selected_table ( COMMA selected_table )* (pivot_clause|unpivot_clause)?
// 	;
// join_clause
// 	:	table_name c_alias? ( inner_cross_join_clause | outer_join_clause )+
// 	;
// inner_cross_join_clause
// 	:	( k_inner )? k_join table_name c_alias? ( r_on sql_condition | k_using LPAREN column_specs RPAREN )
// 	|	( k_cross | k_natural ( k_inner ) ) k_join table_name c_alias?
// 	;
// outer_join_clause
// 	:	( query_partition_clause )?
// 		(	outer_join_type k_join
// 		|	k_natural ( outer_join_type )? k_join
// 		)
// 		table_name c_alias? ( query_partition_clause )?
// 		( r_on sql_condition | k_using LPAREN column_specs RPAREN )?
// 	;
// column_specs
// 	:	column_spec ( COMMA column_spec )*
// 	;
// query_partition_clause
// 	:	k_partition r_by expression_list
// 	;
// outer_join_type
// 	:	( k_full | k_left | k_right ) ( k_outer )?
// 	;
// outer_join_sign
// 	:	LPAREN PLUS RPAREN
// 	;
// selected_table
// 	:	( table_spec | ( r_table | k_the )? subquery ) (alias|alias_name=sql_identifier[T_UNKNOWN])?
//         -> ^('selected_table' table_spec? r_table? k_the? subquery? alias? $alias_name? )
// 	;

// table_spec
// 	:	( schema_name DOT )? table_name ( AT_SIGN link_name )?
// 		-> ^('selected_table' schema_name? DOT? table_name? AT_SIGN? link_name?)
// 	|	table_cast
// 		-> ^('selected_table' table_cast)
// 	;

// schema_name
// 	:	sql_identifier[T_UNKNOWN]
// 	;
// table_name
// 	:	sql_identifier[T_UNKNOWN]
// 	;
// table_alias
// 	:	( schema_name DOT )? table_name ( AT_SIGN link_name )? ( alias )?
// 	;
// link_name
// 	:	sql_identifier[T_UNKNOWN]
// 	;
// table_cast
// 	:	r_table LPAREN (simple_expression | select_expression | cast_expression) RPAREN
//     ;

/* ================================================================================
   where clause
   ================================================================================ */
where_clause
	:	r_where sql_condition
        -> ^( 't_where' r_where sql_condition)
	;
/* ================================================================================
   hierarchical query clause
   ================================================================================ */
hierarchical_query_clause
	:	r_connect r_by ( k_nocycle )? connect1=sql_condition ( r_start r_with start1=sql_condition )?
	-> ^('t_hierarchical' r_connect r_by k_nocycle? $connect1 r_start? r_with? $start1?)
	|	( r_start r_with start2=sql_condition ) r_connect r_by ( k_nocycle )? connect2=sql_condition
	-> ^('t_hierarchical' r_start r_with $start2 r_connect r_by k_nocycle? $connect2)
	;

/* ================================================================================
   group by clause
   ================================================================================ */
group_by_clause
    :	(r_having) => ( h1=r_having c1=sql_condition (g1=r_group b1=r_by e1=group_by_exprs)? )
    |	(r_group) =>  ( g2=r_group b2=r_by e2=group_by_exprs (h2=r_having c2=sql_condition)? )
	-> ^('t_group_by' $h1? $c1? $g1? $b1? $e1? $g2? $b2? $e2? $h2? $c2?)
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
	:	( k_rollup | k_cube ) LPAREN grouping_expression_list RPAREN
	;
grouping_sets_clause
	:	k_grouping k_sets LPAREN grouping_sets_expression_list RPAREN
	;
grouping_sets_exprs
	:	grouping_sets_expr ( COMMA grouping_sets_expr )*
	;
grouping_sets_expr
	:	rollup_cube_clause | grouping_expression_list
	;
sql_condition
	:	condition_or
	;
condition_or
	:	condition_and ( r_or condition_and )* ->^(T_COND_OR_SEQ condition_and ^(T_COND_OR r_or condition_and)*)
//	:	condition_and ( r_or condition_and )+ ->^(T_COND_OR_SEQ ^(T_COND_OR condition_not r_or)*)
//	|	condition_and
	;
condition_and
	:	condition_not ( r_and condition_not )* ->^(T_COND_AND_SEQ condition_not ^(T_COND_AND r_and condition_not)*)
//	:	condition_not ( r_and condition_not )+ ->^(T_COND_AND_SEQ ^(T_COND_AND condition_not r_and)*)
//	|	condition_not
	;
condition_not
	:	r_not condition_expr -> ^(T_COND_NOT r_not condition_expr)
	|	condition_expr
	;
condition_expr
	:	(r_exists) => condition_exists
//	|	(LPAREN+ sql_condition) => condition_paren
	|	(LPAREN sql_condition) => condition_paren
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
	:	r_exists subquery
	;
condition_is
	:	column_spec outer_join_sign? r_is ( r_not )? ( k_nan | k_infinite | r_null )
	|	sql_expression  r_is ( r_not )? ( k_nan | k_infinite | r_null )
	;
condition_comparison
@after {
 	pANTLR3_BASE_TREE pRoot = retval.tree;
     if(retval.start != 0 && pRoot != 0) { pRoot->u = (void*)T_OPERATOR_BINARY; }
}
	:
        LPAREN sql_expressions RPAREN o1=outer_join_sign? ( EQ | not_equal ) subquery o2=outer_join_sign?
        -> ^(T_OPERATOR_BINARY LPAREN sql_expressions RPAREN $o1? EQ? not_equal? subquery $o2?)
    |
        rp1=r_prior? se1=sql_expression o1=outer_join_sign? ( EQ | not_equal | GTH | geq | LTH | leq ) rp2=r_prior? ( se2=sql_expression | LPAREN select_statement RPAREN ) o2=outer_join_sign?
    	-> ^(T_OPERATOR_BINARY $rp1? $se1 $o1? EQ? not_equal? GTH? geq? LTH? leq? $rp2? $se2? LPAREN? select_statement? RPAREN? $o2?)
	;
condition_group_comparison
	:	LPAREN sql_expressions RPAREN ( EQ | not_equal ) ( r_any | k_some | r_all ) LPAREN ( grouping_expression_list | select_statement ) RPAREN
	|	sql_expression ( EQ | not_equal | GTH | geq | LTH | leq ) ( r_any | k_some | r_all ) LPAREN ( sql_expressions | select_statement ) RPAREN
	;
condition_in
 	:	LPAREN sql_expressions RPAREN ( r_not )? r_in LPAREN ( grouping_expression_list | select_statement ) RPAREN
	|	sql_expression ( r_not )? r_in LPAREN ( expression_list | select_statement ) RPAREN        
	|	sql_expression ( r_not )? r_in sql_expression
	;
condition_is_a_set
	:	nested_table_column_name r_is ( r_not )? k_a r_set
	;
condition_is_any
	:	( column_name r_is )? r_any
	;
condition_is_empty
	:	nested_table_column_name r_is ( r_not )? k_empty
	;
condition_is_of_type
	:	sql_expression r_is (r_not)? r_of ( k_type )? LPAREN type_names RPAREN
	;
// condition_is_of_type_names
// 	:	condition_is_of_type_name ( COMMA condition_is_of_type_name )*
// 	;
// condition_is_of_type_name
// 	:	( k_only )? type_name
// 	;
condition_is_present
	:	cell_reference r_is k_present
	;
condition_like
	:	sql_expression ( r_not )? ( r_like | k_likec | k_like2 | k_like4 ) sql_expression ( k_escape sql_expression )?
	;
condition_memeber
	:	sql_expression ( r_not )? k_member ( r_of )? (function_expression|nested_table_column_name)
	;
condition_between
	:	sql_expression ( r_not )? r_between sql_expression r_and sql_expression
	;
condition_regexp_like
 	:	k_regexp_like LPAREN call_parameters RPAREN
 	;
condition_submultiset
	:	nested_table_column_name ( r_not )? k_submultiset ( r_of )? nested_table_column_name
	;
condition_equals_path
	:	k_equals_path LPAREN column_name COMMA path_string ( COMMA correlation_integer )? RPAREN
	;
condition_under_path
	:	k_under_path LPAREN column_name ( COMMA levels )? COMMA path_string ( COMMA correlation_integer )? RPAREN
	;
levels
	:	integer
	;
correlation_integer
	:	integer
	;
path_string
	:	quoted_string
	;
type_names
	:	k_only? (schema_name DOT)? identifier[T_UNKNOWN,0]
		( k_only? (schema_name DOT)? identifier[T_UNKNOWN,0] )*
	;
integer
	:	NUMBER
	;
column_name
	:	sql_identifier[T_COLUMN_NAME,0]
	;
nested_table
	:	sql_identifier[T_TABLE_ALIAS,T_USE]
	;
nested_table_column_name
	:	( schema_name DOT )? (table_name DOT)? (nested_table DOT)? column_name
	;
sql_expressions
	:	sql_expression ( COMMA sql_expression )*
	;
// In this case Oracle SQL reference is not true enough
grouping_sets_expression_list
	:
	(
	
        LPAREN RPAREN
	|	LPAREN sql_expressions RPAREN
	|	sql_expression
	)
	( COMMA
		( LPAREN RPAREN
	 	| LPAREN sql_expressions RPAREN
		| sql_expression
		)
	)*
	;
grouping_expression_list
	:	expression_list ( COMMA expression_list )*
	;
expression_list
	:	LPAREN sql_expressions RPAREN
	|	sql_expressions
	;
cell_reference
	:	sql_identifier[T_UNKNOWN,0]
	;

condition_paren
	:	LPAREN sql_condition RPAREN
	;

/* ================================================================================
   MODEL clause
   ================================================================================ */
model_clause
	:	k_model main_model
        ( cell_reference_options )?
		( return_rows_clause )?
		( reference_model )* //main_model
	-> ^( 't_model' k_model main_model cell_reference_options? return_rows_clause? reference_model* )
	;
cell_reference_options
	:	( ( k_ignore | k_keep ) k_nav )?
		( r_unique ( k_dimension | k_single k_reference ) )?
	;
return_rows_clause
	:	k_return ( k_updated | r_all ) r_rows
	;
reference_model
	:	k_reference reference_model_name r_on LPAREN subquery RPAREN
		model_column_clauses ( cell_reference_options )
	;
reference_model_name
	:	identifier[T_UNKNOWN,0]
	;
main_model
	:	( k_main main_model_name )? model_column_clauses
		( cell_reference_options ) model_rules_clause
	;
main_model_name
	:	identifier[T_UNKNOWN,0]
	;
model_column_clauses
	:	( query_partition_clause ( column_spec )? )?
		k_dimension r_by LPAREN model_columns RPAREN
		k_measures LPAREN model_columns RPAREN
	;
model_columns
	:	model_column ( COMMA model_column )*
	;
model_column
	:	sql_expression ( ( r_as )? column_spec )?
	;
model_rules_clause
	:	( k_rules ( r_update | k_upsert ( r_all )? )? ( ( k_automatic | k_sequential ) r_order )? )?
		( k_iterate LPAREN NUMBER RPAREN ( k_until LPAREN sql_condition RPAREN )? )?
		LPAREN model_rules_exprs RPAREN
	;
model_rules_exprs
	:	model_rules_expr ( COMMA model_rules_expr )*
	;
model_rules_expr
	:	( r_update | k_upsert ( r_all )? )? cell_assignment ( order_by_clause )? EQ sql_expression
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
	:	r_for column_name
		(	r_in LPAREN ( literals | subquery ) RPAREN
		|	( r_like pattern )? r_from literal r_to literal ( r_increment | k_decrement ) literal
		)
	;
pattern
	:	quoted_string
	;
literal
	:	( PLUS | MINUS )? NUMBER
	|	quoted_string
	;
literals
	:	literal ( COMMA literal )*
	;
multi_column_for_loop
	:	r_for LPAREN column_specs RPAREN r_in LPAREN ( bracket_literals_list | subquery ) RPAREN
	;
bracket_literals
	:	LPAREN literals RPAREN
	;
bracket_literals_list
	:	bracket_literals ( COMMA bracket_literals )*
	;

/* ================================================================================
   UNION clause
   ================================================================================ */
union_clause
    :
	(	r_union ( r_all )?
 	|	r_intersect
 	|	r_minus
 	)
 	(	select_statement |	subquery )
	-> ^('t_union' r_union? r_all? r_intersect? r_minus? select_statement? subquery?)
	;
	
/* ================================================================================
   ORDER BY clause
   ================================================================================ */
order_by_clause
//TODO use search_clause here
	:	r_order k_siblings ? r_by order_by_clause_part_first order_by_clause_part_next*
	-> ^('t_order_by' r_order k_siblings ? r_by order_by_clause_part_first order_by_clause_part_next*)
	;
// NOTE: these two here here only to preserve COMMAs in parse tree
order_by_clause_part_first
	:	sql_expression r_asc ? r_desc ? (k_nulls k_first)? (k_nulls k_last)?
	;        
order_by_clause_part_next
	:	COMMA sql_expression r_asc ? r_desc ? (k_nulls k_first)? (k_nulls k_last)?
	;        

/* ================================================================================
   Analytic query part
   ================================================================================ */
analytic_function_name
	:
	// | k_avg	| k_corr	| k_covar_pop	| k_covar_samp	| k_count	| k_cume_dist	| k_dense_rank
	// | k_first	| k_first_value	| k_lag	| k_last	| k_last_value	| k_lead	| k_max	| k_min
	// | k_ntile	| k_percent_rank	| k_percentile_cont	| k_percentile_disc	| k_rank	| k_ratio_to_report
	// | k_regr_slope	| k_regr_intercept	| k_regr_count	| k_regr_r2	| k_regr_avgx	| k_regr_avgy
	// | k_regr_sxx	| k_regr_syy	| k_regr_sxy	| k_row_number	| k_stddev	| k_stddev_pop
	// | k_stddev_samp	| k_sum	| k_var_pop	| k_var_samp	| k_variance
	function_name        
    ;

analytic_function_call
	: analytic_function_name LPAREN ( r_distinct | r_unique | r_all)? sql_expression? (COMMA sql_expression)* ( ( k_respect | k_ignore) k_nulls )? RPAREN
	;
	
analytic_function
	: dense_rank_analytic
    | percent_rank_analytic
    | percent_cont_disc_analytic
    | first_last
	| listagg        
    | analytic_function_call ( ( k_respect | k_ignore) k_nulls )?  k_over LPAREN analytic_clause RPAREN
	;

count_function
	: k_count LPAREN ( ASTERISK | (r_distinct | r_unique | r_all)? sql_expression) RPAREN
        ( k_over LPAREN analytic_clause RPAREN)?
    ;
analytic_clause
	: query_partition_clause? (order_by_clause windowing_clause?)?
	;

windowing_clause_part
	: ( k_unbounded ( k_preceding | k_following ))
    | ( r_current r_row )
    | ( sql_expression ( k_preceding | k_following ) )
	;
			
windowing_clause
	: (r_rows | k_range )
	  ( windowing_clause_part | ( r_between windowing_clause_part r_and windowing_clause_part) )
	;

/* ================================================================================
   Aggregate functions
   ================================================================================ */
aggregate_function_name
	: (k_count | function_spec) // TODO use real list of aggregate function names here
	;
aggregate_function
	: dense_rank_aggregate
    | percent_rank_aggregate
	| first_last
	| listagg
	| aggregate_function_name LPAREN ( ASTERISK | (r_distinct | r_unique | r_all)? sql_expression) RPAREN ( k_over LPAREN analytic_clause RPAREN)?
    ;

/* ================================================================================
   Special functions
   ================================================================================ */
percent_rank_aggregate
	:	k_percent_rank LPAREN expression_list RPAREN k_within r_group
        LPAREN r_order r_by sql_expression (r_asc | r_desc)? (k_nulls (k_first | k_last))?
        (COMMA sql_expression (r_asc | r_desc)? (k_nulls (k_first | k_last))?)* 
    ;
dense_rank_aggregate
	: k_dense_rank LPAREN expression_list RPAREN k_within r_group
        LPAREN r_order r_by sql_expression (r_asc | r_desc)? (k_nulls (k_first | k_last))?
        (COMMA sql_expression (r_asc | r_desc)? (k_nulls (k_first | k_last))?)*
    ;

percent_rank_analytic
	: k_percent_rank LPAREN RPAREN k_over LPAREN query_partition_clause RPAREN
    ;

percent_cont_disc_analytic
	: (k_percentile_disc | k_percentile_cont)
	LPAREN sql_expression RPAREN k_within r_group LPAREN order_by_clause RPAREN
        (k_over LPAREN query_partition_clause RPAREN)?
	;

dense_rank_analytic
	: k_dense_rank LPAREN RPAREN k_over LPAREN query_partition_clause RPAREN
    ;

first_last
	: aggregate_function_name LPAREN ( ASTERISK | (r_distinct | r_unique |r_all)? sql_expression) RPAREN k_keep
        LPAREN k_dense_rank (k_first|k_last) order_by_clause RPAREN ( k_over LPAREN analytic_clause RPAREN)?
    ;
listagg
	: k_listagg LPAREN sql_expression (COMMA quoted_string)? RPAREN k_within r_group LPAREN order_by_clause RPAREN
        (k_over LPAREN query_partition_clause RPAREN)?
    ;
/* ================================================================================
    FOR UPDATE CLAUSE
   ================================================================================ */
for_update_clause
	: r_for r_update ( r_of for_update_clause_part_first for_update_clause_part_next* )? (r_nowait | k_wait NUMBER | k_skip k_locked)?
	-> ^('t_for_update' r_for r_update r_of? for_update_clause_part_first? for_update_clause_part_next* r_nowait? k_wait? NUMBER? k_skip? k_locked?)
	;
for_update_clause_part_first
	: (sch1=schema_name dot1a=DOT)? (tbl1=table_name dot1b=DOT)? col1=column_name
	;
for_update_clause_part_next
	: COMMA (sch1=schema_name dot1a=DOT)? (tbl1=table_name dot1b=DOT)? col1=column_name
	;
	
/* ================================================================================
    PIVOT CLAUSE
   ================================================================================ */
pivot_clause
	:	k_pivot k_xml? LPAREN aggregate_function c_alias? (COMMA aggregate_function c_alias?)*
		pivot_for_clause pivot_in_clause RPAREN
	;
pivot_for_clause
	:	r_for column_spec | ( LPAREN column_specs RPAREN )
	;
pivot_in_clause
	:	r_in
        LPAREN
        (
            select_statement
        |	r_any (COMMA r_any)*
        |	expression_list c_alias? (COMMA expression_list c_alias?) /*!!!*/
        )
        RPAREN
	;
unpivot_clause
	:	k_unpivot (( k_exclude | k_include ) k_nulls)?
		LPAREN (column_spec | (LPAREN column_specs RPAREN)) pivot_for_clause unpivot_in_clause RPAREN
	;
unpivot_in_clause
	:	r_in
		LPAREN
		(column_spec | (LPAREN column_specs RPAREN)) (r_as (constant | (LPAREN constant RPAREN)))?
		(COMMA (column_spec | (LPAREN column_specs RPAREN)) (r_as (constant | (LPAREN constant RPAREN)))?)*
		RPAREN
	;
constant
	:	NUMBER | quoted_string
	;	// TODO fixme        

/* ================================================================================
   Oracle reserved words
   cannot by used for name database objects such as columns, tables, or indexes.
   ================================================================================ */
r_access : r='ACCESS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_add : r='ADD' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_all : r='ALL' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
r_alter : r='ALTER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_and : r='AND' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_any : r='ANY' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
r_arraylen : r='ARRAYLEN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_as : r='AS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_asc : r='ASC' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_audit : r='AUDIT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_between : r='BETWEEN' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
r_by : r='BY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_case : r='CASE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ; //PL/SQL
r_char : r='CHAR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_check : r='CHECK' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_cluster : r='CLUSTER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_column : r='COLUMN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_comment : r='COMMENT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_compress : r='COMPRESS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_connect : r='CONNECT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_create : r='CREATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_current : r='CURRENT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_date : r='DATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_decimal : r='DECIMAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_default : r='DEFAULT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_delete : r='DELETE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_desc : r='DESC' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_distinct : r='DISTINCT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_drop : r='DROP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_else : r='ELSE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_exclusive : r='EXCLUSIVE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_exists : r='EXISTS' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_UNARY;  }  ;
r_false : r='FALSE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ; //PL/SQL
r_file : r='FILE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_float : r='FLOAT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_for : r='FOR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_from : r='FROM' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_grant : r='GRANT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_group : r='GROUP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_having : r='HAVING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_identified : r='IDENTIFIED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_immediate : r='IMMEDIATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_in : r='IN' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
r_increment : r='INCREMENT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_index : r='INDEX' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_initial : r='INITIAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_insert : r='INSERT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_integer : r='INTEGER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_intersect : r='INTERSECT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_into : r='INTO' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_is : r='IS' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_UNARY;  }  ;
r_level : r='LEVEL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_like : r='LIKE' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
r_lock : r='LOCK' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_long : r='LONG' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_maxextents : r='MAXEXTENTS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_minus : r='MINUS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_mode : r='MODE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_modify : r='MODIFY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_noaudit : r='NOAUDIT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_nocompress : r='NOCOMPRESS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_not : r='NOT' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
r_notfound : r='NOTFOUND' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_nowait : r='NOWAIT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_null : r='NULL' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
r_number : r='NUMBER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_of : r='OF' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
r_offline : r='OFFLINE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_on : r='ON' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_online : r='ONLINE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_option : r='OPTION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_or : r='OR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_order : r='ORDER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_pctfree : r='PCTFREE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_prior : r='PRIOR' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
r_privileges : r='PRIVILEGES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_public : r='PUBLIC' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_raw : r='RAW' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_rename : r='RENAME' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_resource : r='RESOURCE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_revoke : r='REVOKE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_row : r='ROW' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_rowid : r='ROWID' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_rowlabel : r='ROWLABEL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_rownum : r='ROWNUM' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_rows : r='ROWS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_select : r='SELECT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_session : r='SESSION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_set : r='SET' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
r_share : r='SHARE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_size : r='SIZE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_smallint : r='SMALLINT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_sqlbuf : r='SQLBUF' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_start : r='START' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_successful : r='SUCCESSFUL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_synonym : r='SYNONYM' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_sysdate : r='SYSDATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_table : r='TABLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_then : r='THEN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_to : r='TO' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_trigger  : r='TRIGGER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_true  : r='TRUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ; // PL/SQL
r_uid : r='UID' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_union : r='UNION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_unique : r='UNIQUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_update : r='UPDATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_user  : r='USER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_validate : r='VALIDATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_values : r='VALUES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_varchar : r='VARCHAR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_varchar2 : r='VARCHAR2' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_view : r='VIEW' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_whenever : r='WHENEVER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_where : r='WHERE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
r_with : r='WITH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;

// reserved_word options { backtrack=false; }
// 	: r=( 'ACCESS'	| 'ADD'	| 'ALL'	| 'ALTER'	| 'AND'	| 'ANY'	| 'ARRAYLEN'	| 'AS'	| 'ASC'	| 'AUDIT'
// 	| 'BETWEEN'	| 'BY'
// 	| 'CASE'
// 	| 'CHAR'	| 'CHECK'	| 'CLUSTER'	| 'COLUMN'	| 'COMMENT'	| 'COMPRESS'	| 'CONNECT'	| 'CREATE'	| 'CURRENT'	
// 	| 'DATE'	| 'DECIMAL'	| 'DEFAULT'	| 'DELETE'	| 'DESC'	| 'DISTINCT'	| 'DROP'	
// 	| 'ELSE'	| 'EXCLUSIVE'	| 'EXISTS'	
// 	| 'FILE'	| 'FLOAT'	| 'FOR'	| 'FROM'	
// 	| 'GRANT'	| 'GROUP'	
// 	| 'HAVING'	
// 	| 'IDENTIFIED'	| 'IMMEDIATE'	| 'IN'	| 'INCREMENT'	| 'INDEX'	| 'INITIAL'	| 'INSERT'	| 'INTEGER'	
// 	| 'INTERSECT'	| 'INTO'	| 'IS'	
// 	| 'LEVEL'	| 'LIKE'	| 'LOCK'	| 'LONG'	
// 	| 'MAXEXTENTS'	| 'MINUS'	| 'MODE'	| 'MODIFY'	
// 	| 'NOAUDIT'	| 'NOCOMPRESS'	| 'NOT'	| 'NOTFOUND'	| 'NOWAIT'	| 'NULL'	| 'NUMBER'	
// 	| 'OF'	| 'OFFLINE'	| 'ON'	| 'ONLINE'	| 'OPTION'	| 'OR'	| 'ORDER'	
// 	| 'PCTFREE'	| 'PRIOR'	| 'PRIVILEGES'	| 'PUBLIC'	
// 	| 'RAW'	| 'RENAME'	| 'RESOURCE'	| 'REVOKE'	| 'ROW'	| 'ROWID'	| 'ROWLABEL'	| 'ROWNUM'	| 'ROWS'	
// 	| 'SELECT'	| 'SESSION'	| 'SET'	| 'SHARE'	| 'SIZE'	| 'SMALLINT'	| 'SQLBUF'	
// 	| 'START'	| 'SUCCESSFUL'	| 'SYNONYM'	| 'SYSDATE'	
// 	| 'TABLE'	| 'THEN'	| 'TO'	| 'TRIGGER'	
// 	| 'UID'	| 'UNION'	| 'UNIQUE'	| 'UPDATE'	| 'USER'	
// 	| 'VALIDATE'	| 'VALUES'	| 'VARCHAR'	| 'VARCHAR2'	| 'VIEW'	
// 	| 'WHENEVER'	| 'WHERE'	| 'WITH'
// 	) //{ $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }
// 	  //{ $type = T_RESERVED; }
// 	// -> ^(T_RESERVED[$r])
// 	;

/* ================================================================================
   Oracle keywords
   can by used for name database objects such as columns, tables, or indexes.
   ================================================================================ */

//k_as : { !(LT(1)->getText(LT(1))->compare8(LT(1)->getText(LT(1)), "AS")) }? ID;
//k_as : { !(strcasecmp(LT(1)->getText(LT(1))->chars, "AS")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;

// k_a  : r='A' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_admin : r='ADMIN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_after : r='AFTER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_allocate : r='ALLOCATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_analyze : r='ANALYZE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_archive : r='ARCHIVE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_archivelog : r='ARCHIVELOG' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_at  : r='AT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_authorization : r='AUTHORIZATION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_automatic : r='AUTOMATIC' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_avg	 : r='AVG' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_backup : r='BACKUP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_become : r='BECOME' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_before : r='BEFORE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_begin : r='BEGIN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_bfile : r='BFILE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_binary_double : r='BINARY_DOUBLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_binary_float : r='BINARY_FLOAT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_binary_integer : r='BINARY_INTEGER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_blob : r='BLOB' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_block : r='BLOCK' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_body	 : r='BODY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_boolean : r='BOOLEAN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_breadth : r='BREADTH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_byte : r='BYTE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cache : r='CACHE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cancel : r='CANCEL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cascade : r='CASCADE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cast : r='CAST' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_change : r='CHANGE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_character : r='CHARACTER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_checkpoint : r='CHECKPOINT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_clob : r='CLOB' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_close	 : r='CLOSE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cluster_set : r='CLUSTER_SET' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cobol : r='COBOL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_column_value : r='COLUMN_VALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_commit : r='COMMIT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_compile : r='COMPILE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_connect_by_iscycle : r='CONNECT_BY_ISCYCLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_connect_by_isleaf : r='CONNECT_BY_ISLEAF' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_connect_by_root : r='CONNECT_BY_ROOT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_constraint : r='CONSTRAINT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_constraints : r='CONSTRAINTS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_contents : r='CONTENTS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_continue	 : r='CONTINUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_controlfile : r='CONTROLFILE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_corr : r='CORR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_count : r='COUNT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_covar_pop : r='COVAR_POP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_covar_samp : r='COVAR_SAMP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cross : r='CROSS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cube : r='CUBE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cume_dist : r='CUME_DIST' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cursor : r='CURSOR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_cycle	 : r='CYCLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_database : r='DATABASE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_datafile : r='DATAFILE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_day : r='DAY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_dba : r='DBA' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_dbtimezone : r='DBTIMEZONE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_dec : r='DEC' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_declare : r='DECLARE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_decrement : r='DECREMENT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_dense_rank : r='DENSE_RANK' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_depth : r='DEPTH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_dimension : r='DIMENSION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_disable : r='DISABLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_dismount : r='DISMOUNT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_double : r='DOUBLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_dump	 : r='DUMP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_each : r='EACH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_empty : r='EMPTY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_enable : r='ENABLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_end : r='END' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_equals_path : r='EQUALS_PATH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_errors : r='ERRORS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_escape : r='ESCAPE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_events : r='EVENTS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_except : r='EXCEPT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_exceptions : r='EXCEPTIONS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_exclude : r='EXCLUDE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_exec : r='EXEC' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_execute	 : r='EXECUTE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_explain : r='EXPLAIN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_extent : r='EXTENT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_externally	 : r='EXTERNALLY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_fetch : r='FETCH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_first : r='FIRST' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_first_value : r='FIRST_VALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_flush : r='FLUSH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_following : r='FOLLOWING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_force : r='FORCE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_foreign : r='FOREIGN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_fortran : r='FORTRAN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_found : r='FOUND' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_freelist : r='FREELIST' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_freelists : r='FREELISTS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_full : r='FULL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_function	 : r='FUNCTION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_go : r='GO' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_goto : r='GOTO' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_grouping : r='GROUPING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_groups : r='GROUPS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_ignore : r='IGNORE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_include : r='INCLUDE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_including : r='INCLUDING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_indicator : r='INDICATOR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_infinite : r='INFINITE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_initrans : r='INITRANS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_inner : r='INNER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_instance : r='INSTANCE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_int	 : r='INT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_interval : r='INTERVAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_iterate : r='ITERATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_join : r='JOIN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_keep : r='KEEP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_key	 : r='KEY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_lag : r='LAG' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_language : r='LANGUAGE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_last : r='LAST' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_last_value : r='LAST_VALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_layer : r='LAYER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_lead : r='LEAD' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_left : r='LEFT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_limit : r='LIMIT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// //k_link : r='LINK' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_like2 : r='LIKE2' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_like4 : r='LIKE4' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_likec : r='LIKEC' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_lists : r='LISTS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_local	 : r='LOCAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_locked	 : r='LOCKED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_log : r='LOG' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_logfile	 : r='LOGFILE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_main : r='MAIN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_manage : r='MANAGE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_manual : r='MANUAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_matched : r='MATCHED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_max : r='MAX' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_maxdatafiles : r='MAXDATAFILES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_maxinstances : r='MAXINSTANCES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_maxlogfiles : r='MAXLOGFILES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_maxloghistory	 : r='MAXLOGHISTORY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_maxlogmembers : r='MAXLOGMEMBERS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_maxtrans : r='MAXTRANS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_maxvalue : r='MAXVALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_measures : r='MEASURES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_member : r='MEMBER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_merge : r='MERGE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_min : r='MIN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_minextents : r='MINEXTENTS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_minvalue : r='MINVALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_mivalue : r='MIVALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_mlslabel : r='MLSLABEL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_model : r='MODEL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_module : r='MODULE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_month	 : r='MONTH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_mount	 : r='MOUNT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_multiset : r='MULTISET' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nan : r='NAN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_national : r='NATIONAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_natural : r='NATURAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nav : r='NAV' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nchar : r='NCHAR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nclob : r='NCLOB' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_new : r='NEW' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_next : r='NEXT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_noarchivelog : r='NOARCHIVELOG' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nocache : r='NOCACHE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nocycle : r='NOCYCLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nomaxvalue : r='NOMAXVALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nominvalue : r='NOMINVALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_none	 : r='NONE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_noorder : r='NOORDER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_noresetlogs : r='NORESETLOGS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_normal : r='NORMAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nosort : r='NOSORT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_ntile : r='NTILE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nulls : r='NULLS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_numeric	 : r='NUMERIC' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nvarchar : r='NVARCHAR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_nvarchar2 : r='NVARCHAR2' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_object_id : r='OBJECT_ID' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_object_value : r='OBJECT_VALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_off : r='OFF' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_old : r='OLD' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_only : r='ONLY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_open : r='OPEN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_optimal : r='OPTIMAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_ora_rowscn : r='ORA_ROWSCN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_outer : r='OUTER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_over : { !(strcasecmp(LT(1)->getText(LT(1))->chars, "OVER")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_own	 : r='OWN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_package : r='PACKAGE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_parallel : r='PARALLEL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_partition : r='PARTITION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_pctincrease : r='PCTINCREASE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_pctused : r='PCTUSED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_percent_rank : r='PERCENT_RANK' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_percentile_cont : r='PERCENTILE_CONT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_percentile_disc : r='PERCENTILE_DISC' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_pivot : r='PIVOT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_plan : r='PLAN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_pli : r='PLI' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_pls_integer : r='PLS_INTEGER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_positive : r='POSITIVE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_preceding : r='PRECEDING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_precision : r='PRECISION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_present : r='PRESENT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_primary : r='PRIMARY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_private : r='PRIVATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_procedure : r='PROCEDURE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_profile	 : r='PROFILE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_quota	 : r='QUOTA' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_range : r='RANGE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_rank : r='RANK' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_ratio_to_report : r='RATIO_TO_REPORT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_read : r='READ' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_real : r='REAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_recover : r='RECOVER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_reference : r='REFERENCE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_references : r='REFERENCES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_referencing : r='REFERENCING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regexp_like : r='REGEXP_LIKE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regr_avgx : r='REGR_AVGX' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regr_avgy : r='REGR_AVGY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regr_count : r='REGR_COUNT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regr_intercept : r='REGR_INTERCEPT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regr_r2 : r='REGR_R2' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regr_slope : r='REGR_SLOPE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regr_sxx : r='REGR_SXX' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regr_sxy : r='REGR_SXY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_regr_syy : r='REGR_SYY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_reject : r='REJECT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_resetlogs : r='RESETLOGS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_respect : r='RESPECT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_restricted : r='RESTRICTED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_return : r='RETURN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_returning : r='RETURNING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_reuse	 : r='REUSE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_right : r='RIGHT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_role : r='ROLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_roles : r='ROLES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_rollback	 : r='ROLLBACK' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_rollup : r='ROLLUP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_row_number : r='ROW_NUMBER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_rules : r='RULES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sample : r='SAMPLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_savepoint : r='SAVEPOINT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_schema : r='SCHEMA' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_scn : r='SCN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_search : r='SEARCH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_second : r='SECOND' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_section : r='SECTION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_seed : r='SEED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_segment : r='SEGMENT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sequence : r='SEQUENCE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sequential : r='SEQUENTIAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sessiontimezone : r='SESSIONTIMEZONE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sets : r='SETS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_shared : r='SHARED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_siblings : r='SIBLINGS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_single : r='SINGLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_skip : r='SKIP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_snapshot	 : r='SNAPSHOT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_some : r='SOME' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sort : r='SORT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sql : r='SQL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sqlcode : r='SQLCODE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sqlerror : r='SQLERROR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sqlstate : r='SQLSTATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_statement_ID : r='STATEMENT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_statistics : r='STATISTICS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_stddev : r='STDDEV' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_stddev_pop : r='STDDEV_POP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_stddev_samp : r='STDDEV_SAMP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_stop : r='STOP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_storage : r='STORAGE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_submultiset : r='SUBMULTISET' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_subpartition : r='SUBPARTITION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_sum : r='SUM' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_switch : r='SWITCH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_system	 : r='SYSTEM' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_tables : r='TABLES' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_tablespace : r='TABLESPACE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_temporary : r='TEMPORARY' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_the : r='THE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_thread : r='THREAD' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_time : r='TIME' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_timestamp : r='TIMESTAMP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_tracing : r='TRACING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_transaction : r='TRANSACTION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_triggers	 : r='TRIGGERS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_truncate	 : r='TRUNCATE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_type : r='TYPE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_unbounded : r='UNBOUNDED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_under : r='UNDER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_under_path : r='UNDER_PATH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_unlimited : r='UNLIMITED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_unpivot : r='UNPIVOT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_until : r='UNTIL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_updated : r='UPDATED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_upsert : r='UPSERT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_urowid : r='UROWID' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_use : r='USE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_using	 : r='USING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_value : r= 'VALUE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_var_pop : r='VAR_POP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_var_samp : r='VAR_SAMP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_variance : r='VARIANCE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_varying : r='VARYING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_versions : r='VERSIONS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// // k_versions_endscn : r='VERSIONS_ENDSCN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// // k_versions_endtime : r='VERSIONS_ENDTIME' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// // k_versions_operation : r='VERSIONS_OPERATION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// // k_versions_starscn : r='VERSIONS_STARSCN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// // k_versions_starttime : r='VERSIONS_STARTTIME' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// // k_versions_xid : r='VERSIONS_XID' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_wait : r='WAIT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_when : r='WHEN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_work : r='WORK' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_write	 : r='WRITE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_xml : r='XML' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_xmldata : r='XMLDATA' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_year : { !(strcasecmp(LT(1)->getText(LT(1))->chars, "YEAR")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_zone	 : r='ZONE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;

//k_a : r='A' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
//k_a : { !(LT(1)->getText(LT(1))->compare8(LT(1)->getText(LT(1)), "AS")) }? ID;
k_a	: { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "A")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;

k_at                    : r='AT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_at                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "AT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_automatic             : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "AUTOMATIC")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_avg                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "AVG")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_bfile                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BFILE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_binary_double         : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BINARY_DOUBLE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_binary_float          : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BINARY_FLOAT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_binary_integer        : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BINARY_INTEGER")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_blob                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BLOB")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_block                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BLOCK")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_boolean               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BOOLEAN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_both                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BOTH")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_breadth               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BREADTH")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_byte                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "BYTE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_cast                  : r='CAST' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_cast                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CAST")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_character             : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CHARACTER")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_clob                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CLOB")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_cluster_set           : r='CLUSTER_SET' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_cluster_set         : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CLUSTER_SET")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_column_value        : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "COLUMN_VALUE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_connect_by_iscycle  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CONNECT_BY_ISCYCLE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_connect_by_isleaf   : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CONNECT_BY_ISLEAF")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_connect_by_root       : r='CONNECT_BY_ROOT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_connect_by_root     : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CONNECT_BY_ROOT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_constraint            : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CONSTRAINT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_corr                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CORR")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_count                 : r='COUNT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_count               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "COUNT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ; 
//k_covar_pop           : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "COVAR_POP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_covar_samp          : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "COVAR_SAMP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_cross                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CROSS")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_cube                  : r='CUBE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_cube                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CUBE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_cume_dist           : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CUME_DIST")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_cursor                : r='CURSOR' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_cursor              : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CURSOR")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_cycle                 : r='CYCLE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_cycle               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "CYCLE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_day                   : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "DAY")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_dbtimezone            : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "DBTIMEZONE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_dec                   : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "DEC")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_decrement             : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "DECREMENT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_dense_rank            : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "DENSE_RANK")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_depth                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "DEPTH")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_dimension             : r='DIMENSION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_dimension           : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "DIMENSION")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_double                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "DOUBLE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_empty                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "EMPTY")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
k_end                   : r='END' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
//k_end                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "END")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
k_equals_path           : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "EQUALS_PATH")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_UNARY;  }  ;
k_errors                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "ERRORS")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_escape                : r='ESCAPE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_escape              : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "ESCAPE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_exclude               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "EXCLUDE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_extract               : r='EXTRACT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_extract             : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "EXCLUDE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_first                 : r='FIRST' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_first : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "FIRST")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_first_value : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "FIRST_VALUE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_following : r='FOLLOWING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_following : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "FOLLOWING")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_full : r='FULL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_full : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "FULL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_grouping : r='GROUPING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_grouping : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "GROUPING")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_hour : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "HOUR")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_ignore : r='IGNORE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_ignore : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "IGNORE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_include : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "INCLUDE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_infinite : r='INFINITE' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
//k_infinite : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "INFINITE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
k_inner : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "INNER")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_int : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "INT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_interval : r='INTERVAL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_interval : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "INTERVAL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_iterate : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "ITERATE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_join : r='JOIN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_join : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "JOIN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_keep : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "KEEP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_lag : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LAG")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_last : r='LAST' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_last : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LAST")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_last_value : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LAST_VALUE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_lead : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LEAD")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_leading : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LEADING")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_left : r='LEFT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_left : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LEFT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_like2 : r='LIKE2' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
//k_like2 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LIKE2")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
k_like4 : r='LIKE4' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
//k_like4 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LIKE4")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
k_likec : r='LIKEC' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
//k_likec : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LIKEC")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
k_limit                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LIMIT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_listagg               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LISTAGG")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_lnnvl                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LNNVL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_local                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LOCAL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_locked                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LOCKED")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_log                   : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "LOG"   )) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_main                  : r='MAIN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_main                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MAIN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_matched               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MATCHED")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_max                 : r='MAX' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_max                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MAX")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_maxvalue              : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MAXVALUE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_measures              : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MEASURES")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_member                : r='MEMBER' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
//k_member              : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MEMBER")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
k_merge                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MERGE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_min                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MIN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_minute                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MINUTE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_mivalue               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MIVALUE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_mlslabel              : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MLSLABEL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_model : {
    !(strcasecmp((const char*)LT(2)->getText(LT(2))->chars, "MAIN")) ||
    !(strcasecmp((const char*)LT(2)->getText(LT(2))->chars, "PARTITION")) ||
    !(strcasecmp((const char*)LT(2)->getText(LT(2))->chars, "DIMENSION")) 
   }? r='MODEL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// i_model : {
//     (strcasecmp((const char*)LT(2)->getText(LT(2))->chars, "MAIN")) &&
//     (strcasecmp((const char*)LT(2)->getText(LT(2))->chars, "PARTITION")) &&
//     (strcasecmp((const char*)LT(2)->getText(LT(2))->chars, "DIMENSION")) 
//    }? r='MODEL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_model : r='MODEL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_model : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MODEL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_month : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MONTH")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_multiset : r='MULTISET' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_multiset : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "MULTISET")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_nan : r='NAN' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
//k_nan : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NAN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
k_national : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NATIONAL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_natural : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NATURAL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_nav : r='NAV' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_nav : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NAV")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_nchar : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NCHAR")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_nclob : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NCLOB")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_nocycle : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NOCYCLE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_ntile : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NTILE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_nulls : r='NULLS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_nulls : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NULLS")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_numeric : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NUMERIC")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_nvarchar : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NVARCHAR")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_nvarchar2 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "NVARCHAR2")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_object_id : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "OBJECT_ID")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_object_value : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "OBJECT_VALUE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_only : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "ONLY")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_ora_rowscn : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "ORA_ROWSCN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_outer : r='OUTER' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_outer : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "OUTER")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_over : r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_over : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "OVER")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_partition : r='PARTITION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_partition : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "PARTITION")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_percent_rank : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "PERCENT_RANK")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_percentile_cont : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "PERCENTILE_CONT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_percentile_disc : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "PERCENTILE_DISC")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_pivot : r='PIVOT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_pivot : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "PIVOT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_pls_integer : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "PLS_INTEGER")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_positive : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "POSITIVE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_preceding : r='PRECEDING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_preceding : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "PRECEDING")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_precision : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "PRECISION")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_present : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "PRESENT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
k_range : r='RANGE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_range : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "RANGE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_rank : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "RANK")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_ratio_to_report : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "RATIO_TO_REPORT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_read : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "READ")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_real : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REAL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_reference : r='REFERENCE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_reference : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REFERENCE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_regexp_like : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGEXP_LIKE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_UNARY;  }  ;
//k_regr_avgx : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGR_AVGX")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_regr_avgy : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGR_AVGY")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_regr_count : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGR_COUNT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_regr_intercept : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGR_INTERCEPT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_regr_r2 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGR_R2")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_regr_slope : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGR_SLOPE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_regr_sxx : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGR_SXX")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_regr_sxy : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGR_SXY")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_regr_syy : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REGR_SYY")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_reject : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "REJECT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_respect : r='RESPECT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_respect : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "RESPECT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_return : r='RETURN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_return : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "RETURN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_returning : r='RETURNING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_returning : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "RETURNING")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_right : r='RIGHT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_right : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "RIGHT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_rollup : r='ROLLUP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_rollup : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "ROLLUP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_row_number : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "ROW_NUMBER")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_rules : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "RULES")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_sample : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SAMPLE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_scn : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SCN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_search : r='SEARCH' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_search : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SEARCH")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_second : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SECOND")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_seed : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SEED")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_sequential : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SEQUENTIAL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_sessiontimezone : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SESSIONTIMEZONE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_sets : r='SETS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_sets : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SETS")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_siblings : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SIBLINGS")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_single : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SINGLE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_skip : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SKIP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_some : r='SOME' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
//k_some : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SOME")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
k_sql : r='SQL' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_sql : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SQL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_stddev : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "STDDEV")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_stddev_pop : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "STDDEV_POP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_stddev_samp : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "STDDEV_SAMP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_submultiset : r='SUBMULTISET' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
//k_submultiset : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SUBMULTISET")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_BINARY;  }  ;
k_subpartition : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SUBPARTITION")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_sum : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "SUM")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_the : r='THE' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_the : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "THE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_time : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TIME")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_timestamp : r='TIMESTAMP' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_timestamp : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TIMESTAMP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_timezone_hour : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TIMEZONE_HOUR")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_timezone_minute : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TIMEZONE_MINUTE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_timezone_region : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TIMEZONE_REGION")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_timezone_abbr : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TIMEZONE_ABBR")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_to                    : r='TO' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_to                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TO")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_trailing              : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TRAILING")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_trim                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TRIM")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_type                : r='TYPE' { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
k_type                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "TYPE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_PART;  }  ;
k_unbounded             : r='UNBOUNDED' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_unbounded           : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "UNBOUNDED")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_under_path            : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "UNDER_PATH")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_OPERATOR_UNARY;  }  ;
k_unlimited             : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "UNLIMITED")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_unpivot               : r='UNPIVOT' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_unpivot             : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "UNPIVOT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_until                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "UNTIL")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_updated               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "UPDATED")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_upsert                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "UPSERT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_urowid                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "UROWID")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_using                 : r='USING' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_using               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "USING")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_value                 : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "VALUE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_var_pop             : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "VAR_POP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_var_samp            : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "VAR_SAMP")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_variance            : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "VARIANCE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_varying               : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "VARYING")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_versions              : r='VERSIONS' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_versions            : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "VERSIONS")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_versions_endscn    : r='VERSIONS_ENDSCN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_versions_endtime   : r='VERSIONS_ENDTIME' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_versions_operation : r='VERSIONS_OPERATION' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_versions_starscn   : r='VERSIONS_STARSCN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_versions_starttime : r='VERSIONS_STARTTIME' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
// k_versions_xid       : r='VERSIONS_XID' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_wait                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "WAIT")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_when                  : r='WHEN' { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_when                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "WHEN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_within                : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "WITHIN")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_xml                   : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "XML")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
//k_xmldata             : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "XMLDATA")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_year                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "YEAR")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;
k_zone                  : { !(strcasecmp((const char*)LT(1)->getText(LT(1))->chars, "ZONE")) }? r=ID { $r->setType($r, T_RESERVED); $r->user1 = T_RESERVED;  }  ;

keyword[int identifierClass, int usageType]
:	k=(
		//'A'	// note: this one is not listed in the docs but is a part of "IS A SET" condition clause
		'AT'
//         | 'AUTOMATIC'
//         | 'AVG'
//         | 'BFILE'
//         | 'BINARY_DOUBLE'
//         | 'BINARY_FLOAT'
//         | 'BINARY_INTEGER'
//         | 'BLOB'
//         | 'BLOCK'
//         | 'BOOLEAN'
//         | 'BREADTH'
//         | 'BYTE'
//         | 'CAST'
// NOTE!!! CASE is reserved word in Oracle but still can be used as identifier
         | 'CASE'
//         | 'CHARACTER'
//         | 'CLOB'
//         | 'CLUSTER_SET'
//         | 'COLUMN_VALUE'
//         | 'CONNECT_BY_ISCYCLE'
//         | 'CONNECT_BY_ISLEAF'
//         | 'CONNECT_BY_ROOT'
//         | 'CONSTRAINT'
//         | 'CORR'
         | 'COUNT'
//         | 'COVAR_POP'
//         | 'COVAR_SAMP'
//         | 'CROSS'
         | 'CUBE'
//         | 'CUME_DIST'
//             //| 'CURSOR'
         | 'CYCLE'
//         | 'DAY'
//         | 'DBTIMEZONE'
//         | 'DEC'
//         | 'DECREMENT'
//             //| 'DENSE_RANK'
//         | 'DEPTH'
//         | 'DIMENSION'
//         | 'DOUBLE'
//         | 'EMPTY'
//         | 'END'
//         | 'EQUALS_PATH'
//         | 'ERRORS'
         | 'ESCAPE'
//         | 'EXCLUDE'
           | 'EXTRACT'
        | 'FIRST'
//         | 'FIRST_VALUE'
//         | 'FOLLOWING'
//             //| 'FULL'
         | 'GROUPING'
//         | 'IGNORE'
//         | 'INCLUDE'
         | 'INFINITE'
//         | 'INNER'
//         | 'INT'
         | 'INTERVAL'
//         | 'ITERATE'
//             //| 'JOIN'
//         | 'KEEP'
//         | 'LAG'
         | 'LAST'
//         | 'LAST_VALUE'
//         | 'LEAD'
//             //| 'LEFT'
         | 'LIKE2'
         | 'LIKE4'
         | 'LIKEC'
//         | 'LIMIT'
//         | 'LISTAGG'
//         | 'LOCAL'
//         | 'LOCKED'
//         | 'LOG'
//         | 'MAIN'
//         | 'MATCHED'
//         | 'MAX'
//         | 'MAXVALUE'
//         | 'MEASURES'
         | 'MEMBER'
//         | 'MERGE'
//         | 'MIN'
//         | 'MIVALUE'
//         | 'MLSLABEL'
//           //| 'MODEL'
//        | i_model	
//         | 'MONTH'
//             //| 'MULTISET'
         | 'NAN'
//         | 'NATIONAL'
//         | 'NATURAL'
//         | 'NAV'
//         | 'NCHAR'
//         | 'NCLOB'
//         | 'NOCYCLE'
//         | 'NTILE'
         | 'NULLS'
//         | 'NUMERIC'
//         | 'NVARCHAR'
//         | 'NVARCHAR2'
//         | 'OBJECT_ID'
//         | 'OBJECT_VALUE'
//         | 'ONLY'
//         | 'ORA_ROWSCN'
             | 'OUTER'
//         | 'OVER'
//             //| 'PARTITION'
//             //| 'PERCENT_RANK'
//             //| 'PERCENTILE_CONT'
//             //| 'PERCENTILE_DISC'
         | 'PIVOT'
//         | 'PLS_INTEGER'
//         | 'POSITIVE'
//         | 'PRECEDING'
//         | 'PRECISION'
//         | 'PRESENT'
//         | 'RANGE'
//         | 'RANK'
//         | 'RATIO_TO_REPORT'
//         | 'READ'
//         | 'REAL'
         | 'REFERENCE'
//         | 'REGEXP_LIKE'
//         | 'REGR_AVGX'
//         | 'REGR_AVGY'
//         | 'REGR_COUNT'
//         | 'REGR_INTERCEPT'
//         | 'REGR_R2'
//         | 'REGR_SLOPE'
//         | 'REGR_SXX'
//         | 'REGR_SXY'
//         | 'REGR_SYY'
//         | 'REJECT'
//         | 'RESPECT'
         | 'RETURN'
//         | 'RETURNING'
//             //| 'RIGHT'
         | 'ROLLUP'
//         | 'ROW_NUMBER'
//         | 'RULES'
//         | 'SAMPLE'
//         | 'SCN'
         | 'SEARCH'
//         | 'SECOND'
//         | 'SEED'
//         | 'SEQUENTIAL'
//         | 'SESSIONTIMEZONE'
//         | 'SETS'
//         | 'SIBLINGS'
//         | 'SINGLE'
//         | 'SKIP'
//         | 'SOME'
         | 'SQL'
//         | 'STDDEV'
//         | 'STDDEV_POP'
//         | 'STDDEV_SAMP'
//         | 'SUBMULTISET'
//         | 'SUBPARTITION'
//         | 'SUM'
//         | 'THE'
//         | 'TIME'
         | 'TIMESTAMP'
//         | 'TO'		            
//         | 'TYPE'
//         | 'UNBOUNDED'
//         | 'UNDER_PATH'
//         | 'UNLIMITED'
         | 'UNPIVOT'
//         | 'UNTIL'
//         | 'UPDATED'
//         | 'UPSERT'
//         | 'UROWID'
//             //| 'USING'
//         | 'VALUE'
//         | 'VAR_POP'
//         | 'VAR_SAMP'
//         | 'VARIANCE'
//         | 'VARYING'
//         | 'VERSIONS'
//             // | 'VERSIONS_ENDSCN'
//             // | 'VERSIONS_ENDTIME'
//             // | 'VERSIONS_OPERATION'
//             // | 'VERSIONS_STARSCN'
//             // | 'VERSIONS_STARTTIME'
//             // | 'VERSIONS_XID'
//         | 'WAIT'
		| 'WHEN'
//         | 'WITHIN'        
//         | 'XML'
//         | 'XMLDATA'
//         | 'YEAR'
//         | 'ZONE'
		) { $k->user1 = identifierClass; $k->user2 = usageType; }
	;

quoted_string
	:	QUOTED_STRING | QSTRING
	;

QUOTED_STRING
	:	( 'n'|'N' )? '\'' ( '\'\'' | ~('\'') )* '\''
	;

/* Perl-style quoted string */
QSTRING             : ('q'|'Q') ( QS_ANGLE | QS_BRACE | QS_BRACK | QS_PAREN | QS_OTHER) ;
fragment QS_ANGLE   : QUOTE '<' ( options {greedy=false;} : . )* '>' QUOTE ;
fragment QS_BRACE   : QUOTE '{' ( options {greedy=false;} : . )* '}' QUOTE ;
fragment QS_BRACK   : QUOTE '[' ( options {greedy=false;} : . )* ']' QUOTE ;
fragment QS_PAREN   : QUOTE '(' ( options {greedy=false;} : . )* ')' QUOTE ;

fragment QS_OTHER_CH: ~('<'|'{'|'['|'('|' '|'\t'|'\n'|'\r');
fragment QS_OTHER
		@declarations {
    		ANTLR3_UINT32 (*oldLA)(struct ANTLR3_INT_STREAM_struct *, ANTLR3_INT32);
		}
		@init {
			oldLA = INPUT->istream->_LA;
            INPUT->setUcaseLA(INPUT, ANTLR3_FALSE);
		}
		:	
		QUOTE delimiter=QS_OTHER_CH
/* JAVA Syntax */        
// 		( { input.LT(1) != $delimiter.text.charAt(0) || ( input.LT(1) == $delimiter.text.charAt(0) && input.LT(2) != '\'') }? => . )*
// 		( { input.LT(1) == $delimiter.text.charAt(0) && input.LT(2) == '\'' }? => . ) QUOTE
/* C Syntax */ 
		( { LA(1) != $delimiter->getText(delimiter)->chars[0] || LA(2) != '\'' }? => . )*
		( { LA(1) == $delimiter->getText(delimiter)->chars[0] && LA(2) == '\'' }? => . ) QUOTE
 		{ INPUT->istream->_LA = oldLA; }
		;

BINDVAR /*options { testLiterals=true; }*/
    :	COLON 'A' .. 'Z' ( 'A' .. 'Z' | '0' .. '9' | '_' | '$' | '#' | COLON )*
    |	COLON DOUBLEQUOTED_STRING
    |	COLON NUM
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
doublevertbar
	:	DOUBLEVERTBAR
    |	VERTBAR VERTBAR
    ;
DOUBLEVERTBAR
	:	'||'
	;
not_equal
	:	NOT_EQ
    |	LTH GTH
    |	'!' EQ
    |	'^' EQ
    ;
NOT_EQ
	:	'<>' | '!=' | '^=' | '~='
	;
LTH
	:	'<'
	;
leq
	:	LEQ
    |	LTH EQ
    ;
LEQ
	:	'<='
	;
GTH
	:	'>'
	;
geq
	: GEQ
    | GTH EQ
    ;
GEQ
	:	'>='
	;
NUMBER
	:	//( PLUS | MINUS )?
		(	( NUM POINT NUM ) => NUM POINT NUM
		|	POINT NUM
		|	NUM
		)
		( 'E' ( PLUS | MINUS )? NUM )?
		( 'D' | 'F')?		
    ;
fragment
NUM
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


ZV	:	'@!' {$channel=HIDDEN;}
	;
