lexer grammar MySQLBase;

@lexer::header {
package abbr.documentation.sqlscript.parser;

import java.util.Arrays;
import java.util.List;
}

@members {

	public static final int COMMENTS_CHANNEL = 5;
	
	/*
	** Calc type of integer; long integer, longlong integer or real.
	** Returns smallest type that match the string.
	** When using unsigned long long values the result is converted to a real
	** because else they will be unexpected sign changes because all calculation
	** is done with longlong or double.
	*/

	static final String long_str="2147483647";
	static final int long_len=10;
	static final String signed_long_str="-2147483648";
	static final String longlong_str="9223372036854775807";
	static final int longlong_len=19;
	static final String signed_longlong_str="-9223372036854775808";
	static final int signed_longlong_len=19;
	static final String unsigned_longlong_str="18446744073709551615";
	static final int unsigned_longlong_len=20;

	public static int getIntType(String str)
	{
		char ch;
		int i = 0;
		int length;

		ch = str.charAt(i);
		length = str.length();

		if (length < long_len) // quick normal case
			return NUM;

		while (ch == '0' && length > 0) {
			ch = str.charAt(++i);
			length--;
		}

		if (length < long_len)
			return NUM;

		int smaller, bigger;
		String cmp;
		if (length == long_len) {
			cmp = long_str;
			smaller = NUM;
			bigger = LONG_NUM;
		} else if (length < longlong_len)
			return LONG_NUM;
		else if (length > longlong_len) {
			if (length > unsigned_longlong_len)
				return DECIMAL_NUM;
			cmp = unsigned_longlong_str;
			smaller = ULONGLONG_NUM;
			bigger = DECIMAL_NUM;
		} else {
			cmp = longlong_str;
			smaller = LONG_NUM;
			bigger = ULONGLONG_NUM;
		}

		int j = 0;
		while (j < cmp.length() && cmp.charAt(j++) == str.charAt(i++))
			;
		return cmp.charAt(j - 1) == str.charAt(i - 1) ? smaller : bigger;
	}	
	
	public static int getNegativeIntType(String str)
	{
		char ch;
		int i = 0;
		int length;

		ch = str.charAt(i);
		length = str.length();

		if (length < long_len) // quick normal case
			return NUM;

		while (ch == '0' && length > 0) {
			ch = str.charAt(++i);
			length--;
		}

		if (length < long_len)
			return NUM;

		int smaller, bigger;
		String cmp;

		if (length == long_len) {
			cmp = signed_long_str.substring(1);
			smaller = NUM; // If <= signed_long_str
			bigger = LONG_NUM; // If >= signed_long_str
		} else if (length < signed_longlong_len)
			return LONG_NUM;
		else if (length > signed_longlong_len)
			return DECIMAL_NUM;
		else {
			cmp = signed_longlong_str.substring(1);
			smaller = LONG_NUM; // If <= signed_longlong_str
			bigger = DECIMAL_NUM;
		}

		int j = 0;
		while (j < cmp.length() && cmp.charAt(j++) == str.charAt(i++))
			;
		return cmp.charAt(j - 1) == str.charAt(i - 1) ? smaller : bigger;
	}	
}

fragment
DIGIT	:	
	'0'..'9'
;	

fragment
HEX_DIGIT:	
	('a'..'f' | 'A'..'F' | DIGIT )
;	

fragment
UNSIGNED_INTEGER : 
	DIGIT+ 
;

fragment
Exponent: 
	('e'|'E') ('+'|'-')? UNSIGNED_INTEGER 
;

// disambiguate these
fragment NUM: ;
fragment LONG_NUM: ;
fragment ULONGLONG_NUM: ;	
fragment DECIMAL_NUM: ;	
fragment FLOAT_NUM: ;


NUM_literal:	
           ('-'|'+')? UNSIGNED_INTEGER '.' UNSIGNED_INTEGER? (Exponent {$type = FLOAT_NUM; } | {$type = DECIMAL_NUM; } )
    	|  ('-'|'+')? '.' UNSIGNED_INTEGER (Exponent {$type = FLOAT_NUM; } | {$type = DECIMAL_NUM;  } )
    	|  ('-'|'+')? ('0'..'9')+ Exponent {$type = FLOAT_NUM; } 
	|  '-' i=UNSIGNED_INTEGER { $type = getNegativeIntType($i.text); } 
	| '+'? i=UNSIGNED_INTEGER { $type = getIntType($i.text); }
;	

BIN_NUM : 
	('B' | 'b') '\'' ('0' | '1')+ '\''
;

HEX_NUM : 
	('X' | 'x') '\'' (  HEX_DIGIT HEX_DIGIT )+ '\'' 
;

WS	:	(' '|'\r'|'\t'|'\n')+ {$channel=HIDDEN;}
;
	
SL_COMMENT
	:	('--'|'#') ~('\n'|'\r')* '\r'? '\n' {$channel=COMMENTS_CHANNEL;}
;
		
ML_COMMENT
	:	'/*' ( options {greedy=false;} : . )* '*/' {$channel=COMMENTS_CHANNEL;}
;	

// MG: Rule Added from SQL standard
//{ Rule #358 <NATIONAL_CHAR_STRING_LIT> - subtoken typecast in <REGULAR_ID>, it also incorporates <character_representation>
//  Lowercase 'n' is a usual addition to the standard
NCHAR_STRING: 
	('N' | 'n') 
	  ('\'' 
	  	( 
	  		  options{greedy=true;}: ~('\'' | '\r' | '\n' ) | '\'' '\'' 
	  	)* 
	  '\'' )
;
//}

TEXT_STRING:
	  ('\'' 
	  	( 
	  		  options{greedy=true;}: ~('\'' | '\r' | '\n' ) | '\'' '\'' 
	  	)* 
	  '\'' )
		
;

fragment 
NEWLINE	:	'\r'? '\n';


// FIXME it may be reserved word and contain special characters
IDENT_QUOTED: 
	'`' ('$'|'_'|'a'..'z'|'A'..'Z'|'0'..'9')+ '`'
;

  // FIXME it may not be reserved words nor contain special characters; it must contain not only digits
IDENT : ('$'|'_'|'a'..'z'|'A'..'Z'|'0'..'9')+;
