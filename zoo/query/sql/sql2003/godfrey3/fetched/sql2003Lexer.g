lexer grammar sql2003Lexer;

options
{
    language=Java;
}

/* 
=====================================================================================

BNF Grammar for ISO/IEC 9075-2:2003 - Database Language SQL (SQL-2003) SQL/Foundation

4/27/2011 - Lexer updated:
			1) Support case insensitive keyword tokens.
			2) Improve parsing of Numeric tokens
			3) Improve parsing of string constant tokens			

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

fragment A
	:	'A' | 'a';

fragment B 
	:	'B' | 'b';

fragment C 
	:	'C' | 'c';
	
fragment D 
	:	'D' | 'd';
	
fragment E
	:	'E' | 'e';

fragment F
	:	'F' | 'f';

fragment G
	:	'G' | 'g';

fragment H
	:	'H' | 'h';
	
fragment I
	:	'I' | 'i';
	
fragment J
	:	'J' | 'j';
	
fragment K
	:	'K' | 'k';
	
fragment L
	:	'L' | 'l';
	
fragment M 
	:	'M' | 'm';
	
fragment N
	:	'N' | 'n';
	
fragment O
	:	'O' | 'o';
	
fragment P
	:	'P' | 'p';
	
fragment Q
	:	'Q' | 'q';
	
fragment R
	:	'R' | 'r';
	
fragment S
	:	'S' | 's';
	
fragment T
	:	'T' | 't';
	
fragment U
	:	'U' | 'u';
	
fragment V
	:	'V' | 'v';
	
fragment W
	:	'W' | 'w';
	
fragment X
	:	'X' | 'x';
	
fragment Y
	:	'Y' | 'y';
	
fragment Z
	:	'Z' | 'z';

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
Hexit   :  Digit | A | B | C | D | E | F;

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

//  Keyword Tokens

//  Reserved Keyword Tokens

	ADD                         :   A D D;
	ALLOCATE                    :   A L L O C A T E;
	ALL                         :   A L L;
	ALTER                       :   A L T E R;
	AND                         :   A N D;
	ANY                         :   A N Y;
	ARE                         :   A R E;
	ARRAY                       :   A R R A Y;
	ASENSITIVE                  :   A S E N S I T I V E;
	ASYMMETRIC                  :   A S Y M M E T R I C;
	AS                          :   A S;
	ATOMIC                      :   A T O M I C;
	AT                          :   A T;
	AUTHORIZATION               :   A U T H O R I Z A T I O N;
	BEGIN                       :   B E G I N;
	BETWEEN                     :   B E T W E E N;
	BIGINT                      :   B I G I N T;
	BINARY                      :   B I N A R Y;
	BLOB                        :   B L O B;
	BOOLEAN                     :   B O O L E A N;
	BOTH                        :   B O T H;
	BY                          :   B Y;
	CALLED                      :   C A L L E D;
	CALL                        :   C A L L;
	CASCADED                    :   C A S C A D E D;
	CASE                        :   C A S E;
	CAST                        :   C A S T;
	CHARACTER                   :   C H A R A C T E R;
	CHAR                        :   C H A R;
	CHECK                       :   C H E C K;
	CLOB                        :   C L O B;
	CLOSE                       :   C L O S E;
	COLLATE                     :   C O L L A T E;
	COLUMN                      :   C O L U M N;
	COMMIT                      :   C O M M I T;
	CONNECTION                  :   C O N N E C T I O N;
	CONNECT                     :   C O N N E C T;
	CONSTRAINT                  :   C O N S T R A I N T;
	CONSTRUCTOR                 :   C O N S T R U C T O R;
	CONTINUE                    :   C O N T I N U E;
	CORRESPONDING               :   C O R R E S P O N D I N G;
	CREATE                      :   C R E A T E;
	CROSS                       :   C R O S S;
	CUBE                        :   C U B E;
	CURRENT_DATE                :   C U R R E N T Underscore D A T E;
	CURRENT_DEFAULT_TRANSFORM_GROUP 
	                            :   C U R R E N T Underscore D E F A U L T Underscore 
	                            	T R A N S F O R M Underscore G R O U P;                 
	CURRENT_PATH                :   C U R R E N T Underscore P A T H;
	CURRENT_ROLE                :   C U R R E N T Underscore R O L E ;
	CURRENT_TIMESTAMP           :   C U R R E N T Underscore T I M E S T A M P;     
	CURRENT_TIME                :   C U R R E N T Underscore T I M E;
	CURRENT_TRANSFORM_GROUP_FOR_TYPE    
	                            :   C U R R E N T Underscore T R A N S F O R M Underscore 
	                            	G R O U P Underscore F O R Underscore T Y P E;                 
	CURRENT_USER                :   C U R R E N T Underscore U S E R;
	CURRENT                     :   C U R R E N T;
	CURSOR                      :   C U R S O R;
	CYCLE                       :   C Y C L E;
	DATE                        :   D A T E;
	DAY                         :   D A Y;
	DEALLOCATE                  :   D E A L L O C A T E;
	DECIMAL                     :   D E C I M A L;
	DECLARE                     :   D E C L A R E;
	DEC                         :   D E C;
	DEFAULT                     :   D E F A U L T;
	DELETE                      :   D E L E T E;
	DEREF                       :   D E R E F;
	DESCRIBE                    :   D E S C R I B E;
	DETERMINISTIC               :   D E T E R M I N I S T I C;
	DISCONNECT                  :   D I S C O N N E C T;
	DISTINCT                    :   D I S T I N C T;
	DOUBLE                      :   D O U B L E;
	DROP                        :   D R O P;
	DYNAMIC                     :   D Y N A M I C;
	EACH                        :   E A C H;
	ELEMENT                     :   E L E M E N T;
	ELSE                        :   E L S E;
	END_EXEC                    :   E N D Hyphen E X E C;
	END                         :   E N D;
	ESCAPE                      :   E S C A P E;
	EXCEPT                      :   E X C E P T;
	EXECUTE                     :   E X E C U T E;
	EXEC                        :   E X E C;
	EXISTS                      :   E X I S T S;
	EXIT                        :   E X I T;
	EXTERNAL                    :   E X T E R N A L;
	FALSE                       :   F A L S E;
	FETCH                       :   F E T C H;
	FILTER                      :   F I L T E R;
	FOREIGN                     :   F O R E I G N;
	FOR                         :   F O R;
	FREE                        :   F R E E;
	FROM                        :   F R O M;
	FULL                        :   F U L L;
	FUNCTION                    :   F U N C T I O N;
	GENERATED                   :   G E N E R A T E D;
	GET                         :   G E T;
	GLOBAL                      :   G L O B A L;
	GRANT                       :   G R A N T;
	GROUPING                    :   G R O U P I N G;
	GROUP                       :   G R O U P;
	HANDLER                     :   H A N D L E R;
	HAVING                      :   H A V I N G;
	HOLD                        :   H O L D;
	HOUR                        :   H O U R;
	IDENTITY                    :   I D E N T I T Y;
	IMMEDIATE                   :   I M M E D I A T E;
	INDICATOR                   :   I N D I C A T O R;
	INNER                       :   I N N E R;
	INOUT                       :   I N O U T;
	INPUT                       :   I N P U T;
	INSENSITIVE                 :   I N S E N S I T I V E;
	INSERT                      :   I N S E R T;
	INTEGER                     :   I N T E G E R;
	INTERSECT                   :   I N T E R S E C T;
	INTERVAL                    :   I N T E R V A L;
	INTO                        :   I N T O;
	INT                         :   I N T;
	IN                          :   I N;
	ISOLATION                   :   I S O L A T I O N;
	IS                          :   I S;
	JOIN                        :   J O I N;
	LANGUAGE                    :   L A N G U A G E;
	LARGE                       :   L A R G E;
	LATERAL                     :   L A T E R A L;
	LEADING                     :   L E A D I N G;
	LEFT                        :   L E F T;
	LIKE                        :   L I K E;
	LOCALTIMESTAMP              :   L O C A L T I M E S T A M P;
	LOCALTIME                   :   L O C A L T I M E;
	LOCAL                       :   L O C A L;
	MATCH                       :   M A T C H;
	MEMBER                      :   M E M B E R;
	MERGE                       :   M E R G E;
	METHOD                      :   M E T H O D;
	MINUTE                      :   M I N U T E;
	MODIFIES                    :   M O D I F I E S;
	MODULE                      :   M O D U L E;
	MONTH                       :   M O N T H;
	MULTISET                    :   M U L T I S E T;
	NATIONAL                    :   N A T I O N A L;
	NATURAL                     :   N A T U R A L;
	NCHAR_VARYING               :   N C H A R Underscore V A R Y I N G;
	NCHAR                       :   N C H A R;
	NCLOB                       :   N C L O B;
	NEW                         :   N E W;
	NONE                        :   N O N E;
	NOTFOUND                    :   N O T F O U N D;
	NOT                         :   N O T;
	NO                          :   N O;
	NULL                        :   N U L L;
	NUMERIC                     :   N U M E R I C;
	OF                          :   O F;
	OLD                         :   O L D;
	ONLY                        :   O N L Y;
	ON                          :   O N;
	OPEN                        :   O P E N;
	ORDER                       :   O R D E R;
	OR                          :   O R;
	OUTER                       :   O U T E R;
	OUTPUT                      :   O U T P U T;
	OUT                         :   O U T;
	OVERLAPS                    :   O V E R L A P S;
	OVER                        :   O V E R;
	PARAMETER                   :   P A R A M E T E R;
	PARTITION                   :   P A R T I T I O N;
	PRECISION                   :   P R E C I S I O N;
	PREPARE                     :   P R E P A R E;
	PRIMARY                     :   P R I M A R Y;
	PROCEDURE                   :   P R O C E D U R E;
	RANGE                       :   R A N G E;
	READS                       :   R E A D S;
	REAL                        :   R E A L;
	RECURSIVE                   :   R E C U R S I V E;
	REFERENCES                  :   R E F E R E N C E S;
	REFERENCING                 :   R E F E R E N C I N G;
	REF                         :   R E F;
	RELEASE                     :   R E L E A S E;
	RETURNS                     :   R E T U R N S;
	RETURN                      :   R E T U R N;
	REVOKE                      :   R E V O K E;
	RIGHT                       :   R I G H T;
	ROLLBACK                    :   R O L L B A C K;
	ROLLUP                      :   R O L L U P;
	ROWS                        :   R O W S;
	ROW                         :   R O W;
	SAVEPOINT                   :   S A V E P O I N T;
	SCOPE                       :   S C O P E;
	SCROLL                      :   S C R O L L;
	SEARCH                      :   S E A R C H;
	SECOND                      :   S E C O N D;
	SELECT                      :   S E L E C T;
	SENSITIVE                   :   S E N S I T I V E;
	SESSION_USER                :   S E S S I O N Underscore U S E R;
	SET                         :   S E T;
	SIMILAR                     :   S I M I L A R;
	SMALLINT                    :   S M A L L I N T;
	SOME                        :   S O M E;
	SPECIFICTYPE                :   S P E C I F I C T Y P E;
	SPECIFIC                    :   S P E C I F I C;
	SQLEXCEPTION                :   S Q L E X C E P T I O N;
	SQLSTATE                    :   S Q L S T A T E;
	SQLWARNING                  :   S Q L W A R N I N G;
	SQL                         :   S Q L;
	START                       :   S T A R T;
	STATIC                      :   S T A T I C;
	SUBMULTISET                 :   S U B M U L T I S E T;
	SYMMETRIC                   :   S Y M M E T R I C;
	SYSTEM_USER                 :   S Y S T E M Underscore U S E R;
	SYSTEM                      :   S Y S T E M;
	TABLE                       :   T A B L E;
	THEN                        :   T H E N;
	TIMESTAMP                   :   T I M E S T A M P;
	TIMEZONE_HOUR               :   T I M E Z O N E Underscore H O U R;
	TIMEZONE_MINUTE             :   T I M E Z O N E Underscore M I N U T E;
	TIME                        :   T I M E;
	TO                          :   T O;
	TRAILING                    :   T R A I L I N G;
	TRANSLATION                 :   T R A N S L A T I O N;
	TREAT                       :   T R E A T;
	TRIGGER                     :   T R I G G E R;
	TRUE                        :   T R U E;
	UNDO                        :   U N D O;
	UNION                       :   U N I O N;
	UNIQUE                      :   U N I Q U E;
	UNKNOWN                     :   U N K N O W N;
	UNNEST                      :   U N N E S T;
	UPDATE                      :   U P D A T E;
	USER                        :   U S E R;
	USING                       :   U S I N G;
	VALUES                      :   V A L U E S;
	VALUE                       :   V A L U E;
	VARCHAR                     :   V A R C H A R;
	VARYING                     :   V A R Y I N G;
	WHENEVER                    :   W H E N E V E R;
	WHEN                        :   W H E N;
	WHERE                       :   W H E R E;
	WINDOW                      :   W I N D O W;
	WITH                        :   W I T H;
	WITHIN                      :   W I T H I N;
	WITHOUT                     :   W I T H O U T;
	YEAR                        :   Y E A R;


//  Non-Reserved Keyword Tokens

	ABS                         :   A B S;
	ABSOLUTE                    :   A B S O L U T E;
	ACTION                      :   A C T I O N;
	ADA                         :   A D A;
	ADMIN                       :   A D M I N;
	AFTER                       :   A F T E R;
	ALWAYS                      :   A L W A Y S;
	ASC                         :   A S C;
	ASSERTION                   :   A S S E R T I O N;
	ASSIGNMENT                  :   A S S I G N M E N T;
	ATTRIBUTE                   :   A T T R I B U T E;
	ATTRIBUTES                  :   A T T R I B U T E S;
	AUTO                        :   A U T O;
	AVG                         :   A V G;
	BEFORE                      :   B E F O R E;
	BERNOULLI                   :   B E R N O U L L I;
	BIN                         :   B I N;
	BREADTH                     :   B R E A D T H;
	CARDINALITY                 :   C A R D I N A L I T Y;
	CASCADE                     :   C A S C A D E;
	CATALOG_NAME                :   C A T A L O G Underscore N A M E;
	CATALOG                     :   C A T A L O G;
	CEILING                     :   C E I L I N G;
	CEIL                        :   C E I L;
	CHAIN                       :   C H A I N;
	CHARACTERISTICS             :   C H A R A C T E R I S T I C S;
	CHARACTERS                  :   C H A R A C T E R S;
	CHARACTER_LENGTH            :   C H A R A C T E R Underscore L E N G T H;
	CHARACTER_SET_CATALOG       :   C H A R A C T E R Underscore S E T Underscore C A T A L O G;
	CHARACTER_SET_NAME          :   C H A R A C T E R Underscore S E T Underscore N A M E;
	CHARACTER_SET_SCHEMA        :   C H A R A C T E R Underscore S E T Underscore S C H E M A;
	CHAR_LENGTH                 :   C H A R Underscore L E N G T H;
	CHECKED                     :   C H E C K E D;
	CLASS_ORIGIN                :   C L A S S Underscore O R I G I N;
	COALESCE                    :   C O A L E S C E;
	COBOL                       :   C O B O L;
	CODE_UNITS                  :   C O D E Underscore U N I T S;
	COLLATION_CATALOG           :   C O L L A T I O N Underscore C A T A L O G;
	COLLATION_NAME              :   C O L L A T I O N Underscore N A M E;
	COLLATION_SCHEMA            :   C O L L A T I O N Underscore S C H E M A;
	COLLATION                   :   C O L L A T I O N;
	COLLECT                     :   C O L L E C T;
	COLUMN_NAME                 :   C O L U M N Underscore N A M E;
	COMMAND_FUNCTION_CODE       :   C O M M A N D Underscore F U N C T I O N Underscore C O D E; 
	COMMAND_FUNCTION            :   C O M M A N D Underscore F U N C T I O N;
	COMMITTED                   :   C O M M I T T E D;
	CONDITION_NUMBER            :   C O N D I T I O N Underscore N U M B E R;
	CONDITION                   :   C O N D I T I O N;
	CONNECTION_NAME             :   C O N N E C T I O N Underscore N A M E;
	CONSTRAINTS                 :   C O N S T R A I N T S;
	CONSTRAINT_CATALOG          :   C O N S T R A I N T Underscore C A T A L O G;
	CONSTRAINT_NAME             :   C O N S T R A I N T Underscore N A M E;
	CONSTRAINT_SCHEMA           :   C O N S T R A I N T Underscore S C H E M A;
	CONSTRUCTORS                :   C O N S T R U C T O R S;
	CONST                       :   C O N S T;
	CONTAINS                    :   C O N T A I N S;
	CONVERT                     :   C O N V E R T;
	CORR                        :   C O R R;
	COUNT                       :   C O U N T;
	COVAR_POP                   :   C O V A R Underscore P O P;
	COVAR_SAMP                  :   C O V A R Underscore S A M P;
	CUME_DIST                   :   C U M E Underscore D I S T;
	CURRENT_COLLATION           :   C U R R E N T Underscore C O L L A T I O N;
	CURSOR_NAME                 :   C U R S O R Underscore N A M E;
	DATA                        :   D A T A;
	DATETIME_INTERVAL_CODE      :   D A T E T I M E Underscore I N T E R V A L Underscore C O D E;
	DATETIME_INTERVAL_PRECISION :   D A T E T I M E Underscore I N T E R V A L Underscore P R E C I S I O N;
	DAYS                        :   D A Y S;
	DCL                         :   D C L;
	DEFAULTS                    :   D E F A U L T S;
	DEFERRABLE                  :   D E F E R R A B L E;
	DEFERRED                    :   D E F E R R E D;
	DEFINED                     :   D E F I N E D;
	DEFINER                     :   D E F I N E R;
	DEGREE                      :   D E G R E E;
	DENSE_RANK                  :   D E N S E Underscore R A N K;
	DEPTH                       :   D E P T H;
	DERIVED                     :   D E R I V E D;
	DESCRIPTOR                  :   D E S C R I P T O R;
	DESC                        :   D E S C;
	DIAGNOSTICS                 :   D I A G N O S T I C S;
	DISPATCH                    :   D I S P A T C H;
	DISPLAY                     :   D I S P L A Y;
	DOMAIN                      :   D O M A I N;
	DOUBLE_PRECISION            :   D O U B L E Underscore P R E C I S I O N;
	DYNAMIC_FUNCTION            :   D Y N A M I C Underscore F U N C T I O N;
	DYNAMIC_FUNCTION_CODE       :   D Y N A M I C Underscore F U N C T I O N Underscore C O D E;
	EQUALS                      :   E Q U A L S;
	EVERY                       :   E V E R Y;
	EXCEPTION                   :   E X C E P T I O N;
	EXCLUDE                     :   E X C L U D E;
	EXCLUDING                   :   E X C L U D I N G;
	EXP                         :   E X P;
	EXTERN                      :   E X T E R N;
	EXTRACT                     :   E X T R A C T;
	FINAL                       :   F I N A L;
	FIRST                       :   F I R S T;
	FIXED                       :   F I X E D;
	FLOAT                       :   F L O A T;
	FLOOR                       :   F L O O R;
	FOLLOWING                   :   F O L L O W I N G;
	FORTRAN                     :   F O R T R A N;
	FOUND                       :   F O U N D;
	FUSION                      :   F U S I O N;
	GENERAL                     :   G E N E R A L;
	GOTO                        :   G O T O;
	GO                          :   G O;
	GRANTED                     :   G R A N T E D;
	HIERARCHY                   :   H I E R A R C H Y;
	HOURS                       :   H O U R S;
	IMPLEMENTATION              :   I M P L E M E N T A T I O N;
	INCLUDING                   :   I N C L U D I N G;
	INCREMENT                   :   I N C R E M E N T;
	INDICATOR_TYPE              :   I N D I C A T O R Underscore T Y P E;
	INITIALLY                   :   I N I T I A L L Y;
	INSTANCE                    :   I N S T A N C E;
	INSTANTIABLE                :   I N S T A N T I A B L E;
	INTERFACES                  :   I N T E R F A C E S;
	INTERSECTION                :   I N T E R S E C T I O N;
	INVOKER                     :   I N V O K E R;
	KEY_MEMBER                  :   K E Y Underscore M E M B E R;
	KEY_TYPE                    :   K E Y Underscore T Y P E;
	KEY                         :   K E Y;
	KIND                        :   K I N D;
	LAST                        :   L A S T;
	LENGTH                      :   L E N G T H;
	LEN                         :   L E N;
	LEVEL                       :   L E V E L;
	LOGICAL                     :   L O G I C A L;
	LONG                        :   L O N G;
	LN                          :   L N;
	LOCATOR                     :   L O C A T O R;
	LOWER                       :   L O W E R;
	MAP                         :   M A P;
	MATCHED                     :   M A T C H E D;
	MAXVALUE                    :   M A X V A L U E;
	MAX                         :   M A X;
	MESSAGE_LENGTH              :   M E S S A G E Underscore L E N G T H;
	MESSAGE_OCTET_LENGTH        :   M E S S A G E Underscore O C T E T Underscore L E N G T H;
	MESSAGE_TEXT                :   M E S S A G E Underscore T E X T;
	MINVALUE                    :   M I N V A L U E;
	MIN                         :   M I N;
	MOD                         :   M O D;
	MORE                        :   M O R E;
	MUMPS                       :   M U M P S;
	NAMES                       :   N A M E S;
	NAME                        :   N A M E;
	NESTING                     :   N E S T I N G;
	NEXT                        :   N E X T;
	NORMALIZED                  :   N O R M A L I Z E D;
	NORMALIZE                   :   N O R M A L I Z E;
	NULLABLE                    :   N U L L A B L E;
	NULLIF                      :   N U L L I F;
	NULLS                       :   N U L L S;
	NUMBER                      :   N U M B E R;
	OBJECT                      :   O B J E C T;
	OCTETS                      :   O C T E T S;
	OCTET_LENGTH                :   O C T E T Underscore L E N G T H;
	OPTION                      :   O P T I O N;
	OPTIONS                     :   O P T I O N S;
	ORDERING                    :   O R D E R I N G;
	ORDINALITY                  :   O R D I N A L I T Y;
	OTHERS                      :   O T H E R S;
	OVERLAY                     :   O V E R L A Y;
	OVERRIDING                  :   O V E R R I D I N G;
	PACKED                      :   P A C K E D;
	PAD                         :   P A D;
	PARAMETER_MODE              :   P A R A M E T E R Underscore M O D E;
	PARAMETER_NAME              :   P A R A M E T E R Underscore N A M E;
	PARAMETER_ORDINAL_POSITION  :   P A R A M E T E R Underscore O R D I N A L Underscore P O S I T I O N;
	PARAMETER_SPECIFIC_CATALOG  :   P A R A M E T E R Underscore S P E C I F I C Underscore C A T A L O G;
	PARAMETER_SPECIFIC_NAME     :   P A R A M E T E R Underscore S P E C I F I C Underscore N A M E;
	PARAMETER_SPECIFIC_SCHEMA   :   P A R A M E T E R Underscore S P E C I F I C Underscore S C H E M A;
	PARTIAL                     :   P A R T I A L;
	PASCAL                      :   P A S C A L;
	PATH                        :   P A T H;
	PERCENTILE_CONT             :   P E R C E N T I L E Underscore C O N T;
	PERCENTILE_DISC             :   P E R C E N T I L E Underscore D I S C;
	PERCENT_RANK                :   P E R C E N T Underscore R A N K;
	PICTURE                     :   P I C T U R E;
	PIC                         :   P I C;
	PLACING                     :   P L A C I N G;
	PLI                         :   P L I | P L '1';
	POSITION                    :   P O S I T I O N;
	POWER                       :   P O W E R;
	PRECEDING                   :   P R E C E D I N G;
	PRESERVE                    :   P R E S E R V E;
	PRIOR                       :   P R I O R;
	PRIVILEGES                  :   P R I V I L E G E S;
	PUBLIC                      :   P U B L I C;
	RANK                        :   R A N K;
	READ                        :   R E A D;
	REGR_AVGX                   :   R E G R Underscore A V G X;
	REGR_AVGY                   :   R E G R Underscore A V G Y;
	REGR_COUNT                  :   R E G R Underscore C O U N T;
	REGR_INTERCEPT              :   R E G R Underscore I N T E R C E P T;
	REGR_R2                     :   R E G R Underscore R '2';
	REGR_SLOPE                  :   R E G R Underscore S L O P E;
	REGR_SXX                    :   R E G R Underscore S X X;
	REGR_SXY                    :   R E G R Underscore S X Y;
	REGR_SYY                    :   R E G R Underscore S Y Y;
	RELATIVE                    :   R E L A T I V E;
	REPEATABLE                  :   R E P E A T A B L E;
	RESTART                     :   R E S T A R T;
	RESTRICT                    :   R E S T R I C T;
	RESULT                      :   R E S U L T;
	RETURNED_CARDINALITY        :   R E T U R N E D Underscore C A R D I N A L I T Y;
	RETURNED_LENGTH             :   R E T U R N E D Underscore L E N G T H;
	RETURNED_OCTET_LENGTH       :   R E T U R N E D Underscore O C T E T Underscore L E N G T H;
	RETURNED_SQLSTATE           :   R E T U R N E D Underscore S Q L S T A T E;
	ROLE                        :   R O L E;
	ROUTINE_CATALOG             :   R O U T I N E Underscore C A T A L O G;
	ROUTINE_NAME                :   R O U T I N E Underscore N A M E;
	ROUTINE_SCHEMA              :   R O U T I N E Underscore S C H E M A;
	ROUTINE                     :   R O U T I N E;
	ROW_COUNT                   :   R O W Underscore C O U N T;
	ROW_NUMBER                  :   R O W Underscore N U M B E R;
	SCALE                       :   S C A L E;
	SCHEMA_NAME                 :   S C H E M A Underscore N A M E;
	SCHEMA                      :   S C H E M A;
	SCOPE_CATALOG               :   S C O P E Underscore C A T A L O G;
	SCOPE_NAME                  :   S C O P E Underscore N A M E;
	SCOPE_SCHEMA                :   S C O P E Underscore S C H E M A;
	SECTION                     :   S E C T I O N;
	SECURITY                    :   S E C U R I T Y;
	SELF                        :   S E L F;
	SEPARATE                    :   S E P A R A T E;
	SEQUENCE                    :   S E Q U E N C E;
	SERIALIZABLE                :   S E R I A L I Z A B L E;
	SERVER_NAME                 :   S E R V E R Underscore N A M E;
	SESSION                     :   S E S S I O N;
	SETS                        :   S E T S;
	SHORT                       :   S H O R T;
	SIGNED                      :   S I G N E D;
	SIGN                        :   S I G N;
	SIMPLE                      :   S I M P L E;
	SIZE                        :   S I Z E;
	SOURCE                      :   S O U R C E;
	SPACE                       :   S P A C E;
	SPECIFIC_NAME               :   S P E C I F I C Underscore N A M E;
	SQLSTATE_TYPE               :   S Q L S T A T E Underscore T Y P E;
	SQRT                        :   S Q R T;
	STATEMENT                   :   S T A T E M E N T;
	STATE                       :   S T A T E;
	STDDEV_POP                  :   S T D D E V Underscore P O P;
	STDDEV_SAMP                 :   S T D D E V Underscore S A M P;
	STRUCTURE                   :   S T R U C T U R E;
	STYLE                       :   S T Y L E;
	SUBCLASS_ORIGIN             :   S U B C L A S S Underscore O R I G I N;
	SUBSTRING                   :   S U B S T R I N G;
	SUM                         :   S U M;
	TABLESAMPLE                 :   T A B L E S A M P L E;
	TABLE_NAME                  :   T A B L E Underscore N A M E;
	TEMPORARY                   :   T E M P O R A R Y;
	TIES                        :   T I E S;
	TOP_LEVEL_COUNT             :   T O P Underscore L E V E L Underscore C O U N T;
	TRANSACTIONS_COMMITTED      :   T R A N S A C T I O N S Underscore C O M M I T T E D;
	TRANSACTIONS_ROLLED_BACK    :   T R A N S A C T I O N S Underscore R O L L E D Underscore B A C K;
	TRANSACTION_ACTIVE          :   T R A N S A C T I O N Underscore A C T I V E;
	TRANSACTION                 :   T R A N S A C T I O N;
	TRANSFORMS                  :   T R A N S F O R M S;
	TRANSFORM                   :   T R A N S F O R M;
	TRANSLATE                   :   T R A N S L A T E;
	TRIGGER_CATALOG             :   T R I G G E R Underscore C A T A L O G;
	TRIGGER_NAME                :   T R I G G E R Underscore N A M E;
	TRIGGER_SCHEMA              :   T R I G G E R Underscore S C H E M A;
	TRIM                        :   T R I M;
	TYPE                        :   T Y P E;
	UNBOUNDED                   :   U N B O U N D E D;
	UNCOMMITTED                 :   U N C O M M I T T E D;
	UNDER                       :   U N D E R;
	UNNAMED                     :   U N N A M E D;
	UNSIGNED                    :   U N S I G N E D;
	UPPER                       :   U P P E R;
	USAGE                       :   U S A G E;
	USER_DEFINED_TYPE_CATALOG   :   U S E R Underscore D E F I N E D Underscore T Y P E Underscore C A T A L O G;
	USER_DEFINED_TYPE_CODE      :   U S E R Underscore D E F I N E D Underscore T Y P E Underscore C O D E;
	USER_DEFINED_TYPE_NAME      :   U S E R Underscore D E F I N E D Underscore T Y P E Underscore N A M E;
	USER_DEFINED_TYPE_SCHEMA    :   U S E R Underscore D E F I N E D Underscore T Y P E Underscore S C H E M A;
	VAR_POP                     :   V A R Underscore P O P;
	VAR_SAMP                    :   V A R Underscore S A M P;
	VIEW                        :   V I E W;
	VOLATILE                    :   V O L A T I L E;
	WIDTH_BUCKET                :   W I D T H Underscore B U C K E T;
	WORK                        :   W O R K;
	WRITE                       :   W R I T E;
	ZONE                        :   Z O N E;

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
fragment
Hyphen              
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

// Character Set rules

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




fragment
Unicode_Identifier_Part          :  Unicode_Escape_Value | Unicode_Permitted_Identifier_Character;

fragment
Unicode_Escape_Value             :  Unicode_4_Digit_Escape_Value  | Unicode_6_Digit_Escape_Value ;

fragment
Unicode_4_Digit_Escape_Value     :  Escape_Character  Hexit  Hexit  Hexit  Hexit ;

fragment
Unicode_6_Digit_Escape_Value     :  Escape_Character  Plus_Sign Hexit  Hexit  Hexit  Hexit  Hexit  Hexit ;

Escape_Character                 :  '\\' /* Unicode_Allowed_Escape_Chracter */ /*!! See the Syntax Rules*/; 


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
				(	('K' | 'M' |'G')
					{
						_type  =  Unsigned_Large_Integer;
					}
				|	{true}?
					{
						_type  =  Unsigned_Integer;
					}
				)
				
			|	( OctalDigit )* 
				(	('K' | 'M' |'G')
					{
						_type  =  Unsigned_Large_Integer;
					}
				|	{true}?
					{
						_type  =  Unsigned_Integer;
					}
				)
				
			|	Period 
				( Digit )+ ( ( 'f' | 'F' | 'd' | 'D' | 'e' | 'E' ) ( Plus_Sign | Minus_Sign )? Digit ( Digit ( Digit )? )? )?
				{
					_type  =  Unsigned_Float;
				}
				
			|	'8'..'9' ( Digit )*
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
				
			|	(	('K' | 'M' |'G')
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
				
			|	(	('K' | 'M' |'G')
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
Character_Set		:	Underscore  Character_Set_Name;

fragment
Character_String_Literal :
		  Quote ( Extended_Latin_Without_Quotes  )* Quote ( Quote ( Extended_Latin_Without_Quotes  )* Quote )*
		;
		
fragment
National_Character_String_Literal :
		'N' Quote ( Extended_Latin_Without_Quotes  )* Quote ( Quote ( Extended_Latin_Without_Quotes  )* Quote )*
		;

fragment
Unicode_Character_String_Literal  :
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
	(	Character_Set
		(
			Unicode_Character_String_Literal
				{
					_type  =  Unicode_Character_String_Literal;
				}
		|	Character_String_Literal
				{
					_type  =  Character_String_Literal;
				}
		)
	|	Bit_String_Literal
			{
				_type  =  Bit_String_Literal;
			}	
	|	Hex_String_Literal
			{
				_type  =  Hex_String_Literal;
			}	
	|	National_Character_String_Literal
			{
				_type  =  National_Character_String_Literal;
			}
	|	Unicode_Character_String_Literal
			{
				_type  =  Unicode_Character_String_Literal;
			}
	|	Character_String_Literal
			{
				_type  =  Character_String_Literal;
			}
	);

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
//                    |   {isSybaseASA()}? 				SybaseASA_Identifier
//                    |   {isSQLServerOrSybaseASE()}? 	SqlServer_Identifier
//                    |   {isTeradata()}?				Teradata_Identifier
//                    |   {isMySQL()}?					MySQL_Identifier
//                    |   {isInformixOrPostgreSQL()}?	Informix_PostgreSQL_Identifier 
//                    |   {isOracle()}?					Oracle_Identifier
//                    |   {isInterbase()}?				Interbase_Identifier
//                    |   {true}?						SQL92_Identifier 
                    ;

// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// Sybase ASA      Latin,'_','@','#','$'   Latin,Digit,'_','@','#','$'     no              128
fragment
SybaseASA_Identifier  :  
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
    Teradata_Identifier_Start ( Teradata_Identifier_Part )*;
fragment
Teradata_Identifier_Start  :  Simple_Latin_Letter | Hash_Sign | Dollar_Sign; // | Underscore;
fragment
Teradata_Identifier_Part   :  Simple_Latin_Letter | Digit | Underscore | Hash_Sign | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// MySQL           Latin,Digit             Latin,Digit,'_','$'             yes             64
fragment
MySQL_Identifier  :  
    MySQL_Identifier_Start ( MySQL_Identifier_Part )*;
fragment
MySQL_Identifier_Start  :  Simple_Latin_Letter | Digit;
fragment
MySQL_Identifier_Part  :  Simple_Latin_Letter | Digit | Underscore | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// Informix        Latin,'_'               Latin,Digit,'_','$'             no              128
fragment
Informix_PostgreSQL_Identifier  :  
    Informix_Identifier_Start ( Informix_Identifier_Part )*;
fragment
Informix_Identifier_Start  :  Simple_Latin_Letter; // | Underscore;
fragment
Informix_Identifier_Part  :  Simple_Latin_Letter | Digit | Underscore | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// Oracle          Latin                   Latin,Digit,'_','#','$'         no              30
fragment
Oracle_Identifier  :  
    Oracle_Identifier_Start ( Oracle_Identifier_Part )*;
fragment
Oracle_Identifier_Start  :  Simple_Latin_Letter;
fragment
Oracle_Identifier_Part  :  Simple_Latin_Letter | Digit | Underscore | Hash_Sign | Dollar_Sign;


// Database        1st Character           Sunsequent Characters           Case Sensitive  Max Length
// Interbase       Latin                   Latin,Digit,'_','$'             no              67
fragment
Interbase_Identifier  :  
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

