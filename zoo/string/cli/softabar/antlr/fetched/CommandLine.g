/*
Grammar for command line parsing in 
Softabar Command Line Program v1.2.0

http://softabar.com/home/command-line-program-platform/

*/
grammar CommandLine

commandline:	
	(commandlineWithGlobalOptions | commandlineWithoutGlobalOptions)
	EOF
	;

commandlineWithGlobalOptions:
    (option*
     (WSPACE+ command)*)
     WSPACE*
     ;

commandlineWithoutGlobalOptions:    
     (WSPACE* command (WSPACE+ command)*)
     WSPACE*
     ;

command:
     name option*
    ;
    
option:
    WSPACE* HYPHEN HYPHEN? name (EQUALS WSPACE* (value | qvalue |sqvalue)  (WSPACE* COMMA WSPACE* (value|qvalue | sqvalue) )* )? 
    ;

name:
    NAME+ 
    ;

value:
    (NAME | VALUECHARS )+
    ;

qvalue:
    DQUOTE  
    (SLASH {qvalueString.append($SLASH.text);}
    | NAME  {qvalueString.append($NAME.text);}
    | VALUECHARS {qvalueString.append($VALUECHARS.text);}
    | COMMA {qvalueString.append(',');}
    | WSPACE {qvalueString.append($WSPACE.text);}
    | HYPHEN {qvalueString.append($HYPHEN.text);}
    | EQUALS {qvalueString.append('=');}
    | NULL {qvalueString.append(0x00);}
    | ASCII_CONTROLCHARS {qvalueString.append($ASCII_CONTROLCHARS.text);}
    | SQUOTE {qvalueString.append("'");}
    | DQUOTE {qvalueString.append('"');} DQUOTE {qvalueString.append('"');}
    | UTF_VALUECHARS {qvalueString.append($UTF_VALUECHARS.text);}
    | EXTRASCII_VALUECHARS {qvalueString.append($EXTRASCII_VALUECHARS.text);})*
    DQUOTE 
    ;


sqvalue:
    SQUOTE  
    (SLASH {qvalueString.append($SLASH.text);}
    | NAME  {qvalueString.append($NAME.text);}
    | VALUECHARS {qvalueString.append($VALUECHARS.text);}
    | COMMA {qvalueString.append(',');}
    | WSPACE {qvalueString.append($WSPACE.text);}
    | HYPHEN {qvalueString.append($HYPHEN.text);}
    | EQUALS {qvalueString.append('=');}
    | NULL {qvalueString.append(0x00);}
    | ASCII_CONTROLCHARS {qvalueString.append($ASCII_CONTROLCHARS.text);}
    | DQUOTE {qvalueString.append('"');}
    | SQUOTE {qvalueString.append("'");} SQUOTE {qvalueString.append("'");}
    | UTF_VALUECHARS {qvalueString.append($UTF_VALUECHARS.text);}
    | EXTRASCII_VALUECHARS {qvalueString.append($EXTRASCII_VALUECHARS.text);})*
    SQUOTE 
    ;


NAME:
    	('a'..'z'|'A'..'Z'|'0'..'9'|'_')+
    	;

SLASH:
	'\u002f' 
	;

VALUECHARS:	
	//all ascii from ox20 to 0x7f, except chars in NAME,EQUALS,COMMA,HYPHENand DEL
	 ('\u0021' | '\u0023'..'\u0026' |'\u0028'..'\u002b' | '\u002e' | '\u003a'..'\u003c' |'\u003e'..'\u0040'|'\u005b'..'\u005e'|'\u0060'|'\u007b'..'\u007e' )+
	;


EXTRASCII_VALUECHARS:
	( '\u0080'..'\u00ff')+
	;

UTF_VALUECHARS:
	( '\u0100'..'\uffff')+
	;

ASCII_CONTROLCHARS:
	//All control chars except 0x01 that is used as separator in command line option values
	 ( '\u0002'..'\u001f')+
	;
  
WSPACE:
	(' ' |'\t')    
	;

EQUALS:	
	 '\u003d'
    	;

HYPHEN:	
	'\u002d'
    	;

COMMA:
	'\u002c'
    	;

NULL:
	'\u0000'
    	;

SQUOTE:	
	'\u0027'
	;

DQUOTE:
	'\u0022'
	;