/*
 * Copyright 2010 Class Action P/L
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
grammar Zoneinfo;

options {
	output=AST;
	language=Java;
}

tokens {
	DEFAULT_TIME_OF_DAY_SUFFIX;
	ZERO;
	NO_IN;
	NO_ON;
	NO_AT;
}
	
@header {
	package com.classactionpl.tz;
}

@lexer::header {
	package com.classactionpl.tz;
}

line
	: (r+=ruleLine | z+=zoneLine | l+=linkLine | NEWLINE)* -> $r* $z* $l*
	;

ruleLine
	: 'Rule' ruleName ruleFrom ruleTo ruleType ruleIn ruleOn ruleAt ruleSave ruleLetters NEWLINE!
	;

zoneLine
	: 'Zone' zoneName zoneGmtOffset zoneRules zoneFormat 
	(zoneUntil (NEWLINE+) zoneGmtOffset zoneRules zoneFormat)* 
	NEWLINE
	-> 'Zone' zoneName zoneGmtOffset zoneRules zoneFormat 
	(zoneUntil 'Zone' zoneName zoneGmtOffset zoneRules zoneFormat)* 
	;

linkLine
	: 'Link' linkFrom linkTo NEWLINE!
	;

ruleName
	: ID
	;
	
ruleFrom
	: INT | YEAR_MINMAX
	;
	
ruleTo
	: INT | YEAR_MINMAX | ONLY_YEAR
	;
	
ruleType
	: '-' | YEAR_TYPE
	;
	
ruleIn
	: MONTH
	;
	
ruleOn
	: INT | LAST_DAY | (DAY_OF_WEEK DAY_COMPARATOR INT)
	;
	
ruleAt
	: '-' 
	| (positiveTime TIME_OF_DAY_SUFFIX -> positiveTime TIME_OF_DAY_SUFFIX?)
	| (positiveTime -> positiveTime DEFAULT_TIME_OF_DAY_SUFFIX)
	;
	
ruleSave
	: offset
	;
	
ruleLetters
	: '-' | ID
	;

zoneName
	: ID
	;

zoneGmtOffset
	: offset
	;
	
zoneRules
	: '-' | positiveTime | ID
	;
	
zoneFormat
	: ID
	;

zoneUntil
	: INT -> INT NO_IN NO_ON NO_AT
	| INT ruleIn -> INT ruleIn NO_ON NO_AT
	| INT ruleIn ruleOn -> INT ruleIn ruleOn NO_AT
	| INT ruleIn ruleOn ruleAt -> INT ruleIn ruleOn ruleAt
	;

linkFrom
	: ID
	;
	
linkTo
	: ID
	;
	
offset
	: '-'? positiveTime
	| '-' ~INT
	;

positiveTime
	: (INT -> INT ZERO ZERO)
	| (INT ':' INT -> INT INT ZERO)
	| (INT ':' INT ':' INT -> INT INT INT)
	;

YEAR_MINMAX
	: 'min' | 'max'
	;

ONLY_YEAR
	: 'only'
	;
	
YEAR_TYPE
	: 'even' | 'odd' | 'uspres' | 'nonpres' | 'nonuspres'
	;

MONTH
	: 'Jan' 'uary'? 
	| 'Feb' 'ruary'? 
	| 'Mar' 'ch'? 
	| 'Apr' 'il'? 
	| 'May' 
	| 'Jun' 'e'? 
	| 'Jul' 'y'? 
	| 'Aug' 'ust'? 
	| 'Sep' 'tember'? 
	| 'Oct' 'ober'? 
	| 'Nov' 'ember'? 
	| 'Dec' 'ember'?
	;
	
LAST_DAY
	: 'last' '-'? DAY_OF_WEEK
	;

DAY_OF_WEEK 
	: 'Sun' 'day'? 
	| 'Mon' 'day'? 
	| 'Tue' 'sday'? 
	| 'Wed' 'nesday'? 
	| 'Thu' 'rsday'? 
	| 'Fri' 'day'? 
	| 'Sat' 'urday'?
	;
	
DAY_COMPARATOR
	: '<=' | '>='
	;

TIME_OF_DAY_SUFFIX
	: 'w' | 's' | 'u' | 'g' | 'z'
	;

INT
	: '0'..'9'+
	;
	
ID
	: ('a'..'z'|'A'..'Z'|'%')('a'..'z'|'A'..'Z'|'0'..'9'|'%'|'/'|'_'|'-'|'+')*
	;

NEWLINE
	: ('#' ~('\n'|'\r')*)? '\r'? '\n' | EOF
    	;

WS
    	: (' ' | '\t') {skip();}
    	;
