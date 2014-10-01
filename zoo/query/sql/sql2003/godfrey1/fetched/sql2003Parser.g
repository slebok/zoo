parser grammar sql2003Parser;

options
{
    language=Java;
    tokenVocab=sql2003Lexer;
    output=AST;
    backtrack=true;
    memoize=true;
}

// !!WARNING!! This grammar requires 64bit Java 1.6 and heap size for AntlrWorks [1GB] and Antlr [8GB] or greater.
// 
// !!WARNING!! Your PC or Mac will require 10GB RAM or greater!
//
// You need to specify the heap size separately for both AntlrWorks and for Antlr [when it is run by AntlrWorks]
// specify -Xmx8G in AntlrWorks::Preferences::General::ANTLR_options
// specify -Xmx1G on the Java command line for invoking AntlrWorks
//
// java16 -d64 -jar antlr_33_complete.jar -Xmx8G -Xwatchconversion sql2003Parser.g
//
// on Mac OS X right-click the ANTLRWorks.app package, select Show Package Contents and edit the info.plist file
//   add a new child to the Java property
//     Key   = VMOptions
//     Value = [string] -Xms256m -Xmx1G
//     Key   = VMArchs
//     Value = [array] [string] x86_64
//
//   or in XML format
//    <key>Java</key>
//    <dict>
//        <key>ClassPath</key>
//        <string>$JAVAROOT/antlrworks.jar</string>
//        <key>JVMVersion</key>
//        <string>1.6</string>
//        <key>MainClass</key>
//        <string>org.antlr.works.IDE</string>
//        <key>VMOptions</key>
//        <string>-Xmx1G</string>
//        <key>JVMArchs</key>
//        <array>
//          <string>x86_64</string>
//        </array> 
//    </dict>
//
// This SQL 2003 grammar has infinite look-ahead in some of the rules relating to SQL expressions.
// The grammar will not generate no matter how much memory you have until the infinite look-ahead is resolved.
// The likely culpret is the cluster of rules involving predicate, value_expression, value_expression_primary,
// and nonparenthesized_value_expression_primary.
//
// If you manage to resolve the infinite lookahead, please repost the updated grammar on the Antlr.org site

/*
=====================================================================================

BNF Grammar for ISO/IEC 9075-2:2003 - Database Language SQL (SQL-2003) SQL/Foundation

=====================================================================================

This software is made available under the BSD License:

Copyright (c) 2011, Mage Systems
Portions Copyright (c) Jonathan Leffler 2004-2009'
Portions Copyright (c) 2003, ISO - International Organization for Standardization
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this
      list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of the "Mage Systems" nor the names of its contributors
      may be used to endorse or promote products derived from this software
      without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
OF THE POSSIBILITY OF SUCH DAMAGE.



Information taken from the Final Committee Draft (FCD) of ISO/IEC 9075-2:2003.
However, the page numbers and some section titles (9.14 through 9.23,
for example) are from the final standard.
This means there could be other as yet undiagnosed differences between
the final standard and the notation in this document; you were warned!

The plain text version of this grammar is
--## <a href='sql-2003-2.bnf'> sql-2003-2.bnf </a>.
*/


/*
	Key SQL Statements and Fragments
		* ALTER DOMAIN <alter domain statement>
		* ALTER TABLE <alter table statement>
		* CLOSE cursor <close statement>
		* Column definition <column definition>
		* COMMIT WORK <commit statement>
		* CONNECT <connect statement>
		* CREATE ASSERTION <assertion definition>
		* CREATE CHARACTER SET <character set definition>
		* CREATE COLLATION <collation definition>
		* CREATE DOMAIN <domain definition>
		* CREATE FUNCTION <schema function>
		* CREATE PROCEDURE <schema procedure>
		* CREATE SCHEMA <schema definition>
		* CREATE TABLE <table definition>
		* CREATE TRANSLATION <translation definition>
		* CREATE TRIGGER <trigger definition>
		* CREATE VIEW <view definition>
		* Data type <data type>
		* DEALLOCATE PREPARE <deallocate prepared statement>
		* DECLARE cursor <declare cursor> <dynamic declare cursor>
		* DECLARE LOCAL TEMPORARY TABLE <temporary table declaration>
		* DELETE <delete statement: positioned> <delete statement: searched> <dynamic delete statement: positioned>
		* DESCRIBE <describe statement>
		* DESCRIPTOR statements <system descriptor statement>
		* DISCONNECT <disconnect statement>
		* EXECUTE <execute statement>
		* EXECUTE IMMEDIATE <execute immediate statement>
		* FETCH cursor <fetch statement>
		* FROM clause <from clause>
		* GET DIAGNOSTICS <get diagnostics statement>
		* GRANT <grant statement>
		* GROUP BY clause <group by clause>
		* HAVING clause <having clause>
		* INSERT <insert statement>
		* Literals <literal>
		* Keywords <key word>
		* MERGE <merge statement>
		* OPEN cursor <open statement>
		* ORDER BY clause <order by clause>
		* PREPARE <prepare statement>
		* REVOKE <revoke statement>
		* ROLLBACK WORK <rollback statement>
		* SAVEPOINT <savepoint statement>
		* Search condition <search condition> <regular expression>
		* SELECT <query specification>
		* SET CATALOG <set catalog statement>
		* SET CONNECTION <set connection statement>
		* SET CONSTRAINTS <set constraints mode statement>
		* SET NAMES <set names statement>
		* SET SCHEMA <set schema statement>
		* SET SESSION AUTHORIZATION <set session user identifier statement>
		* SET TIME ZONE <set local time zone statement>
		* SET TRANSACTION <set transaction statement>
		* SQL Client MODULE <SQL-client module definition>
		* UPDATE <update statement: positioned> <update statement: searched> <dynamic update statement: positioned>
		* Value expression <value expression>
		* WHERE clause <where clause>
*/


//-------------------------------------------------------------------------
//
//  Start Rule
//
//-------------------------------------------------------------------------


sql2003Parser
	:	( sql_client_module_definition
		| externally_invoked_procedure
		| sql_invoked_procedure
		| sql_invoked_function
		| ( sql_procedure_statement Semicolon )+
		)
		EOF
	;

//-------------------------------------------------------------------------
//
//  Parser Rules
//
//-------------------------------------------------------------------------


left_bracket_or_trigraph    : Left_Bracket  | Left_Bracket_Trigraph;
right_bracket_or_trigraph   : Right_Bracket | Right_Bracket_Trigraph;

unimplemented_error : { error(UNIMPLEMENTED_FEATURE, $text); skip(); } ;


//  Keyword Tokens

/*
key_word
	:	reserved_word
	| 	non_reserved_word;


reserved_word  :
		ADD
	|	ALL
	|	ALLOCATE
	|	ALTER
	|	AND
	|	ANY
	|	ARE
	|	ARRAY
	|	AS
	|	ASENSITIVE
	|	ASYMMETRIC
	|	AT
	|	ATOMIC
	|	AUTHORIZATION
	|	BEGIN
	|	BETWEEN
	|	BIGINT
	|	BINARY
	|	BLOB
	|	BOOLEAN
	|	BOTH
	|	BY
	|	CALL
	|	CALLED
	|	CASCADED
	|	CASE
	|	CAST
	|	CHAR
	|	CHARACTER
	|	CHECK
	|	CLOB
	|	CLOSE
	|	COLLATE
	|	COLUMN
	|	COMMIT
	|	CONNECTION
	|	CONNECT
	|	CONSTRAINT
	|	CONSTRUCTOR
	|	CONTINUE
	|	CORRESPONDING
	|	CREATE
	|	CROSS
	|	CUBE
	|	CURRENT
	|	CURRENT_DATE
	|	CURRENT_DEFAULT_TRANSFORM_GROUP
	|	CURRENT_PATH
	|	CURRENT_ROLE
	|	CURRENT_TIME
	|	CURRENT_TIMESTAMP
	|	CURRENT_TRANSFORM_GROUP_FOR_TYPE
	|	CURRENT_USER
	|	CURSOR
	|	CYCLE
	|	DATE
	|	DAY
	|	DEALLOCATE
	|	DEC
	|	DECIMAL
	|	DECLARE
	|	DEFAULT
	|	DELETE
	|	DEREF
	|	DESCRIBE
	|	DETERMINISTIC
	|	DISCONNECT
	|	DISTINCT
	|	DOUBLE
	|	DROP
	|	DYNAMIC
	|	EACH
	|	ELEMENT
	|	ELSE
	|	END
	|	END_EXEC
	|	ESCAPE
	|	EXCEPT
	|	EXEC
	|	EXECUTE
	|	EXISTS
	|	EXIT
	|	EXTERNAL
	|	FALSE
	|	FETCH
	|	FILTER
	|	FOR
	|	FOREIGN
	|	FREE
	|	FROM
	|	FULL
	|	FUNCTION
	|	GENERATED
	|	GET
	|	GLOBAL
	|	GRANT
	|	GROUP
	|	GROUPING
	|	HAVING
	|	HOLD
	|	HOUR
	|	IDENTITY
	|	IMMEDIATE
	|	IN
	|	INDICATOR
	|	INNER
	|	INOUT
	|	INPUT
	|	INSENSITIVE
	|	INSERT
	|	INT
	|	INTEGER
	|	INTERSECT
	|	INTERVAL
	|	INTO
	|	IS
	|	ISOLATION
	|	JOIN
	|	LANGUAGE
	|	LARGE
	|	LATERAL
	|	LEADING
	|	LEFT
	|	LIKE
	|	LOCAL
	|	LOCALTIME
	|	LOCALTIMESTAMP
	|	MATCH
	|	MEMBER
	|	MERGE
	|	METHOD
	|	MINUTE
	|	MODIFIES
	|	MODULE
	|	MONTH
	|	MULTISET
	|	NATIONAL
	|	NATURAL
	|	NCHAR
	|	NCLOB
	|	NEW
	|	NO
	|	NONE
	|	NOTFOUND
	|	NOT
	|	NULL
	|	NUMERIC
	|	OF
	|	OLD
	|	ON
	|	ONLY
	|	OPEN
	|	OR
	|	ORDER
	|	OUT
	|	OUTER
	|	OUTPUT
	|	OVER
	|	OVERLAPS
	|	PARAMETER
	|	PARTITION
	|	PRECISION
	|	PREPARE
	|	PRIMARY
	|	PROCEDURE
	|	RANGE
	|	READS
	|	REAL
	|	RECURSIVE
	|	REF
	|	REFERENCES
	|	REFERENCING
	|	RELEASE
	|	RETURN
	|	RETURNS
	|	REVOKE
	|	RIGHT
	|	ROLLBACK
	|	ROLLUP
	|	ROW
	|	ROWS
	|	SAVEPOINT
	|	SCOPE
	|	SCROLL
	|	SEARCH
	|	SECOND
	|	SELECT
	|	SENSITIVE
	|	SESSION_USER
	|	SET
	|	SIMILAR
	|	SMALLINT
	|	SOME
	|	SPECIFIC
	|	SPECIFICTYPE
	|	SQL
	|	SQLEXCEPTION
	|	SQLSTATE
	|	SQLWARNING
	|	START
	|	STATIC
	|	SUBMULTISET
	|	SYMMETRIC
	|	SYSTEM
	|	SYSTEM_USER
	|	TABLE
	|	THEN
	|	TIME
	|	TIMESTAMP
	|	TIMEZONE_HOUR
	|	TIMEZONE_MINUTE
	|	TO
	|	TRAILING
	|	TRANSLATION
	|	TREAT
	|	TRIGGER
	|	TRUE
	|	UNDO
	|	UNION
	|	UNIQUE
	|	UNKNOWN
	|	UNNEST
	|	UPDATE
	|	USER
	|	USING
	|	VALUE
	|	VALUES
	|	VARCHAR
	|	VARYING
	|	WHEN
	|	WHENEVER
	|	WHERE
	|	WINDOW
	|	WITH
	|	WITHIN
	|	WITHOUT
	|	YEAR
	;
*/

non_reserved_word  :
		ABS
	|	ABSOLUTE
	|	ACTION
	|	ADA
	|	ADMIN
	|	AFTER
	|	ALWAYS
	|	ASC
	|	ASSERTION
	|	ASSIGNMENT
	|	ATTRIBUTE
	|	ATTRIBUTES
	|	AUTO
	|	AVG
	|	BEFORE
	|	BERNOULLI
	|	BIN
	|	BREADTH
	|	CARDINALITY
	|	CASCADE
	|	CATALOG
	|	CATALOG_NAME
	|	CEIL
	|	CEILING
	|	CHAIN
	|	CHARACTERISTICS
	|	CHARACTERS
	|	CHARACTER_LENGTH
	|	CHARACTER_SET_CATALOG
	|	CHARACTER_SET_NAME
	|	CHARACTER_SET_SCHEMA
	|	CHAR_LENGTH
	|	CHAR
	|	CHECKED
	|	CLASS_ORIGIN
	|	COALESCE
	|	COBOL
	|	CODE_UNITS
	|	COLLATION
	|	COLLATION_CATALOG
	|	COLLATION_NAME
	|	COLLATION_SCHEMA
	|	COLLECT
	|	COLUMN_NAME
	|	COMMAND_FUNCTION
	|	COMMAND_FUNCTION_CODE
	|	COMMITTED
	|	CONDITION
	|	CONDITION_NUMBER
	|	CONNECTION_NAME
	|	CONSTRAINTS
	|	CONSTRAINT_CATALOG
	|	CONSTRAINT_NAME
	|	CONSTRAINT_SCHEMA
	|	CONSTRUCTORS
	|	CONST
	|	CONTAINS
	|	CONVERT
	|	CORR
	|	COUNT
	|	COVAR_POP
	|	COVAR_SAMP
	|	CUME_DIST
	|	CURRENT_COLLATION
	|	CURSOR_NAME
	|	DATA
	|	DATETIME_INTERVAL_CODE
	|	DATETIME_INTERVAL_PRECISION
	|	DCL
	|	DEFAULTS
	|	DEFERRABLE
	|	DEFERRED
	|	DEFINED
	|	DEFINER
	|	DEGREE
	|	DENSE_RANK
	|	DEPTH
	|	DERIVED
	|	DESC
	|	DESCRIPTOR
	|	DIAGNOSTICS
	|	DISPATCH
	|	DISPLAY
	|	DOMAIN
	|	DOUBLE_PRECISION
	|	DYNAMIC_FUNCTION
	|	DYNAMIC_FUNCTION_CODE
	|	EQUALS
	|	EVERY
	|	EXCEPTION
	|	EXCLUDE
	|	EXCLUDING
	|	EXP
	|	EXTERN
	|	EXTRACT
	|	FINAL
	|	FIRST
	|	FIXED
	|	FLOAT
	|	FLOOR
	|	FOLLOWING
	|	FORTRAN
	|	FOUND
	|	FUSION
	|	GENERAL
	|	GO
	|	GOTO
	|	GRANTED
	|	HIERARCHY
	|	IMPLEMENTATION
	|	INCLUDING
	|	INCREMENT
	|	INDICATOR_TYPE
	|	INITIALLY
	|	INSTANCE
	|	INSTANTIABLE
	|	INTERFACES
	|	INTERSECTION
	|	INVOKER
	|	ISOLATION
	|	KEY
	|	KEY_MEMBER
	|	KEY_TYPE
	|	KIND
	|	LAST
	|	LENGTH
	|	LEN
	|	LEVEL
	|	LN
	|	LOGICAL
	|	LOCATOR
	|	LONG
	|	LOWER
	|	MAP
	|	MATCHED
	|	MAX
	|	MAXVALUE
	|	MESSAGE_LENGTH
	|	MESSAGE_OCTET_LENGTH
	|	MESSAGE_TEXT
	|	MIN
	|	MINVALUE
	|	MOD
	|	MORE
	|	MUMPS
	|	NAME
	|	NAMES
	|	NESTING
	|	NEXT
	|	NORMALIZE
	|	NORMALIZED
	|	NULLABLE
	|	NULLIF
	|	NULLS
	|	NUMBER
	|	OBJECT
	|	OCTETS
	|	OCTET_LENGTH
	|	OPTION
	|	OPTIONS
	|	ORDERING
	|	ORDINALITY
	|	OTHERS
	|	OVERLAY
	|	OVERRIDING
	|	PAD
	|	PACKED
	|	PARAMETER_MODE
	|	PARAMETER_NAME
	|	PARAMETER_ORDINAL_POSITION
	|	PARAMETER_SPECIFIC_CATALOG
	|	PARAMETER_SPECIFIC_NAME
	|	PARAMETER_SPECIFIC_SCHEMA
	|	PARTIAL
	|	PASCAL
	|	PATH
	|	PERCENTILE_CONT
	|	PERCENTILE_DISC
	|	PERCENT_RANK
	|	PICTURE
	|	PIC
	|	PLACING
	|	PLI
	|	POSITION
	|	POWER
	|	PRECEDING
	|	PRESERVE
	|	PRIOR
	|	PRIVILEGES
	|	PUBLIC
	|	RANK
	|	READ
	|	REGR_AVGX
	|	REGR_AVGY
	|	REGR_COUNT
	|	REGR_INTERCEPT
	|	REGR_R2
	|	REGR_SLOPE
	|	REGR_SXX
	|	REGR_SXY
	|	REGR_SYY
	|	RELATIVE
	|	REPEATABLE
	|	RESTART
	|	RESTRICT
	|	RESULT
	|	RETURNED_CARDINALITY
	|	RETURNED_LENGTH
	|	RETURNED_OCTET_LENGTH
	|	RETURNED_SQLSTATE
	|	ROLE
	|	ROUTINE
	|	ROUTINE_CATALOG
	|	ROUTINE_NAME
	|	ROUTINE_SCHEMA
	|	ROW_COUNT
	|	ROW_NUMBER
	|	SCALE
	|	SCHEMA
	|	SCHEMA_NAME
	|	SCOPE_CATALOG
	|	SCOPE_NAME
	|	SCOPE_SCHEMA
	|	SECTION
	|	SECURITY
	|	SELF
	|	SEPARATE
	|	SEQUENCE
	|	SERIALIZABLE
	|	SERVER_NAME
	|	SESSION
	|	SETS
	|	SHORT
	|	SIGNED
	|	SIGN
	|	SIMPLE
	|	SIZE
	|	SOURCE
	|	SPACE
	|	SPECIFIC_NAME
	|	SQLSTATE_TYPE
	|	SQRT
	|	STATE
	|	STATEMENT
	|	STDDEV_POP
	|	STDDEV_SAMP
	|	STRUCTURE
	|	STYLE
	|	SUBCLASS_ORIGIN
	|	SUBSTRING
	|	SUM
	|	TABLESAMPLE
	|	TABLE_NAME
	|	TEMPORARY
	|	TIES
	|	TOP_LEVEL_COUNT
	|	TRANSACTION
	|	TRANSACTIONS_COMMITTED
	|	TRANSACTIONS_ROLLED_BACK
	|	TRANSACTION_ACTIVE
	|	TRANSFORM
	|	TRANSFORMS
	|	TRANSLATE
	|	TRIGGER_CATALOG
	|	TRIGGER_NAME
	|	TRIGGER_SCHEMA
	|	TRIM
	|	TYPE
	|	UNBOUNDED
	|	UNCOMMITTED
	|	UNDER
	|	UNNAMED
	|	UNSIGNED
	|	UPPER
	|	USAGE
	|	USER_DEFINED_TYPE_CATALOG
	|	USER_DEFINED_TYPE_CODE
	|	USER_DEFINED_TYPE_NAME
	|	USER_DEFINED_TYPE_SCHEMA
	|	VAR_POP
	|	VAR_SAMP
	|	VIEW
	|	VOLATILE
	|	WIDTH_BUCKET
	|	WORK
	|	WRITE
	|	ZONE
	;


/*
		 5.4 Names and identifiers (p151)
*/

identifier   	   
	options{k=1;} 
	:  
	/*( non_reserved_word )=> non_reserved_word |*/ Regular_Identifier | Unicode_Identifier;
sql_language_identifier          
	options{k=1;}  				 
	:  Regular_Identifier;
user_identifier                  
	options{k=1;}  				 
	:  Regular_Identifier;
schema_name                      
	options{k=1;}  				 
	:  identifier  ( Period  identifier )? ;
fully_qualified_identifier       
	options{k=1;}  				 
	:  identifier  ( Period  identifier (  Period  identifier )? )?;

table_name                       
	options{k=1;}  				 
	:  	( MODULE Period identifier
		| identifier  ( Period  identifier (  Period  identifier )? )?
		);
cursor_name                      
	options{k=1;}  				 
	:  ( MODULE  Period )? identifier ;
external_routine_name            
	options{k=1;}  				 
	:  identifier  | Character_String_Literal  ;
sql_statement_name               
	options{k=1;}  				 
	:  identifier  | scoped_identifier ;
dynamic_cursor_name              
	options{k=1;}  				 
	:  cursor_name  | scoped_identifier ;
scoped_identifier                
	options{k=1;}  				 
	:  ( scope_option  )? simple_value_specification ;
scope_option                     
	options{k=1;}  				 
	:  GLOBAL | LOCAL;

connection_name                  
	options{k=1;}  				 
	:  simple_value_specification ;
sql_server_name                  
	options{k=1;}  				 
	:  simple_value_specification ;
connection_user_name             
	options{k=1;}  				 
	:  simple_value_specification ;

simple_value_specification  	 
	options{k=1;}  				 
	:	literal
	//|	host_parameter_name 	 // Colon identifier
	|	identifier_chain 		 // identifier ( Period identifier )*
	;

column_reference
	options{k=1;}  				 
	: 	identifier_chain | MODULE Period identifier  Period identifier;
identifier_chain   				 :  identifier  ( Period identifier  )*;

/*
		 5.2 <token> and <separator> (p134)

Specifying lexical units (tokens and separators) that participate in SQL language.
*/

/*
token  :  nondelimiter_token | delimiter_token;

nondelimiter_token :
		Regular_Identifier
	|	Unsigned_Float
	|	Unsigned_Integer
	|	Unsigned_Large_Integer
	|	Signed_Float
	|	Signed_Integer
	|	Signed_Large_Integer
	|	key_word
	;

delimiter_token :
		Unicode_Identifier
	|	Character_String_Literal
	|	National_Character_String_Literal
	|	Unicode_Character_String_Literal
	|	Bit_String_Literal
	|	Hex_String_Literal
	|	date_literal
	|	time_literal
	|	timestamp_literal
	|	interval_literal
	|	Unicode_Identifier
	|	SQL_Special_Character
	|	Not_Equals_Operator
	|	Greater_Or_Equals_Operator
	|	Less_Or_Equals_Operator
	|	Concatenation_Operator
	|	Right_Arrow
	|	Left_Bracket_Trigraph
	|	Right_Bracket_Trigraph
	|	Double_Colon
	|	Double_Period
	;
*/

/*
		 5.3 <literal> (p143)
*/


general_literal
	options{k=1;}
	:	Character_String_Literal
	|	National_Character_String_Literal
	|	Bit_String_Literal
	|	Hex_String_Literal
	|	boolean_literal
	|	day_time_literal
	|	interval_literal
	;

boolean_literal             :  TRUE | FALSE | UNKNOWN;

signed_numeric_literal   :  Signed_Integer | Signed_Large_Integer | Signed_Float;

unsigned_numeric_literal  :  Unsigned_Integer | Unsigned_Large_Integer | Unsigned_Float ;

literal
	options{k=1;}
	:	Signed_Integer
	|	Signed_Float
	|	general_literal ;


/*
The Quote symbol  rule consists of two immediately adjacent Quote
marks with no spaces.
As usual, this would be best handled in the lexical analyzer, not in the
grammar.
*/

quote_symbol   :  Quote Quote;

sign   :  Plus_Sign | Minus_Sign;


datetime_literal            :   date_literal  | time_literal  | timestamp_literal ;

date_literal                :   DATE Quote years_value  Minus_Sign months_value Minus_Sign days_value  Quote  ;

time_literal                :   TIME Quote hours_value  Colon minutes_value  Colon seconds_value
                                (  ( Plus_Sign | Minus_Sign )  hours_value  Colon minutes_value )?  Quote  ;

timestamp_literal           :   TIMESTAMP Quote  years_value  Minus_Sign months_value Minus_Sign days_value
                                         Space hours_value  Colon minutes_value  Colon seconds_value
                                         (  ( Plus_Sign | Minus_Sign )  hours_value  Colon minutes_value )?
                                         Quote ;

interval_literal            :   INTERVAL
                                Quote ( Plus_Sign | Minus_Sign )? ( year_month_literal | day_time_literal ) Quote;

year_month_literal          :  years_value  | years_value  Minus_Sign months_value ;

day_time_literal            :  day_time_interval  | time_interval ;

day_time_interval           :  DAYS days_value  Space hours_value  ( Colon minutes_value  ( Colon seconds_value  )? )?;

time_interval               :  HOURS hours_value  ( Colon minutes_value   ( Colon seconds_value )? )?;


years_value                 :  Unsigned_Integer ;

months_value                :  Unsigned_Integer ;

days_value                  :  Unsigned_Integer ;

hours_value                 :  Unsigned_Integer ;

minutes_value               :  Unsigned_Integer ;

seconds_value               :  Unsigned_Integer  ( Period ( Unsigned_Integer  )? )?;

/*
		 10.1 interval_qualifier  (p465)

Specify the precision of an interval data type.
*/

interval_qualifier
	options{k=1;}
	:	datetime_field_name  ( Left_Paren Unsigned_Integer  Right_Paren )?
			(
				TO
				(	datetime_field_name
				|	SECOND ( Left_Paren Unsigned_Integer  Right_Paren )?
				)
			)?
	|	SECOND ( Left_Paren Unsigned_Integer  ( Comma Unsigned_Integer  )? Right_Paren )?
	;

primary_datetime_field  : YEAR | MONTH | DAY | HOUR | MINUTE | SECOND;

datetime_field_name   :  YEAR | MONTH | DAY | HOUR | MINUTE;

/*
	6 Scalar expressions

		 6.1 <data type> (p161)
*/

data_type
	options{k=1;}
	:	predefined_type
	|	row_type
	|	fully_qualified_identifier
	|	reference_type
	|	array_type
	| 	multiset_type
	;

//data_type  :
//		predefined_type
//	|	row_type
//	|	path_resolved_user_defined_type_name
//	|	reference_type
//	|	collection_type
//	;

predefined_type
	options{k=1;}
	:	character_string_type
		( CHARACTER SET Character_Set_Name )?
		( collate_clause  )?
	|	national_character_string_type
		( collate_clause  )?
	|	binary_large_object_string_type
	|	numeric_type
	|	boolean_type
	|	datetime_type
	|	interval_type
	;

character_string_type
	options{k=1;}
	:	(	CHARACTER |	CHAR )
		( 	Left_Paren length  Right_Paren )?

	|	(	CHARACTER VARYING |	CHAR VARYING | VARCHAR )
			Left_Paren length  Right_Paren

	|	(	CHARACTER LARGE OBJECT | CHAR LARGE OBJECT | CLOB )
			( Left_Paren large_object_length  Right_Paren )?
	;

national_character_string_type
	options{k=1;}
	:	(	NATIONAL CHARACTER | NATIONAL CHAR | NCHAR
		)	( Left_Paren length  Right_Paren )?

	|	(	NATIONAL CHARACTER VARYING | NATIONAL CHAR VARYING | NCHAR VARYING )
			Left_Paren length  Right_Paren

	|	(	NATIONAL CHARACTER LARGE OBJECT | NCHAR LARGE OBJECT | NCLOB )
		 	( Left_Paren large_object_length  Right_Paren )?
	;

binary_large_object_string_type
	options{k=1;}
	:	(	BINARY LARGE OBJECT | BLOB )
		( 	Left_Paren large_object_length  Right_Paren )?
	;

numeric_type
	options{k=1;}
	:	exact_numeric_type
	|	approximate_numeric_type ;

exact_numeric_type
	options{k=1;}
	:	(	NUMERIC
		|	DECIMAL
		|	DEC
		)
		( Left_Paren precision  ( Comma scale  )? Right_Paren )?
	|	SMALLINT
	|	INTEGER
	|	INT
	|	BIGINT
	;

approximate_numeric_type
	options{k=1;}
	:	FLOAT ( Left_Paren precision  Right_Paren )?
	|	REAL
	|	DOUBLE PRECISION
	;

length
	:	Unsigned_Integer ;

large_object_length
	options{k=1;}
	:	(	Unsigned_Integer | Unsigned_Large_Integer )
		(	char_length_units  )?
	;

char_length_units
	: 	CHARACTERS | CODE_UNITS | OCTETS;

precision
	: 	Unsigned_Integer ;

scale
	:	Unsigned_Integer ;

boolean_type
	:	BOOLEAN;

datetime_type
	options{k=1;}
	:	DATE
	|	(	TIME |	TIMESTAMP )
		( Left_Paren Unsigned_Integer  Right_Paren )?
		( with_or_without_time_zone  )?
	;

with_or_without_time_zone           :  ( WITH | WITHOUT ) TIME ZONE;

time_precision                      :  time_fractional_seconds_precision ;

timestamp_precision                 :  time_fractional_seconds_precision ;

time_fractional_seconds_precision   :  Unsigned_Integer ;

interval_type                       :  INTERVAL interval_qualifier ;

row_type                            :  ROW row_type_body ;

row_type_body                       :  Left_Paren field_definition  ( Comma field_definition  )* Right_Paren;

reference_type                      :  REF Left_Paren fully_qualified_identifier  Right_Paren ( scope_clause  )?;

scope_clause                        :  SCOPE table_name ;

collection_type
	options{k=2;}
	:   (	predefined_type
		|	row_type
		|	fully_qualified_identifier
		|	reference_type 				// duplicate of fully_qualified_identifier
 		)
		( 	ARRAY ( left_bracket_or_trigraph Unsigned_Integer  right_bracket_or_trigraph )?
 		|	MULTISET
 		)*;

//collection_type
//	options{k=2;}
//	:	array_type
//	|	multiset_type ;

array_type :  	collection_type;

//array_type
//	options{k=2;}
//	:  	( 	predefined_type
//		|	row_type
//		|	fully_qualified_identifier
//		|	reference_type
//		| 	multiset_type
//		)
//		( ARRAY ( left_bracket_or_trigraph Unsigned_Integer  right_bracket_or_trigraph )? )*;

// array_type                       :  data_type  ARRAY ( left_bracket_or_trigraph Unsigned_Integer  right_bracket_or_trigraph )?;

multiset_type 	:	collection_type;

// multiset_type                    :  data_type  MULTISET;

//multiset_type
//	options{k=2;}
//	:	(	predefined_type
//		|	row_type
//		|	fully_qualified_identifier
//		|	reference_type
//		|	array_type
//		)
//		( MULTISET )*;

//data_type
//	:	predefined_type
//	|	row_type
//	|	fully_qualified_identifier
//	|	reference_type
//	|	collection_type
//	;

/*
		 6.2 field_definition  (p173)
*/

field_definition   :  identifier  data_type  ( reference_scope_check  )?;

/*
		 6.3 <value expression primary> (p174)
/*

/*
value_expression_primary  :
		parenthesized_value_expression
	|	nonparenthesized_value_expression_primary
	;

nonparenthesized_value_expression_primary  :
		unsigned_value_specification
	|	column_reference
	|	set_function_specification
	|	window_function
	|	scalar_subquery
	|	case_expression
	|	cast_specification
	|	field_reference
	|	subtype_treatment
	|	method_invocation
	|	static_method_invocation
	|	new_specification
	|	attribute_or_method_reference
	|	reference_resolution
	|	collection_value_constructor
	|	array_element_reference
	|	multiset_element_reference
	|	routine_invocation
	|	next_value_expression
	;

*/
parenthesized_value_expression
	options{k=1;}
	:  Left_Paren value_expression  Right_Paren;

/*

		 6.4 <value specification> and <target specification> (p176)*/

value_specification
	options{k=1;}
	:	literal
	|	general_value_specification ;

unsigned_value_specification
	options{k=1;}
	:	Unsigned_Integer
	|	general_value_specification ;

general_value_specification
	options{k=1;}
	:
//	host_parameter_specification 		// Colon identifier  ( ( INDICATOR )? Colon identifier )?;
//	|	embedded_variable_specification 	// duplicate of host_parameter_specification
	|	identifier_chain 					// identifier ( Period identifier )*
	|	dynamic_parameter_specification 	// Question_Mark
	|	current_collation_specification 	// CURRENT_COLLATION Left_Paren string_value_expression  Right_Paren
	|	CURRENT_DEFAULT_TRANSFORM_GROUP
	|	CURRENT_PATH
	|	CURRENT_ROLE
	|	CURRENT_TRANSFORM_GROUP_FOR_TYPE fully_qualified_identifier
	|	CURRENT_USER
	|	SESSION_USER
	|	SYSTEM_USER
	|	USER
	|	VALUE
	;

target_specification
	options{k=1;}
	:
//	host_parameter_specification 		// host_parameter_name  ( indicator_parameter  )?;
	|	target_column_or_array_element 		// column_reference ( left_bracket simple_value_specification  right_bracket )?
	|	dynamic_parameter_specification 	// Question_Mark
	;
//	|	column_reference 					// identifier_chain | MODULE Period identifier Period identifier
//	|	embedded_variable_specification 	// duplicate of host_parameter_specification
//	|	identifier_chain 					// called by column_reference

target_column_or_array_element
	options{k=1;}
	:	column_reference  ( left_bracket_or_trigraph simple_value_specification  right_bracket_or_trigraph )? ;

simple_target_specification
	options{k=1;}
	:
//	host_parameter_specification 		// host_parameter_name  ( indicator_parameter  )?;
	|	column_reference 					// identifier_chain | MODULE Period identifier Period identifier
//	|	host_parameter_name 				// called by host_parameter_specification
//	|	identifier_chain 					// called by column_reference
	;
/*
host_parameter_specification
	options{k=1;}
	:	host_parameter_name  ( indicator_parameter  )?;
*/
dynamic_parameter_specification
	:	Question_Mark;

// embedded_variable_specification   :  host_parameter_name  ( indicator_variable  )?;

// indicator_variable   :  INDICATOR host_parameter_name ;

// indicator_variable   :  ( INDICATOR )? host_parameter_name ;

// indicator_parameter   :  INDICATOR host_parameter_name ;

// indicator_parameter   :  ( INDICATOR )? host_parameter_name ;

target_array_element_specification  :
		target_array_reference  left_bracket_or_trigraph simple_value_specification  right_bracket_or_trigraph ;

target_array_reference   :  column_reference ; // | identifier_chain called by column_reference

current_collation_specification   :  CURRENT_COLLATION Left_Paren string_value_expression  Right_Paren;

/*
		 6.5 <contextually typed value specification> (p181)*/

contextually_typed_value_specification  
	options {k=1;}
	:	implicitly_typed_value_specification  
	| 	default_specification ;

implicitly_typed_value_specification   
	options {k=1;}
	:  	null_specification  
	| 	empty_specification ;

null_specification   
	options {k=1;}
	:  NULL;

empty_specification  
	options {k=1;}
	:	ARRAY left_bracket_or_trigraph right_bracket_or_trigraph
	|	MULTISET left_bracket_or_trigraph right_bracket_or_trigraph
	;

default_specification   
	options {k=1;}
	:  DEFAULT;

/*
		 6.6 <identifier chain> (p183)*/

//identifier_chain   :  identifier  ( Period identifier  )*;

//identifier_chain   :  identifier_chain ;

/*
		 6.7 column_reference  (p187)*/

//column_reference  :
//		identifier_chain
//	|	MODULE Period identifier  Period identifier
//	;

/*
		 6.8 identifier_chain  (p190)*/

//identifier_chain   :  identifier_chain ;

/*
		 6.9 set_function_specification  (p191)
*/

set_function_specification   
	options{k=1;}
	:  aggregate_function  | grouping_operation ;

grouping_operation   :  GROUPING Left_Paren column_reference  ( Comma column_reference  )* Right_Paren;

/*
		 6.10 window_function  (p193)
*/

window_function   
	options {k=1;}
	:  window_function_type  OVER window_name_or_specification ;

window_function_type
	options {k=1;}
	:
		rank_function_type  Left_Paren Right_Paren
	|	ROW_NUMBER Left_Paren Right_Paren
	|	aggregate_function
	;

rank_function_type   :  RANK | DENSE_RANK | PERCENT_RANK | CUME_DIST;

window_name_or_specification   :  identifier  | in_line_window_specification ;

in_line_window_specification   :  window_specification ;

/*

		 6.11 case_expression  (p197)*/

case_expression   
	options{k=1;}
	:  case_abbreviation  | case_specification ;

case_abbreviation  :
		NULLIF Left_Paren value_expression  Comma value_expression  Right_Paren
	|	COALESCE Left_Paren value_expression  ( Comma value_expression  )+ Right_Paren;

case_specification   :  simple_case  | searched_case ;

simple_case   :  CASE case_operand  ( simple_when_clause )+ ( else_clause  )? END;

searched_case   :  CASE ( searched_when_clause )+ ( else_clause  )? END;

simple_when_clause   :  WHEN when_operand  THEN result ;

searched_when_clause   :  WHEN search_condition  THEN result ;

else_clause   :  ELSE result ;

case_operand
	options {k=1;}
	:	row_value_predicand
	| 	overlaps_predicate_part_1;

when_operand
	options {k=1;}
	:
		row_value_predicand

	|	comparison_predicate_part_2
	|	quantified_comparison_predicate_part_2

	|	between_predicate_part_2
	|	in_predicate_part_2

	|	character_like_predicate_part_2
//	|	octet_like_predicate_part_2

	|	similar_predicate_part_2
	|	null_predicate_part_2
	|	match_predicate_part_2
	|	overlaps_predicate_part_2
	|	distinct_predicate_part_2
	|	member_predicate_part_2
	|	submultiset_predicate_part_2
	|	set_predicate_part_2
	|	type_predicate_part_2
	;

result   :  result_expression  | NULL;

result_expression   :  value_expression ;

/*
		 6.12 cast_specification  (p200)
*/

cast_specification
	options{k=1;}
	:	CAST
		Left_Paren
			cast_operand
			AS cast_target
		Right_Paren;

cast_operand
	options{k=1;}
	:	value_expression
	|	implicitly_typed_value_specification ;

cast_target
	:	fully_qualified_identifier
	|	data_type ;

/*
		 6.13 next_value_expression  (p216)
*/

next_value_expression   
	options{k=1;}
	:  NEXT VALUE FOR fully_qualified_identifier ;

/*
		 6.14 field_reference  (p218)
*/

/*

field_reference   :  value_expression_primary  Period identifier ;

*/

/*
		 6.15 subtype_treatment  (p219)
*/

subtype_treatment  
	options{k=1;}
	:
		TREAT Left_Paren subtype_operand  AS target_subtype  Right_Paren;

subtype_operand   :  value_expression ;

target_subtype  :
		fully_qualified_identifier
	|	reference_type
	;

/*

		 6.16 method_invocation  (p221)
*/

/*
method_invocation   :  direct_invocation  | generalized_invocation ;

direct_invocation  :
		value_expression_primary  Period identifier  ( sql_argument_list )?;
*/
generalized_invocation
	options{k=1;}
	:	Left_Paren
			value_expression_primary
			AS data_type
		Right_Paren
		Period identifier
		( sql_argument_list )?
		;

method_selection   :  routine_invocation ;

constructor_method_selection   :  routine_invocation ;

/*

		 6.17 static_method_invocation  (p223)*/

static_method_invocation  
	options{k=1;}
	:
		fully_qualified_identifier  Double_Colon  identifier  ( sql_argument_list )?;

static_method_selection   :  routine_invocation ;

/*

		 6.18 new_specification  (p225)*/

new_specification
	options{k=1;}
	:	NEW routine_invocation ;

new_invocation
	options{k=1;}
	:	method_invocation
	|	routine_invocation ;

/*

		 6.19 attribute_or_method_reference  (p227)
*/

/*

attribute_or_method_reference  :
		value_expression_primary  Right_Arrow  identifier
		( sql_argument_list )?
		;

*/
// dereference_operator   :  Right_Arrow ;

/*

		 6.20 <dereference operation> (p229)*/

dereference_operation   :  reference_value_expression  Right_Arrow  identifier ;

/*

		 6.21 <method reference> (p230)*/

method_reference  :
		value_expression_primary  Right_Arrow  identifier  sql_argument_list;

/*

		 6.22 reference_resolution  (p232)*/

reference_resolution   
	options{k=1;}
	:  DEREF Left_Paren reference_value_expression  Right_Paren;

/*
		 6.23 array_element_reference  (p234)
*/

/*

array_element_reference  :
		array_value_expression  left_bracket_or_trigraph numeric_value_expression  right_bracket_or_trigraph ;

*/
/*
		 6.24 multiset_element_reference  (p235)*/

multiset_element_reference  
	options{k=1;}
	:
		ELEMENT Left_Paren multiset_value_expression  Right_Paren;

/*
		 6.25 value_expression  (p236)

Specify a value.
*/

value_expression
	options {k=1;}
	:	common_value_expression
	|	boolean_value_expression
	|	row_value_expression
	;

common_value_expression
	options {k=1;}
	:	numeric_value_expression
	|	string_value_expression
	|	datetime_value_expression
	|	interval_value_expression
	|	collection_value_expression
	|	reference_value_expression
//	|	user_defined_type_value_expression // duplicates reference_value_expression
	;

user_defined_type_value_expression
	options {k=1;}
	: 	value_expression_primary ;

reference_value_expression
	options {k=1;}
	:	value_expression_primary ;

collection_value_expression
	options {k=1;}
	:	array_value_expression
	|	multiset_value_expression ;

collection_value_constructor
	options{k=1;}
	:	array_value_constructor  		// value_expression_primary ( Concatenation_Operator  value_expression_primary )*
	|	multiset_value_constructor ;

/*
		 6.26 numeric_value_expression  (p240)

Specify a numeric value.
*/

numeric_value_expression
	options{k=1;}
	:	term ( ( Plus_Sign | Minus_Sign ) term )*
	;

term
	options{k=1;}
	:	factor ( ( Asterisk | Slash ) factor )*
	;

factor
	options{k=1;}
	:  ( sign  )? numeric_primary ;

numeric_primary
	options{k=1;}
	:	value_expression_primary
	|	numeric_value_function
	;

/*
		 6.27 numeric_value_function  (p242)


Specify a function yielding a value of type numeric.
*/

numeric_value_function
	options{k=1;}
	:	position_expression
	|	extract_expression
	|	length_expression
	|	cardinality_expression
	|	absolute_value_expression
	|	modulus_expression
	|	natural_logarithm
	|	exponential_function
	|	power_function
	|	square_root
	|	floor_function
	|	ceiling_function
	|	width_bucket_function
	;

position_expression  :
		string_position_expression
	|	blob_position_expression
	;

string_position_expression  :
		POSITION Left_Paren string_value_expression  IN string_value_expression  ( USING char_length_units  )? Right_Paren;

blob_position_expression  :
		POSITION Left_Paren character_value_expression  IN character_value_expression  Right_Paren;

length_expression  :
		char_length_expression
	|	octet_length_expression
	;

char_length_expression  :
		( CHAR_LENGTH | CHARACTER_LENGTH ) Left_Paren string_value_expression  ( USING char_length_units  )? Right_Paren;

octet_length_expression   :  OCTET_LENGTH Left_Paren string_value_expression  Right_Paren;

extract_expression   :  EXTRACT Left_Paren extract_field  FROM extract_source  Right_Paren;

extract_field   :  primary_datetime_field  | time_zone_field ;

time_zone_field   :  TIMEZONE_HOUR | TIMEZONE_MINUTE;

extract_source
	options{k=1;}
	:	datetime_value_expression
	|	interval_value_expression ;

cardinality_expression   :  CARDINALITY Left_Paren collection_value_expression  Right_Paren;

absolute_value_expression   :  ABS Left_Paren numeric_value_expression  Right_Paren;

modulus_expression   :  MOD Left_Paren numeric_value_expression  Comma numeric_value_expression Right_Paren;

natural_logarithm   :  LN Left_Paren numeric_value_expression  Right_Paren;

exponential_function   :  EXP Left_Paren numeric_value_expression  Right_Paren;

power_function   :  POWER Left_Paren numeric_value_expression  Comma numeric_value_expression  Right_Paren;

square_root   :  SQRT Left_Paren numeric_value_expression  Right_Paren;

floor_function   :  FLOOR Left_Paren numeric_value_expression  Right_Paren;

ceiling_function   :  ( CEIL | CEILING ) Left_Paren numeric_value_expression  Right_Paren;

width_bucket_function   :  WIDTH_BUCKET Left_Paren numeric_value_expression  Comma numeric_value_expression  Comma numeric_value_expression  Comma numeric_value_expression  Right_Paren;

/*
		 6.28 string_value_expression  (p251)


Specify a character string value or a binary string value.
*/

string_value_expression
	options{k=1;}
	:	character_value_expression; //  | blob_value_expression ;

character_value_expression
	options{k=1;}
	:	character_factor ( Concatenation_Operator  character_factor )*;
// character_value_expression   :  concatenation  | character_factor ;

// concatenation   :  character_value_expression  Concatenation_Operator  character_factor ;

character_factor
	options{k=1;}
	:	character_primary
		( collate_clause  )?;

character_primary
	options{k=1;}
	:	value_expression_primary
	|	string_value_function ;

/*
blob_value_expression   :  blob_factor ( Concatenation_Operator  blob_factor )* ;
// blob_value_expression   :  blob_concatenation  | blob_factor ;

blob_factor   :  blob_primary ;

blob_primary   :  value_expression_primary  | string_value_function ;

// blob_concatenation   :  blob_value_expression  Concatenation_Operator  blob_factor ;
*/

/*
		 6.29 string_value_function  (p255)


Specify a function yielding a value of type character string or binary string.
*/

string_value_function
	options{k=1;}
	:	character_value_function
	|	blob_value_function ;

character_value_function
	options{k=1;}
	:	character_substring_function
	|	regular_expression_substring_function
	|	fold
	|	transcoding
	|	character_transliteration
	|	trim_function
	|	character_overlay_function
	|	normalize_function
	|	specific_type_method
	;

character_substring_function
	options{k=1;}
	:	SUBSTRING
		Left_Paren
			character_value_expression
			FROM start_position
			( FOR string_length  )?
			( USING char_length_units  )?
		Right_Paren;

regular_expression_substring_function
	options{k=1;}
	:	SUBSTRING
		Left_Paren
			character_value_expression
			SIMILAR character_value_expression
			ESCAPE Character_String_Literal
		Right_Paren;

fold
	options{k=1;}
	:	( UPPER | LOWER )
		Left_Paren
			character_value_expression
		Right_Paren;

transcoding
	options{k=1;}
	:	CONVERT
		Left_Paren
			character_value_expression
			USING fully_qualified_identifier
		Right_Paren;

character_transliteration
	options{k=1;}
	:	TRANSLATE
		Left_Paren
			character_value_expression
			USING fully_qualified_identifier
		Right_Paren;

trim_function
	options{k=1;}
	:	TRIM
		Left_Paren
			trim_operands
		Right_Paren;

trim_operands
	options{k=1;}
	:	trim_source
	|	trim_specification	// ( trim_specification )?
		( trim_character  )?
		FROM
		trim_source ;

trim_source   :  character_value_expression ;

trim_specification   :  LEADING | TRAILING | BOTH;

trim_character   :  character_value_expression ;

character_overlay_function
	options{k=1;}
	:	OVERLAY
		Left_Paren
			character_value_expression
			PLACING character_value_expression
			FROM start_position
			( FOR string_length  )?
			( USING char_length_units  )?
		Right_Paren;


normalize_function
	options{k=1;}
	:	NORMALIZE
		Left_Paren
			character_value_expression
		Right_Paren;

specific_type_method   :  user_defined_type_value_expression  Period SPECIFICTYPE;

blob_value_function
	options{k=1;}
	:	blob_substring_function
	|	blob_trim_function
	|	blob_overlay_function
	;

blob_substring_function
	options{k=1;}
	:	SUBSTRING
		Left_Paren
			character_value_expression
			FROM start_position
			( FOR string_length  )?
		Right_Paren;

blob_trim_function
	options{k=1;}
	:	TRIM
		Left_Paren
			blob_trim_operands
		Right_Paren;

blob_trim_operands
	options{k=1;}
	:	blob_trim_source
	|	trim_specification
		( trim_octet  )?
		FROM
		blob_trim_source ;

blob_trim_source   :  character_value_expression ;

trim_octet   :  character_value_expression ;

blob_overlay_function
	options{k=1;}
	:	OVERLAY
		Left_Paren
			character_value_expression
			PLACING character_value_expression
			FROM start_position
			( FOR string_length  )?
		Right_Paren;

start_position   :  numeric_value_expression ;

string_length   :  numeric_value_expression ;

/*
		 6.30 datetime_value_expression  (p266)

Specify a datetime value.
*/

datetime_value_expression
	options{k=1;}
	:	( interval_value_expression  Plus_Sign)? datetime_term
		( ( Plus_Sign | Minus_Sign) interval_term )*
	;

datetime_term
	options{k=1;}
	:	datetime_factor ;

datetime_factor
	options{k=1;}
	:	datetime_primary  ( time_zone  )?;

datetime_primary
	options{k=1;}
	:	pure_numeric_value_expression
	|	datetime_value_function ;

//datetime_primary
//	:	value_expression_primary
//	|	datetime_value_function ;

time_zone
	options{k=1;}
	:	AT time_zone_specifier ;

time_zone_specifier
	options{k=1;}
	:	LOCAL | TIME ZONE interval_primary ;

/*
		 6.31 datetime_value_function  (p269)


Specify a function yielding a value of type datetime.
*/

datetime_value_function
	options{k=1;}
	:	current_date_value_function
	|	current_time_value_function
	|	current_timestamp_value_function
	|	current_local_time_value_function
	|	current_local_timestamp_value_function
	;

current_date_value_function
	options{k=1;}
	:	CURRENT_DATE;

current_time_value_function
	options{k=1;}
	:	CURRENT_TIME ( Left_Paren time_precision  Right_Paren )?;

current_local_time_value_function
	options{k=1;}
	:	LOCALTIME ( Left_Paren time_precision  Right_Paren )?;

current_timestamp_value_function
	options{k=1;}
	:	CURRENT_TIMESTAMP ( Left_Paren timestamp_precision  Right_Paren )?;

current_local_timestamp_value_function
	options{k=1;}
	:	LOCALTIMESTAMP ( Left_Paren timestamp_precision  Right_Paren )?;

/*
		 6.32 interval_value_expression  (p271)

Specify an interval value.
*/

interval_value_expression
	options{k=1;}
	:	(	interval_term
		|	Left_Paren datetime_value_expression  Minus_Sign datetime_term  Right_Paren interval_qualifier
		)
		( ( Plus_Sign | Minus_Sign ) interval_term )*
	;

interval_term
	options{k=1;}
	:	( pure_numeric_term Asterisk )?
		interval_factor
		( ( Asterisk | Slash ) pure_numeric_factor )*
	;

//interval_term
//	options{k=1;}
//	:	( term  Asterisk )? interval_factor
//		( ( Asterisk | Slash ) factor )*
//	;

interval_factor
	options{k=1;}
	:  	( sign  )? interval_primary ;

interval_primary
	options{k=1;}
	:	pure_numeric_value_expression  ( interval_qualifier  )?
	|	interval_value_function
	;

pure_numeric_value_expression
	options{k=1;}
	:	 ( ( Plus_Sign | Minus_Sign ) pure_numeric_term )*
	;

pure_numeric_term
	options{k=1;}
	:	pure_numeric_factor ( ( Asterisk | Slash ) pure_numeric_factor )*
	;

pure_numeric_factor
	options{k=1;}
	:  ( sign  )? pure_numeric_primary ;

pure_numeric_primary
	options{k=1;}
	:	unsigned_value_specification
	|	numeric_value_function
//	|	host_parameter_specification
	|	column_reference
	;

/*
		 6.33 interval_value_function  (p276)*/

interval_value_function
	options{k=1;}
	:	interval_absolute_value_function ;

interval_absolute_value_function
	options{k=1;}
	:	ABS Left_Paren interval_value_expression  Right_Paren;

/*
		 6.34 boolean_value_expression  (p277)*/

boolean_value_expression
	options{k=1;}
	:	boolean_term ( OR boolean_term )*
	;

boolean_term
	options {k=1;}
	:	boolean_factor ( AND boolean_factor )*
	;

boolean_factor
	options {k=1;}
	:  ( NOT )? boolean_test ;

boolean_test
	options {k=1;}
	:  boolean_primary  ( IS ( NOT )? truth_value  )?;

truth_value   :  TRUE | FALSE | UNKNOWN;

boolean_primary
	options {k=1;}
	:	predicate
	|	boolean_predicand;

boolean_predicand
	options {k=1;}
	:	parenthesized_boolean_value_expression
	|	nonparenthesized_value_expression_primary
	;


parenthesized_boolean_value_expression
	options {k=1;}
	:  Left_Paren boolean_value_expression  Right_Paren;

/*
		 6.35 array_value_expression  (p284)
*/

//array_element_reference  :
//		array_value_expression  left_bracket_or_trigraph numeric_value_expression  right_bracket_or_trigraph ;

array_value_expression
	:	value_expression_primary ( Concatenation_Operator  value_expression_primary )*;

// array_value_expression   :  array_concatenation  | array_factor ;

// array_concatenation   :  array_value_expression  Concatenation_Operator  array_factor ;
// array_concatenation   :  array_value_expression_1  Concatenation_Operator  array_factor ;

// array_value_expression_1   :  array_value_expression ;

// array_factor   :  value_expression_primary ;


method_invocation
	options{k=1;}
	:	generalized_invocation
	|	value_expression_primary  Period identifier  ( sql_argument_list )?
	;
// method_invocation   :  direct_invocation  | generalized_invocation ;

value_expression_primary
	options{k=1;}
	:	(	parenthesized_value_expression
		|	unsigned_value_specification
		|	column_reference
		|	set_function_specification
		|	window_function
		|	scalar_subquery
		|	case_expression
		|	cast_specification
		|	subtype_treatment
		|	static_method_invocation
		|	new_specification
		|	reference_resolution
		|	collection_value_constructor
		|	multiset_element_reference
		|	routine_invocation
		|	next_value_expression
		|	generalized_invocation
		)
		(	 Period identifier  ( sql_argument_list )?
		|	 Right_Arrow  identifier ( sql_argument_list )?
		|	( Concatenation_Operator  value_expression_primary )*  left_bracket_or_trigraph numeric_value_expression  right_bracket_or_trigraph
		)*
	;

//value_expression_primary  :
//		parenthesized_value_expression
//	|	nonparenthesized_value_expression_primary
//	;

nonparenthesized_value_expression_primary
	options {k=1;}
	:	unsigned_value_specification
	|	column_reference
	|	set_function_specification
	|	window_function
	|	scalar_subquery
	|	case_expression
	|	cast_specification
	|	subtype_treatment
	|	static_method_invocation
	|	new_specification
	|	reference_resolution
	|	collection_value_constructor
	|	multiset_element_reference
	|	routine_invocation
	|	next_value_expression
	|	generalized_invocation

	|	value_expression_primary ( Concatenation_Operator  value_expression_primary )*  left_bracket_or_trigraph numeric_value_expression  right_bracket_or_trigraph
	|	value_expression_primary  Period identifier  ( sql_argument_list )?
	|	value_expression_primary  Right_Arrow  identifier ( sql_argument_list )?
	|	value_expression_primary  Period identifier
	;

// direct_invocation  :
//		value_expression_primary  Period identifier  ( sql_argument_list )?;

// field_reference   :  value_expression_primary  Period identifier ;

//attribute_or_method_reference  :
//		value_expression_primary  Right_Arrow  identifier ( sql_argument_list )?
//		;

/*
		 6.36 array_value_constructor  (p284)*/

array_value_constructor  :
		array_value_constructor_by_enumeration
	|	array_value_constructor_by_query ;

array_value_constructor_by_enumeration  :
		ARRAY left_bracket_or_trigraph array_element_list  right_bracket_or_trigraph;

array_element_list   :  array_element  ( Comma array_element  )*;

array_element   :  value_expression ;

array_value_constructor_by_query  :
		ARRAY Left_Paren query_expression  ( order_by_clause  )? Right_Paren;

/*
		 6.37 multiset_value_expression  (p286)
*/
multiset_value_expression
	options{k=1;}
	:	multiset_term ( MULTISET ( UNION | EXCEPT ) ( ALL | DISTINCT )? multiset_term )*
	;

multiset_term
	options{k=1;}
	:	multiset_primary ( MULTISET INTERSECT ( ALL | DISTINCT )? multiset_primary )*
	;

multiset_primary
	options{k=1;}
	:	multiset_value_function
	|	value_expression_primary ;

/*
		 6.38 multiset_value_function  (p289)
*/

multiset_value_function
	:	multiset_set_function ;

multiset_set_function
	:	SET Left_Paren multiset_value_expression  Right_Paren;

/*
		 6.39 multiset_value_constructor  (p290)
*/

multiset_value_constructor
	options{k=2;}
	:	multise_value_constructor_by_enumeration
	|	multiset_value_constructor_by_query
	|	table_value_constructor_by_query
	;

multise_value_constructor_by_enumeration
	options{k=2;}
	:	MULTISET left_bracket_or_trigraph multiset_element_list  right_bracket_or_trigraph;

multiset_element_list
	options{k=1;}
	:	multiset_element  ( Comma multiset_element  )*;

multiset_element
	:	value_expression ;

multiset_value_constructor_by_query
	options{k=2;}
	:	MULTISET Left_Paren query_expression  Right_Paren;

table_value_constructor_by_query
	options{k=1;}
	:	TABLE Left_Paren query_expression  Right_Paren;

/*

	7 Query expressions


		 7.1 <row value constructor> (p293)


Specify a value or list of values to be constructed into a row or partial row.
*/

row_value_constructor
	options {k=1;}
	:
		common_value_expression
	|	boolean_value_expression
	|	explicit_row_value_constructor
	;

explicit_row_value_constructor
	options {k=1;}
	:	Left_Paren row_value_constructor_element  Comma row_value_constructor_element_list  Right_Paren
	|	ROW Left_Paren row_value_constructor_element_list  Right_Paren
	|	row_subquery
	;

row_value_constructor_element_list  :
		row_value_constructor_element  ( Comma row_value_constructor_element  )*;

row_value_constructor_element   
	options {k=1;}
	:  value_expression ;

contextually_typed_row_value_constructor
	options {k=1;}
    :	common_value_expression
	|	boolean_value_expression
	|	contextually_typed_value_specification
//	|	Left_Paren contextually_typed_row_value_constructor_element  Comma contextually_typed_row_value_constructor_element_list  Right_Paren
	|	(ROW)? Left_Paren contextually_typed_row_value_constructor_element_list  Right_Paren
	;

contextually_typed_row_value_constructor_element_list  
	options {k=1;}
	:
		contextually_typed_row_value_constructor_element
		( Comma contextually_typed_row_value_constructor_element  )*;

contextually_typed_row_value_constructor_element
	options {k=1;}
	:	value_expression
	|	contextually_typed_value_specification
	;

row_value_constructor_predicand
	options {k=1;}
	:	common_value_expression
	|	boolean_predicand
	|	explicit_row_value_constructor
	;

/*
		 7.2 row_value_expression  (p296)


Specify a row value.
*/

row_value_expression
	options {k=1;}
	:	row_value_special_case
	|	explicit_row_value_constructor
	;

table_row_value_expression
	options {k=1;}
	:	row_value_special_case
	|	row_value_constructor
	;

contextually_typed_row_value_expression
	options {k=1;}
	:	row_value_special_case
	|	contextually_typed_row_value_constructor
	;

row_value_predicand
	options {k=1;}
	:	row_value_special_case
	|	row_value_constructor_predicand
	;

row_value_special_case
	options {k=1;}
	:  nonparenthesized_value_expression_primary ;

/*
		 7.3 <table value constructor> (p298)


Specify a set of row_value_expression(s) to be constructed into a table.
*/

table_value_constructor
	options {k=1;}
	:  VALUES row_value_expression_list ;

row_value_expression_list
	options {k=1;}
	:  table_row_value_expression  ( Comma table_row_value_expression  )*;

contextually_typed_table_value_constructor
	options {k=1;}
	:	VALUES
		contextually_typed_row_value_expression_list ;

contextually_typed_row_value_expression_list
	options {k=1;}
	:	contextually_typed_row_value_expression
    	( Comma contextually_typed_row_value_expression )*;

/*
		 7.4 <table expression> (p300)


Specify a table or a grouped table.
*/

table_expression
	options {k=1;}
	:	from_clause
		( where_clause  )?
		( group_by_clause  )?
		( having_clause  )?
		( window_clause  )?
		;

/*
		 7.5 from_clause  (p301)


Specify a table derived from one or more tables.
*/

from_clause
	:	FROM
		table_reference_list ;

table_reference_list
	options {k=1;}
	:	table_reference
		( Comma table_reference  )*;

/*
		 7.6 table_reference  (p303)

Reference a table.
*/

table_reference
	options {k=1;}
	:	(	table_primary
		|	joined_table
		)
		( sample_clause )?;

//table_reference   :  table_primary_or_joined_table  ( sample_clause  )?;

// table_primary_or_joined_table   :  table_primary  | joined_table ;

sample_clause
	:	TABLESAMPLE sample_method
		Left_Paren numeric_value_expression  Right_Paren
		( repeatable_clause  )?;

sample_method
	:	BERNOULLI
	|	SYSTEM;

repeatable_clause
	:	REPEATABLE Left_Paren numeric_value_expression  Right_Paren;

//sample_percentage   :	numeric_value_expression ;

//repeat_argument   :  numeric_value_expression ;

table_primary  :
		table_or_query_name  ( ( AS )? identifier  ( Left_Paren derived_column_list  Right_Paren )? )?
	|	derived_table  ( AS )? identifier  ( Left_Paren derived_column_list  Right_Paren )?
	|	lateral_derived_table  ( AS )? identifier  ( Left_Paren derived_column_list  Right_Paren )?
	|	collection_derived_table  ( AS )? identifier  ( Left_Paren derived_column_list  Right_Paren )?
	|	table_function_derived_table  ( AS )? identifier  ( Left_Paren derived_column_list  Right_Paren )?
	|	only_spec  ( ( AS )? identifier  ( Left_Paren derived_column_list  Right_Paren )? )?
	|	Left_Paren joined_table  Right_Paren
	;

only_spec   :  ONLY Left_Paren table_or_query_name  Right_Paren;

lateral_derived_table   :  LATERAL table_subquery ;

collection_derived_table   :  UNNEST Left_Paren collection_value_expression  Right_Paren ( WITH ORDINALITY )?;

table_function_derived_table   :  TABLE Left_Paren collection_value_expression  Right_Paren;

derived_table   :  table_subquery ;

table_or_query_name   :  table_name  | identifier ;

derived_column_list   :  column_name_list ;

column_name_list   
	options {k=1;}
	:  identifier  ( Comma identifier  )*;

/*
		 7.7 joined_table  (p312)


Specify a table derived from a Cartesian product, inner or outer join, or union join.
*/

joined_table  :
	table_primary
	(
		( 	sample_clause  )?
		(	CROSS JOIN table_primary
		|	( join_type  )? JOIN table_reference  join_specification
		|	NATURAL ( join_type  )? JOIN table_primary
		|	UNION JOIN table_primary
		)
	)+
	;

//joined_table  :
//		cross_join
//	|	qualified_join
//	|	natural_join
//	|	union_join
//	;

cross_join   		:  table_reference  CROSS JOIN table_primary ;

qualified_join   	:  table_reference  ( join_type  )? JOIN table_reference  join_specification ;

natural_join   		:  table_reference  NATURAL ( join_type  )? JOIN table_primary ;

union_join   		:  table_reference  UNION JOIN table_primary ;

join_specification  :  join_condition  | named_columns_join ;

join_condition   	:  ON search_condition ;

named_columns_join  :  USING Left_Paren join_column_list  Right_Paren;

join_type   		:  INNER | outer_join_type  ( OUTER )? ;

outer_join_type   	:  LEFT | RIGHT | FULL;

join_column_list   	:  column_name_list ;

/*
		 7.8 where_clause  (p319)


Specify a table derived by the application of a search_condition  to the result of the preceding
from_clause .
*/

where_clause   :  WHERE search_condition ;

/*
		 7.9 group_by_clause  (p320)


Specify a grouped table derived by the application of the group_by_clause  to the result of the
previously specified clause.
*/

group_by_clause   :  GROUP BY ( set_quantifier  )? grouping_element_list ;

grouping_element_list   :  grouping_element  ( Comma grouping_element  )*;

grouping_element  :
		ordinary_grouping_set
	|	rollup_list
	|	cube_list
	|	grouping_sets_specification
	|	empty_grouping_set
	;

ordinary_grouping_set  :
		grouping_column_reference
	|	Left_Paren grouping_column_reference_list  Right_Paren
	;

grouping_column_reference   :  column_reference  ( collate_clause  )?;

grouping_column_reference_list   :  grouping_column_reference  ( Comma grouping_column_reference  )*;

rollup_list   :  ROLLUP Left_Paren ordinary_grouping_set_list  Right_Paren;

ordinary_grouping_set_list   :  ordinary_grouping_set  ( Comma ordinary_grouping_set  )*;

cube_list   :  CUBE Left_Paren ordinary_grouping_set_list  Right_Paren;

grouping_sets_specification   :  GROUPING SETS Left_Paren grouping_set_list  Right_Paren;

grouping_set_list   :  grouping_set  ( Comma grouping_set  )*;

grouping_set  :
		ordinary_grouping_set
	|	rollup_list
	|	cube_list
	|	grouping_sets_specification
	|	empty_grouping_set
	;

empty_grouping_set   :  Left_Paren Right_Paren;

/*
		 7.10 having_clause  (p329)


Specify a grouped table derived by the elimination of groups that do not satisfy a search_condition .
*/

having_clause   :  HAVING search_condition ;

/*
		 7.11 window_clause  (p331)


Specify one or more window definitions.
*/

window_clause   :  WINDOW window_definition_list ;

window_definition_list   :  window_definition  ( Comma window_definition  )*;

window_definition   :  new_window_name  AS window_specification ;

new_window_name   :  identifier ;

window_specification   :  Left_Paren window_specification_details  Right_Paren;

window_specification_details  :
		( existing_window_name  )? ( window_partition_clause  )? ( window_order_clause  )? ( window_frame_clause  )?;

existing_window_name   :  identifier ;

window_partition_clause   :  PARTITION BY window_partition_column_reference_list ;

window_partition_column_reference_list   :  window_partition_column_reference  ( Comma window_partition_column_reference  )*;

window_partition_column_reference   :  column_reference  ( collate_clause  )?;

window_order_clause   :  ORDER BY sort_specification_list ;

window_frame_clause   :  window_frame_units  window_frame_extent  ( window_frame_exclusion  )?;

window_frame_units   :  ROWS | RANGE;

window_frame_extent   :  window_frame_start  | window_frame_between ;

window_frame_start   :  UNBOUNDED PRECEDING | window_frame_preceding  | CURRENT ROW;

window_frame_preceding   :  unsigned_value_specification  PRECEDING;

window_frame_between   :  BETWEEN window_frame_bound_1  AND window_frame_bound_2 ;

window_frame_bound_1   :  window_frame_bound ;

window_frame_bound_2   :  window_frame_bound ;

window_frame_bound  :
		window_frame_start
	|	UNBOUNDED FOLLOWING
	|	window_frame_following
	;

window_frame_following   :  unsigned_value_specification  FOLLOWING;

window_frame_exclusion  :
		EXCLUDE CURRENT ROW
	|	EXCLUDE GROUP
	|	EXCLUDE TIES
	|	EXCLUDE NO OTHERS
	;

/*
		 7.12 <query specification> (p341)


Specify a table derived from the result of a table_expression .
*/

query_specification
	options{k=1;}
	:  SELECT ( set_quantifier  )? select_list  table_expression ;

select_list
	options{k=1;}
	:	Asterisk
	|	select_sublist  ( Comma select_sublist  )*;

select_sublist
	options{k=1;}
	:	derived_column
	|	qualified_asterisk ;

qualified_asterisk
	options{k=1;}
	:	schema_name  Period Asterisk
	|	all_fields_reference
	;

derived_column
	options{k=1;}
	:	value_expression
		( as_clause  )?;

as_clause
	:	( AS )? identifier ;

all_fields_reference
	options{k=1;}
	:	value_expression_primary  Period Asterisk ( AS Left_Paren all_fields_column_name_list  Right_Paren )?;

all_fields_column_name_list
	options{k=1;}
	:	column_name_list ;

/*
		 7.13 query_expression  (p350)


Specify a table.
*/

query_expression
	options {k=1;}
	:  ( with_clause  )? query_expression_body ;

with_clause
	options {k=1;}
	:  WITH ( RECURSIVE )? with_list ;

with_list
	options {k=1;}
	:  with_list_element  ( Comma with_list_element  )*;

with_list_element
	options {k=1;}
	:	identifier  ( Left_Paren with_column_list  Right_Paren )?
		AS Left_Paren query_expression  Right_Paren ( search_or_cycle_clause  )?;

with_column_list   
	options {k=1;}
	:  column_name_list ;

query_expression_body
	options {k=1;}
	:	non_join_query_expression  | joined_table ;

//  query_expression_body   :  non_join_query_expression  | joined_table ;

non_join_query_expression
	options {k=1;}
	:	(	non_join_query_term
		|	joined_table  ( UNION | EXCEPT ) ( ALL | DISTINCT )? ( corresponding_spec  )? query_term
		)
		( ( UNION | EXCEPT ) ( ALL | DISTINCT )? ( corresponding_spec  )? query_term )*
	;

//non_join_query_expression  :
//		non_join_query_term
//	|	query_expression_body  UNION ( ALL | DISTINCT )? ( corresponding_spec  )? query_term
//	|	query_expression_body  EXCEPT ( ALL | DISTINCT )? ( corresponding_spec  )? query_term
//	;

query_term
	options {k=1;}
	:  non_join_query_term  | joined_table ;

//query_term   :  non_join_query_term  | joined_table ;

non_join_query_term
	options {k=1;}
	:	(	non_join_query_primary
		|	joined_table  INTERSECT ( ALL | DISTINCT )? ( corresponding_spec  )? query_primary
		)
		(	INTERSECT ( ALL | DISTINCT )? ( corresponding_spec  )? query_primary )*
	;

//non_join_query_term  :
//		non_join_query_primary
//	|	query_term  INTERSECT ( ALL | DISTINCT )? ( corresponding_spec  )? query_primary
//	;

query_primary
	options {k=1;}
	:	non_join_query_primary
	|	joined_table ;

non_join_query_primary
	options {k=1;}
	:	simple_table
	|	Left_Paren non_join_query_expression  Right_Paren;

simple_table
	options {k=1;}
	:	query_specification
	|	table_value_constructor
	|	explicit_table
	;

explicit_table
	options {k=1;}
	:  TABLE table_or_query_name ;

corresponding_spec   :  CORRESPONDING ( BY Left_Paren corresponding_column_list  Right_Paren )?;

corresponding_column_list   :  column_name_list ;

/*
		 7.14 search_or_cycle_clause  (p363)

Specify the generation of ordering and cycle detection information in the result of recursive query
expressions.
*/

search_or_cycle_clause
    options {k=1;}
    :
		search_clause
	|	cycle_clause
	|	search_clause  cycle_clause
	;

search_clause   :  SEARCH recursive_search_order  SET sequence_column ;

recursive_search_order  :
		DEPTH FIRST BY sort_specification_list
	|	BREADTH FIRST BY sort_specification_list
	;

sequence_column   :  identifier ;

cycle_clause  :
		CYCLE cycle_column_list
		SET cycle_mark_column  TO cycle_mark_value
		DEFAULT non_cycle_mark_value
		USING path_column
		;

cycle_column_list   :  cycle_column  ( Comma cycle_column  )*;

cycle_column   :  identifier ;

cycle_mark_column   :  identifier ;

path_column   :  identifier ;

cycle_mark_value   :  value_expression ;

non_cycle_mark_value   :  value_expression ;

/*
		 7.15 <subquery> (p368)


Specify a scalar value, a row, or a table derived from a query_expression .
*/

scalar_subquery   
	options {k=1;}
	:  subquery ;

row_subquery
	options {k=1;}
	:  subquery ;

table_subquery   :  subquery ;

subquery
	options {k=1;}
	:  Left_Paren query_expression  Right_Paren;

/*
	8 Predicates

		 8.1 predicate  (p371)

Specify a condition that can be evaluated to give a boolean value.
*/

predicate
	options {k=1;}
	:	comparison_predicate
	|	between_predicate
	|	in_predicate
	|	like_predicate
	|	similar_predicate
	|	null_predicate
	|	quantified_comparison_predicate
	|	exists_predicate
	|	unique_predicate
	|	normalized_predicate
	|	match_predicate
	|	overlaps_predicate
	|	distinct_predicate
	|	member_predicate
	|	submultiset_predicate
	|	set_predicate
	|	type_predicate
	;

/*
		 8.2 comparison_predicate  (p373)

Specify a comparison of two row values.
*/

comparison_predicate
	options {k=1;}
	:  row_value_predicand  comparison_predicate_part_2 ;

comparison_predicate_part_2
	options {k=1;}
	:  comp_op  row_value_predicand ;

comp_op  :
		Equals_Operator
	|	Not_Equals_Operator
	|	Less_Than_Operator
	|	Greater_Than_Operator
	|	Less_Or_Equals_Operator
	|	Greater_Or_Equals_Operator
	;

/*
		 8.3 between_predicate  (p380)


Specify a range comparison.
*/

between_predicate   :  row_value_predicand  between_predicate_part_2 ;

between_predicate_part_2
	options {k=1;}
	:  ( NOT )? BETWEEN ( ASYMMETRIC | SYMMETRIC )? row_value_predicand  AND row_value_predicand ;

/*
		 8.4 in_predicate  (p381)


Specify a quantified comparison.
*/

in_predicate   :  row_value_predicand  in_predicate_part_2  ;

in_predicate_part_2
	options {k=1;}
	:  ( NOT )? IN in_predicate_value ;

in_predicate_value  :
		table_subquery
	|	Left_Paren in_value_list  Right_Paren
	;

in_value_list   :  row_value_expression  ( Comma row_value_expression  )*;

/*
		 8.5 like_predicate  (p383)


Specify a pattern-match comparison.
*/

like_predicate   :  character_like_predicate; //  | octet_like_predicate ;

character_like_predicate   :  row_value_predicand  character_like_predicate_part_2 ;

character_like_predicate_part_2
	options {k=1;}
	:  ( NOT )? LIKE character_pattern  ( ESCAPE Character_String_Literal  )?;

character_pattern   :  character_value_expression ;

/*
octet_like_predicate   :  row_value_predicand  octet_like_predicate_part_2 ;

octet_like_predicate_part_2   :  ( NOT )? LIKE octet_pattern  ( ESCAPE escape_octet  )?;

octet_pattern   :  character_value_expression ;
*/
escape_octet   :  character_value_expression ;

/*
		 8.6 similar_predicate  (p389)


Specify a character string similarity by means of a regular expression.
*/

similar_predicate   :  row_value_predicand  similar_predicate_part_2 ;

similar_predicate_part_2
	options {k=1;}
	:  ( NOT )? SIMILAR TO similar_pattern  ( ESCAPE Character_String_Literal  )?;

similar_pattern   :  character_value_expression ;

regular_expression  :
		regular_term ( Vertical_Bar regular_term )*
	;

regular_term  :
		regular_factor ( regular_factor )*
	;

regular_factor  :
		regular_primary ( Asterisk | Plus_Sign | Question_Mark | repeat_factor )*
	;

repeat_factor   :  Left_Brace low_value  ( upper_limit  )? Right_Brace;

upper_limit   :  Comma ( high_value  )?;

low_value   :  Unsigned_Integer ;

high_value   :  Unsigned_Integer ;

regular_primary  :
		character_specifier
	|	Percent
	|	regular_character_set
	|	Left_Paren regular_expression  Right_Paren
	;

character_specifier     :  non_escaped_character  | escaped_character ;

non_escaped_character   :  Regex_Non_Escaped_Unicode    /*!! See the Syntax Rules*/;

escaped_character       :  Regex_Escaped_Unicode        /*!! See the Syntax Rules*/;

regular_character_set  :
		Underscore
	|	Left_Bracket ( character_enumeration )+ Right_Bracket
	|	Left_Bracket ( Circumflex character_enumeration )+ Right_Bracket
	|	Left_Bracket ( character_enumeration_include )+
	    Circumflex   ( character_enumeration_exclude )+ Right_Bracket
	;

character_enumeration_include   :  character_enumeration ;

character_enumeration_exclude   :  character_enumeration ;

character_enumeration  :
		character_specifier
	|	character_specifier  Minus_Sign character_specifier
	|	Left_Bracket Colon regular_character_set_identifier  Colon Right_Bracket
	;

regular_character_set_identifier   :  identifier ;

/*
		 8.7 null_predicate  (p395)


Specify a test for a null value.
*/

null_predicate   :  row_value_predicand  null_predicate_part_2 ;

null_predicate_part_2
	options {k=1;}
	:  IS ( NOT )? NULL ;

/*
		 8.8 quantified_comparison_predicate  (p397)


Specify a quantified comparison.
*/

quantified_comparison_predicate   :  row_value_predicand  quantified_comparison_predicate_part_2 ;

quantified_comparison_predicate_part_2
	options {k=1;}
	:  comp_op  quantifier  table_subquery ;

quantifier   :  all  | some ;

all   :  ALL;

some   :  SOME | ANY;

/*
		 8.9 exists_predicate  (p399)


Specify a test for a non_empty set.
*/

exists_predicate   :  EXISTS table_subquery ;

/*
		 8.10 unique_predicate  (p400)


Specify a test for the absence of duplicate rows
*/

unique_predicate   :  UNIQUE table_subquery ;

/*
		 8.11 normalized_predicate  (p401)


Determine whether a character string value is normalized.
*/

normalized_predicate   :  string_value_expression  IS ( NOT )? NORMALIZED;

/*
		 8.12 match_predicate  (p402)


Specify a test for matching rows.
*/

match_predicate   :  row_value_predicand  match_predicate_part_2 ;

match_predicate_part_2
	options {k=1;}
	:  MATCH ( UNIQUE )? ( SIMPLE | PARTIAL | FULL )? table_subquery ;

/*
		 8.13 overlaps_predicate  (p405)


Specify a test for an overlap between two datetime periods.
*/

overlaps_predicate   :  overlaps_predicate_part_1  overlaps_predicate_part_2 ;

overlaps_predicate_part_1
	options {k=1;}
   :  row_value_predicand_1 ;

overlaps_predicate_part_2
	options {k=1;}
	:  OVERLAPS row_value_predicand_2 ;

row_value_predicand_1
	options {k=1;}
	:  row_value_predicand ;

row_value_predicand_2   :  row_value_predicand ;

/*
		 8.14 distinct_predicate  (p407)


Specify a test of whether two row values are distinct
*/

distinct_predicate   :  row_value_predicand_3  distinct_predicate_part_2 ;

distinct_predicate_part_2
	options {k=1;}
	:  IS DISTINCT FROM row_value_predicand_4 ;

row_value_predicand_3   :  row_value_predicand ;

row_value_predicand_4   :  row_value_predicand ;

/*
		 8.15 member_predicate  (p409)


Specify a test of whether a value is a member of a multiset.
*/

member_predicate   :  row_value_predicand  member_predicate_part_2 ;

member_predicate_part_2
	options {k=1;}
	:  ( NOT )? MEMBER ( OF )? multiset_value_expression ;

/*
		 8.16 submultiset_predicate  (p411)


Specify a test of whether a multiset is a submultiset of another multiset.
*/

submultiset_predicate   :  row_value_predicand  submultiset_predicate_part_2 ;

submultiset_predicate_part_2
	options {k=1;}
	:  ( NOT )? SUBMULTISET ( OF )? multiset_value_expression ;

/*
		 8.17 set_predicate  (p413)


Specify a test of whether a multiset is a set (that is, does not contain any duplicates).
*/

set_predicate   :  row_value_predicand  set_predicate_part_2 ;

set_predicate_part_2
	options {k=1;}
	:  IS ( NOT )? a SET;

a	:	Regular_Identifier {$Regular_Identifier.text == 'A'}?;

/*
		 8.18 type_predicate  (p414)

Specify a type test.
*/

type_predicate   :  row_value_predicand  type_predicate_part_2 ;

type_predicate_part_2
	options {k=1;}
	:  IS ( NOT )? OF Left_Paren type_list Right_Paren;

type_list   :  user_defined_type_specification  ( Comma user_defined_type_specification  )*;

user_defined_type_specification  :
		inclusive_user_defined_type_specification
	|	exclusive_user_defined_type_specification
	;

inclusive_user_defined_type_specification   :  fully_qualified_identifier ;

exclusive_user_defined_type_specification   :  ONLY fully_qualified_identifier ;

/*
		 8.19 search_condition  (p416)

Specify a condition that is True , False , or Unknown ,
depending on the value of a <boolean value expression>.
*/

search_condition   :  boolean_value_expression ;

/*

	9 Additional common rules


		 9.1 Retrieval assignment (p417)


		 9.2 Store assignment (p422)


		 9.3 Data types of results of aggregations (p427)


		 9.4 Subject routine determination (p430)


		 9.5 Type precedence list determination (p431)


		 9.6 Host parameter mode determination (p434)


		 9.7 Type name determination (p436)


		 9.8 Determination of identical values (p438)


		 9.9 Equality operations (p440)


		 9.10 Grouping operations (p443)


		 9.11 Multiset element grouping operations (p445)


		 9.12 Ordering operations (p447)


		 9.13 Collation determination (p449)


		 9.14 Execution of array-returning functions (p450)


		 9.15 Execution of multiset-returning functions (p453)


		 9.16 Data type identity (p454)


		 9.17 Determination of a from-sql function (p456)


		 9.18 Determination of a from-sql function for an overriding method (p457)


		 9.19 Determination of a to-sql function (p458)


		 9.20 Determination of a to-sql function for an overriding method (p459)


		 9.21 Generation of the next value of a sequence generator (p460)


		 9.22 Creation of a sequence generator (p461)


		 9.23 Altering a sequence generator (p463)



	10 Additional common elements

*/
/*
		 10.2 <language clause> (p469)


Specify a standard programming language.
*/

language_clause   :  LANGUAGE language_name ;

language_name   :  ADA | c | COBOL | FORTRAN | MUMPS | PASCAL | PLI | SQL;

c	:	Regular_Identifier {$Regular_Identifier.text == 'C'}?;

/*
Table 14 -- Standard programming languages

    *  Language keyword   Relevant standard
    *  ADA ISO/IEC 8652
    *  C ISO/IEC 9899
    *  COBOL ISO 1989
    *  FORTRAN ISO 1539
    *  MUMPS ISO/IEC 11756
    *  PASCAL ISO/IEC 7185 and ISO/IEC 10206
    *  PLI ISO 6160
    *  SQL ISO/IEC 9075

		 10.3 <path specification> (p471)

Specify an order for searching for an SQL-invoked routine.
*/

path_specification   :  PATH schema_name_list ;

schema_name_list   :  schema_name  ( Comma schema_name  )*;

/*
		 10.4 routine_invocation  (p472)


Invoke an SQL-invoked routine.
*/

routine_invocation
	options{k=1;}
	:	fully_qualified_identifier  sql_argument_list;

sql_argument_list  
	options{k=1;}
	:  Left_Paren ( sql_argument ( Comma sql_argument )* )? Right_Paren;

sql_argument
    options{k=1;}
    :
		value_expression
	|	target_specification
	|	generalized_expression
	;

generalized_expression
	:	value_expression  AS fully_qualified_identifier ;


/*
		 10.6 <specific routine designator> (p497)


Specify an SQL-invoked routine.
*/

specific_routine_designator  :
		SPECIFIC routine_type  fully_qualified_identifier
		|	routine_type  member_name
		( FOR fully_qualified_identifier  )?;

routine_type  :
		ROUTINE
	|	FUNCTION
	|	PROCEDURE
	|	( INSTANCE | STATIC | CONSTRUCTOR )? METHOD
	;

member_name   :  member_name_alternatives  ( data_type_list  )?;

member_name_alternatives   :  fully_qualified_identifier  | identifier ;

data_type_list   :  Left_Paren ( data_type  ( Comma data_type  )* )? Right_Paren;

/*
		 10.7 collate_clause  (p500)


Specify a default collating sequence.
*/

collate_clause   :  COLLATE fully_qualified_identifier ;

/*
		 10.8 <constraint name definition> and <constraint characteristics> (p501)


Specify the name of a constraint and its characteristics.
*/

constraint_name_definition   :  CONSTRAINT fully_qualified_identifier ;

constraint_characteristics  :
		constraint_check_time  ( ( NOT )? DEFERRABLE )?
	|	( NOT )? DEFERRABLE ( constraint_check_time  )?
	;

constraint_check_time   :  INITIALLY DEFERRED | INITIALLY IMMEDIATE;

/*
		 10.9 aggregate_function  (p503)


Specify a value computed from a collection of rows.
*/

aggregate_function
	options{k=1;}
	:	COUNT Left_Paren Asterisk Right_Paren ( filter_clause  )?
	|	general_set_function  ( filter_clause  )?
	|	binary_set_function   ( filter_clause  )?
	|	ordered_set_function  ( filter_clause  )?
	;

general_set_function
	options{k=1;}
	:  set_function_type  Left_Paren ( set_quantifier  )? value_expression  Right_Paren;

set_function_type   :  computational_operation ;

computational_operation  :
		AVG | MAX | MIN | SUM
	|	EVERY | ANY | SOME
	|	COUNT
	|	STDDEV_POP | STDDEV_SAMP | VAR_SAMP | VAR_POP
	|	COLLECT | FUSION | INTERSECTION
	;

set_quantifier   :  DISTINCT | ALL;

filter_clause   :  FILTER Left_Paren WHERE search_condition  Right_Paren;

binary_set_function
	options{k=1;}
	:	binary_set_function_type
		Left_Paren dependent_variable_expression  Comma independent_variable_expression  Right_Paren;

binary_set_function_type  :
		COVAR_POP | COVAR_SAMP | CORR | REGR_SLOPE
	|	REGR_INTERCEPT | REGR_COUNT | REGR_R2 | REGR_AVGX | REGR_AVGY
	|	REGR_SXX | REGR_SYY | REGR_SXY
	;

dependent_variable_expression   :  numeric_value_expression ;

independent_variable_expression   :  numeric_value_expression ;

ordered_set_function
	options{k=1;}
	:	hypothetical_set_function
	|	inverse_distribution_function ;

hypothetical_set_function   :
		rank_function_type
		Left_Paren hypothetical_set_function_value_expression_list  Right_Paren
		within_group_specification ;

within_group_specification   :  WITHIN GROUP Left_Paren ORDER BY sort_specification_list  Right_Paren;

hypothetical_set_function_value_expression_list   :  value_expression  ( Comma value_expression  )*;

inverse_distribution_function   :
		inverse_distribution_function_type
		Left_Paren inverse_distribution_function_argument
		Right_Paren within_group_specification ;

inverse_distribution_function_argument  :  numeric_value_expression ;

inverse_distribution_function_type   :  PERCENTILE_CONT | PERCENTILE_DISC;

/*
		 10.10 sort_specification_list  (p515)


Specify a sort order.
*/

sort_specification_list   :  sort_specification  ( Comma sort_specification  )*;

sort_specification   :  sort_key  ( ordering_specification  )? ( null_ordering  )?;

sort_key   :  value_expression ;

ordering_specification   :  ASC | DESC;

null_ordering   :  NULLS FIRST | NULLS LAST;

/*

	11 Schema definition and manipulation


		 11.1 <schema definition> (p517)


Define a schema.
*/

schema_definition   :  CREATE SCHEMA schema_name_clause
        ( schema_character_set_or_path  )?
        ( schema_element  )*;

schema_character_set_or_path  :
		schema_character_set_specification
	|	schema_path_specification
	|	schema_character_set_specification  schema_path_specification
	|	schema_path_specification  schema_character_set_specification
	;

schema_name_clause  :
		( schema_name )? ( AUTHORIZATION schema_authorization_identifier )?
	;

schema_authorization_identifier   :  identifier ;

schema_character_set_specification   :  DEFAULT CHARACTER SET Character_Set_Name ;

schema_path_specification   :  path_specification ;

schema_element  :
		table_definition
	|	view_definition
	|	domain_definition
	|	character_set_definition
	|	collation_definition
	|	transliteration_definition
	|	assertion_definition
	|	trigger_definition
	|	user_defined_type_definition
	|	user_defined_cast_definition
	|	user_defined_ordering_definition
	|	transform_definition
	|	schema_routine
	|	sequence_generator_definition
	|	grant_statement
	|	role_definition
	;

/*
		 11.2 <drop schema statement> (p520)


Destroy a schema.
*/

drop_schema_statement   :  DROP SCHEMA schema_name  drop_behavior ;

drop_behavior   :  CASCADE | RESTRICT;

/*
		 11.3 table_definition  (p523)


Define a persistent base table, a created local temporary table, or a global temporary table.
*/

table_definition  :
		CREATE ( table_scope  )? TABLE table_name  table_contents_source
		( ON COMMIT table_commit_action  ROWS )?
		;

table_contents_source  :
		table_element_list
	|	OF fully_qualified_identifier  ( subtable_clause  )? ( table_element_list  )?
	|	as_subquery_clause
	;

table_scope   :  global_or_local  TEMPORARY;

global_or_local   :  GLOBAL | LOCAL;

table_commit_action   :  PRESERVE | DELETE;

table_element_list   :  Left_Paren table_element  ( Comma table_element  )* Right_Paren;

table_element  :
		column_definition
	|	table_constraint_definition
	|	like_clause
	|	self_referencing_column_specification
	|	column_options
	;

self_referencing_column_specification   :  REF IS self_referencing_column_name  reference_generation ;

reference_generation   :  SYSTEM GENERATED | USER GENERATED | DERIVED;

self_referencing_column_name   :  identifier ;

column_options   :  identifier  WITH OPTIONS column_option_list ;

column_option_list   :  ( scope_clause  )? ( default_clause  )? ( column_constraint_definition  )*;

subtable_clause   :  UNDER supertable_clause ;

supertable_clause   :  supertable_name ;

supertable_name   :  table_name ;

like_clause   :  LIKE table_name  ( like_options  )?;

like_options   :  identity_option  | column_default_option ;

identity_option   :  INCLUDING IDENTITY | EXCLUDING IDENTITY;

column_default_option   :  INCLUDING DEFAULTS | EXCLUDING DEFAULTS;

as_subquery_clause   :  ( Left_Paren column_name_list  Right_Paren )? AS subquery  with_or_without_data ;

with_or_without_data   :  WITH NO DATA | WITH DATA;

/*
		 11.4 column_definition  (p534)


Define a column of a base table.
*/

column_definition  :
		identifier  ( data_type  | fully_qualified_identifier  )? ( reference_scope_check  )?
		( default_clause  | identity_column_specification  | generation_clause  )?
		( column_constraint_definition  )* ( collate_clause  )?
		;

column_constraint_definition   :  ( constraint_name_definition  )? column_constraint  ( constraint_characteristics  )?;

column_constraint  :
		NOT NULL
	|	unique_specification
	|	references_specification
	|	check_constraint_definition
	;

reference_scope_check   :  REFERENCES ARE ( NOT )? CHECKED ( ON DELETE reference_scope_check_action  )?;

reference_scope_check_action   :  referential_action ;

identity_column_specification  :
		GENERATED ( ALWAYS | BY DEFAULT ) AS IDENTITY
		( Left_Paren common_sequence_generator_options  Right_Paren )?
		;

generation_clause   :  generation_rule  AS generation_expression ;

generation_rule   :  GENERATED ALWAYS;

generation_expression   :  Left_Paren value_expression  Right_Paren;

/*
		 11.5 default_clause  (p539)


Specify the default for a column, domain, or attribute.
*/

default_clause   :  DEFAULT default_option ;

default_option  :
		literal
	|	datetime_value_function
	|	USER
	|	CURRENT_USER
	|	CURRENT_ROLE
	|	SESSION_USER
	|	SYSTEM_USER
	|	CURRENT_PATH
	|	implicitly_typed_value_specification
	;

/*
		 11.6 table_constraint_definition  (p543)


Specify an integrity constraint.
*/

table_constraint_definition   :  ( constraint_name_definition  )? table_constraint  ( constraint_characteristics  )?;

table_constraint  :
		unique_constraint_definition
	|	referential_constraint_definition
	|	check_constraint_definition
	;

/*
		 11.7 unique_constraint_definition  (p545)


Specify a uniqueness constraint for a table.
*/

unique_constraint_definition  :
		unique_specification  Left_Paren unique_column_list  Right_Paren
	|	UNIQUE ( VALUE )
	;

unique_specification   :  UNIQUE | PRIMARY KEY;

unique_column_list   :  column_name_list ;

/*
		 11.8 referential_constraint_definition  (p547)


Specify a referential constraint.
*/

referential_constraint_definition   :  FOREIGN KEY Left_Paren referencing_columns  Right_Paren references_specification ;

references_specification   :  REFERENCES referenced_table_and_columns  ( MATCH match_type  )? ( referential_triggered_action  )?;

match_type   :  FULL | PARTIAL | SIMPLE;

referencing_columns   :  reference_column_list ;

referenced_table_and_columns   :  table_name  ( Left_Paren reference_column_list  Right_Paren )?;

reference_column_list   :  column_name_list ;

referential_triggered_action   :  update_rule  ( delete_rule  )? | delete_rule  ( update_rule  )?;

update_rule   :  ON UPDATE referential_action ;

delete_rule   :  ON DELETE referential_action ;

referential_action   :  CASCADE | SET NULL | SET DEFAULT | RESTRICT | NO ACTION;

/*
		 11.9 check_constraint_definition  (p567)


Specify a condition for the SQL-data.
*/

check_constraint_definition   :  CHECK Left_Paren search_condition  Right_Paren;

/*
		 11.10 <alter table statement> (p569)


Change the definition of a table.
*/

alter_table_statement   :  ALTER TABLE table_name  alter_table_action ;

alter_table_action  :
		add_column_definition
	|	alter_column_definition
	|	drop_column_definition
	|	add_table_constraint_definition
	|	drop_table_constraint_definition
	;

/*
		 11.11 add_column_definition  (p570)


Add a column to a table.
*/

add_column_definition   :  ADD ( COLUMN )? column_definition ;

/*
		 11.12 alter_column_definition  (p572)


Change a column and its definition.
*/

alter_column_definition   :  ALTER ( COLUMN )? identifier  alter_column_action ;

alter_column_action  :
		set_column_default_clause
	|	drop_column_default_clause
	|	add_column_scope_clause
	|	drop_column_scope_clause
	|	alter_identity_column_specification
	;

/*
		 11.13 set_column_default_clause  (p573)


Set the default clause for a column.
*/

set_column_default_clause   :  SET default_clause ;

/*
		 11.14 drop_column_default_clause  (p574)


Drop the default clause from a column.
*/

drop_column_default_clause   :  DROP DEFAULT;

/*
		 11.15 add_column_scope_clause  (p575)


Add a non_empty scope for an existing column of data type REF in a base table.
*/

add_column_scope_clause   :  ADD scope_clause ;

/*
		 11.16 drop_column_scope_clause  (p576)


Drop the scope from an existing column of data type REF in a base table.
*/

drop_column_scope_clause   :  DROP SCOPE drop_behavior ;

/*
		 11.17 alter_identity_column_specification  (p578)


Change the options specified for an identity column.
*/

alter_identity_column_specification   :  ( alter_identity_column_option )+;

alter_identity_column_option  :
		alter_sequence_generator_restart_option
	|	SET basic_sequence_generator_option
	;

/*
		 11.18 drop_column_definition  (p579)


Destroy a column of a base table.
*/

drop_column_definition   :  DROP ( COLUMN )? identifier  drop_behavior ;

/*
		 11.19 add_table_constraint_definition  (p581)


Add a constraint to a table.
*/

add_table_constraint_definition   :  ADD table_constraint_definition ;

/*
		 11.20 drop_table_constraint_definition  (p582)


Destroy a constraint on a table.
*/

drop_table_constraint_definition   :  DROP CONSTRAINT fully_qualified_identifier  drop_behavior ;

/*
		 11.21 <drop table statement> (p585)


Destroy a table.
*/

drop_table_statement   :  DROP TABLE table_name  drop_behavior ;

/*
		 11.22 view_definition  (p588)


Define a viewed table.
*/

view_definition  :
		CREATE ( RECURSIVE )? VIEW table_name  view_specification  AS query_expression
		( WITH ( levels_clause  )? CHECK OPTION )?;

view_specification   :  regular_view_specification  | referenceable_view_specification ;

regular_view_specification   :  ( Left_Paren view_column_list  Right_Paren )?;

referenceable_view_specification   :  OF fully_qualified_identifier  ( subview_clause  )? ( view_element_list  )?;

subview_clause   :  UNDER table_name ;

view_element_list   :  Left_Paren view_element  ( Comma view_element  )* Right_Paren;

view_element   :  self_referencing_column_specification  | view_column_option ;

view_column_option   :  identifier  WITH OPTIONS scope_clause ;

levels_clause   :  CASCADED | LOCAL;

view_column_list   :  column_name_list ;

/*
		 11.23 <drop view statement> (p598)


Destroy a view.
*/

drop_view_statement   :  DROP VIEW table_name  drop_behavior ;

/*
		 11.24 domain_definition  (p601)


Define a domain.
*/

domain_definition  :
		CREATE DOMAIN fully_qualified_identifier  ( AS )? data_type
		( default_clause  )? ( domain_constraint  )* ( collate_clause  )?;

domain_constraint   :  ( constraint_name_definition  )? check_constraint_definition  ( constraint_characteristics  )?;

/*
		 11.25 <alter domain statement> (p603)


Change a domain and its definition.
*/

alter_domain_statement   :  ALTER DOMAIN fully_qualified_identifier  alter_domain_action ;

alter_domain_action  :
		set_domain_default_clause
	|	drop_domain_default_clause
	|	add_domain_constraint_definition
	|	drop_domain_constraint_definition
	;

/*
		 11.26 set_domain_default_clause  (p604)


Set the default value in a domain.
*/

set_domain_default_clause   :  SET default_clause ;

/*
		 11.27 drop_domain_default_clause  (p605)


Remove the default clause of a domain.
*/

drop_domain_default_clause   :  DROP DEFAULT;

/*
		 11.28 add_domain_constraint_definition  (p606)


Add a constraint to a domain.
*/

add_domain_constraint_definition   :  ADD domain_constraint ;

/*
		 11.29 drop_domain_constraint_definition  (p607)


Destroy a constraint on a domain.
*/

drop_domain_constraint_definition   :  DROP CONSTRAINT fully_qualified_identifier ;

/*
		 11.30 <drop domain statement> (p608)


Destroy a domain.
*/

drop_domain_statement   :  DROP DOMAIN fully_qualified_identifier  drop_behavior ;

/*
		 11.31 character_set_definition (p610)


Define a character set.
*/

character_set_definition :
		CREATE CHARACTER SET fully_qualified_identifier  ( AS )? character_set_source  ( collate_clause  )?;

character_set_source   :  GET Character_Set_Name ;

/*
		 11.32 <drop character set statement> (p612)


Destroy a character set.
*/

drop_character_set_statement   :  DROP CHARACTER SET fully_qualified_identifier ;

/*
		 11.33 collation_definition  (p614)


Define a collating sequence.
*/

collation_definition  :
		CREATE COLLATION fully_qualified_identifier  FOR Character_Set_Name
		FROM fully_qualified_identifier  ( pad_characteristic  )?;

pad_characteristic   :  NO PAD | PAD SPACE;

/*
		 11.34 <drop collation statement> (p616)


Destroy a collating sequence.
*/

drop_collation_statement   :  DROP COLLATION fully_qualified_identifier  drop_behavior ;

/*
		 11.35 transliteration_definition  (p618)


Define a character transliteration.
*/

transliteration_definition  :
		CREATE TRANSLATION fully_qualified_identifier  FOR source_character_set_specification
		TO target_character_set_specification  FROM transliteration_source ;

source_character_set_specification   :  Character_Set_Name ;

target_character_set_specification   :  Character_Set_Name ;

transliteration_source   :  existing_transliteration_name  | transliteration_routine ;

existing_transliteration_name   :  fully_qualified_identifier ;

transliteration_routine   :  specific_routine_designator ;

/*
		 11.36 <drop transliteration statement> (p621)


Destroy a character transliteration.
*/

drop_transliteration_statement   :  DROP TRANSLATION fully_qualified_identifier ;

/*
		 11.37 assertion_definition  (p623)


Specify an integrity constraint.
*/

assertion_definition  :
		CREATE ASSERTION fully_qualified_identifier  CHECK Left_Paren search_condition  Right_Paren ( constraint_characteristics  )?;

/*
		 11.38 <drop assertion statement> (p625)


Destroy an assertion.
*/

drop_assertion_statement   :  DROP ASSERTION fully_qualified_identifier ;

/*
		 11.39 trigger_definition  (p627)


Define triggered SQL-statements.
*/

trigger_definition  :
		CREATE TRIGGER fully_qualified_identifier  trigger_action_time  trigger_event
		ON table_name  ( REFERENCING old_or_new_values_alias_list  )?
		triggered_action ;

trigger_action_time   :  BEFORE | AFTER;

trigger_event   :  INSERT | DELETE | UPDATE ( OF trigger_column_list  )?;

trigger_column_list   :  column_name_list ;

triggered_action  :
		( FOR EACH ( ROW | STATEMENT ) )?
		( WHEN Left_Paren search_condition  Right_Paren )?
		triggered_sql_statement ;

triggered_sql_statement  :
		sql_procedure_statement
	|	BEGIN ATOMIC ( sql_procedure_statement Semicolon )+  END;

old_or_new_values_alias_list   :  ( old_or_new_values_alias )+;

old_or_new_values_alias  :
		OLD ( ROW )? ( AS )? old_values_correlation_name
	|	NEW ( ROW )? ( AS )? new_values_correlation_name
	|	OLD TABLE ( AS )? old_values_table_alias
	|	NEW TABLE ( AS )? new_values_table_alias
	;

old_values_table_alias   :  identifier ;

new_values_table_alias   :  identifier ;

old_values_correlation_name   :  identifier ;

new_values_correlation_name   :  identifier ;

/*
		 11.40 <drop trigger statement> (p631)


Destroy a trigger.
*/

drop_trigger_statement   :  DROP TRIGGER fully_qualified_identifier ;

/*
		 11.41 user_defined_type_definition  (p632)


Define a user_defined type.
*/

user_defined_type_definition   :  CREATE TYPE user_defined_type_body ;

user_defined_type_body  :
		fully_qualified_identifier  ( subtype_clause  )?
		( AS representation  )? ( user_defined_type_option_list  )? ( method_specification_list  )?;

user_defined_type_option_list   :  user_defined_type_option  ( user_defined_type_option  )*;

user_defined_type_option  :
		instantiable_clause
	|	finality
	|	reference_type_specification
	|	ref_cast_option
	|	cast_option ;

subtype_clause  :
		UNDER supertype_name ;

supertype_name  :
		fully_qualified_identifier ;

representation   :  predefined_type  | member_list ;

member_list   :  Left_Paren member  ( Comma member  )* Right_Paren;

member   :  attribute_definition ;

instantiable_clause   :  INSTANTIABLE | NOT INSTANTIABLE;

finality   :  FINAL | NOT FINAL;

reference_type_specification  :
		user_defined_representation
	|	derived_representation
	|	system_generated_representation
	;

user_defined_representation   :  REF USING predefined_type ;

derived_representation   :  REF FROM list_of_attributes ;

system_generated_representation   :  REF IS SYSTEM GENERATED;

ref_cast_option   :  ( cast_to_ref  )? ( cast_to_type  )?;

cast_to_ref   :  CAST Left_Paren SOURCE AS REF Right_Paren WITH cast_to_ref_identifier ;

cast_to_ref_identifier   :  identifier ;

cast_to_type   :  CAST Left_Paren REF AS SOURCE Right_Paren WITH cast_to_type_identifier ;

cast_to_type_identifier   :  identifier ;

list_of_attributes   :  Left_Paren identifier  ( Comma identifier  )* Right_Paren;

cast_option   :  ( cast_to_distinct  )? ( cast_to_source  )?;

cast_to_distinct  :
		CAST Left_Paren SOURCE AS DISTINCT Right_Paren
		WITH cast_to_distinct_identifier ;

cast_to_distinct_identifier   :  identifier ;

cast_to_source  :
		CAST Left_Paren DISTINCT AS SOURCE Right_Paren
		WITH cast_to_source_identifier ;

cast_to_source_identifier   :  identifier ;

method_specification_list   :  method_specification  ( Comma method_specification  )*;

method_specification   :  original_method_specification  | overriding_method_specification ;

original_method_specification  :
		partial_method_specification  ( SELF AS RESULT )? ( SELF AS LOCATOR )? ( method_characteristics  )?;

overriding_method_specification   :  OVERRIDING partial_method_specification ;

partial_method_specification  :
		( INSTANCE | STATIC | CONSTRUCTOR )? METHOD identifier  sql_parameter_declaration_list
		returns_clause  ( SPECIFIC fully_qualified_identifier  )?;

method_characteristics   :  ( method_characteristic )+;

method_characteristic  :
		language_clause
	|	parameter_style_clause
	|	deterministic_characteristic
	|	sql_data_access_indication
	|	null_call_clause
	;

/*
		 11.42 attribute_definition  (p648)


Define an attribute of a structured type.
*/

attribute_definition  :
		identifier  data_type  ( reference_scope_check  )? ( attribute_default  )? ( collate_clause  )?;

attribute_default   :  default_clause ;

/*
		 11.43 <alter type statement> (p650)


Change the definition of a user_defined type.
*/

alter_type_statement  :
ALTER TYPE fully_qualified_identifier  alter_type_action ;

alter_type_action  :
		add_attribute_definition
	|	drop_attribute_definition
	|	add_original_method_specification
	|	add_overriding_method_specification
	|	drop_method_specification
	;

/*
		 11.44 add_attribute_definition  (p651)


Add an attribute to a user_defined type.
*/

add_attribute_definition   :  ADD ATTRIBUTE attribute_definition ;

/*
		 11.45 drop_attribute_definition  (p653)


Destroy an attribute of a user_defined type.
*/

drop_attribute_definition   :  DROP ATTRIBUTE identifier  RESTRICT;

/*
		 11.46 add_original_method_specification  (p655)


Add an original method specification to a user_defined type.
*/

add_original_method_specification   :  ADD original_method_specification ;

/*
		 11.47 add_overriding_method_specification  (p661)


Add an overriding method specification to a user_defined type.
*/

add_overriding_method_specification   :  ADD overriding_method_specification ;

/*
		 11.48 drop_method_specification  (p666)


Remove a method specification from a user_defined type.
*/

drop_method_specification   :  DROP specific_method_specification_designator  RESTRICT;

specific_method_specification_designator   :  ( INSTANCE | STATIC | CONSTRUCTOR )? METHOD identifier  data_type_list ;

/*
		 11.49 <drop data type statement> (p670)


Destroy a user_defined type.
*/

drop_data_type_statement   :  DROP TYPE fully_qualified_identifier  drop_behavior ;

/*
		 11.50 <SQL-invoked routine> (p673)


Define an SQL-invoked routine.
*/

sql_invoked_routine
	options{k=1;}
	:	schema_routine ;

schema_routine
	options{k=1;}
	:	schema_procedure
	|	schema_function ;

schema_procedure
	options{k=1;}
	:	CREATE sql_invoked_procedure ;

schema_function
	options{k=1;}
	:	CREATE sql_invoked_function ;

sql_invoked_procedure
	options{k=1;}
	:	PROCEDURE
		fully_qualified_identifier
		sql_parameter_declaration_list
		routine_characteristics
		routine_body ;

sql_invoked_function
	options{k=1;}
	:	(	function_specification
		|	method_specification_designator
		)
		routine_body ;

sql_parameter_declaration_list
	:	Left_Paren ( sql_parameter_declaration ( Comma sql_parameter_declaration )* )? Right_Paren;

sql_parameter_declaration
	:	( parameter_mode )?
		( identifier )?
		parameter_type
		( RESULT )?;

parameter_mode   :  IN | OUT | INOUT;

parameter_type   :  data_type  ( locator_indication )?;

locator_indication   :  AS LOCATOR;

function_specification
	options{k=1;}
	:	FUNCTION
		fully_qualified_identifier
		sql_parameter_declaration_list returns_clause
		routine_characteristics
		( dispatch_clause  )?;

method_specification_designator
	options{k=1;}
	:	SPECIFIC METHOD fully_qualified_identifier
	|	( INSTANCE | STATIC | CONSTRUCTOR )?
		METHOD identifier
		sql_parameter_declaration_list
		( returns_clause  )?
		FOR fully_qualified_identifier ;

routine_characteristics   :  ( routine_characteristic  )*;

routine_characteristic
	options{k=1;}
	:	language_clause
	|	parameter_style_clause
	|	SPECIFIC fully_qualified_identifier
	|	deterministic_characteristic
	|	sql_data_access_indication
	|	null_call_clause
	|	dynamic_result_sets_characteristic
	|	savepoint_level_indication
	;

savepoint_level_indication   :  NEW SAVEPOINT LEVEL | OLD SAVEPOINT LEVEL;

dynamic_result_sets_characteristic   :  DYNAMIC RESULT SETS maximum_dynamic_result_sets ;

parameter_style_clause   :  PARAMETER STYLE parameter_style ;

dispatch_clause   :  STATIC DISPATCH;

returns_clause   :  RETURNS returns_type ;

returns_type  :
		returns_data_type  ( result_cast  )?
	|	returns_table_type
	;

returns_table_type   :  TABLE table_function_column_list ;

table_function_column_list  :
		Left_Paren
		table_function_column_list_element  ( Comma table_function_column_list_element  )*
		Right_Paren
		;

table_function_column_list_element   :  identifier  data_type ;

result_cast   :  CAST FROM result_cast_from_type ;

result_cast_from_type   :  data_type  ( locator_indication  )?;

returns_data_type   :  data_type  ( locator_indication  )?;

routine_body  :
		sql_routine_spec
	|	external_body_reference
	;

sql_routine_spec   :  ( rights_clause  )? sql_routine_body;

rights_clause   :  SQL SECURITY INVOKER | SQL SECURITY DEFINER;

sql_routine_body  :  sql_procedure_statement | BEGIN ( sql_procedure_statement Semicolon )+ END;

external_body_reference  :
		EXTERNAL
		( NAME external_routine_name  )?
		( parameter_style_clause  )?
		( transform_group_specification  )?
		( external_security_clause  )?
		;

external_security_clause  :
		EXTERNAL SECURITY DEFINER
	|	EXTERNAL SECURITY INVOKER
	|	EXTERNAL SECURITY IMPLEMENTATION DEFINED
	;

parameter_style   :  SQL | GENERAL;

deterministic_characteristic   :  DETERMINISTIC | NOT DETERMINISTIC;

sql_data_access_indication  :
		NO SQL
	|	CONTAINS SQL
	|	READS SQL DATA
	|	MODIFIES SQL DATA
	;

null_call_clause  :
		RETURNS NULL ON NULL INPUT
	|	CALLED ON NULL INPUT
	;

maximum_dynamic_result_sets   :  Unsigned_Integer ;

transform_group_specification   :  TRANSFORM GROUP ( single_group_specification | multiple_group_specification );

single_group_specification   :  group_name ;

multiple_group_specification   :  group_specification  ( Comma group_specification  )*;

group_specification   :  group_name  FOR TYPE fully_qualified_identifier ;

/*
		 11.51 <alter routine statement> (p698)


Alter a characteristic of an SQL-invoked routine.
*/

alter_routine_statement   :  ALTER specific_routine_designator  alter_routine_characteristics  alter_routine_behavior ;

alter_routine_characteristics   :  ( alter_routine_characteristic )+;

alter_routine_characteristic  :
		language_clause
	|	parameter_style_clause
	|	sql_data_access_indication
	|	null_call_clause
	|	dynamic_result_sets_characteristic
	|	NAME external_routine_name
	;

alter_routine_behavior   :  RESTRICT;

/*
		 11.52 <drop routine statement> (p701)

		Destroy an SQL-invoked routine.
*/

drop_routine_statement   :  DROP specific_routine_designator  drop_behavior ;

/*
		 11.53 user_defined_cast_definition  (p703)

		Define a user_defined cast.
*/

user_defined_cast_definition  :
		CREATE CAST Left_Paren source_data_type  AS target_data_type  Right_Paren
		WITH cast_function  ( AS ASSIGNMENT )?;

cast_function   :  specific_routine_designator ;

source_data_type   :  data_type ;

target_data_type   :  data_type ;

/*
		 11.54 <drop user_defined cast statement> (p705)


Destroy a user_defined cast.
*/

drop_user_defined_cast_statement  :
		DROP CAST Left_Paren source_data_type  AS target_data_type  Right_Paren drop_behavior ;

/*
		 11.55 user_defined_ordering_definition  (p707)


Define a user_defined ordering for a user_defined type.
*/

user_defined_ordering_definition  :
		CREATE ORDERING FOR fully_qualified_identifier  ordering_form ;

ordering_form   :  equals_ordering_form  | full_ordering_form ;

equals_ordering_form   :  EQUALS ONLY BY ordering_category ;

full_ordering_form   :  ORDER FULL BY ordering_category ;

ordering_category   :  relative_category  | map_category  | state_category ;

relative_category   :  RELATIVE WITH relative_function_specification ;

map_category   :  MAP WITH map_function_specification ;

state_category   :  STATE ( fully_qualified_identifier  )?;

relative_function_specification   :  specific_routine_designator ;

map_function_specification   :  specific_routine_designator ;

/*
		 11.56 <drop user_defined ordering statement> (p710)


Destroy a user_defined ordering method.
*/

drop_user_defined_ordering_statement  :
		DROP ORDERING FOR fully_qualified_identifier  drop_behavior ;

/*
		 11.57 transform_definition  (p712)


Define one or more transform functions for a user_defined type.
*/

transform_definition   :  CREATE ( TRANSFORM | TRANSFORMS ) FOR fully_qualified_identifier ( transform_group )+;

transform_group   :  group_name  Left_Paren transform_element_list  Right_Paren;

group_name   :  identifier ;

transform_element_list   :  transform_element  ( Comma transform_element  )?;

transform_element   :  to_sql   | from_sql ;

to_sql    :  TO SQL WITH to_sql_function ;

from_sql   :  FROM SQL WITH from_sql_function ;

to_sql_function   :  specific_routine_designator ;

from_sql_function   :  specific_routine_designator ;

/*
		 11.58 <alter transform statement> (p715)


Change the definition of one or more transform groups.
*/

alter_transform_statement  :
		ALTER ( TRANSFORM | TRANSFORMS ) FOR fully_qualified_identifier ( alter_group )+;

alter_group   :  group_name  Left_Paren alter_transform_action_list  Right_Paren;

alter_transform_action_list   :  alter_transform_action  ( Comma alter_transform_action  )*;

alter_transform_action   :  add_transform_element_list  | drop_transform_element_list ;

/*
		 11.59 add_transform_element_list  (p717)

		Add a transform element (to_sql   and/or from_sql ) to an existing transform group.
*/

add_transform_element_list   :  ADD Left_Paren transform_element_list  Right_Paren;

/*
		 11.60 drop_transform_element_list  (p719)


Remove a transform element (to_sql   and/or from_sql ) from a transform group.
*/

drop_transform_element_list   :  DROP Left_Paren transform_kind  ( Comma transform_kind  )? drop_behavior  Right_Paren;

transform_kind   :  TO SQL | FROM SQL;

/*
		 11.61 <drop transform statement> (p721)


Remove one or more transform functions associated with a transform.
*/

drop_transform_statement  :
		DROP ( TRANSFORM | TRANSFORMS ) transforms_to_be_dropped  FOR fully_qualified_identifier  drop_behavior ;

transforms_to_be_dropped   :  ALL | transform_group_element ;

transform_group_element   :  group_name ;

/*
		 11.62 sequence_generator_definition  (p724)


Define an external sequence generator.
*/

sequence_generator_definition   :  CREATE SEQUENCE fully_qualified_identifier  ( sequence_generator_options  )?;

sequence_generator_options   :  ( sequence_generator_option  )+;

sequence_generator_option   :  sequence_generator_data_type_option  | common_sequence_generator_options ;

common_sequence_generator_options   : ( common_sequence_generator_option )+;

common_sequence_generator_option   :  sequence_generator_start_with_option  | basic_sequence_generator_option ;

basic_sequence_generator_option  :
		sequence_generator_increment_by_option
	|	sequence_generator_maxvalue_option
	|	sequence_generator_minvalue_option
	|	sequence_generator_cycle_option
	;

sequence_generator_data_type_option   :  AS data_type ;

sequence_generator_start_with_option   :  START WITH sequence_generator_start_value ;

sequence_generator_start_value   :  signed_numeric_literal ;

sequence_generator_increment_by_option  :  INCREMENT BY sequence_generator_increment ;

sequence_generator_increment   :  signed_numeric_literal ;

sequence_generator_maxvalue_option   :
		MAXVALUE sequence_generator_max_value
	|	NO MAXVALUE
	;

sequence_generator_max_value   :  signed_numeric_literal ;

sequence_generator_minvalue_option   :  MINVALUE sequence_generator_min_value  | NO MINVALUE;

sequence_generator_min_value   :  signed_numeric_literal ;

sequence_generator_cycle_option   :  CYCLE | NO CYCLE;

/*
		 11.63 <alter sequence generator statement> (p726)


Change the definition of an external sequence generator.
*/

alter_sequence_generator_statement  :
		ALTER SEQUENCE fully_qualified_identifier  alter_sequence_generator_options ;

alter_sequence_generator_options   : ( alter_sequence_generator_option )+;

alter_sequence_generator_option  :
		alter_sequence_generator_restart_option
	|	basic_sequence_generator_option
	;

alter_sequence_generator_restart_option   :  RESTART WITH sequence_generator_restart_value ;

sequence_generator_restart_value   :  signed_numeric_literal ;

/*
		 11.64 <drop sequence generator statement> (p727)


Destroy an external sequence generator.
*/

drop_sequence_generator_statement   :  DROP SEQUENCE fully_qualified_identifier  drop_behavior ;

/*

	12 Access control


		 12.1 grant_statement  (p729)


Define privileges and role authorizations.
*/

grant_statement   :  grant_privilege_statement  | grant_role_statement ;

/*
		 12.2 grant_privilege_statement  (p734)


Define privileges.
*/

grant_privilege_statement  :
		GRANT privileges  TO grantee  ( Comma grantee  )*
		( WITH HIERARCHY OPTION )? ( WITH GRANT OPTION )? ( GRANTED BY grantor  )?;

/*
		 12.3 privileges  (p737)


Specify privileges.
*/

privileges   :  object_privileges  ON object_name ;

object_name  :
		( TABLE )? table_name
	|	DOMAIN fully_qualified_identifier
	|	COLLATION fully_qualified_identifier
	|	CHARACTER SET fully_qualified_identifier
	|	TRANSLATION fully_qualified_identifier
	|	TYPE fully_qualified_identifier
	|	SEQUENCE fully_qualified_identifier
	|	specific_routine_designator
	;

object_privileges  :
		ALL PRIVILEGES
	|	action  ( Comma action  )*
	;

action  :
		SELECT
	|	SELECT Left_Paren privilege_column_list  Right_Paren
	|	SELECT Left_Paren privilege_method_list  Right_Paren
	|	DELETE
	|	INSERT ( Left_Paren privilege_column_list  Right_Paren )?
	|	UPDATE ( Left_Paren privilege_column_list  Right_Paren )?
	|	REFERENCES ( Left_Paren privilege_column_list  Right_Paren )?
	|	USAGE
	|	TRIGGER
	|	UNDER
	|	EXECUTE
	;

privilege_method_list   :  specific_routine_designator  ( Comma specific_routine_designator  )*;

privilege_column_list   :  column_name_list ;

grantee   :  PUBLIC | identifier ;

grantor   :  CURRENT_USER | CURRENT_ROLE;

/*
		 12.4 role_definition  (p741)


Define a role.
*/

role_definition   :  CREATE ROLE identifier  ( WITH ADMIN grantor  )?;

/*
		 12.5 grant_role_statement  (p742)


Define role authorizations.
*/

grant_role_statement  :
		GRANT role_granted  ( Comma role_granted  )*
		TO grantee  ( Comma grantee  )* ( WITH ADMIN OPTION )? ( GRANTED BY grantor  )?;

role_granted   :  identifier ;

/*
		 12.6 <drop role statement> (p744)

Destroy a role.
*/

drop_role_statement   :  DROP ROLE identifier ;

/*
		 12.7 <revoke statement> (p745)

Destroy privileges and role authorizations.
*/

revoke_statement  :
		revoke_privilege_statement
	|	revoke_role_statement ;

revoke_privilege_statement  :
		REVOKE ( revoke_option_extension  )? privileges  FROM grantee  ( Comma grantee  )*
		( GRANTED BY grantor  )? drop_behavior ;

revoke_option_extension   :  GRANT OPTION FOR | HIERARCHY OPTION FOR;

revoke_role_statement  :
		REVOKE ( ADMIN OPTION FOR )? role_revoked  ( Comma role_revoked  )*
		FROM grantee  ( Comma grantee  )* ( GRANTED BY grantor  )? drop_behavior ;

role_revoked   :  identifier ;

/*
	13 SQL-client modules


	13.1 <SQL-client module definition> (p763)


	Define an SQL-client module.
*/

sql_client_module_definition
	options{k=1;}
	:	module_name_clause
		language_clause
		module_authorization_clause
		( module_path_specification  )?
		( module_transform_group_specification  )?
		( module_collations  )?
		( temporary_table_declaration  )*
		( module_contents )+
		;

module_authorization_clause  :
		( SCHEMA schema_name )?
		( AUTHORIZATION module_authorization_identifier  ( FOR STATIC ( ONLY | AND DYNAMIC ) )? )?
	;

module_authorization_identifier   :  identifier ;

module_path_specification   :  path_specification ;

module_transform_group_specification   :  transform_group_specification ;

module_collations   :  ( module_collation_specification )+;

module_collation_specification   :  COLLATION fully_qualified_identifier  ( FOR character_set_specification_list  )?;

character_set_specification_list   :  Character_Set_Name  (Comma Character_Set_Name  )*;

module_contents  :
		declare_cursor
	|	dynamic_declare_cursor
	|	externally_invoked_procedure
	;

/*
		 13.2 module_name_clause  (p768)


Name an SQL-client module.
*/

module_name_clause
	:	MODULE
		( identifier  )?
		( module_character_set_specification  )?;

module_character_set_specification
	:  NAMES ARE Character_Set_Name ;

/*
		 13.3 externally_invoked_procedure  (p769)


Define an externally-invoked procedure.
*/

externally_invoked_procedure  :
		PROCEDURE identifier  host_parameter_declaration_list  Semicolon
		sql_routine_body Semicolon;

host_parameter_declaration_list  :
		Left_Paren host_parameter_declaration  ( Comma host_parameter_declaration  )* Right_Paren;

host_parameter_declaration  :
//		host_parameter_name  host_parameter_data_type
	|	status_parameter
	;

host_parameter_data_type   :  data_type  ( locator_indication  )?;

status_parameter   :  SQLSTATE;

/*
		 13.4 Calls to an externally_invoked_procedure  (p772)

		 13.5 sql_procedure_statement (p788)

Define all of the SQL-statements that are sql_procedure_statements.
*/

sql_procedure_statement  :  sql_executable_statement;

sql_executable_statement
	options{k=1;}
	:	sql_schema_statement
	|	sql_data_statement
	|	sql_control_statement
	|	sql_transaction_statement
	|	sql_connection_statement
	|	sql_session_statement
	|	sql_diagnostics_statement
	|	sql_dynamic_statement
	;

sql_schema_statement
	options{k=1;}
	:	sql_schema_definition_statement
	|	sql_schema_manipulation_statement
	;

sql_schema_definition_statement
	options{k=1;}
	:	schema_definition
	|	table_definition
	|	view_definition
	|	sql_invoked_routine
	|	grant_statement
	|	role_definition
	|	domain_definition
	|	character_set_definition
	|	collation_definition
	|	transliteration_definition
	|	assertion_definition
	|	trigger_definition
	|	user_defined_type_definition
	|	user_defined_cast_definition
	|	user_defined_ordering_definition
	|	transform_definition
	|	sequence_generator_definition
	;

sql_schema_manipulation_statement
	options{k=1;}
	:	drop_schema_statement
	|	alter_table_statement
	|	drop_table_statement
	|	drop_view_statement
	|	alter_routine_statement
	|	drop_routine_statement
	|	drop_user_defined_cast_statement
	|	revoke_statement
	|	drop_role_statement
	|	alter_domain_statement
	|	drop_domain_statement
	|	drop_character_set_statement
	|	drop_collation_statement
	|	drop_transliteration_statement
	|	drop_assertion_statement
	|	drop_trigger_statement
	|	alter_type_statement
	|	drop_data_type_statement
	|	drop_user_defined_ordering_statement
	|	alter_transform_statement
	|	drop_transform_statement
	|	alter_sequence_generator_statement
	|	drop_sequence_generator_statement
	;

sql_data_statement
	options{k=1;}
	:	open_statement
	|	fetch_statement
	|	close_statement
	|	select_statement_single_row
//	|	free_locator_statement
//	|	hold_locator_statement
	|	sql_data_change_statement
	;

sql_data_change_statement
	options{k=1;}
	:	delete_statement_positioned
	|	delete_statement_searched
	|	insert_statement
	|	update_statement_positioned
	|	update_statement_searched
	|	merge_statement
	;

sql_control_statement
	options{k=1;}
	:	call_statement
	|	return_statement
	;

sql_transaction_statement
	options{k=1;}
	:	start_transaction_statement
	|	set_transaction_statement
	|	set_constraints_mode_statement
	|	savepoint_statement
	|	release_savepoint_statement
	|	commit_statement
	|	rollback_statement
	;

sql_connection_statement
	options{k=1;}
	:	connect_statement
	|	set_connection_statement
	|	disconnect_statement  ;

sql_session_statement
	options{k=1;}
	:	set_session_user_identifier_statement
	|	set_role_statement
	|	set_local_time_zone_statement
	|	set_session_characteristics_statement
	|	set_catalog_statement
	|	set_schema_statement
	|	set_names_statement
	|	set_path_statement
	|	set_transform_group_statement
	|	set_session_collation_statement
	;

sql_diagnostics_statement   :  get_diagnostics_statement  ;

sql_dynamic_statement
	options{k=1;}
	:	system_descriptor_statement
	|	prepare_statement
	|	deallocate_prepared_statement
	|	describe_statement
	|	execute_statement
	|	execute_immediate_statement
	|	sql_dynamic_data_statement
	;

sql_dynamic_data_statement
	options{k=1;}
	:	allocate_cursor_statement
	|	dynamic_open_statement
	|	dynamic_fetch_statement
	|	dynamic_close_statement
	|	dynamic_delete_statement_positioned
	|	dynamic_update_statement_positioned
	;

system_descriptor_statement
	options{k=1;}
	:	allocate_descriptor_statement
	|	deallocate_descriptor_statement
	|	set_descriptor_statement
	|	get_descriptor_statement
	;

/*
		 13.6 Data type correspondences (p796)


Table 16 -- Data type correspondences for C


    *   SQL Data Type   C Data Type

    *   SQLSTATE   char, with length 6
    *   CHARACTER (L)3   char, with length (L+1)*k1
    *   CHARACTER VARYING (L)3   char, with length (L+1)*k1
    *   CHARACTER LARGE OBJECT(L)

--## struct (
--## long hvn3_reserved
--## unsigned long hvn2_length
--## char3 hvn2_data(L)?;
--## } hvn2

    *   BINARY LARGE OBJECT(L)
 struct (
--## long hvn2_reserved
--## unsigned long hvn2_length
--## char hvn2_data(L)?;
--## } hvn2

    *   NUMERIC(P,S)   None
    *   DECIMAL(P,S)   None
    *   SMALLINT   pointer to short
    *   INTEGER   pointer to long
    *   BIGINT   pointer to long long
    *   FLOAT(P)   None
    *   REAL   pointer to float
    *   DOUBLE PRECISION   pointer to double
    *   BOOLEAN   pointer to long
    *   DATE   None
    *   TIME(T)   None
    *   TIMESTAMP(T)   None
    *   INTERVAL(Q)   None
    *   user_defined type   None
    *   REF   char, with length N
    *   ROW   None
    *   ARRAY   None
    *   MULTISET   None



1 For character set UTF16, as well as other
implementation-defined character sets in which a code unit occupies two
octets, k is the length in units of C unsigned short of the character
encoded using the greatest number of such units in the character set;
for character set UTF32, as well as other implementation-defined
character sets in which a code unit occupies four octets, k is four; for
other character sets, k is the length in units of C char of the
character encoded using the greatest number of such units in the
character set.

2 hvn is the name of the host variable defined to correspond
to the SQL data type

3 For character set UTF16, as well as other
implementation-defined character sets in which a code unit occupies two
octets, char or unsigned char should be replaced with unsigned short;
for character set UTF32, as well as other implementation-defined
character sets in which a code unit occupies four octets, char or
unsigned char should be replaced with unsigned int.  Otherwise, char or
unsigned char should be used.



	14 Data manipulation


		 14.1 declare_cursor  (p807)



Define a cursor.
*/

declare_cursor
	options{k=1;}
	:	DECLARE cursor_name
		( cursor_sensitivity  )?
		( cursor_scrollability  )?
		CURSOR
		( cursor_holdability  )?
		( cursor_returnability  )?
		FOR cursor_specification ;

cursor_sensitivity   :  SENSITIVE | INSENSITIVE | ASENSITIVE;

cursor_scrollability   :  SCROLL | NO SCROLL;

cursor_holdability   :  WITH HOLD | WITHOUT HOLD;

cursor_returnability   :  WITH RETURN | WITHOUT RETURN;

cursor_specification
	options{k=1;}
	:  	query_expression
		( order_by_clause  )?
		( updatability_clause  )? ;

updatability_clause   :  FOR ( READ ONLY | UPDATE ( OF column_name_list  )? );

order_by_clause   :  ORDER BY sort_specification_list ;

/*
		 14.2 open_statement   (p813)

		Open a cursor.
*/

open_statement    :  OPEN cursor_name ;

/*
		 14.3 fetch_statement   (p815)


Position a cursor on a specified row of a table and retrieve values from that row.
*/

fetch_statement   :
		FETCH ( ( fetch_orientation  )? FROM )? cursor_name  INTO fetch_target_list ;

fetch_orientation  :
		NEXT
	|	PRIOR
	|	FIRST
	|	LAST
	|	( ABSOLUTE | RELATIVE ) simple_value_specification
	;

fetch_target_list   :  target_specification  ( Comma target_specification  )*;

/*
		 14.4 close_statement   (p820)


Close a cursor.
*/

close_statement    :  CLOSE cursor_name ;

/*
		 14.5 select_statement_single_row  (p822)


Retrieve values from a specified row of a table.
*/

select_statement_single_row
	options{k=1;}
	:	SELECT
		( set_quantifier  )?
		select_list
		INTO select_target_list
		table_expression ;

select_target_list   :  target_specification  ( Comma target_specification  )*;

/*
		 14.6 delete_statement_positioned  (p826)


Delete a row of a table.
*/

delete_statement_positioned   :  DELETE FROM target_table  WHERE CURRENT OF cursor_name ;

target_table  :
		table_name
	|	ONLY Left_Paren table_name  Right_Paren
	;

/*
		 14.7 delete_statement_searched  (p829)


Delete rows of a table.
*/

delete_statement_searched
	options{k=1;}
	:	DELETE FROM target_table
		( WHERE search_condition )?;

/*
		 14.8 insert_statement   (p832)


Create new rows in a table.
*/

insert_statement
	options{k=1;}
	:  INSERT INTO insertion_target  insert_columns_and_source ;

insertion_target   :  table_name ;

insert_columns_and_source
	options{k=1;}
	:	( 	Left_Paren insert_column_list  Right_Paren )?
		( 	override_clause  )?
			( 	query_expression
			|	contextually_typed_table_value_constructor
			)
	|	from_default
	;

//insert_columns_and_source  :
//		from_subquery
//	|	from_constructor
//	|	from_default
//	;

// from_subquery   :  ( Left_Paren insert_column_list  Right_Paren )? ( override_clause  )? query_expression ;

// from_constructor  : ( Left_Paren insert_column_list  Right_Paren )? ( override_clause  )? contextually_typed_table_value_constructor ;

override_clause   
	options{k=1;}
	:  OVERRIDING USER VALUE | OVERRIDING SYSTEM VALUE;

from_default   
	options{k=1;}
	:  DEFAULT VALUES;

insert_column_list   
	options{k=1;}
	:  column_name_list ;

/*
		 14.9 merge_statement   (p837)


Conditionally update rows of a table, or insert new rows into a table, or both.
*/

merge_statement
	options{k=1;}
	:	MERGE INTO target_table
		( ( AS )? merge_correlation_name  )?
		USING table_reference
		ON search_condition
		merge_operation_specification ;

merge_correlation_name
	:	identifier ;

merge_operation_specification
	:	( merge_when_clause )+;

merge_when_clause
	:	merge_when_matched_clause
	|	merge_when_not_matched_clause ;

merge_when_matched_clause
	:	WHEN MATCHED THEN merge_update_specification ;

merge_when_not_matched_clause
	:	WHEN NOT MATCHED THEN merge_insert_specification ;

merge_update_specification
	:	UPDATE SET set_clause_list ;

merge_insert_specification  :
		INSERT
		( Left_Paren insert_column_list  Right_Paren )?
		( override_clause  )?
		VALUES merge_insert_value_list ;

merge_insert_value_list
	:	Left_Paren
		merge_insert_value_element
		( Comma merge_insert_value_element  )*
		Right_Paren;

merge_insert_value_element
	options{k=1;}
	:	value_expression
	|	contextually_typed_value_specification ;

/*
		 14.10 update_statement_positioned  (p844)


Update a row of a table.
*/

update_statement_positioned   :  UPDATE target_table  SET set_clause_list  WHERE CURRENT OF cursor_name ;

/*
		 14.11 update_statement_searched  (p847)


Update rows of a table.
*/

update_statement_searched   :  UPDATE target_table  SET set_clause_list  ( WHERE search_condition  )?;

/*
		 14.12 set_clause_list  (p851)


Specify a list of updates.
*/

set_clause_list   :  set_clause  ( Comma set_clause  )*;

set_clause  :
		multiple_column_assignment
	|	set_target  Equals_Operator update_source
	;

set_target   :  update_target  | mutated_set_clause ;

multiple_column_assignment   :  set_target_list  Equals_Operator assigned_row ;

set_target_list   :  Left_Paren set_target  ( Comma set_target  )* Right_Paren;

assigned_row   :  contextually_typed_row_value_expression;

update_target  :
		object_column
	|	object_column  left_bracket_or_trigraph simple_value_specification  right_bracket_or_trigraph
	;

object_column   :  identifier ;

mutated_set_clause   :  mutated_target  Period identifier ;

mutated_target   :  object_column ( Period identifier )* ;
// mutated_target   :  object_column  | mutated_set_clause ;

update_source
    options{k=1;}
    :  value_expression  | contextually_typed_value_specification ;

/*
		 14.13 temporary_table_declaration  (p856)


Declare a declared local temporary table.
*/

temporary_table_declaration  :
		DECLARE LOCAL TEMPORARY TABLE table_name  table_element_list
		( ON COMMIT table_commit_action  ROWS )?
		;

/*
		 14.14 free_locator_statement   (p858)


Remove the association between a locator variable and the value that is represented by that locator.
*/

//free_locator_statement    :  FREE LOCATOR locator_reference  ( Comma locator_reference  )*;

//locator_reference   :  host_parameter_name  ;

/*
		 14.15 hold_locator_statement   (p859)


Mark a locator variable as being holdable.
*/

//hold_locator_statement    :  HOLD LOCATOR locator_reference  ( Comma locator_reference  )*;

/*
		 14.16 Effect of deleting rows from base tables (p860)


		 14.17 Effect of deleting some rows from a derived table (p862)


		 14.18 Effect of deleting some rows from a viewed table (p864)


		 14.19 Effect of inserting tables into base tables (p865)


		 14.20 Effect of inserting a table into a derived table (p867)


		 14.21 Effect of inserting a table into a viewed table (p869)


		 14.22 Effect of replacing rows in base tables (p871)


		 14.23 Effect of replacing some rows in a derived table (p874)


		 14.24 Effect of replacing some rows in a viewed table (p877)


		 14.25 Execution of BEFORE triggers (p879)


		 14.26 Execution of AFTER triggers (p880)


		 14.27 Execution of triggers (p881)



	15 Control statements


		 15.1 call_statement   (p883)


Invoke an SQL-invoked routine.
*/

call_statement    :  CALL routine_invocation ;

/*
		 15.2 return_statement   (p884)


Return a value from an SQL function.
*/

return_statement    :  RETURN return_value ;

return_value   :  value_expression  | NULL;

/*

	16 Transaction management


		 16.1 start_transaction_statement   (p885)


Start an SQL-transaction and set its characteristics.
*/

start_transaction_statement    :  START TRANSACTION ( transaction_mode  ( Comma transaction_mode  )* )?;

transaction_mode   :  isolation_level  | transaction_access_mode  | diagnostics_size ;

transaction_access_mode   :  READ ONLY | READ WRITE;

isolation_level   :  ISOLATION LEVEL level_of_isolation ;

level_of_isolation   :  READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE;

diagnostics_size   :  DIAGNOSTICS SIZE number_of_conditions ;

number_of_conditions   :  simple_value_specification ;

/*
		 16.2 set_transaction_statement   (p888)


Set the characteristics of the next SQL-transaction for the SQL-agent.
NOTE 402 - This statement has no effect on any SQL-transactions subsequent to the next SQL-transaction.
*/

set_transaction_statement    :  SET ( LOCAL )? transaction_characteristics ;

transaction_characteristics   :  TRANSACTION transaction_mode  ( Comma transaction_mode  )*;

/*
		 16.3 set_constraints_mode_statement   (p890)


If an SQL-transaction is currently active, then set the constraint mode for that SQL-transaction in
the current SQL-session. If no SQL-transaction is currently active, then set the constraint mode for
the next SQL-transaction in the current SQL-session for the SQL-agent.
NOTE: This statement has no effect on any SQL-transactions subsequent to this SQL-transaction.
*/

set_constraints_mode_statement    :  SET CONSTRAINTS constraint_name_list  ( DEFERRED | IMMEDIATE );

constraint_name_list   :  ALL | fully_qualified_identifier  ( Comma fully_qualified_identifier  )*;

/*
		 16.4 savepoint_statement   (p892)


Establish a savepoint.
*/

savepoint_statement    :  SAVEPOINT savepoint_specifier ;

savepoint_specifier   :  identifier ;

/*
		 16.5 release_savepoint_statement   (p893)


Destroy a savepoint.
*/

release_savepoint_statement    :  RELEASE SAVEPOINT savepoint_specifier ;

/*
		 16.6 commit_statement   (p894)


Terminate the current SQL-transaction with commit.
*/

commit_statement    :  COMMIT ( WORK )? ( AND ( NO )? CHAIN )?;

/*
		 16.7 rollback_statement   (p896)


Terminate the current SQL-transaction with rollback, or rollback all actions affecting SQL-data
and/or schemas since the establishment of a savepoint.
*/

rollback_statement    :  ROLLBACK ( WORK )? ( AND ( NO )? CHAIN )? ( savepoint_clause  )?;

savepoint_clause   :  TO SAVEPOINT savepoint_specifier ;

/*

	17 Connection management


		 17.1 connect_statement   (p899)


Establish an SQL-session.
*/

connect_statement    :  CONNECT TO connection_target ;

connection_target  :
		sql_server_name  ( AS connection_name  )? ( USER connection_user_name  )?
	|	DEFAULT
	;

/*
		 17.2 set_connection_statement   (p902)


Select an SQL-connection from the available SQL-connections.
*/

set_connection_statement    :  SET CONNECTION connection_object ;

connection_object   :  DEFAULT | connection_name  ;

/*
		 17.3 disconnect_statement   (p904)


Terminate an SQL-connection.
*/

disconnect_statement    :  DISCONNECT disconnect_object ;

disconnect_object   :  connection_object  | ALL |	CURRENT;

/*

	18 Session management


		 18.1 set_session_characteristics_statement   (p907)


Set one or more characteristics for the current SQL-session.
*/

set_session_characteristics_statement    :  SET SESSION CHARACTERISTICS AS session_characteristic_list ;

session_characteristic_list   :  session_characteristic  ( Comma session_characteristic  )*;

session_characteristic   :  transaction_characteristics ;

/*
		 18.2 set_session_user_identifier_statement   (p908)


Set the SQL-session user identifier and the current user identifier of the current SQL-session
context.
*/

set_session_user_identifier_statement    :  SET SESSION AUTHORIZATION value_specification ;

/*
		 18.3 set_role_statement   (p909)


Set the current role name for the current SQL-session context.
*/

set_role_statement    :  SET ROLE role_specification ;

role_specification   :  value_specification  | NONE;

/*
		 18.4 set_local_time_zone_statement   (p911)


Set the default local time zone displacement for the current SQL-session.
*/

set_local_time_zone_statement    :  SET TIME ZONE set_time_zone_value ;

set_time_zone_value   :  interval_value_expression  | LOCAL;

/*
		 18.5 set_catalog_statement   (p912)


Set the default catalog name for unqualified schema_name s in <preparable_statement> s that
are prepared in the current SQL-session by an execute_immediate_statement   or a <prepare
statement> and in <direct sql_statement> s that are invoked directly.
*/

set_catalog_statement    :  SET catalog_name_characteristic ;

catalog_name_characteristic   :  CATALOG value_specification ;

/*
		 18.6 set_schema_statement   (p913)


Set the default schema name for unqualified fully_qualified_identifier s in <preparable_statement> s
that are prepared in the current SQL-session by an execute_immediate_statement   or a <prepare
statement> and in <direct sql_statement> s that are invoked directly.
*/

set_schema_statement    :  SET schema_name_characteristic ;

schema_name_characteristic   :  SCHEMA value_specification ;

/*
		 18.7 set_names_statement   (p915)


Set the default character set name for character_string_literal  s in <preparable_statement> s that
are prepared in the current SQL-session by an execute_immediate_statement   or a <prepare
statement> and in <direct sql_statement> s that are invoked directly.
*/

set_names_statement    :  SET character_set_name_characteristic ;

character_set_name_characteristic   :  NAMES value_specification ;

/*
		 18.8 set_path_statement   (p916)


Set the SQL-path used to determine the subject routine of routine_invocation s with unqualified
fully_qualified_identifier s in <preparable_statement> s that are prepared in the current SQL-session by
an execute_immediate_statement   or a prepare_statement   and in <direct sql_statement> s,
respectively, that are invoked directly. The SQL-path remains the current SQL-path of the SQLsession
until another SQL-path is successfully set.
*/

set_path_statement    :  SET sql_path_characteristic ;

sql_path_characteristic   :  PATH value_specification ;

/*
		 18.9 set_transform_group_statement   (p917)


Set the group name that identifies the group of transform functions for
mapping values of userdefined types to predefined data types.
*/

set_transform_group_statement    :  SET transform_group_characteristic ;

transform_group_characteristic  :
		DEFAULT TRANSFORM GROUP value_specification
	|	TRANSFORM GROUP FOR TYPE fully_qualified_identifier  value_specification
	;

/*
		 18.10 set_session_collation_statement   (p918)


Set the SQL-session collation of the SQL-session for one or more
character sets.  An SQL-session collation remains effective until
another SQL-session collation for the same character set is successfully
set.
*/

set_session_collation_statement   :
		SET COLLATION collation_specification  ( FOR character_set_specification_list  )?
	|	SET NO COLLATION ( FOR character_set_specification_list  )?
	;

collation_specification   :  value_specification ;

/*

	19 Dynamic SQL

		 19.1 Description of SQL descriptor areas (p921)


		 19.2 allocate_descriptor_statement  (p931)


Allocate an SQL descriptor area.
*/

allocate_descriptor_statement   :  ALLOCATE ( SQL )? DESCRIPTOR scoped_identifier  ( WITH MAX occurrences  )?;

occurrences   :  simple_value_specification ;

/*
		 19.3 deallocate_descriptor_statement   (p933)


Deallocate an SQL descriptor area.
*/

deallocate_descriptor_statement    :  DEALLOCATE ( SQL )? DESCRIPTOR scoped_identifier ;

/*
		 19.4 get_descriptor_statement   (p934)


Get information from an SQL descriptor area.
*/

get_descriptor_statement    :  GET ( SQL )? DESCRIPTOR scoped_identifier  get_descriptor_information ;

get_descriptor_information  :
		get_header_information  ( Comma get_header_information  )*
	|	VALUE item_number  get_item_information  ( Comma get_item_information  )*
	;

get_header_information   :  simple_target_specification  Equals_Operator header_item_name ;

header_item_name   :  COUNT | KEY_TYPE | DYNAMIC_FUNCTION | DYNAMIC_FUNCTION_CODE | TOP_LEVEL_COUNT;

get_item_information   :  simple_target_specification  Equals_Operator descriptor_item_name ;

descriptor_item_name  :
		CARDINALITY
	|	CHARACTER_SET_CATALOG
	|	CHARACTER_SET_NAME
	|	CHARACTER_SET_SCHEMA
	|	COLLATION_CATALOG
	|	COLLATION_NAME
	|	COLLATION_SCHEMA
	|	DATA
	|	DATETIME_INTERVAL_CODE
	|	DATETIME_INTERVAL_PRECISION
	|	DEGREE
	|	INDICATOR
	|	KEY_MEMBER
	|	LENGTH
	|	LEVEL
	|	NAME
	|	NULLABLE
	|	OCTET_LENGTH
	|	PARAMETER_MODE
	|	PARAMETER_ORDINAL_POSITION
	|	PARAMETER_SPECIFIC_CATALOG
	|	PARAMETER_SPECIFIC_NAME
	|	PARAMETER_SPECIFIC_SCHEMA
	|	PRECISION
	|	RETURNED_CARDINALITY
	|	RETURNED_LENGTH
	|	RETURNED_OCTET_LENGTH
	|	SCALE
	|	SCOPE_CATALOG
	|	SCOPE_NAME
	|	SCOPE_SCHEMA
	|	TYPE
	|	UNNAMED
	|	USER_DEFINED_TYPE_CATALOG
	|	USER_DEFINED_TYPE_NAME
	|	USER_DEFINED_TYPE_SCHEMA
	|	USER_DEFINED_TYPE_CODE
	;

/*
		 19.5 set_descriptor_statement   (p937)


Set information in an SQL descriptor area.
*/

set_descriptor_statement    :  SET ( SQL )? DESCRIPTOR scoped_identifier  set_descriptor_information ;

set_descriptor_information  :
		set_header_information  ( Comma set_header_information  )*
	|	VALUE item_number  set_item_information  ( Comma set_item_information  )*
	;

set_header_information   :  header_item_name  Equals_Operator simple_value_specification_1 ;

set_item_information   :  descriptor_item_name  Equals_Operator simple_value_specification_2 ;

simple_value_specification_1   :  simple_value_specification ;

simple_value_specification_2   :  simple_value_specification ;

item_number   :  simple_value_specification ;


/*
		 19.6 prepare_statement   (p941)


Prepare a statement for execution.
*/

prepare_statement   :
		PREPARE sql_statement_name  ( attributes_specification  )? FROM sql_statement_variable;

attributes_specification   :  ATTRIBUTES attributes_variable ;

attributes_variable   :  simple_value_specification ;

sql_statement_variable  :  simple_value_specification ;

preparable_statement   :
		preparable_sql_data_statement
	|	preparable_sql_schema_statement
	|	preparable_sql_transaction_statement
	|	preparable_sql_control_statement
	|	preparable_sql_session_statement
	|	preparable_implementation_defined_statement
	;

preparable_sql_data_statement
    options{k=1;}
    :
        delete_statement_searched
	|	dynamic_single_row_select_statement
	|	insert_statement
	|	dynamic_select_statement
	|	update_statement_searched
	|	merge_statement
	|	preparable_dynamic_delete_statement_positioned
	|	preparable_dynamic_update_statement_positioned
	;

preparable_sql_schema_statement    :  sql_schema_statement ;

preparable_sql_transaction_statement    :  sql_transaction_statement ;

preparable_sql_control_statement    :  sql_control_statement ;

preparable_sql_session_statement    :  sql_session_statement  ;

dynamic_select_statement    :  cursor_specification ;

preparable_implementation_defined_statement   :  unimplemented_error /*!! See the Syntax Rules.*/;

/*
		 19.7 <cursor_attributes> (p953)


Specify a list of cursor attributes.
*/

cursor_attributes   : ( cursor_attribute )+;

cursor_attribute  :
		cursor_sensitivity
	|	cursor_scrollability
	|	cursor_holdability
	|	cursor_returnability
	;

/*
		 19.8 deallocate_prepared_statement   (p954)


Deallocate SQL-statements that have been prepared with a prepare_statement  .
*/

deallocate_prepared_statement    :  DEALLOCATE PREPARE sql_statement_name ;

/*
		 19.9 describe_statement   (p955)


Obtain information about the select_list  columns or dynamic_parameter_specification s contained
in a prepared statement or about the columns of the result set associated with a cursor.
*/

describe_statement    :  describe_input_statement   | describe_output_statement  ;

describe_input_statement    :  DESCRIBE INPUT sql_statement_name  using_descriptor  ( nesting_option  )?;

describe_output_statement    :  DESCRIBE ( OUTPUT )? described_object  using_descriptor ( nesting_option  )?;

nesting_option   :  WITH NESTING | WITHOUT NESTING;

using_descriptor   :  USING ( SQL )? DESCRIPTOR scoped_identifier ;

described_object  :
		sql_statement_name
	|	CURSOR scoped_identifier  STRUCTURE
	;

/*
		 19.10 input_using_clause (p961)


Supply input values for an sql_dynamic_statement .
*/

input_using_clause  :  using_arguments | using_input_descriptor;

using_arguments  :  USING using_argument ( Comma using_argument )*;

using_argument  :  general_value_specification ;

using_input_descriptor  :  using_descriptor ;

/*
		 19.11 <output using_clause> (p965)


Supply output variables for an sql_dynamic_statement .
*/

output_using_clause  :  into_arguments | into_descriptor;

into_arguments  :  INTO into_argument ( Comma into_argument )*;

into_argument  :  target_specification ;

into_descriptor  :  INTO ( SQL )? DESCRIPTOR scoped_identifier ;

/*
		 19.12 execute_statement   (p970)


Associate input SQL parameters and output targets with a prepared statement and execute the
statement.
*/

execute_statement    :  EXECUTE sql_statement_name  ( result_using_clause )? ( parameter_using_clause )?;

result_using_clause  :  output_using_clause;

parameter_using_clause  :  input_using_clause;

/*
		 19.13 execute_immediate_statement   (p972)


Dynamically prepare and execute a preparable statement.
*/

execute_immediate_statement    :  EXECUTE IMMEDIATE sql_statement_variable;

/*
		 19.14 dynamic_declare_cursor  (p973)


Declare a cursor to be associated with a identifier , which may in turn be associated with a
cursor_specification .
*/

dynamic_declare_cursor  :
		DECLARE cursor_name  ( cursor_sensitivity  )? ( cursor_scrollability  )? CURSOR
		( cursor_holdability  )? ( cursor_returnability  )? FOR identifier
		;

/*
		 19.15 allocate_cursor_statement  (p974)


Define a cursor based on a prepared statement for a cursor_specification  or assign a cursor to the
ordered set of result sets returned from an SQL-invoked procedure.
*/

allocate_cursor_statement   :  ALLOCATE scoped_identifier  cursor_intent;

cursor_intent  :  statement_cursor | result_set_cursor;

statement_cursor :
		( cursor_sensitivity  )? ( cursor_scrollability  )? CURSOR
		( cursor_holdability  )? ( cursor_returnability  )? FOR scoped_identifier
		;

result_set_cursor  :  FOR PROCEDURE specific_routine_designator ;

/*
		 19.16 dynamic_open_statement   (p976)


Associate input dynamic parameters with a cursor_specification  and open the cursor.
*/

dynamic_open_statement    :  OPEN dynamic_cursor_name  ( input_using_clause )?;

/*
		 19.17 dynamic_fetch_statement   (p977)


Fetch a row for a cursor declared with a dynamic_declare_cursor .
*/

dynamic_fetch_statement    :  FETCH ( ( fetch_orientation  )? FROM )? dynamic_cursor_name  output_using_clause;

/*
		 19.18 dynamic_single_row_select_statement   (p978)


Retrieve values from a dynamically-specified row of a table.
*/

dynamic_single_row_select_statement    :  query_specification ;

/*
		 19.19 dynamic_close_statement   (p979)


Close a cursor.
*/

dynamic_close_statement    :  CLOSE dynamic_cursor_name ;

/*
		 19.20 dynamic_delete_statement_positioned  (p980)


Delete a row of a table.
*/

dynamic_delete_statement_positioned   :  DELETE FROM target_table  WHERE CURRENT OF dynamic_cursor_name ;

/*
		 19.21 dynamic_update_statement_positioned  (p982)


Update a row of a table.
*/

dynamic_update_statement_positioned  :
		UPDATE target_table  SET set_clause_list  WHERE CURRENT OF dynamic_cursor_name ;

/*
		 19.22 preparable_dynamic_delete_statement_positioned  (p984)


Delete a row of a table through a dynamic cursor.
*/

preparable_dynamic_delete_statement_positioned  :
		DELETE ( FROM target_table  )? WHERE CURRENT OF ( scope_option  )? cursor_name ;

/*
		 19.23 preparable_dynamic_update_statement_positioned  (p986)


Update a row of a table through a dynamic cursor.
*/

preparable_dynamic_update_statement_positioned  :
		UPDATE ( target_table  )? SET set_clause_list  WHERE CURRENT OF ( scope_option  )? cursor_name ;

/*

	20 Embedded SQL


		 20.1 embedded_sql_host_program  (p989)


Specify an embedded_sql_host_program .
*/

/*
embedded_sql_host_program  :
		embedded_sql_ada_program
	|	embedded_sql_c_program
	|	embedded_sql_cobol_program
	|	embedded_sql_fortran_program
	|	embedded_sql_mumps_program
	|	embedded_sql_pascal_program
	|	embedded_sql_pl1_program
	;

embedded_sql_statement   :  sql_prefix statement_or_declaration ( sql_terminator )?;

statement_or_declaration :
		declare_cursor
	|	dynamic_declare_cursor
	|	temporary_table_declaration
	|	embedded_authorization_declaration
	|	embedded_path_specification
	|	embedded_transform_group_specification
	|	embedded_collation_specification
	|	embedded_exception_declaration
	|	handler_declaration
	|	sql_procedure_statement
	;

sql_prefix  :  EXEC SQL | Ampersand SQL Left_Paren;

sql_terminator  :  END_EXEC | Semicolon | Right_Paren;

embedded_authorization_declaration  :  DECLARE embedded_authorization_clause;

embedded_authorization_clause :
		( SCHEMA schema_name )?
	 	( AUTHORIZATION embedded_authorization_identifier ( FOR STATIC ( ONLY | AND DYNAMIC ) )? )?
	;

embedded_authorization_identifier  :  module_authorization_identifier ;

embedded_path_specification  :  path_specification ;

embedded_transform_group_specification  :  transform_group_specification ;

embedded_collation_specification  :  module_collations ;

embedded_sql_declare_section
    options{k=1;}
    :
		embedded_sql_begin_declare ( embedded_character_set_declaration )? ( host_variable_definition )* embedded_sql_end_declare
	|	embedded_sql_MUMPS_declare
	;

embedded_character_set_declaration  :  SQL NAMES ARE Character_Set_Name ;

embedded_sql_begin_declare  options{k=1;}:  sql_prefix BEGIN DECLARE SECTION ( sql_terminator )?;

embedded_sql_end_declare  options{k=1;}:  sql_prefix END DECLARE SECTION ( sql_terminator )?;

embedded_sql_MUMPS_declare :
		sql_prefix BEGIN DECLARE SECTION ( embedded_character_set_declaration )?
		( host_variable_definition )* END DECLARE SECTION sql_terminator
		;

host_variable_definition
    options{k=1;}
    :
		{isAdaHost()}? 		ada_variable_definition
	|	{isCppHost()}? 		c_variable_definition
	|	{isCobolHost()}? 	cobol_variable_definition
	|	{isFortranHost}? 	fortran_variable_definition
	|	{isMumpsHost}?		mumps_variable_definition
	|	{isPascalHost()}?	pascal_variable_definition
	|	{isPl1Host()}?		pl1_variable_definition
	|	{true}?
	;

host_parameter_name      :  Colon host_identifier ;

host_identifier :
		{isAdaHost()}? 		ada_host_identifier
	|	{isCppHost()}? 		c_host_identifier
	|	{isCobolHost()}? 	cobol_host_identifier
	|	{isFortranHost}? 	fortran_host_identifier
	|	{isMumpsHost}?		mumps_host_identifier
	|	{isPascalHost()}?	pascal_host_identifier
	|	{isPl1Host()}?		pl1_host_identifier
	|	{true}?				sql_language_identifier
	;
*/
/*
		 20.2 embedded_exception_declaration (p1001)


Specify the action to be taken when an SQL-statement causes a specific class of condition to be
raised.
*/

embedded_exception_declaration  :  WHENEVER condition condition_action;

condition  :  sql_condition;

sql_condition :
		major_category
	|	SQLSTATE Left_Paren sqlstate_class_value ( Comma sqlstate_subclass_value )? Right_Paren
	|	CONSTRAINT fully_qualified_identifier
	;

major_category  :  SQLEXCEPTION | SQLWARNING | NOT FOUND;

sqlstate_class_value  :  sqlstate_char sqlstate_char /*!! See the Syntax Rules.*/;

sqlstate_subclass_value  :  sqlstate_char sqlstate_char sqlstate_char /*!! See the Syntax Rules.*/;

sqlstate_value : SQLSTATE ( VALUE )? Character_String_Literal;

sqlstate_char  :  Simple_Latin_Upper_Case_Letter | Digit;

condition_action  :  CONTINUE | go_to;

condition_name : identifier;

go_to  :  ( GOTO | GO TO ) go_to_target;

go_to_target :
		host_label_identifier
	|	Unsigned_Integer
	|	host_pl1_label_variable
	;

host_label_identifier  :  Regular_Identifier /*!! See the Syntax Rules.*/;

host_pl1_label_variable  :  Regular_Identifier /*!! See the Syntax Rules.*/;

handler_declaration :
    DECLARE handler_type HANDLER FOR condition_value_list handler_action;

handler_type :
    CONTINUE
  | EXIT
  | UNDO
  ;

handler_action : sql_procedure_statement;

condition_value_list : condition_value ( Comma condition_value )*;

condition_value :
    sqlstate_value
  | condition_name
  | SQLEXCEPTION
  | SQLWARNING
  | NOTFOUND
  ;


/*
		 20.3 embedded_sql_ada_program (p1005)


Specify an embedded_sql_ada_program.
*/

embedded_sql_ada_program  :  unimplemented_error /*!! See the Syntax Rules.*/;

ada_variable_definition :
		ada_host_identifier ( Comma ada_host_identifier )* Colon ada_type_specification ( ada_initial_value )?;

ada_initial_value  :  ada_assignment_operator ~(Semicolon)* Semicolon;

ada_assignment_operator  :  Colon Equals_Operator;

ada_host_identifier  :  Regular_Identifier /*!! See the Syntax Rules.*/;

ada_type_specification :
		ada_qualified_type_specification
	|	ada_unqualified_type_specification
	|	ada_derived_type_specification
	;

ada_qualified_type_specification :
		INTERFACES Period SQL Period
		(	CHAR ( CHARACTER SET ( IS )? Character_Set_Name  )?
			Left_Paren one Double_Period  length  Right_Paren
		|	SMALLINT
		|	INT
		|	BIGINT
		|	REAL
		|	DOUBLE_PRECISION
		|	BOOLEAN
		|	SQLSTATE_TYPE
		|	INDICATOR_TYPE
		)
	;
one	:	Unsigned_Integer {$UnsignedInteger.text == '1'};

ada_unqualified_type_specification :
		CHAR Left_Paren one Double_Period  length  Right_Paren
	|	SMALLINT
	|	INT
	|	BIGINT
	|	REAL
	|	DOUBLE_PRECISION
	|	BOOLEAN
	|	SQLSTATE_TYPE
	|	INDICATOR_TYPE
	;

ada_derived_type_specification :
		ada_CLOB_variable
	|	ada_CLOB_locator_variable
	|	ada_BLOB_variable
	|	ada_BLOB_locator_variable
	|	ada_user_defined_type_variable
	|	ada_user_defined_type_locator_variable
	|	ada_REF_variable
	|	ada_array_locator_variable
	|	ada_multiset_locator_variable
	;

ada_CLOB_variable :
		SQL TYPE IS CLOB Left_Paren large_object_length  Right_Paren ( CHARACTER SET ( IS )? Character_Set_Name  )?;

ada_CLOB_locator_variable  :  SQL TYPE IS CLOB AS LOCATOR;

ada_BLOB_variable  :  SQL TYPE IS BLOB Left_Paren large_object_length  Right_Paren;

ada_BLOB_locator_variable  :  SQL TYPE IS BLOB AS LOCATOR;

ada_user_defined_type_variable  :  SQL TYPE IS fully_qualified_identifier  AS predefined_type ;

ada_user_defined_type_locator_variable  :  SQL TYPE IS fully_qualified_identifier  AS LOCATOR;

ada_REF_variable  :  SQL TYPE IS reference_type ;

ada_array_locator_variable  :  SQL TYPE IS array_type  AS LOCATOR;

ada_multiset_locator_variable  :  SQL TYPE IS multiset_type  AS LOCATOR;

/*
		 20.4 embedded_sql_C_program (p1011)


Specify an embedded_sql_C_program.
*/

embedded_sql_c_program  :  unimplemented_error /*!! See the Syntax Rules.*/;

c_variable_definition  :  ( c_storage_class )? ( c_class_modifier )? c_variable_specification Semicolon;

c_variable_specification  :  c_numeric_variable | c_character_variable | c_derived_variable;

c_storage_class  :  AUTO | EXTERN | STATIC;

c_class_modifier  :  CONST | VOLATILE;

c_numeric_variable :
		( LONG LONG | LONG | SHORT | FLOAT | DOUBLE ) c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_character_variable :
		c_character_type ( CHARACTER SET ( IS )? Character_Set_Name  )?
		c_host_identifier c_array_specification ( c_initial_value )?
		( Comma c_host_identifier c_array_specification ( c_initial_value )? )*
		;

c_character_type  :  CHAR | UNSIGNED CHAR | UNSIGNED SHORT;

c_array_specification  :  Left_Bracket length  Right_Bracket;

c_host_identifier  :  Regular_Identifier /*!! See the Syntax Rules.*/;

c_derived_variable :
		c_VARCHAR_variable
	|	c_NCHAR_variable
	|	c_NCHAR_VARYING_variable
	|	c_CLOB_variable
	|	c_NCLOB_variable
	|	c_BLOB_variable
	|	c_user_defined_type_variable
	|	c_CLOB_locator_variable
	|	c_BLOB_locator_variable
	|	c_array_locator_variable
	|	c_multiset_locator_variable
	|	c_user_defined_type_locator_variable
	|	c_REF_variable
	;

c_VARCHAR_variable :
		VARCHAR ( CHARACTER SET ( IS )? Character_Set_Name  )?
		c_host_identifier c_array_specification ( c_initial_value )?
		( Comma c_host_identifier c_array_specification ( c_initial_value )? )*
		;

c_NCHAR_variable :
		NCHAR ( CHARACTER SET ( IS )? Character_Set_Name  )?
		c_host_identifier c_array_specification ( c_initial_value )?
		( Comma c_host_identifier c_array_specification ( c_initial_value )?  )*
		;

c_NCHAR_VARYING_variable :
		NCHAR_VARYING ( CHARACTER SET ( IS )? Character_Set_Name  )?
		c_host_identifier c_array_specification ( c_initial_value )?
		( Comma c_host_identifier c_array_specification ( c_initial_value )?  )*
		;

c_CLOB_variable :
		SQL TYPE IS CLOB Left_Paren large_object_length  Right_Paren
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_NCLOB_variable :
		SQL TYPE IS NCLOB Left_Paren large_object_length  Right_Paren
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_user_defined_type_variable :
		SQL TYPE IS fully_qualified_identifier  AS predefined_type
		c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_BLOB_variable :
		SQL TYPE IS BLOB Left_Paren large_object_length  Right_Paren
		c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_CLOB_locator_variable :
		SQL TYPE IS CLOB AS LOCATOR
		c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_BLOB_locator_variable :
		SQL TYPE IS BLOB AS LOCATOR
		c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_array_locator_variable :
		SQL TYPE IS array_type  AS LOCATOR
		c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_multiset_locator_variable :
		SQL TYPE IS multiset_type  AS LOCATOR
		c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_user_defined_type_locator_variable :
		SQL TYPE IS
		fully_qualified_identifier  AS LOCATOR
		c_host_identifier ( c_initial_value )?
		( Comma c_host_identifier ( c_initial_value )? )*
		;

c_REF_variable  :  SQL TYPE IS reference_type ;

c_initial_value  :  Equals_Operator  ~(Semicolon)* Semicolon;

/*
		 20.5 embedded_sql_cobol_program (p1019)


Specify an embedded_sql_cobol_program.
*/

embedded_sql_cobol_program  :  unimplemented_error /*!! See the Syntax Rules.*/;

cobol_variable_definition :
		( zero_one | seven_seven ) cobol_host_identifier cobol_type_specification
		 ~(Period)* Period
		;
zero_one	:	Unsigned_Integer {$Unsigned_Integer.text == '01'}?;
seven_seven	:	Unsigned_Integer {$Unsigned_Integer.text == '77'}?;

cobol_host_identifier  :  Regular_Identifier /*!! See the Syntax Rules.*/;

cobol_type_specification :
		cobol_character_type
	|	cobol_national_character_type
	|	cobol_numeric_type
	|	cobol_integer_type
	|	cobol_derived_type_specification
	;

cobol_derived_type_specification :
		cobol_CLOB_variable
	|	cobol_NCLOB_variable
	|	cobol_BLOB_variable
	|	cobol_user_defined_type_variable
	|	cobol_CLOB_locator_variable
	|	cobol_BLOB_locator_variable
	|	cobol_array_locator_variable
	|	cobol_multiset_locator_variable
	|	cobol_user_defined_type_locator_variable
	|	cobol_REF_variable
	;

cobol_character_type :
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		( PIC | PICTURE ) ( IS )? ( x ( Left_Paren length  Right_Paren )? )+
		;
x	:	Regular_Identifier {$Regular_Identifier.text == 'X'}?;

cobol_national_character_type :
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		( PIC | PICTURE ) ( IS )? ( n ( Left_Paren length  Right_Paren )? )+
		;
n	:	Regular_Identifier {$Regular_Identifier.text == 'N'}?;

cobol_CLOB_variable :
		( USAGE ( IS )? )?
		SQL TYPE IS CLOB Left_Paren large_object_length  Right_Paren
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		;

cobol_NCLOB_variable :
		( USAGE ( IS )? )?
		SQL TYPE IS NCLOB Left_Paren large_object_length  Right_Paren
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		;

cobol_BLOB_variable :
		( USAGE ( IS )? )?
		SQL TYPE IS BLOB Left_Paren large_object_length  Right_Paren;

cobol_user_defined_type_variable :
		( USAGE ( IS )? )? SQL TYPE IS fully_qualified_identifier  AS predefined_type ;

cobol_CLOB_locator_variable :
		( USAGE ( IS )? )? SQL TYPE IS CLOB AS LOCATOR;

cobol_BLOB_locator_variable :
		( USAGE ( IS )? )? SQL TYPE IS BLOB AS LOCATOR;

cobol_array_locator_variable :
	( USAGE ( IS )? )? SQL TYPE IS array_type  AS LOCATOR;

cobol_multiset_locator_variable :
	( USAGE ( IS )? )? SQL TYPE IS multiset_type  AS LOCATOR;

cobol_user_defined_type_locator_variable :
	( USAGE ( IS )? )? SQL TYPE IS fully_qualified_identifier  AS LOCATOR;

cobol_REF_variable  :  ( USAGE ( IS )? )? SQL TYPE IS reference_type ;

cobol_numeric_type :
		( PIC | PICTURE ) ( IS )? s cobol_nines_specification ( USAGE ( IS )? )? DISPLAY SIGN LEADING SEPARATE;

s	:	Regular_Identifier {$Regular_Identifier.text == 'S'}?;

cobol_nines_specification :
		cobol_nines ( v ( cobol_nines )? )?
	|	v cobol_nines
	;
v	:	Regular_Identifier {$Regular_Identifier.text == 'V'}?;

cobol_integer_type  :  cobol_binary_integer;

cobol_binary_integer  :  ( PIC | PICTURE ) ( IS )? s cobol_nines ( USAGE ( IS )? )? BINARY;

cobol_nines  :  ( nine ( Left_Paren length  Right_Paren )? )+;

nine	:	Unsigned_Integer {$Unsigned_Integer.text == '9'}?;

/*
		 20.6 embedded_sql_fortran_program (p1025)


Specify an embedded_sql_fortran_program.
*/

embedded_sql_fortran_program  :  unimplemented_error /*!! See the Syntax Rules.*/;

fortran_variable_definition :
		fortran_type_specification fortran_host_identifier ( Comma fortran_host_identifier )*;

fortran_host_identifier  :  Regular_Identifier /*!! See the Syntax Rules.*/;

fortran_type_specification :
		CHARACTER
			( Asterisk Unsigned_Integer | LEN Equals_Operator Unsigned_Integer )?
			( Left_Paren KIND Equals_Operator Unsigned_Integer Right_Paren )?
			( CHARACTER SET ( IS )? Character_Set_Name  )?

	|	(	INTEGER
		|	REAL
		|	DOUBLE PRECISION
		|	LOGICAL
		)
		( Asterisk Unsigned_Integer | LEN Equals_Operator Unsigned_Integer )?
		( Left_Paren KIND Equals_Operator Unsigned_Integer Right_Paren )?

	|	fortran_derived_type_specification
	;

fortran_derived_type_specification :
		fortran_CLOB_variable
	|	fortran_BLOB_variable
	|	fortran_user_defined_type_variable
	|	fortran_CLOB_locator_variable
	|	fortran_BLOB_locator_variable
	|	fortran_user_defined_type_locator_variable
	|	fortran_array_locator_variable
	|	fortran_multiset_locator_variable
	|	fortran_REF_variable
	;

fortran_CLOB_variable :
		SQL TYPE IS CLOB Left_Paren large_object_length  Right_Paren
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		;

fortran_BLOB_variable :
		SQL TYPE IS BLOB Left_Paren large_object_length  Right_Paren;

fortran_user_defined_type_variable :
		SQL TYPE IS fully_qualified_identifier  AS predefined_type ;

fortran_CLOB_locator_variable  :  SQL TYPE IS CLOB AS LOCATOR;

fortran_BLOB_locator_variable  :  SQL TYPE IS BLOB AS LOCATOR;

fortran_user_defined_type_locator_variable  :  SQL TYPE IS fully_qualified_identifier  AS LOCATOR;

fortran_array_locator_variable  :  SQL TYPE IS array_type  AS LOCATOR;

fortran_multiset_locator_variable  :  SQL TYPE IS multiset_type  AS LOCATOR;

fortran_REF_variable  :  SQL TYPE IS reference_type ;

/*
		 20.7 embedded_sql_mumps_program (p1030)


Specify an embedded_sql_mumps_program.
*/

embedded_sql_mumps_program  :  unimplemented_error /*!! See the Syntax Rules.*/;

mumps_variable_definition :
		mumps_numeric_variable Semicolon
	|	mumps_character_variable Semicolon
	|	mumps_derived_type_specification Semicolon
	;

mumps_character_variable :
		VARCHAR mumps_host_identifier mumps_length_specification
		( Comma mumps_host_identifier mumps_length_specification )*
		;

mumps_host_identifier  :  Regular_Identifier /*!! See the Syntax Rules.*/;

mumps_length_specification  :  Left_Paren length  Right_Paren;

mumps_numeric_variable  :  mumps_type_specification mumps_host_identifier ( Comma mumps_host_identifier )*;

mumps_type_specification :
		INT
	|	DEC ( Left_Paren precision  ( Comma scale  )? Right_Paren )?
	|	REAL
	;

mumps_derived_type_specification :
		mumps_CLOB_variable
	|	mumps_BLOB_variable
	|	mumps_user_defined_type_variable
	|	mumps_CLOB_locator_variable
	|	mumps_BLOB_locator_variable
	|	mumps_user_defined_type_locator_variable
	|	mumps_array_locator_variable
	|	mumps_multiset_locator_variable
	|	mumps_REF_variable
	;

mumps_CLOB_variable :
		SQL TYPE IS CLOB Left_Paren large_object_length  Right_Paren
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		;

mumps_BLOB_variable  :  SQL TYPE IS BLOB Left_Paren large_object_length  Right_Paren;

mumps_user_defined_type_variable  :  SQL TYPE IS fully_qualified_identifier  AS predefined_type ;

mumps_CLOB_locator_variable  :  SQL TYPE IS CLOB AS LOCATOR;

mumps_BLOB_locator_variable  :  SQL TYPE IS BLOB AS LOCATOR;

mumps_user_defined_type_locator_variable  :  SQL TYPE IS fully_qualified_identifier  AS LOCATOR;

mumps_array_locator_variable  :  SQL TYPE IS array_type  AS LOCATOR;

mumps_multiset_locator_variable  :  SQL TYPE IS multiset_type  AS LOCATOR;

mumps_REF_variable  :  SQL TYPE IS reference_type ;

/*
		 20.8 embedded_sql_pascal_program (p1035)


Specify an embedded_sql_pascal_program.
*/

embedded_sql_pascal_program  :  unimplemented_error /*!! See the Syntax Rules.*/;

pascal_variable_definition :
		pascal_host_identifier ( Comma pascal_host_identifier )* Colon pascal_type_specification Semicolon;

pascal_host_identifier  :  Regular_Identifier /*!! See the Syntax Rules.*/;

pascal_type_specification :
		PACKED ARRAY Left_Bracket one Double_Period  length  Right_Bracket OF CHAR
		( CHARACTER SET ( IS )? Character_Set_Name  )?
	|	INTEGER
	|	REAL
	|	CHAR ( CHARACTER SET ( IS )? Character_Set_Name  )?
	|	BOOLEAN
	|	pascal_derived_type_specification
	;

pascal_derived_type_specification :
		pascal_CLOB_variable
	|	pascal_BLOB_variable
	|	pascal_user_defined_type_variable
	|	pascal_CLOB_locator_variable
	|	pascal_BLOB_locator_variable
	|	pascal_user_defined_type_locator_variable
	|	pascal_array_locator_variable
	|	pascal_multiset_locator_variable
	|	pascal_REF_variable
	;

pascal_CLOB_variable :
		SQL TYPE IS CLOB Left_Paren large_object_length  Right_Paren
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		;

pascal_BLOB_variable  :  SQL TYPE IS BLOB Left_Paren large_object_length  Right_Paren;

pascal_CLOB_locator_variable  :  SQL TYPE IS CLOB AS LOCATOR;

pascal_user_defined_type_variable  :  SQL TYPE IS fully_qualified_identifier  AS predefined_type ;

pascal_BLOB_locator_variable  :  SQL TYPE IS BLOB AS LOCATOR;

pascal_user_defined_type_locator_variable  :  SQL TYPE IS fully_qualified_identifier  AS LOCATOR;

pascal_array_locator_variable  :  SQL TYPE IS array_type  AS LOCATOR;

pascal_multiset_locator_variable  :  SQL TYPE IS multiset_type  AS LOCATOR;

pascal_REF_variable  :  SQL TYPE IS reference_type;

/*
		 20.9 embedded_sql_pl1_program (p1040)


Specify an embedded_sql_pl1_program.
*/

embedded_sql_pl1_program  :  unimplemented_error /*!! See the Syntax Rules.*/;

pl1_variable_definition :
		(DCL | DECLARE)
		( 	pl1_host_identifier
		|	Left_Paren pl1_host_identifier ( Comma pl1_host_identifier )* Right_Paren
		)
		pl1_type_specification ~(Semicolon)* Semicolon
		;

pl1_host_identifier  :  Regular_Identifier /*!! See the Syntax Rules.*/;

pl1_type_specification :
		( CHAR | CHARACTER ) ( VARYING )? Left_Paren length Right_Paren ( CHARACTER SET ( IS )? Character_Set_Name  )?
	|	pl1_type_fixed_decimal Left_Paren precision  ( Comma scale  )? Right_Paren
	|	pl1_type_fixed_binary ( Left_Paren precision  Right_Paren )?
	|	pl1_type_float_binary Left_Paren precision  Right_Paren
	|	pl1_derived_type_specification
	;

pl1_derived_type_specification :
		pl1_CLOB_variable
	|	pl1_BLOB_variable
	|	pl1_user_defined_type_variable
	|	pl1_CLOB_locator_variable
	|	pl1_BLOB_locator_variable
	|	pl1_user_defined_type_locator_variable
	|	pl1_array_locator_variable
	|	pl1_multiset_locator_variable
	|	pl1_REF_variable
	;

pl1_CLOB_variable :
		SQL TYPE IS CLOB Left_Paren large_object_length  Right_Paren
		( CHARACTER SET ( IS )? Character_Set_Name  )?
		;

pl1_BLOB_variable  :  SQL TYPE IS BLOB Left_Paren large_object_length  Right_Paren;

pl1_user_defined_type_variable  :  SQL TYPE IS fully_qualified_identifier  AS predefined_type ;

pl1_CLOB_locator_variable  :  SQL TYPE IS CLOB AS LOCATOR;

pl1_BLOB_locator_variable  :  SQL TYPE IS BLOB AS LOCATOR;

pl1_user_defined_type_locator_variable  :  SQL TYPE IS fully_qualified_identifier  AS LOCATOR;

pl1_array_locator_variable  :  SQL TYPE IS array_type  AS LOCATOR;

pl1_multiset_locator_variable  :  SQL TYPE IS multiset_type  AS LOCATOR;

pl1_REF_variable  :  SQL TYPE IS reference_type ;

pl1_type_fixed_decimal :
		( DEC | DECIMAL ) FIXED
	|	FIXED ( DEC | DECIMAL )
	;

pl1_type_fixed_binary :
		( BIN | BINARY ) FIXED
	|	FIXED ( BIN | BINARY )
	;

pl1_type_float_binary :
		( BIN | BINARY ) FLOAT
	|	FLOAT ( BIN | BINARY )
	;

/*
	21 Direct invocation of SQL

	 21.1 <direct sql_statement>  (p1047)


Specify direct execution of SQL.
*/

direct_sql_statement   :  direct_executable_statement  Semicolon;

direct_executable_statement  :
		direct_sql_data_statement
	|	sql_schema_statement
	|	sql_transaction_statement
	|	sql_connection_statement
	|	sql_session_statement
	|	direct_implementation_defined_statement
	;

direct_sql_data_statement  :
		delete_statement_searched
	|	direct_select_statement_multiple_rows
	|	insert_statement
	|	update_statement_searched
	|	merge_statement
	|	temporary_table_declaration
	;

direct_implementation_defined_statement   :  /*!! See the Syntax Rules*/;

/*
		 21.2 direct_select_statement_multiple_rows (p1051)


Specify a statement to retrieve multiple rows from a specified table.
*/

direct_select_statement_multiple_rows  :  cursor_specification ;

/*

	22 Diagnostics management

		 22.1 get_diagnostics_statement   (p1053)


Get exception or completion condition information from a diagnostics area.;
*/

get_diagnostics_statement    :  GET DIAGNOSTICS sql_diagnostics_information;

sql_diagnostics_information  :  statement_information | condition_information;

statement_information  :  statement_information_item ( Comma statement_information_item )*;

statement_information_item  :  simple_target_specification  Equals_Operator statement_information_item_name;

statement_information_item_name :
		NUMBER
	|	MORE
	|	COMMAND_FUNCTION
	|	COMMAND_FUNCTION_CODE
	|	DYNAMIC_FUNCTION
	|	DYNAMIC_FUNCTION_CODE
	|	ROW_COUNT
	|	TRANSACTIONS_COMMITTED
	|	TRANSACTIONS_ROLLED_BACK
	|	TRANSACTION_ACTIVE
	;

condition_information :
		( EXCEPTION | CONDITION ) condition_number condition_information_item ( Comma condition_information_item )*;

condition_information_item  :  simple_target_specification  Equals_Operator condition_information_item_name;

condition_information_item_name :
		CATALOG_NAME
	|	CLASS_ORIGIN
	|	COLUMN_NAME
	|	CONDITION_NUMBER
	|	CONNECTION_NAME
	|	CONSTRAINT_CATALOG
	|	CONSTRAINT_NAME
	|	CONSTRAINT_SCHEMA
	|	CURSOR_NAME
	|	MESSAGE_LENGTH
	|	MESSAGE_OCTET_LENGTH
	|	MESSAGE_TEXT
	|	PARAMETER_MODE
	|	PARAMETER_NAME
	|	PARAMETER_ORDINAL_POSITION
	|	RETURNED_SQLSTATE
	|	ROUTINE_CATALOG
	|	ROUTINE_NAME
	|	ROUTINE_SCHEMA
	|	SCHEMA_NAME
	|	SERVER_NAME
	|	SPECIFIC_NAME
	|	SUBCLASS_ORIGIN
	|	TABLE_NAME
	|	TRIGGER_CATALOG
	|	TRIGGER_NAME
	|	TRIGGER_SCHEMA
	;

condition_number  :  simple_value_specification ;

/*
		 22.2 Pushing and popping the diagnostics area stack (p1068)



	23 Status codes



		 23.1 SQLSTATE (p1069)*/

/*
The character string value returned in an SQLSTATE parameter comprises a
2-character class value followed by a 3-character subclass value, each
with an_implementation_defined character set that has a one-octet
character encoding form and is restricted to digits and
simple_Latin_upper_case_letters.
Table 31, 'SQLSTATE class and subclass values', specifies the class
value for each condition and the subclass value or values for each class
value.
*/
/*
Class values that begin with one of the digits '0', '1', '2', '3', or
'4' or one of the simple_Latin_upper_case_letters 'A', 'B', 'C', 'D',
'E', 'F', 'G', or 'H' are returned only for conditions defined in
ISO/IEC 9075 or in any other International Standard.
The range of such class values are called standard-defined
classes.
Some such class codes are reserved for use by specific International
Standards, as specified elsewhere in this Clause.
Subclass values associated with such classes that also begin with one of
those 13 characters are returned only for conditions defined in ISO/IEC
9075 or some
other International Standard.
The range of such class values are called standard-defined classes.
Subclass values associated with such classes that begin with one of the
digits '5', '6', '7', '8', or '9' or one of the <simple_Latin upper
case letter>s 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
'T', 'U', 'V', 'W', 'X', 'Y', or 'Z' are reserved for
implementation-specified conditions and are called
implementation_defined subclasses.
*/
/*
Class values that begin with one of the digits '5', '6', '7', '8', or
'9' or one of the simple_Latin_upper_case_letters 'I', 'J', 'K', 'L',
'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', or 'Z'
are reserved for implementation-specified exception conditions and are
called_implementation_defined classes.
All subclass values except '000', which means no subclass, associated
with such classes are reserved for implementation-specified conditions
and are called_implementation_defined subclasses.
An_implementation_defined completion condition shall be indicated by
returning an_implementation_defined subclass in conjunction with one of
the classes successful completion, warning, or no data.
*/


/*
The 'Category' column has the following meanings: 'S' means that the class value given corresponds
to successful completion and is a completion condition; 'W' means that the class value given
corresponds to a successful completion but with a warning and is a completion condition; 'N' means
that the class value given corresponds to a no-data situation and is a completion condition; 'X'
means that the class value given corresponds to an exception condition.
*/

/*
Table 31 - SQLSTATE class and subclass values
*/

/*

    *   Category   Condition   Class   Subcondition   Subclass
    *   X   ambiguous cursor name   3C   (no subclass)   000
    *   X   attempt to assign to non_updatable column   0U   (no subclass)   000
    *   X   attempt to assign to ordering column   0V   (no subclass)   000
    *   X   cardinality violation   21   (no subclass)   000
    *   X   connection exception   08   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   connection does not exist   003
    *   &nbsp;   &nbsp;   &nbsp;   connection failure   006
    *   &nbsp;   &nbsp;   &nbsp;   connection name in use   002
    *   &nbsp;   &nbsp;   &nbsp;   SQL-client unable to establish SQL-connection   001
    *   &nbsp;   &nbsp;   &nbsp;   SQL-server rejected establishment of SQL-connection   004
    *   &nbsp;   &nbsp;   &nbsp;   transaction resolution unknown   007
    *   X   cursor sensitivity exception   36   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   request failed   002
    *   &nbsp;   &nbsp;   &nbsp;   request rejected   001
    *   X   data exception   22   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   array data, right truncation   02F
    *   &nbsp;   &nbsp;   &nbsp;   array element error   02E
    *   &nbsp;   &nbsp;   &nbsp;   character not in repertoire   021
    *   &nbsp;   &nbsp;   &nbsp;   datetime field overflow   008
    *   &nbsp;   &nbsp;   &nbsp;   division by zero   012
    *   &nbsp;   &nbsp;   &nbsp;   error in assignment   005
    *   &nbsp;   &nbsp;   &nbsp;   escape character conflict   00B
    *   &nbsp;   &nbsp;   &nbsp;   indicator overflow   022
    *   &nbsp;   &nbsp;   &nbsp;   interval field overflow   015
    *   &nbsp;   &nbsp;   &nbsp;   invalid argument for natural logarithm   01E
    *   &nbsp;   &nbsp;   &nbsp;   invalid argument for power function   01F
    *   &nbsp;   &nbsp;   &nbsp;   invalid argument for width bucket function   01G
    *   &nbsp;   &nbsp;   &nbsp;   invalid character value for cast   018
    *   &nbsp;   &nbsp;   &nbsp;   invalid datetime format   007
    *   &nbsp;   &nbsp;   &nbsp;   invalid escape character   019
    *   &nbsp;   &nbsp;   &nbsp;   invalid escape octet   00D
    *   &nbsp;   &nbsp;   &nbsp;   invalid escape sequence   025
    *   &nbsp;   &nbsp;   &nbsp;   invalid indicator parameter value   010
    *   &nbsp;   &nbsp;   &nbsp;   invalid interval format   006
    *   &nbsp;   &nbsp;   &nbsp;   invalid parameter value   023
    *   &nbsp;   &nbsp;   &nbsp;   invalid preceding or following size in window function   013
    *   &nbsp;   &nbsp;   &nbsp;   invalid regular expression   01B
    *   &nbsp;   &nbsp;   &nbsp;   invalid repeat argument in a sample clause   02G
    *   &nbsp;   &nbsp;   &nbsp;   invalid sample size   02H
    *   &nbsp;   &nbsp;   &nbsp;   invalid time zone displacement value   009
    *   &nbsp;   &nbsp;   &nbsp;   invalid use of escape character   00C
    *   &nbsp;   &nbsp;   &nbsp;   most specific type mismatch   00G
    *   &nbsp;   &nbsp;   &nbsp;   noncharacter in UCS string   029
    *   &nbsp;   &nbsp;   &nbsp;   null value substituted for mutator subject parameter   02D
    *   &nbsp;   &nbsp;   &nbsp;   null row not permitted in table   01C
    *   &nbsp;   &nbsp;   &nbsp;   null value in array target   00E
    *   &nbsp;   &nbsp;   &nbsp;   null value, no indicator parameter   002
    *   &nbsp;   &nbsp;   &nbsp;   null value not allowed   004
    *   &nbsp;   &nbsp;   &nbsp;   numeric value out of range   003
    *   &nbsp;   &nbsp;   &nbsp;   sequence generator limit exceeded   00H
    *   &nbsp;   &nbsp;   &nbsp;   string data, length mismatch   026
    *   &nbsp;   &nbsp;   &nbsp;   string data, right truncation   001
    *   &nbsp;   &nbsp;   &nbsp;   substring error   011
    *   &nbsp;   &nbsp;   &nbsp;   trim error   027
    *   &nbsp;   &nbsp;   &nbsp;   unterminated C string   024
    *   &nbsp;   &nbsp;   &nbsp;   zero-length character string   00F
    *   X   dependent privilege descriptors still exist   2B   (no subclass)   000
    *   X   diagnostics exception   0Z   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   maximum number of stacked diagnostics areas exceeded   001
    *   X   dynamic SQL error   07   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   cursor specification cannot be executed   003
    *   &nbsp;   &nbsp;   &nbsp;   data type transform function violation   00B
    *   &nbsp;   &nbsp;   &nbsp;   invalid DATA target   00D
    *   &nbsp;   &nbsp;   &nbsp;   invalid DATETIME_INTERVAL_CODE   00F
    *   &nbsp;   &nbsp;   &nbsp;   invalid descriptor count   008
    *   &nbsp;   &nbsp;   &nbsp;   invalid descriptor index   009
    *   &nbsp;   &nbsp;   &nbsp;   invalid LEVEL value   00E
    *   &nbsp;   &nbsp;   &nbsp;   prepared statement not a cursor specification   005
    *   &nbsp;   &nbsp;   &nbsp;   restricted data type attribute violation   006
    *   &nbsp;   &nbsp;   &nbsp;   undefined DATA value   00C
    *   &nbsp;   &nbsp;   &nbsp;   using clause does not match dynamic parameter specifications   001
    *   &nbsp;   &nbsp;   &nbsp;   using clause does not match target specifications   002
    *   &nbsp;   &nbsp;   &nbsp;   using clause required for dynamic parameters   004
    *   &nbsp;   &nbsp;   &nbsp;   using clause required for result fields   007
    *   X   external routine exception   38   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   containing SQL not permitted   001
    *   &nbsp;   &nbsp;   &nbsp;   modifying SQL-data not permitted   002
    *   &nbsp;   &nbsp;   &nbsp;   prohibited SQL-statement attempted   003
    *   &nbsp;   &nbsp;   &nbsp;   reading SQL-data not permitted   004
    *   X   external routine invocation exception   39   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   invalid SQLSTATE returned   001
    *   &nbsp;   &nbsp;   &nbsp;   null value not allowed   004
    *   X   feature not supported   0A   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   multiple server transactions   001
    *   X   integrity constraint violation   23   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   restrict violation   001
    *   X   invalid authorization specification   28   (no subclass)   000
    *   X   invalid catalog name   3D   (no subclass)   000
    *   X   invalid character set name   2C   (no subclass)   000
    *   X   invalid condition number   35   (no subclass)   000
    *   X   invalid connection name   2E   (no subclass)   000
    *   X   invalid cursor name   34   (no subclass)   000
    *   X   invalid cursor state   24   (no subclass)   000
    *   X   invalid grantor   0L   (no subclass)   000
    *   X   invalid role specification   0P   (no subclass)   000
    *   X   invalid schema name   3F   (no subclass)   000
    *   X   invalid schema name list specification   0E   (no subclass)   000
    *   X   invalid session collation specification   2H   (no subclass)   000
    *   X   invalid SQL descriptor name   33   (no subclass)   000
    *   X   invalid SQL-invoked procedure reference   0M   (no subclass)   000
    *   X   invalid SQL statement name   26   (no subclass)   000
    *   X   invalid SQL statement Regular_Identifier   30   (no subclass)   000
    *   X   invalid target type specification   0D   (no subclass)   000
    *   X   invalid transaction initiation   0B   (no subclass)   000
    *   X   invalid transaction state   25   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   active SQL-transaction   001
    *   &nbsp;   &nbsp;   &nbsp;   branch transaction already active   002
    *   &nbsp;   &nbsp;   &nbsp;   held cursor requires same isolation level   008
    *   &nbsp;   &nbsp;   &nbsp;   inappropriate access mode for branch transaction   003
    *   &nbsp;   &nbsp;   &nbsp;   inappropriate isolation level for branch transaction   004
    *   &nbsp;   &nbsp;   &nbsp;   no active SQL-transaction for branch transaction   005
    *   &nbsp;   &nbsp;   &nbsp;   read-only SQL-transaction   006
    *   &nbsp;   &nbsp;   &nbsp;   schema and data statement mixing not supported   007
    *   X   invalid transaction termination   2D   (no subclass)   000
    *   X   invalid transform group name specification   0S   (no subclass)   000
    *   X   locator exception   0F   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   invalid specification   001
    *   N   no data   02   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   no additional dynamic result sets returned   001
    *   X   prohibited statement encountered during trigger execution   0W   (no subclass)   000
    *   X   Remote Database Access   HZ   (See Table 32, 'SQLSTATE class codes for RDA', for the definition of protocol subconditions and subclass code values)   &nbsp;
    *   X   savepoint exception   3B   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   invalid specification   001
    *   &nbsp;   &nbsp;   &nbsp;   too many   002
    *   X   SQL routine exception   2F   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   function executed no return statement   005
    *   &nbsp;   &nbsp;   &nbsp;   modifying SQL-data not permitted   002
    *   &nbsp;   &nbsp;   &nbsp;   prohibited SQL-statement attempted   003
    *   &nbsp;   &nbsp;   &nbsp;   reading SQL-data not permitted   004
    *   S   successful completion   00   (no subclass)   000
    *   X   syntax error or access rule violation   42   (no subclass)   000
    *   X   target table disagrees with cursor specification   0T   (no subclass)   000
    *   X   transaction rollback   40   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   integrity constraint violation   002
    *   &nbsp;   &nbsp;   &nbsp;   serialization failure   001
    *   &nbsp;   &nbsp;   &nbsp;   statement completion unknown   003
    *   &nbsp;   &nbsp;   &nbsp;   triggered action exception   004
    *   X   triggered action exception   09   (no subclass)   000
    *   X   triggered data change violation   27   (no subclass)   000
    *   W   warning   01   (no subclass)   000
    *   &nbsp;   &nbsp;   &nbsp;   additional result sets returned   00D
    *   &nbsp;   &nbsp;   &nbsp;   array data, right truncation   02F
    *   &nbsp;   &nbsp;   &nbsp;   attempt to return too many result sets   00E
    *   &nbsp;   &nbsp;   &nbsp;   cursor operation conflict   001
    *   &nbsp;   &nbsp;   &nbsp;   default value too long for information schema   00B
    *   &nbsp;   &nbsp;   &nbsp;   disconnect error   002
    *   &nbsp;   &nbsp;   &nbsp;   dynamic result sets returned   00C
    *   &nbsp;   &nbsp;   &nbsp;   external routine warning (the value of xx to be chosen by the author of the external routine)   Hxx
    *   &nbsp;   &nbsp;   &nbsp;   insufficient item descriptor areas   005
    *   &nbsp;   &nbsp;   &nbsp;   null value eliminated in set function   003
    *   &nbsp;   &nbsp;   &nbsp;   privilege not granted   007
    *   &nbsp;   &nbsp;   &nbsp;   privilege not revoked   006
    *   &nbsp;   &nbsp;   &nbsp;   query expression too long for information schema   00A
    *   &nbsp;   &nbsp;   &nbsp;   search condition too long for information schema   009
    *   &nbsp;   &nbsp;   &nbsp;   statement too long for information schema   008
    *   &nbsp;   &nbsp;   &nbsp;   string data, right truncation   004
    *   X   with check option violation   44   (no subclass)   000

*/

/*

	24 Conformance


		 24.1 General Conformance Requirements (p1079)


Table 33 - Implied feature relationships
*/

/*

    *   Feature ID   Feature Description   Implied Feature   ID Implied Feature Description
    *   B032   Extended dynamic SQL   B031   Basic dynamic SQL
    *   B034   Dynamic specification of cursor attributes   B031   Basic dynamic SQL
    *   F381   Extended schema manipulation   F491   Constraint management
    *   F451   Character set definition   F461   Named character sets
    *   F711   ALTER domain   F251   Domain support
    *   F801   Full set function   F441   Extended set function support
    *   S024   Enhanced structured types   S023   Basic structured types
    *   S041   Basic reference types   S023   Basic structured types
    *   S041   Basic reference types   S051   Create table of type
    *   S043   Enhanced reference types   S041   Basic reference types
    *   S051   Create table of type   S023   Basic structured types
    *   S081   Subtables   S023   Basic structured types
    *   S081   Subtables   S051   Create table of type
    *   S092   Arrays of user_defined types   S091   Basic array support
    *   S094   Arrays of reference types   S041   Basic reference types
    *   S094   Arrays of reference types   S091   Basic array support
    *   S095   Array constructors by query   S091   Basic array support
    *   S096   Optional array bounds   S091   Basic array support
    *   S111   ONLY in query expressions   S023   Basic structured types
    *   S111   ONLY in query expressions   S051   Create table of type
    *   S201   SQL-invoked routines on arrays   S091   Basic array support
    *   S202   SQL-invoked routines on multisets   S271   Basic multiset support
    *   S231   Structured type locators   S023   Basic structured types
    *   S232   Array locators   S091   Basic array support
    *   S233   Multiset locators   S271   Basic multiset support
    *   S242   Alter transform statement   S241   Transform functions
    *   S272   Multisets of user_defined types   S271   Basic multiset support
    *   S274   Multisets of reference types   S041   Basic reference types
    *   S274   Multisets of reference types   S271   Basic multiset support
    *   S275   Advanced multiset support   S271   Basic multiset support
    *   T042   Extended LOB data type support   T041   Basic LOB data type support
    *   T061   UCS Support   F461   Named character sets
    *   T071   BIGINT data type   E001-01   INTEGER and SMALLINT data types (including all spellings)
    *   T131   Recursive query   T121   WITH (excluding RECURSIVE) in query expression
    *   T173   Extended LIKE clause in table definition   T171   LIKE clause in table definition
    *   T212   Enhanced trigger capability   T211   Basic trigger capability
    *   T332   Extended roles   T331   Basic roles
    *   T511   Transaction counts   F121   Basic diagnostics management
    *   T571   Array-returning external SQL-invoked functions   S091   Basic array support
    *   T571   Array-returning external SQL-invoked functions   S201   SQL-invoked routines on arrays
    *   T572   Multiset-returning external SQLinvoked functions   S202   SQL-invoked routines on multisets
    *   T572   Multiset-returning external SQLinvoked functions   S271   Basic multiset support
    *   T612   Advanced OLAP operations   T611   Elementary OLAP operations

*/

/*

	END OF SQL-2003 Part 2 (SQL/Foundation) GRAMMAR


	Notes on Automatically Converting the SQL Grammar to a YACC Grammar


Automatic translation of this grammar is non_trivial for a number of
reasons.
One is that the grammar has a number of actions '!!See the Syntax Rules'
which cannot be translated automatically. Another is that the grammar
contains rules that are usually better handled by the lexical analyzer
than the grammar proper. Then there are incomplete rules such as those
which reference parts 6 to 10 (they are not defined; indeed, part 7,
which was going to be SQL/Temporal, is in complete abeyance), and the
packages (almost completely undefined in the grammar). It is not clear
whether these can be ignored, or annotated out of the way.
*/

/*
Another complication is automatically generating rules to deal with
optional components and repetitive components in the grammar.
Square brackets do not contain alternative non_terminals; all those
expressions are contained within curly brackets within the square
brackets.
However, some square brackets do contain alternative terminals.
Curly brackets contain and group mandatory elements.
However, they are usually used in conjunction with the 'one or more
times' repeater ellipsis '...' mark.
*/

/*
	END OF SQL 2003-2 (SQL/FOUNDATION) GRAMMAR
*/

