/*
 * Copyright 2010 Spolecne s.r.o. (www.spoledge.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
lexer grammar GqlLexer;

/*********************************************
 * KEYWORDS
 **********************************************/

ANCESTOR: A N C E S T O R;
ASC: A S C;
AND: A N D;
BY: B Y;
DATETIME: D A T E T I M E;
DATE: D A T E;
DESC: D E S C;
FALSE: F A L S E;
FROM: F R O M;
GEOPT: G E O P T;
IN: I N;
IS: I S;
KEYPROP: '__key__';
KEY: K E Y;
LIMIT: L I M I T;
NULL: N U L L;
OFFSET: O F F S E T;
ORDER: O R D E R;
SELECT: S E L E C T;
TIME: T I M E;
TRUE: T R U E;
USER: U S E R;
WHERE: W H E R E;


/*********************************************
 * GENERAL
 **********************************************/

ID: ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')* ;

VARID: ':' '0'..'9'+;

VARNAME: ':' ID;

OPER: '<' | '>' | '<=' | '>=' | '!=';

EQ: '=';

WS: ( ' ' | '\t' | '\r' | '\n') {$channel=HIDDEN;} ;

PLUS: '+';

MINUS: '-';


/*********************************************
 * TYPES
 **********************************************/

FLOAT: ('0'..'9')+ '.' ('0'..'9')* EXPONENT?
    | '.' ('0'..'9')+ EXPONENT?
    | ('0'..'9')+ EXPONENT
    ;

INT: '0'..'9'+ ;

STRING: '\'' ( '\'\'' | ~'\'' )* '\'' ;


/*********************************************
 * FRAGMENTS
 **********************************************/

fragment EXPONENT: ('e'|'E') ('+'|'-')? ('0'..'9')+ ;

fragment HEX_DIGIT: ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment A:('a'|'A');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
fragment F:('f'|'F');
fragment G:('g'|'G');
fragment H:('h'|'H');
fragment I:('i'|'I');
fragment J:('j'|'J');
fragment K:('k'|'K');
fragment L:('l'|'L');
fragment M:('m'|'M');
fragment N:('n'|'N');
fragment O:('o'|'O');
fragment P:('p'|'P');
fragment Q:('q'|'Q');
fragment R:('r'|'R');
fragment S:('s'|'S');
fragment T:('t'|'T');
fragment U:('u'|'U');
fragment V:('v'|'V');
fragment W:('w'|'W');
fragment X:('x'|'X');
fragment Y:('y'|'Y');
fragment Z:('z'|'Z');

