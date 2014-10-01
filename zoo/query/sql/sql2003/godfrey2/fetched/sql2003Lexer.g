lexer grammar sql2003Lexer;

options
{
    language=Java;
}

/* 
=====================================================================================

BNF Grammar for ISO/IEC 9075-2:2003 - Database Language SQL (SQL-2003) SQL/Foundation

=====================================================================================

This software is made available under the BSD License:

Copyright (c) 2011, Mage Systems
Portions Copyright (c)  Jonathan Leffler 2004-2009'
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


	5 Lexical Elements


Basic definitions of characters used, tokens, symbols, etc.
Most of this section would normally be handled within the lexical
analyzer rather than in the grammar proper.
Further, the original document does not quote the various single
characters, which makes it hard to process automatically.
*/

//-------------------------------------------------------------------------
//
//  Lexer Rules
//
//-------------------------------------------------------------------------


// C o m m e n t   T o k e n s
fragment
Start_Comment   : '/*';

fragment
End_Comment     : '*/';

fragment
Line_Comment    : '//';

COMMENT
    :   (   Start_Comment ( options {greedy=false;} : . )* End_Comment )+ 
		{
//			$channel=HIDDEN;
			SKIP();
		} 
    ;

LINE_COMMENT
    : 	(   ( Line_Comment | '--' ) ~('\n'|'\r')* '\r'? '\n')+ 
		{
//			$channel=HIDDEN;
			SKIP();
		} 
    ;


fragment
SQL_Terminal_Character  :  SQL_Language_Character;

fragment
SQL_Language_Character  :  Simple_Latin_Letter | Digit | SQL_Special_Character;

fragment
Simple_Latin_Letter  :  Simple_Latin_Upper_Case_Letter | Simple_Latin_Lower_Case_Letter;

fragment
Simple_Latin_Upper_Case_Letter :
		'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G' | 'H' | 'I' | 'J' | 'K' | 'L' | 'M' | 
		'N' | 'O' | 'P' | 'Q' | 'R' | 'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z';

fragment
Simple_Latin_Lower_Case_Letter :
		'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm' | 
		'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z';

fragment
Digit  :  '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9';

fragment
OctalDigit  :  '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7';

fragment
Hexit   :  Digit | 'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'a' | 'b' | 'c' | 'd' | 'e' | 'f';

fragment
SQL_Special_Character :
		Space
	|	Double_Quote
	|	Percent
	|	Ampersand
	|	Quote
	|	Left_Paren
	|	Right_Paren
	|	Asterisk
	|	Plus_Sign
	|	Comma
	|	Minus_Sign
	|	Period
	|	Slash
	|	Colon
	|	Semicolon
	|	Less_Than_Operator
	|	Equals_Operator
	|	Greater_Than_Operator
	|	Question_Mark
	|	Left_Bracket
	|	Right_Bracket
	|	Circumflex
	|	Underscore
	|	Vertical_Bar
	|	Left_Brace
	|	Right_Brace
	;

fragment
Unsigned_Large_Integer
	:	;
fragment
Signed_Large_Integer
	:	;
fragment
Unsigned_Float
	:	;
fragment
Signed_Float
	:	;

//  Punctuation and Arithmetic/Logical Operators

Not_Equals_Operator     
	:	 '<>';
Greater_Or_Equals_Operator  
	:	 '>=';
Less_Or_Equals_Operator 
	:	 '<=';
Concatenation_Operator  
	:	 '||';
Right_Arrow             
	:	 '->';
Double_Colon            
	:	 '::';
Double_Period           
	:	 '..';

Back_Quote              
	:	 '`';
Tilde                   
	:	 '~';
Exclamation             
	:	 '!';
AT_Sign                 
	:	 '@';
Percent                 
	:	 '\%';
Circumflex              
	:	 '^';
Ampersand               
	:	 '&';
Asterisk                
	:	 '*';
Left_Paren              
	:	 '(';
Right_Paren             
	:	 ')';
Plus_Sign               
	:	 '+';
Minus_Sign              
	:	 '-';
Equals_Operator         
	:	 '=';
Left_Brace              
	:	 '{';
Right_Brace             
	:	 '}';
/*
    The trigraphs are new in SQL-2003.
*/
Left_Bracket            
	:	 '[';
Left_Bracket_Trigraph   
	:	 '??(';
Right_Bracket           
	:	 ']';
Right_Bracket_Trigraph  
	:	 '??)';

Vertical_Bar            
	:	 '|';
Colon                   
	:	 ':';
Semicolon               
	:	 ';';
Double_Quote            
	:	 '"';
Quote                   
	:	 '\'';
Less_Than_Operator      
	:	 '<';
Greater_Than_Operator   
	:	 '>';
Comma                   
	:	 ',';
Period                  
	:	 '.';
Question_Mark           
	:	 '?';
Slash                   
	:	 '/';

fragment
Underscore	: '_';
fragment
Back_Slash  : '\\';
fragment
Hash_Sign   : '#';
fragment
Dollar_Sign : '$';


//  Keyword Tokens


//  Reserved Keyword Tokens

	ADD                         :   'ADD'              | 'add';
	ALLOCATE                    :   'ALLOCATE'         | 'allocate';
	ALL                         :   'ALL'              | 'all';
	ALTER                       :   'ALTER'            | 'alter';
	AND                         :   'AND'              | 'and';
	ANY                         :   'ANY'              | 'any';
	ARE                         :   'ARE'              | 'are';
	ARRAY                       :   'ARRAY'            | 'array';
	ASENSITIVE                  :   'ASENSITIVE'       | 'asensitive';
	ASYMMETRIC                  :   'ASYMMETRIC'       | 'asymmetric';
	AS                          :   'AS'               | 'as';
	ATOMIC                      :   'ATOMIC'           | 'atomic';
	AT                          :   'AT'               | 'at';
	AUTHORIZATION               :   'AUTHORIZATION'    | 'authorization';
	BEGIN                       :   'BEGIN'            | 'begin';
	BETWEEN                     :   'BETWEEN'          | 'between';
	BIGINT                      :   'BIGINT'           | 'bigint';
	BINARY                      :   'BINARY'           | 'binary';
	BLOB                        :   'BLOB'             | 'blob';
	BOOLEAN                     :   'BOOLEAN'          | 'boolean';
	BOTH                        :   'BOTH'             | 'both';
	BY                          :   'BY'               | 'by';
	CALLED                      :   'CALLED'           | 'called';
	CALL                        :   'CALL'             | 'call';
	CASCADED                    :   'CASCADED'         | 'cascaded';
	CASE                        :   'CASE'             | 'case';
	CAST                        :   'CAST'             | 'cast';
	CHARACTER                   :   'CHARACTER'        | 'character';
	CHAR                        :   'CHAR'             | 'char';
	CHECK                       :   'CHECK'            | 'check';
	CLOB                        :   'CLOB'             | 'clob';
	CLOSE                       :   'CLOSE'            | 'close';
	COLLATE                     :   'COLLATE'          | 'collate';
	COLUMN                      :   'COLUMN'           | 'column';
	COMMIT                      :   'COMMIT'           | 'commit';
	CONNECTION                  :   'CONNECTION'       | 'connection';
	CONNECT                     :   'CONNECT'          | 'connect';
	CONSTRAINT                  :   'CONSTRAINT'       | 'constraint';
	CONSTRUCTOR                 :   'CONSTRUCTOR'      | 'constructor';
	CONTINUE                    :   'CONTINUE'         | 'continue';
	CORRESPONDING               :   'CORRESPONDING'    | 'corresponding';
	CREATE                      :   'CREATE'           | 'create';
	CROSS                       :   'CROSS'            | 'cross';
	CUBE                        :   'CUBE'             | 'cube';
	CURRENT_DATE                :   'CURRENT_DATE'     | 'current_date';
	CURRENT_DEFAULT_TRANSFORM_GROUP 
	                            :   'CURRENT_DEFAULT_TRANSFORM_GROUP'                 
	                            |   'current_default_transform_group';
	CURRENT_PATH                :   'CURRENT_PATH'     | 'current_path';
	CURRENT_ROLE                :   'CURRENT_ROLE'     | 'current_role';
	CURRENT_TIMESTAMP           :   'CURRENT_TIMESTAMP'     
	                            |   'current_timestamp';
	CURRENT_TIME                :   'CURRENT_TIME'     | 'current_time';
	CURRENT_TRANSFORM_GROUP_FOR_TYPE    
	                            :   'CURRENT_TRANSFORM_GROUP_FOR_TYPE'                 
	                            |   'current_transform_group_for_type';
	CURRENT_USER                :   'CURRENT_USER'     | 'current_user';
	CURRENT                     :   'CURRENT'          | 'current';
	CURSOR                      :   'CURSOR'           | 'cursor';
	CYCLE                       :   'CYCLE'            | 'cycle';
	DATE                        :   'DATE'             | 'date';
	DAY                         :   'DAY'              | 'day';
	DEALLOCATE                  :   'DEALLOCATE'       | 'deallocate';
	DECIMAL                     :   'DECIMAL'          | 'decimal';
	DECLARE                     :   'DECLARE'          | 'declare';
	DEC                         :   'DEC'              | 'dec';
	DEFAULT                     :   'DEFAULT'          | 'default';
	DELETE                      :   'DELETE'           | 'delete';
	DEREF                       :   'DEREF'            | 'deref';
	DESCRIBE                    :   'DESCRIBE'         | 'describe';
	DETERMINISTIC               :   'DETERMINISTIC'    | 'deterministic';
	DISCONNECT                  :   'DISCONNECT'       | 'disconnect';
	DISTINCT                    :   'DISTINCT'         | 'distinct';
	DOUBLE                      :   'DOUBLE'           | 'double';
	DROP                        :   'DROP'             | 'drop';
	DYNAMIC                     :   'DYNAMIC'          | 'dynamic';
	EACH                        :   'EACH'             | 'each';
	ELEMENT                     :   'ELEMENT'          | 'element';
	ELSE                        :   'ELSE'             | 'else';
	END_EXEC                    :   'END-EXEC'         | 'end-exec';
	END                         :   'END'              | 'end';
	ESCAPE                      :   'ESCAPE'           | 'escape';
	EXCEPT                      :   'EXCEPT'           | 'except';
	EXECUTE                     :   'EXECUTE'          | 'execute';
	EXEC                        :   'EXEC'             | 'exec';
	EXISTS                      :   'EXISTS'           | 'exists';
	EXIT                        :   'EXIT'             | 'exit';
	EXTERNAL                    :   'EXTERNAL'         | 'external';
	FALSE                       :   'FALSE'            | 'false';
	FETCH                       :   'FETCH'            | 'fetch';
	FILTER                      :   'FILTER'           | 'filter';
	FOREIGN                     :   'FOREIGN'          | 'foreign';
	FOR                         :   'FOR'              | 'for';
	FREE                        :   'FREE'             | 'free';
	FROM                        :   'FROM'             | 'from';
	FULL                        :   'FULL'             | 'full';
	FUNCTION                    :   'FUNCTION'         | 'function';
	GENERATED                   :   'GENERATED'        | 'generated';
	GET                         :   'GET'              | 'get';
	GLOBAL                      :   'GLOBAL'           | 'global';
	GRANT                       :   'GRANT'            | 'grant';
	GROUPING                    :   'GROUPING'         | 'grouping';
	GROUP                       :   'GROUP'            | 'group';
	HANDLER                     :   'HANDLER'          | 'handler';
	HAVING                      :   'HAVING'           | 'having';
	HOLD                        :   'HOLD'             | 'hold';
	HOUR                        :   'HOUR'             | 'hour';
	IDENTITY                    :   'IDENTITY'         | 'identity';
	IMMEDIATE                   :   'IMMEDIATE'        | 'immediate';
	INDICATOR                   :   'INDICATOR'        | 'indicator';
	INNER                       :   'INNER'            | 'inner';
	INOUT                       :   'INOUT'            | 'inout';
	INPUT                       :   'INPUT'            | 'input';
	INSENSITIVE                 :   'INSENSITIVE'      | 'insensitive';
	INSERT                      :   'INSERT'           | 'insert';
	INTEGER                     :   'INTEGER'          | 'integer';
	INTERSECT                   :   'INTERSECT'        | 'intersect';
	INTERVAL                    :   'INTERVAL'         | 'interval';
	INTO                        :   'INTO'             | 'into';
	INT                         :   'INT'              | 'int';
	IN                          :   'IN'               | 'in';
	ISOLATION                   :   'ISOLATION'        | 'isolation';
	IS                          :   'IS'               | 'is';
	JOIN                        :   'JOIN'             | 'join';
	LANGUAGE                    :   'LANGUAGE'         | 'language';
	LARGE                       :   'LARGE'            | 'large';
	LATERAL                     :   'LATERAL'          | 'lateral';
	LEADING                     :   'LEADING'          | 'leading';
	LEFT                        :   'LEFT'             | 'left';
	LIKE                        :   'LIKE'             | 'like';
	LOCALTIMESTAMP              :   'LOCALTIMESTAMP'   | 'localtimestamp';
	LOCALTIME                   :   'LOCALTIME'        | 'localtime';
	LOCAL                       :   'LOCAL'            | 'local';
	MATCH                       :   'MATCH'            | 'match';
	MEMBER                      :   'MEMBER'           | 'member';
	MERGE                       :   'MERGE'            | 'merge';
	METHOD                      :   'METHOD'           | 'method';
	MINUTE                      :   'MINUTE'           | 'minute';
	MODIFIES                    :   'MODIFIES'         | 'modifies';
	MODULE                      :   'MODULE'           | 'module';
	MONTH                       :   'MONTH'            | 'month';
	MULTISET                    :   'MULTISET'         | 'multiset';
	NATIONAL                    :   'NATIONAL'         | 'national';
	NATURAL                     :   'NATURAL'          | 'natural';
	NCHAR_VARYING               :   'NCHAR_VARYING'    | 'nchar_varying';
	NCHAR                       :   'NCHAR'            | 'nchar';
	NCLOB                       :   'NCLOB'            | 'nclob';
	NEW                         :   'NEW'              | 'new';
	NONE                        :   'NONE'             | 'none';
	NOTFOUND                    :   'NOTFOUND'         | 'notfound';
	NOT                         :   'NOT'              | 'not';
	NO                          :   'NO'               | 'no';
	NULL                        :   'NULL'             | 'null';
	NUMERIC                     :   'NUMERIC'          | 'numeric';
	OF                          :   'OF'               | 'of';
	OLD                         :   'OLD'              | 'old';
	ONLY                        :   'ONLY'             | 'only';
	ON                          :   'ON'               | 'on';
	OPEN                        :   'OPEN'             | 'open';
	ORDER                       :   'ORDER'            | 'order';
	OR                          :   'OR'               | 'or';
	OUTER                       :   'OUTER'            | 'outer';
	OUTPUT                      :   'OUTPUT'           | 'output';
	OUT                         :   'OUT'              | 'out';
	OVERLAPS                    :   'OVERLAPS'         | 'overlaps';
	OVER                        :   'OVER'             | 'over';
	PARAMETER                   :   'PARAMETER'        | 'parameter';
	PARTITION                   :   'PARTITION'        | 'partition';
	PRECISION                   :   'PRECISION'        | 'precision';
	PREPARE                     :   'PREPARE'          | 'prepare';
	PRIMARY                     :   'PRIMARY'          | 'primary';
	PROCEDURE                   :   'PROCEDURE'        | 'proceedure';
	RANGE                       :   'RANGE'            | 'range';
	READS                       :   'READS'            | 'reads';
	REAL                        :   'REAL'             | 'real';
	RECURSIVE                   :   'RECURSIVE'        | 'recursive';
	REFERENCES                  :   'REFERENCES'       | 'references';
	REFERENCING                 :   'REFERENCING'      | 'referencing';
	REF                         :   'REF'              | 'ref';
	RELEASE                     :   'RELEASE'          | 'release';
	RETURNS                     :   'RETURNS'          | 'returns';
	RETURN                      :   'RETURN'           | 'return';
	REVOKE                      :   'REVOKE'           | 'revoke';
	RIGHT                       :   'RIGHT'            | 'right';
	ROLLBACK                    :   'ROLLBACK'         | 'rollback';
	ROLLUP                      :   'ROLLUP'           | 'rollup';
	ROWS                        :   'ROWS'             | 'rows';
	ROW                         :   'ROW'              | 'row';
	SAVEPOINT                   :   'SAVEPOINT'        | 'savepoint';
	SCOPE                       :   'SCOPE'            | 'scope';
	SCROLL                      :   'SCROLL'           | 'scroll';
	SEARCH                      :   'SEARCH'           | 'search';
	SECOND                      :   'SECOND'           | 'second';
	SELECT                      :   'SELECT'           | 'select';
	SENSITIVE                   :   'SENSITIVE'        | 'sensitive';
	SESSION_USER                :   'SESSION_USER'     | 'session_user';
	SET                         :   'SET'              | 'set';
	SIMILAR                     :   'SIMILAR'          | 'similar';
	SMALLINT                    :   'SMALLINT'         | 'smallint';
	SOME                        :   'SOME'             | 'some';
	SPECIFICTYPE                :   'SPECIFICTYPE'     | 'specifictype';
	SPECIFIC                    :   'SPECIFIC'         | 'specific';
	SQLEXCEPTION                :   'SQLEXCEPTION'     | 'sqleception';
	SQLSTATE                    :   'SQLSTATE'         | 'sqlstate';
	SQLWARNING                  :   'SQLWARNING'       | 'sqlwarning';
	SQL                         :   'SQL'              | 'sql';
	START                       :   'START'            | 'start';
	STATIC                      :   'STATIC'           | 'static';
	SUBMULTISET                 :   'SUBMULTISET'      | 'submultiset';
	SYMMETRIC                   :   'SYMMETRIC'        | 'symmetric';
	SYSTEM_USER                 :   'SYSTEM_USER'      | 'system_user';
	SYSTEM                      :   'SYSTEM'           | 'system';
	TABLE                       :   'TABLE'            | 'table';
	THEN                        :   'THEN'             | 'then';
	TIMESTAMP                   :   'TIMESTAMP'        | 'timestamp';
	TIMEZONE_HOUR               :   'TIMEZONE_HOUR'    | 'timezone_hour';
	TIMEZONE_MINUTE             :   'TIMEZONE_MINUTE'  | 'timezone_minute';
	TIME                        :   'TIME'             | 'time';
	TO                          :   'TO'               | 'to';
	TRAILING                    :   'TRAILING'         | 'trailing';
	TRANSLATION                 :   'TRANSLATION'      | 'translation';
	TREAT                       :   'TREAT'            | 'treat';
	TRIGGER                     :   'TRIGGER'          | 'trigger';
	TRUE                        :   'TRUE'             | 'true';
	UNDO                        :   'UNDO'             | 'undo';
	UNION                       :   'UNION'            | 'union';
	UNIQUE                      :   'UNIQUE'           | 'unique';
	UNKNOWN                     :   'UNKNOWN'          | 'unknown';
	UNNEST                      :   'UNNEST'           | 'unnest';
	UPDATE                      :   'UPDATE'           | 'update';
	USER                        :   'USER'             | 'user';
	USING                       :   'USING'            | 'using';
	VALUES                      :   'VALUES'           | 'values';
	VALUE                       :   'VALUE'            | 'value';
	VARCHAR                     :   'VARCHAR'          | 'varchar';
	VARYING                     :   'VARYING'          | 'varying';
	WHENEVER                    :   'WHENEVER'         | 'whenever';
	WHEN                        :   'WHEN'             | 'when';
	WHERE                       :   'WHERE'            | 'where';
	WINDOW                      :   'WINDOW'           | 'window';
	WITH                        :   'WITH'             | 'with';
	WITHIN                      :   'WITHIN'           | 'within';
	WITHOUT                     :   'WITHOUT'          | 'without';
	YEAR                        :   'YEAR'             | 'year';


//  Non-Reserved Keyword Tokens

	ABS                         :   'ABS'               | 'abs';
	ABSOLUTE                    :   'ABSOLUTE'          | 'absolute';
	ACTION                      :   'ACTION'            | 'action';
	ADA                         :   'ADA'               | 'ada';
	ADMIN                       :   'ADMIN'             | 'admin';
	AFTER                       :   'AFTER'             | 'after';
	ALWAYS                      :   'ALWAYS'            | 'always';
	ASC                         :   'ASC'               | 'asc';
	ASSERTION                   :   'ASSERTION'         | 'assertion';
	ASSIGNMENT                  :   'ASSIGNMENT'        | 'assignment';
	ATTRIBUTE                   :   'ATTRIBUTE'         | 'assignment';
	ATTRIBUTES                  :   'ATTRIBUTES'        | 'attributes';
	AUTO                        :   'AUTO'              | 'auto';
	AVG                         :   'AVG'               | 'avg';
	BEFORE                      :   'BEFORE'            | 'before';
	BERNOULLI                   :   'BERNOULLI'         | 'bernoulli';
	BIN                         :   'BIN'               | 'bin';
	BREADTH                     :   'BREADTH'           | 'breadth';
	CARDINALITY                 :   'CARDINALITY'       | 'cardinality';
	CASCADE                     :   'CASCADE'           | 'cascade';
	CATALOG_NAME                :   'CATALOG_NAME'      | 'identifier';
	CATALOG                     :   'CATALOG'           | 'catalog';
	CEILING                     :   'CEILING'           | 'cieling';
	CEIL                        :   'CEIL'              | 'ciel';
	CHAIN                       :   'CHAIN'             | 'chain';
	CHARACTERISTICS             :   'CHARACTERISTICS'   | 'characteristics';
	CHARACTERS                  :   'CHARACTERS'        | 'characters';
	CHARACTER_LENGTH            :   'CHARACTER_LENGTH'      | 'character_length';
	CHARACTER_SET_CATALOG       :   'CHARACTER_SET_CATALOG' | 'character_set_catalog';
	CHARACTER_SET_NAME          :   'CHARACTER_SET_NAME'    | 'fully_qualified_identifier';
	CHARACTER_SET_SCHEMA        :   'CHARACTER_SET_SCHEMA'  | 'character_set_schema';
	CHAR_LENGTH                 :   'CHAR_LENGTH'       | 'char_length';
	CHECKED                     :   'CHECKED'           | 'checked';
	CLASS_ORIGIN                :   'CLASS_ORIGIN'      | 'class_origin';
	COALESCE                    :   'COALESCE'          | 'coalesce';
	COBOL                       :   'COBOL'             | 'cobol';
	CODE_UNITS                  :   'CODE_UNITS'        | 'code_units';
	COLLATION_CATALOG           :   'COLLATION_CATALOG' | 'collation_catalog';
	COLLATION_NAME              :   'COLLATION_NAME'    | 'fully_qualified_identifier';
	COLLATION_SCHEMA            :   'COLLATION_SCHEMA'  | 'collation_schema';
	COLLATION                   :   'COLLATION'         | 'collaton';
	COLLECT                     :   'COLLECT'           | 'collect';
	COLUMN_NAME                 :   'COLUMN_NAME'       | 'identifier';
	COMMAND_FUNCTION_CODE       :   'COMMAND_FUNCTION_CODE' 
	                            |   'command_function_code';
	COMMAND_FUNCTION            :   'COMMAND_FUNCTION'  | 'command_function';
	COMMITTED                   :   'COMMITTED'         | 'committed';
	CONDITION_NUMBER            :   'CONDITION_NUMBER'  | 'condition_number';
	CONDITION                   :   'CONDITION'         | 'condition';
	CONNECTION_NAME             :   'CONNECTION_NAME'   | 'connection_name';
	CONSTRAINTS                 :   'CONSTRAINTS'       | 'constraints';
	CONSTRAINT_CATALOG          :   'CONSTRAINT_CATALOG'    
	                            |   'constraint_catalog';
	CONSTRAINT_NAME             :   'CONSTRAINT_NAME'   | 'fully_qualified_identifier';
	CONSTRAINT_SCHEMA           :   'CONSTRAINT_SCHEMA' | 'constraint_schema';
	CONSTRUCTORS                :   'CONSTRUCTORS'      | 'constructors';
	CONST                       :   'CONST'             | 'const';
	CONTAINS                    :   'CONTAINS'          | 'contains';
	CONVERT                     :   'CONVERT'           | 'convert';
	CORR                        :   'CORR'              | 'corr';
	COUNT                       :   'COUNT'             | 'count';
	COVAR_POP                   :   'COVAR_POP'         | 'covar_pop';
	COVAR_SAMP                  :   'COVAR_SAMP'        | 'covar_samp';
	CUME_DIST                   :   'CUME_DIST'         | 'cume_dist';
	CURRENT_COLLATION           :   'CURRENT_COLLATION' | 'current_collation';
	CURSOR_NAME                 :   'CURSOR_NAME'       | 'cursor_name';
	DATA                        :   'DATA'              | 'data';
	DATETIME_INTERVAL_CODE      :   'DATETIME_INTERVAL_CODE'    
	                            |   'datetime_interval_code';
	DATETIME_INTERVAL_PRECISION :   'DATETIME_INTERVAL_PRECISION' 
	                            |   'datetime_interval_precision';
	DAYS                        :   'DAYS'              | 'days';
	DCL                         :   'DCL'               | 'dcl';
	DEFAULTS                    :   'DEFAULTS'          | 'defaults';
	DEFERRABLE                  :   'DEFERRABLE'        | 'deferrable';
	DEFERRED                    :   'DEFERRED'          | 'deferred';
	DEFINED                     :   'DEFINED'           | 'defined';
	DEFINER                     :   'DEFINER'           | 'definer';
	DEGREE                      :   'DEGREE'            | 'degree';
	DENSE_RANK                  :   'DENSE_RANK'        | 'dense_rank';
	DEPTH                       :   'DEPTH'             | 'depth';
	DERIVED                     :   'DERIVED'           | 'derived';
	DESCRIPTOR                  :   'DESCRIPTOR'        | 'descriptor';
	DESC                        :   'DESC'              | 'desc';
	DIAGNOSTICS                 :   'DIAGNOSTICS'       | 'diagnostics';
	DISPATCH                    :   'DISPATCH'          | 'dispatch';
	DISPLAY                     :   'DISPLAY'           | 'display';
	DOMAIN                      :   'DOMAIN'            | 'domain';
	DOUBLE_PRECISION            :   'DOUBLE_PRECISION'  | 'double_precision';
	DYNAMIC_FUNCTION            :   'DYNAMIC_FUNCTION'  | 'dynamic_function';
	DYNAMIC_FUNCTION_CODE       :   'DYNAMIC_FUNCTION_CODE' 
	                            |   'dynamic_function_code';
	EQUALS                      :   'EQUALS'            | 'equals';
	EVERY                       :   'EVERY'             | 'every';
	EXCEPTION                   :   'EXCEPTION'         | 'exception';
	EXCLUDE                     :   'EXCLUDE'           | 'exclude';
	EXCLUDING                   :   'EXCLUDING'         | 'excluding';
	EXP                         :   'EXP'               | 'exp';
	EXTERN                      :   'EXTERN'            | 'extern';
	EXTRACT                     :   'EXTRACT'           | 'extract';
	FINAL                       :   'FINAL'             | 'final';
	FIRST                       :   'FIRST'             | 'first';
	FIXED                       :   'FIXED'             | 'fixed';
	FLOAT                       :   'FLOAT'             | 'float';
	FLOOR                       :   'FLOOR'             | 'floor';
	FOLLOWING                   :   'FOLLOWING'         | 'following';
	FORTRAN                     :   'FORTRAN'           | 'fortran';
	FOUND                       :   'FOUND'             | 'found';
	FUSION                      :   'FUSION'            | 'fusion';
	GENERAL                     :   'GENERAL'           | 'general';
	GOTO                        :   'GOTO'              | 'goto';
	GO                          :   'GO'                | 'go';
	GRANTED                     :   'GRANTED'           | 'granted';
	HIERARCHY                   :   'HIERARCHY'         | 'hierarchy';
	HOURS                       :   'HOURS'             | 'hours';
	IMPLEMENTATION              :   'IMPLEMENTATION'    | 'implementation';
	INCLUDING                   :   'INCLUDING'         | 'including';
	INCREMENT                   :   'INCREMENT'         | 'increment';
	INDICATOR_TYPE              :   'INDICATOR_TYPE'    | 'indicator_type';
	INITIALLY                   :   'INITIALLY'         | 'initially';
	INSTANCE                    :   'INSTANCE'          | 'instance';
	INSTANTIABLE                :   'INSTANTIABLE'      | 'instantiable';
	INTERFACES                  :   'INTERFACES'        | 'interfaces';
	INTERSECTION                :   'INTERSECTION'      | 'intersection';
	INVOKER                     :   'INVOKER'           | 'invoker';
	KEY_MEMBER                  :   'KEY_MEMBER'        | 'key_member';
	KEY_TYPE                    :   'KEY_TYPE'          | 'key_type';
	KEY                         :   'KEY'               | 'key';
	KIND                        :   'KIND'              | 'kind';
	LAST                        :   'LAST'              | 'last';
	LENGTH                      :   'LENGTH'            | 'length';
	LEN                         :   'LEN'               | 'len';
	LEVEL                       :   'LEVEL'             | 'level';
	LOGICAL                     :   'LOGICAL'           | 'logical';
	LONG                        :   'LONG'              | 'long';
	LN                          :   'LN'                | 'ln';
	LOCATOR                     :   'LOCATOR'           | 'locator';
	LOWER                       :   'LOWER'             | 'lower';
	MAP                         :   'MAP'               | 'map';
	MATCHED                     :   'MATCHED'           | 'matched';
	MAXVALUE                    :   'MAXVALUE'          | 'maxvalue';
	MAX                         :   'MAX'               | 'max';
	MESSAGE_LENGTH              :   'MESSAGE_LENGTH'    | 'message_length';
	MESSAGE_OCTET_LENGTH        :   'MESSAGE_OCTET_LENGTH'  
	                            |   'message_octet_length';
	MESSAGE_TEXT                :   'MESSAGE_TEXT'      | 'message_length';
	MINVALUE                    :   'MINVALUE'          | 'minvalue';
	MIN                         :   'MIN'               | 'min';
	MOD                         :   'MOD'               | 'mod';
	MORE                        :   'MORE'              | 'more';
	MUMPS                       :   'MUMPS'             | 'mumps';
	NAMES                       :   'NAMES'             | 'names';
	NAME                        :   'NAME'              | 'name';
	NESTING                     :   'NESTING'           | 'nesting';
	NEXT                        :   'NEXT'              | 'next';
	NORMALIZED                  :   'NORMALIZED'        | 'normalized';
	NORMALIZE                   :   'NORMALIZE'         | 'normalize';
	NULLABLE                    :   'NULLABLE'          | 'nullable';
	NULLIF                      :   'NULLIF'            | 'nullif';
	NULLS                       :   'NULLS'             | 'nulls';
	NUMBER                      :   'NUMBER'            | 'number';
	OBJECT                      :   'OBJECT'            | 'object';
	OCTETS                      :   'OCTETS'            | 'octets';
	OCTET_LENGTH                :   'OCTET_LENGTH'      | 'octet_length';
	OPTION                      :   'OPTION'            | 'option';
	OPTIONS                     :   'OPTIONS'           | 'options';
	ORDERING                    :   'ORDERING'          | 'ordering';
	ORDINALITY                  :   'ORDINALITY'        | 'ordinality';
	OTHERS                      :   'OTHERS'            | 'others';
	OVERLAY                     :   'OVERLAY'           | 'overlay';
	OVERRIDING                  :   'OVERRIDING'        | 'overriding';
	PACKED                      :   'PACKED'            | 'packed';
	PAD                         :   'PAD'               | 'pad';
	PARAMETER_MODE              :   'PARAMETER_MODE'    | 'parameter_mode';
	PARAMETER_NAME              :   'PARAMETER_NAME'    | 'parameter_name';
	PARAMETER_ORDINAL_POSITION  :   'PARAMETER_ORDINAL_POSITION'    
	                            |   'parameter_ordinal_position';
	PARAMETER_SPECIFIC_CATALOG  :   'PARAMETER_SPECIFIC_CATALOG'    
	                            |   'parameter_specific_catalog';
	PARAMETER_SPECIFIC_NAME     :   'PARAMETER_SPECIFIC_NAME'       
	                            |   'parameter_specific_name';
	PARAMETER_SPECIFIC_SCHEMA   :   'PARAMETER_SPECIFIC_SCHEMA'     
	                            |   'parameter_specific_schema';
	PARTIAL                     :   'PARTIAL'           | 'partial';
	PASCAL                      :   'PASCAL'            | 'pascal';
	PATH                        :   'PATH'              | 'path';
	PERCENTILE_CONT             :   'PERCENTILE_CONT'   | 'percentile_cont';
	PERCENTILE_DISC             :   'PERCENTILE_DISC'   | 'perventile_disc';
	PERCENT_RANK                :   'PERCENT_RANK'      | 'percent_rank';
	PICTURE                     :   'PICTURE'           | 'picture';
	PIC                         :   'PIC'               | 'pic';
	PLACING                     :   'PLACING'           | 'placing';
	PLI                         :   'PLI'               | 'pli';
	POSITION                    :   'POSITION'          | 'position';
	POWER                       :   'POWER'             | 'power';
	PRECEDING                   :   'PRECEDING'         | 'preceding';
	PRESERVE                    :   'PRESERVE'          | 'preserve';
	PRIOR                       :   'PRIOR'             | 'prior';
	PRIVILEGES                  :   'PRIVILEGES'        | 'privileges';
	PUBLIC                      :   'PUBLIC'            | 'public';
	RANK                        :   'RANK'              | 'rank';
	READ                        :   'READ'              | 'read';
	REGR_AVGX                   :   'REGR_AVGX'         | 'regr_avgx';
	REGR_AVGY                   :   'REGR_AVGY'         | 'regr_avgy';
	REGR_COUNT                  :   'REGR_COUNT'        | 'regr_count';
	REGR_INTERCEPT              :   'REGR_INTERCEPT'    | 'regr_intercept';
	REGR_R2                     :   'REGR_R2'           | 'regr_r2';
	REGR_SLOPE                  :   'REGR_SLOPE'        | 'regr_slope';
	REGR_SXX                    :   'REGR_SXX'          | 'regr_sxx';
	REGR_SXY                    :   'REGR_SXY'          | 'regr_sxy';
	REGR_SYY                    :   'REGR_SYY'          | 'regr_syy';
	RELATIVE                    :   'RELATIVE'          | 'relative';
	REPEATABLE                  :   'REPEATABLE'        | 'repeatable';
	RESTART                     :   'RESTART'           | 'restart';
	RESTRICT                    :   'RESTRICT'          | 'restrict';
	RESULT                      :   'RESULT'            | 'result';
	RETURNED_CARDINALITY        :   'RETURNED_CARDINALITY'  
	                            |   'returned_cardinality';
	RETURNED_LENGTH             :   'RETURNED_LENGTH'   | 'returned_length';
	RETURNED_OCTET_LENGTH       :   'RETURNED_OCTET_LENGTH' 
	                            |   'returned_octet_length';
	RETURNED_SQLSTATE           :   'RETURNED_SQLSTATE' | 'returned_sqlstate';
	ROLE                        :   'ROLE'              | 'role';
	ROUTINE_CATALOG             :   'ROUTINE_CATALOG'   | 'routine_catalog';
	ROUTINE_NAME                :   'ROUTINE_NAME'      | 'fully_qualified_identifier';
	ROUTINE_SCHEMA              :   'ROUTINE_SCHEMA'    | 'routine_schema';
	ROUTINE                     :   'ROUTINE'           | 'routine';
	ROW_COUNT                   :   'ROW_COUNT'         | 'row_count';
	ROW_NUMBER                  :   'ROW_NUMBER'        | 'row_number';
	SCALE                       :   'SCALE'             | 'scale';
	SCHEMA_NAME                 :   'SCHEMA_NAME'       | 'schema_name';
	SCHEMA                      :   'SCHEMA'            | 'schema';
	SCOPE_CATALOG               :   'SCOPE_CATALOG'     | 'scope_catalog';
	SCOPE_NAME                  :   'SCOPE_NAME'        | 'scope_name';
	SCOPE_SCHEMA                :   'SCOPE_SCHEMA'      | 'scope_schema';
	SECTION                     :   'SECTION'           | 'section';
	SECURITY                    :   'SECURITY'          | 'security';
	SELF                        :   'SELF'              | 'self';
	SEPARATE                    :   'SEPARATE'          | 'separate';
	SEQUENCE                    :   'SEQUENCE'          | 'sequence';
	SERIALIZABLE                :   'SERIALIZABLE'      | 'serializable';
	SERVER_NAME                 :   'SERVER_NAME'       | 'server_name';
	SESSION                     :   'SESSION'           | 'session';
	SETS                        :   'SETS'              | 'sets';
	SHORT                       :   'SHORT'             | 'short';
	SIGNED                      :   'SIGNED'            | 'signed';
	SIGN                        :   'SIGN'              | 'sign';
	SIMPLE                      :   'SIMPLE'            | 'simple';
	SIZE                        :   'SIZE'              | 'size';
	SOURCE                      :   'SOURCE'            | 'source';
	SPACE                       :   'SPACE'             | 'Space';
	SPECIFIC_NAME               :   'SPECIFIC_NAME'     | 'fully_qualified_identifier';
	SQLSTATE_TYPE               :   'SQLSTATE_TYPE'     | 'sqlstate_type';
	SQRT                        :   'SQRT'              | 'sqrt';
	STATEMENT                   :   'STATEMENT'         | 'statement';
	STATE                       :   'STATE'             | 'state';
	STDDEV_POP                  :   'STDDEV_POP'        | 'stddev_pop';
	STDDEV_SAMP                 :   'STDDEV_SAMP'       | 'stddev_samp';
	STRUCTURE                   :   'STRUCTURE'         | 'structure';
	STYLE                       :   'STYLE'             | 'style';
	SUBCLASS_ORIGIN             :   'SUBCLASS_ORIGIN'   | 'subclass_origin';
	SUBSTRING                   :   'SUBSTRING'         | 'substring';
	SUM                         :   'SUM'               | 'sum';
	TABLESAMPLE                 :   'TABLESAMPLE'       | 'tablesample';
	TABLE_NAME                  :   'TABLE_NAME'        | 'table_name';
	TEMPORARY                   :   'TEMPORARY'         | 'temporary';
	TIES                        :   'TIES'              | 'ties';
	TOP_LEVEL_COUNT             :   'TOP_LEVEL_COUNT'   | 'top_level_count';
	TRANSACTIONS_COMMITTED      :   'TRANSACTIONS_COMMITTED'    | 'transactions_committed';
	TRANSACTIONS_ROLLED_BACK    :   'TRANSACTIONS_ROLLED_BACK'  | 'transactions_rolled_back';
	TRANSACTION_ACTIVE          :   'TRANSACTION_ACTIVE'        | 'transaction_active';
	TRANSACTION                 :   'TRANSACTION'       | 'transactions';
	TRANSFORMS                  :   'TRANSFORMS'        | 'transforms';
	TRANSFORM                   :   'TRANSFORM'         | 'transform';
	TRANSLATE                   :   'TRANSLATE'         | 'translate';
	TRIGGER_CATALOG             :   'TRIGGER_CATALOG'   | 'trigger_catalog';
	TRIGGER_NAME                :   'TRIGGER_NAME'      | 'fully_qualified_identifier';
	TRIGGER_SCHEMA              :   'TRIGGER_SCHEMA'    | 'trigger_schema';
	TRIM                        :   'TRIM'              | 'trim';
	TYPE                        :   'TYPE'              | 'type';
	UNBOUNDED                   :   'UNBOUNDED'         | 'unbounded';
	UNCOMMITTED                 :   'UNCOMMITTED'       | 'uncommitted';
	UNDER                       :   'UNDER'             | 'under';
	UNNAMED                     :   'UNNAMED'           | 'unnamed';
	UNSIGNED                    :   'UNSIGNED'          | 'unsigned';
	UPPER                       :   'UPPER'             | 'upper';
	USAGE                       :   'USAGE'             | 'usage';
	USER_DEFINED_TYPE_CATALOG   :   'USER_DEFINED_TYPE_CATALOG' | 'user_defined_type_catalog';
	USER_DEFINED_TYPE_CODE      :   'USER_DEFINED_TYPE_CODE'    | 'user_defined_type_code';
	USER_DEFINED_TYPE_NAME      :   'USER_DEFINED_TYPE_NAME'    | 'fully_qualified_identifier';
	USER_DEFINED_TYPE_SCHEMA    :   'USER_DEFINED_TYPE_SCHEMA'  | 'user_defined_type_schema';
	VAR_POP                     :   'VAR_POP'           | 'var_pop';
	VAR_SAMP                    :   'VAR_SAMP'          | 'var_samp';
	VIEW                        :   'VIEW'              | 'view';
	VOLATILE                    :   'VOLATILE'          | 'volatile';
	WIDTH_BUCKET                :   'WIDTH_BUCKET'      | 'width_bucket';
	WORK                        :   'WORK'              | 'work';
	WRITE                       :   'WRITE'             | 'write';
	ZONE                        :   'ZONE'              | 'zone';

fragment
Unicode_Permitted_Identifier_Character  :
        Basic_Latin_Without_Quotes
    |   Latin1_Supplement
    |   Latin_ExtendedA
    |   Latin_ExtendedB
    |   IPA_Extensions
    |   Combining_Diacritical_Marks
    |   Greek_and_Coptic
    |   Cyrillic
    |   Cyrillic_Supplementary
    |   Armenian
    |   Hebrew
    |   Arabic
    |   Syriac
    |   Thaana
    |   Devanagari
    |   Bengali
    |   Gurmukhi
    |   Gujarati
    |   Oriya
    |   Tamil
    |   Telugu
    |   Kannada
    |   Malayalam
    |   Sinhala
    |   Thai
    |   Lao
    |   Tibetan
    |   Myanmar
    |   Georgian
    |   Hangul_Jamo
    |   Ethiopic
    |   Cherokee
    |   Unified_Canadian_Aboriginal
    |   Ogham
    |   Runic
    |   Tagalog
    |   Hanunoo
    |   Buhid
    |   Tagbanwa
    |   Khmer
    |   Mongolian
    |   Limbu
    |   Tai_Le
    |   Khmer_Symbols
    |   Phonetic_Extensions
    |   Latin_Extended_Additional
    |   Greek_Extended
    |   Superscripts_and_Subscripts
    |   Currency_Symbols
    |   Combining_Diacritical_Symbol_Marks
    |   Letterlike_Symbols
    |   Number_Forms
    |   Enclosed_Alphanumerics
    |   CJK_Radicals_Supplement
    |   Kangxi_Radicals
    |   Ideographic_Description_Characters
    |   CJK_Symbols_and_Punctuation
    |   Hiragana
    |   Katakana
    |   Bopomofo
    |   Hangul_Compatibility_Jamo
    |   Kanbun
    |   Bopomofo_Extended
    |   Katakana_Phonetic_Extensions
    |   Enclosed_CJK_Letters_and_Months
    |   CJK_Compatibility
    |   CJK_Unified_Ideographs_ExtensionA
    |   CJK_Unified_Ideographs
    |   Yi_Syllables
    |   Yi_Radicals
    |   Hangul_Syllables
    |   High_Surrogates
    |   High_Private_Use_Surrogates
    |   Low_Surrogates
    |   Private_Use_Area
    |   CJK_Compatibility_Ideographs
    |   Alphabetic_Presentation_Forms
    |   Arabic_Presentation_FormsA
    |   Variation_Selectors
    |   Combining_Half_Marks
    |   CJK_Compatibility_Forms
    |   Small_Form_Variants
    |   Arabic_Presentation_FormsB
    |   Halfwidth_and_Fullwidth_Forms
    ;

//  Generate an Unexpected Token Error if any forbidden characters are used in a Unicode Identifier
Unicode_Forbidden_Identifier_Characters  :  ( Unicode_Forbidden_Identifier_Character )+;

fragment
Unicode_Forbidden_Identifier_Character  :
        Control_Characters
    |   Spacing_Modifier_Letters
    |   General_Punctuation
    |   Arrows
    |   Mathematical_Operators
    |   Miscellaneous_Technical
    |   Control_Pictures
    |   Optical_Character_Recognition
    |   Box_Drawing
    |   Block_Elements
    |   Geometric_Shapes
    |   Miscellaneous_Symbols
    |   Dingbats
    |   Miscellaneous_Mathematical_SymbolsA
    |   Supplemental_ArrowsA
    |   Braille_Patterns
    |   Supplemental_ArrowsB
    |   Miscellaneous_Mathematical_SymbolsB
    |   Supplemental_Mathematical_Operators
    |   Miscellaneous_Symbols_and_Arrows
    |   Yijing_Hexagram_Symbols
    |   Specials
    ;


// Unicode Character Ranges
fragment
Unicode_Character_Without_Quotes    :   Basic_Latin_Without_Quotes
                                    |   '\u00A0' .. '\uFFFF';
fragment
Extended_Latin_Without_Quotes       :   '\u0001' .. '!' | '#' .. '&' | '(' .. '\u00FF';
fragment
Control_Characters                  :   '\u0001' .. '\u001F';
fragment
Basic_Latin                         :   '\u0020' .. '\u007F';
fragment
Basic_Latin_Without_Quotes          :   ' ' .. '!' | '#' .. '&' | '(' .. '~';
fragment
Regex_Non_Escaped_Unicode           :   ~( '|' | '*' | '+' | '-' | '?' | '\%' | '_' | '^' | ':' | '{' | '}' | '(' | ')' | '[' | '\\' ) ;
fragment
Regex_Escaped_Unicode               :   ' ' .. '[' | ']' .. '~' | '\u00A0' .. '\uFFFF';
fragment
Unicode_Allowed_Escape_Chracter		:	'!' | '#' .. '&' | '(' .. '/' | ':' .. '@' | '[' .. '`' | '{' .. '~' | '\u0080' .. '\u00BF';
fragment
Full_Unicode						:	'\u0001' .. '\uFFFF';
fragment
Extended_Control_Characters         :   '\u0080' .. '\u009F';
fragment
Latin1_Supplement                   :   '\u00A0' .. '\u00FF';
fragment
Latin_ExtendedA                     :   '\u0100' .. '\u017F';
fragment
Latin_ExtendedB                     :   '\u0180' .. '\u024F';
fragment
IPA_Extensions                      :   '\u0250' .. '\u02AF';
fragment
Spacing_Modifier_Letters            :   '\u02B0' .. '\u02FF';
fragment
Combining_Diacritical_Marks         :   '\u0300' .. '\u036F';
fragment
Greek_and_Coptic                    :   '\u0370' .. '\u03FF';
fragment
Cyrillic                            :   '\u0400' .. '\u04FF';
fragment
Cyrillic_Supplementary              :   '\u0500' .. '\u052F';
fragment
Armenian                            :   '\u0530' .. '\u058F';
fragment
Hebrew                              :   '\u0590' .. '\u05FF';
fragment
Arabic                              :   '\u0600' .. '\u06FF';
fragment
Syriac                              :   '\u0700' .. '\u074F';
fragment
Thaana                              :   '\u0780' .. '\u07BF';
fragment
Devanagari                          :   '\u0900' .. '\u097F';
fragment
Bengali                             :   '\u0980' .. '\u09FF';
fragment
Gurmukhi                            :   '\u0A00' .. '\u0A7F';
fragment
Gujarati                            :   '\u0A80' .. '\u0AFF';
fragment
Oriya                               :   '\u0B00' .. '\u0B7F';
fragment
Tamil                               :   '\u0B80' .. '\u0BFF';
fragment
Telugu                              :   '\u0C00' .. '\u0C7F';
fragment
Kannada                             :   '\u0C80' .. '\u0CFF';
fragment
Malayalam                           :   '\u0D00' .. '\u0D7F';
fragment
Sinhala                             :   '\u0D80' .. '\u0DFF';
fragment
Thai                                :   '\u0E00' .. '\u0E7F';
fragment
Lao                                 :   '\u0E80' .. '\u0EFF';
fragment
Tibetan                             :   '\u0F00' .. '\u0FFF';
fragment
Myanmar                             :   '\u1000' .. '\u109F';
fragment
Georgian                            :   '\u10A0' .. '\u10FF';
fragment
Hangul_Jamo                         :   '\u1100' .. '\u11FF';
fragment
Ethiopic                            :   '\u1200' .. '\u137F';
fragment
Cherokee                            :   '\u13A0' .. '\u13FF';
fragment
Unified_Canadian_Aboriginal         :   '\u1400' .. '\u167F';
fragment
Ogham                               :   '\u1680' .. '\u169F';
fragment
Runic                               :   '\u16A0' .. '\u16FF';
fragment
Tagalog                             :   '\u1700' .. '\u171F';
fragment
Hanunoo                             :   '\u1720' .. '\u173F';
fragment
Buhid                               :   '\u1740' .. '\u175F';
fragment
Tagbanwa                            :   '\u1760' .. '\u177F';
fragment
Khmer                               :   '\u1780' .. '\u17FF';
fragment
Mongolian                           :   '\u1800' .. '\u18AF';
fragment
Limbu                               :   '\u1900' .. '\u194F';
fragment
Tai_Le                              :   '\u1950' .. '\u197F';
fragment
Khmer_Symbols                       :   '\u19E0' .. '\u19FF';   
fragment
Phonetic_Extensions                 :   '\u1D00' .. '\u1D7F';   
fragment
Latin_Extended_Additional           :   '\u1E00' .. '\u1EFF';   
fragment
Greek_Extended                      :   '\u1F00' .. '\u1FFF';   
fragment
General_Punctuation                 :   '\u2000' .. '\u206F';   
fragment
Superscripts_and_Subscripts         :   '\u2070' .. '\u209F';   
fragment
Currency_Symbols                    :   '\u20A0' .. '\u20CF';   
fragment
Combining_Diacritical_Symbol_Marks  :   '\u20D0' .. '\u20FF';   
fragment
Letterlike_Symbols                  :   '\u2100' .. '\u214F';   
fragment
Number_Forms                        :   '\u2150' .. '\u218F';   
fragment
Arrows                              :   '\u2190' .. '\u21FF';   
fragment
Mathematical_Operators              :   '\u2200' .. '\u22FF';   
fragment
Miscellaneous_Technical             :   '\u2300' .. '\u23FF';   
fragment
Control_Pictures                    :   '\u2400' .. '\u243F';   
fragment
Optical_Character_Recognition       :   '\u2440' .. '\u245F';   
fragment
Enclosed_Alphanumerics              :   '\u2460' .. '\u24FF';   
fragment
Box_Drawing                         :   '\u2500' .. '\u257F';   
fragment
Block_Elements                      :   '\u2580' .. '\u259F';   
fragment
Geometric_Shapes                    :   '\u25A0' .. '\u25FF';   
fragment
Miscellaneous_Symbols               :   '\u2600' .. '\u26FF';   
fragment
Dingbats                            :   '\u2700' .. '\u27BF';   
fragment
Miscellaneous_Mathematical_SymbolsA  :    '\u27C0' .. '\u27EF';   
fragment
Supplemental_ArrowsA                :   '\u27F0' .. '\u27FF';   
fragment
Braille_Patterns                    :   '\u2800' .. '\u28FF';   
fragment
Supplemental_ArrowsB                :   '\u2900' .. '\u297F';   
fragment
Miscellaneous_Mathematical_SymbolsB  :    '\u2980' .. '\u29FF';   
fragment
Supplemental_Mathematical_Operators  :    '\u2A00' .. '\u2AFF';   
fragment
Miscellaneous_Symbols_and_Arrows    :   '\u2B00' .. '\u2BFF';   
fragment
CJK_Radicals_Supplement             :   '\u2E80' .. '\u2EFF';   
fragment
Kangxi_Radicals                     :   '\u2F00' .. '\u2FDF';   
fragment
Ideographic_Description_Characters  :   '\u2FF0' .. '\u2FFF';   
fragment
CJK_Symbols_and_Punctuation         :   '\u3000' .. '\u303F';   
fragment
Hiragana                            :   '\u3040' .. '\u309F';   
fragment
Katakana                            :   '\u30A0' .. '\u30FF';   
fragment
Bopomofo                            :   '\u3100' .. '\u312F';   
fragment
Hangul_Compatibility_Jamo           :   '\u3130' .. '\u318F';   
fragment
Kanbun                              :   '\u3190' .. '\u319F';   
fragment
Bopomofo_Extended                   :   '\u31A0' .. '\u31BF';   
fragment
Katakana_Phonetic_Extensions        :   '\u31F0' .. '\u31FF';   
fragment
Enclosed_CJK_Letters_and_Months     :   '\u3200' .. '\u32FF';   
fragment
CJK_Compatibility                   :   '\u3300' .. '\u33FF';   
fragment
CJK_Unified_Ideographs_ExtensionA   :   '\u3400' .. '\u4DBF';   
fragment
CJK_Unified_Ideographs              :   '\u4E00' .. '\u9FFF';   
fragment
Yijing_Hexagram_Symbols             :   '\u4DC0' .. '\u4DFF';   
fragment
Yi_Syllables                        :   '\uA000' .. '\uA48F';   
fragment
Yi_Radicals                         :   '\uA490' .. '\uA4CF';   
fragment
Hangul_Syllables                    :   '\uAC00' .. '\uD7AF';   
fragment
High_Surrogates                     :   '\uD800' .. '\uDB7F';   
fragment
High_Private_Use_Surrogates         :   '\uDB80' .. '\uDBFF';   
fragment
Low_Surrogates                      :   '\uDC00' .. '\uDFFF';   
fragment
Private_Use_Area                    :   '\uE000' .. '\uF8FF';   
fragment
CJK_Compatibility_Ideographs        :   '\uF900' .. '\uFAFF';   
fragment
Alphabetic_Presentation_Forms       :   '\uFB00' .. '\uFB4F';   
fragment
Arabic_Presentation_FormsA          :   '\uFB50' .. '\uFDFF';   
fragment
Variation_Selectors                 :   '\uFE00' .. '\uFE0F';   
fragment
Combining_Half_Marks                :   '\uFE20' .. '\uFE2F';   
fragment
CJK_Compatibility_Forms             :   '\uFE30' .. '\uFE4F';   
fragment
Small_Form_Variants                 :   '\uFE50' .. '\uFE6F';   
fragment
Arabic_Presentation_FormsB          :   '\uFE70' .. '\uFEFF';   
fragment
Halfwidth_and_Fullwidth_Forms       :   '\uFF00' .. '\uFFEF';   
fragment
Specials                            :   '\uFFF0' .. '\uFFFF';   



/*
		 5.4 Names and identifiers (p151)
*/
// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// ============    ====================    ============================    ==============  ==========
// Sybase ASA      Latin,'_','@','#','$'   Latin,Digit,'_','@','#','$'     no              128
// Sybase ASE      Latin,'_','@','#'       Latin,Digit,'_','@','#','$'     no              255
// SQL Server      Latin,'_','@','#'       Latin,Digit,'_','@','#','$'     no              128
// Teradata        Latin,'_','#','$'       Latin,Digit,'_','#','$'         no              30
// MySQL           Latin,Digit             Latin,Digit,'_','$'             yes             64
// Informix        Latin,'_'               Latin,Digit,'_','$'             no              128
// PostgreSQL      Latin,'_'               Latin,Digit,'_','$'             no              63
// Oracle          Latin                   Latin,Digit,'_','#','$'         no              30
// Interbase       Latin                   Latin,Digit,'_','$'             no              67
// ANSI SQL92      Latin                   Latin,Digit,'_'                 yes             128
// IBM DB2         same as ANSI SQL92                                      no              128
// HP Neoview      same as ANSI SQL92                                      no              128

Regular_Identifier  :  SQL92_Identifier 
//                    |   SybaseASA_Identifier
//                    |   SqlServer_Identifier
//                    |   Teradata_Identifier
//                    |   MySQL_Identifier
//                    |   Informix_PostgreSQL_Identifier 
//                    |   Oracle_Identifier
//                    |   Interbase_Identifier
//                    |   SQL92_Identifier 
                    ;

// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// Sybase ASA      Latin,'_','@','#','$'   Latin,Digit,'_','@','#','$'     no              128
fragment
SybaseASA_Identifier  :  
    {isSybaseASA()}?
    SybaseASA_Identifier_Start ( SybaseASA_Identifier_Part )*;
fragment
SybaseASA_Identifier_Start  :  Simple_Latin_Letter | AT_Sign | Hash_Sign | Dollar_Sign; // | Underscore;
fragment
SybaseASA_Identifier_Part  :  Simple_Latin_Letter |
                            Digit | Underscore | AT_Sign | Hash_Sign | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// SQL Server      Latin,'_','@','#'       Latin,Digit,'_','@','#','$'     no              128
fragment
SqlServer_Identifier  :  
    {isSQLServerOrSybaseASE()}?
    SqlServer_Identifier_Start ( SqlServer_Identifier_Part )*;
fragment
SqlServer_Identifier_Start  :  Simple_Latin_Letter | AT_Sign | Hash_Sign; // | Underscore;
fragment
SqlServer_Identifier_Part  :  Simple_Latin_Letter |
                            Digit | Underscore | AT_Sign | Hash_Sign | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// Teradata        Latin,'_','#','$'       Latin,Digit,'_','#','$'         no              30
fragment
Teradata_Identifier  :  
    {isTeradata()}?
    Teradata_Identifier_Start ( Teradata_Identifier_Part )*;
fragment
Teradata_Identifier_Start  :  Simple_Latin_Letter | Hash_Sign | Dollar_Sign; // | Underscore;
fragment
Teradata_Identifier_Part   :  Simple_Latin_Letter | Digit | Underscore | Hash_Sign | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// MySQL           Latin,Digit             Latin,Digit,'_','$'             yes             64
fragment
MySQL_Identifier  :  
    {isMySQL()}?
    MySQL_Identifier_Start ( MySQL_Identifier_Part )*;
fragment
MySQL_Identifier_Start  :  Simple_Latin_Letter; // | Digit;
fragment
MySQL_Identifier_Part  :  Simple_Latin_Letter | Digit | Underscore | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// Informix        Latin,'_'               Latin,Digit,'_','$'             no              128
fragment
Informix_PostgreSQL_Identifier  :  
    {isInformixOrPostgreSQL()}?
    Informix_Identifier_Start ( Informix_Identifier_Part )*;
fragment
Informix_Identifier_Start  :  Simple_Latin_Letter; // | Underscore;
fragment
Informix_Identifier_Part  :  Simple_Latin_Letter | Digit | Underscore | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// Oracle          Latin                   Latin,Digit,'_','#','$'         no              30
fragment
Oracle_Identifier  :  
    {isOracle()}?
    Oracle_Identifier_Start ( Oracle_Identifier_Part )*;
fragment
Oracle_Identifier_Start  :  Simple_Latin_Letter;
fragment
Oracle_Identifier_Part  :  Simple_Latin_Letter | Digit | Underscore | Hash_Sign | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// Interbase       Latin                   Latin,Digit,'_','$'             no              67
fragment
Interbase_Identifier  :  
    {isInterbase()}?
    Interbase_Identifier_Start ( Interbase_Identifier_Part )*;
fragment
Interbase_Identifier_Start  :  Simple_Latin_Letter;
fragment
Interbase_Identifier_Part  :  Simple_Latin_Letter | Digit | Underscore | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// ANSI SQL92      Latin                   Latin,Digit,'_'                 yes             128
fragment
SQL92_Identifier  :  SQL92_Identifier_Start ( SQL92_Identifier_Part )*;
fragment
SQL92_Identifier_Start  :  Simple_Latin_Letter;
fragment
SQL92_Identifier_Part  :  Simple_Latin_Letter | Digit | Underscore;


/*
The productions for <Unicode delimited identifier> and so on are new in SQL-2003.
*/


Unicode_Identifier  :
		'U' Ampersand Double_Quote  ( Unicode_Identifier_Part )+ Double_Quote
		( ESCAPE Escape_Character )?
		;

fragment
Unicode_Identifier_Part          :  Unicode_Escape_Value | Unicode_Permitted_Identifier_Character;

fragment
Unicode_Escape_Value             :  Unicode_4_Digit_Escape_Value  | Unicode_6_Digit_Escape_Value ;

fragment
Unicode_4_Digit_Escape_Value     :  Escape_Character  Hexit  Hexit  Hexit  Hexit ;

fragment
Unicode_6_Digit_Escape_Value     :  Escape_Character  Plus_Sign Hexit  Hexit  Hexit  Hexit  Hexit  Hexit ;

Escape_Character                 :  Unicode_Allowed_Escape_Chracter /*!! See the Syntax Rules*/; 


/*
		 5.3 <literal> (p143)
*/


fragment
HexPair     :   Hexit Hexit;

fragment
HexQuad     :   Hexit Hexit Hexit Hexit;

fragment
Unsigned_Integer	:
	(	'0'
			(	( 'x' | 'X' ) 
				HexPair ( HexPair ( HexQuad (HexQuad HexQuad)? )? )? 
			|	OctalDigit ( OctalDigit )* 
			|	{true}? 
				( '0' )*
			)  
	|	( '1'..'9' ) ( Digit )* 
	);

fragment
Signed_Integer	:
	( Plus_Sign | Minus_Sign ) ( Digit )+ 			
	;

Number	:
	(	'0'
			(	( 'x' | 'X' ) 
				HexPair ( HexPair ( HexQuad (HexQuad HexQuad)? )? )? 
				{	
					_type  =  Unsigned_Integer;
				}
			|	OctalDigit ( OctalDigit )* 
				{
					_type  =  Unsigned_Integer;
				}
			|	Period 
				( Digit )+ ( ( 'f' | 'F' | 'd' | 'D' | 'e' | 'E' ) ( Plus_Sign | Minus_Sign )? Digit ( Digit ( Digit )? )? )?
				{
					_type  =  Unsigned_Float;
				}
			|	{true}? 
				( '0' )*
				(	('K' | 'M' |'G')
					{
						_type  =  Unsigned_Large_Integer;
					}
				|	{true}?
					{
						_type  =  Unsigned_Integer;
					}
				)
			)  
	|	( Plus_Sign | Minus_Sign ) ( Digit )+ 
			(	Period ( Digit )+ ( ( 'f' | 'F' | 'd' | 'D' | 'e' | 'E' ) ( Plus_Sign | Minus_Sign )? Digit ( Digit ( Digit )? )? )?
				{
					_type  =  Signed_Float;
				}
			|	{true}? 
				(	('K' | 'M' |'G')
					{
						_type  =  Signed_Large_Integer;
					}
				|	{true}?
					{
						_type  =  Signed_Integer;
					}
				)
			)
	|	( '1'..'9' ) ( Digit )* 
			(	Period ( Digit )+ ( ( 'f' | 'F' | 'd' | 'D' | 'e' | 'E' ) ( Plus_Sign | Minus_Sign )? Digit ( Digit ( Digit )? )? )?
				{
					_type  =  Unsigned_Float;
				}
			|	{true}? 
				(	('K' | 'M' |'G')
					{
						_type  =  Unsigned_Large_Integer;
					}
				|	{true}?
					{
						_type  =  Unsigned_Integer;
					}
				)
			)
	|	Period
			( Digit )+ ( ( 'f' | 'F' | 'd' | 'D' | 'e' | 'E' ) ( Plus_Sign | Minus_Sign )? Digit ( Digit ( Digit )? )? )?
				{
					_type  =  Unsigned_Float;
				}
	);


fragment
Character_Set_Name  : ( ( ( Regular_Identifier )  Period )? 
                          ( Regular_Identifier )  Period )? 
                            Regular_Identifier ;

fragment
Character_String_Literal :
		( Underscore  Character_Set_Name  )?
		  Quote ( Extended_Latin_Without_Quotes  )* Quote ( Quote ( Extended_Latin_Without_Quotes  )* Quote )*
		;
		
fragment
National_Character_String_Literal :
		'N' Quote ( Extended_Latin_Without_Quotes  )* Quote ( Quote ( Extended_Latin_Without_Quotes  )* Quote )*
		;

fragment
Unicode_Character_String_Literal  :
		( Underscore  Character_Set_Name  )?
		'U' Ampersand Quote ( Unicode_Character_Without_Quotes  )* Quote ( Quote ( Unicode_Character_Without_Quotes  )* Quote )*
		;

fragment
Bit :   ('0' | '1');

fragment
Bit_String_Literal  :
		'B' Quote ( Bit Bit Bit Bit  Bit Bit Bit Bit  )* Quote ( Quote ( Bit Bit Bit Bit  Bit Bit Bit Bit  )* Quote )*
		;

fragment
Hex_String_Literal  :
		'X' Quote ( Hexit  Hexit  )* Quote ( Quote ( Hexit  Hexit  )* Quote )*
		;

String_Literal	:
	(	Underscore  Character_Set_Name
		(
			'U' Ampersand Quote ( Unicode_Character_Without_Quotes  )* Quote ( Quote ( Unicode_Character_Without_Quotes  )* Quote )*
				{
					_type  =  Unicode_Character_String_Literal;
				}
		|	Quote ( Extended_Latin_Without_Quotes  )* Quote ( Quote ( Extended_Latin_Without_Quotes  )* Quote )*
				{
					_type  =  Character_String_Literal;
				}
		)
	|	'B' Quote ( Bit Bit Bit Bit  Bit Bit Bit Bit  )* Quote ( Quote ( Bit Bit Bit Bit  Bit Bit Bit Bit  )* Quote )*
			{
				_type  =  Bit_String_Literal;
			}	
	|	'X' Quote ( Hexit  Hexit  )* Quote ( Quote ( Hexit  Hexit  )* Quote )*
			{
				_type  =  Hex_String_Literal;
			}	
	|	'N' Quote ( Extended_Latin_Without_Quotes  )* Quote ( Quote ( Extended_Latin_Without_Quotes  )* Quote )*
			{
				_type  =  National_Character_String_Literal;
			}
	|	'U' Ampersand Quote ( Unicode_Character_Without_Quotes  )* Quote ( Quote ( Unicode_Character_Without_Quotes  )* Quote )*
			{
				_type  =  Unicode_Character_String_Literal;
			}
	|	Quote ( Extended_Latin_Without_Quotes  )* Quote ( Quote ( Extended_Latin_Without_Quotes  )* Quote )*
			{
				_type  =  Character_String_Literal;
			}
	);


// W h i t e s p a c e   T o k e n s

// ignore all control characters and non-Ascii characters that are not enclosed in quotes

Space    :  ' '
{
//	$channel=HIDDEN;
	SKIP();
};

White_Space  :	( Control_Characters  | Extended_Control_Characters )+ 
{
//	$channel=HIDDEN;
	SKIP();
};


BAD : . { error(UNKNOWN_CHARACTER, $text); skip(); } ;

