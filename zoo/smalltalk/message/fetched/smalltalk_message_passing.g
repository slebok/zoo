/* ANTLR v3 Grammar for a subset of Smalltalk message passing syntax
 *
 * This grammar describes the basic syntax of Smalltalk message passing with
 * nested receivers, colon and non-colon identifiers but without operators.
 * Where a message sent to a nested receiver begins with a colon identifier,
 * the receiver needs to be enclosed in parentheses in order to avoid an
 * ambiguity due to the possibility that the colon identifier may belong to
 * the previous message in the message passing chain.  Where a message sent to
 * a nested receiver begins instead with a non-colon identifier,  the receiver
 * need not be enclosed in parentheses as there is no such ambiguity because
 * non-colon identifiers can only appear at the start of a method signature.
 *
 * Examples:
 *
 *  FooClass new
 *  FooClass new foo
 *  FooClass new foo bar:12
 *  (FooClass new foo bar:12) baz:34 bam:56
 *  (FooClass new foo bar:12 baz:34 bam:56 ding) dang:78 dong
 *
 * Note that ANTLRworks gives an ambiguity warning in production message but
 * it disables the second alternative automatically and the resulting parser
 * works as intended.  Further study will be required to determine if the
 * grammar can be refactored to yield an equivalent result without warning.
 *
 *
 * Copyright (C) 2009, Benjamin Kowarsch. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * (1) Hosting of  this  file, or any parts thereof, on websites which contain
 *     advertising is expressly forbidden and requires specific prior written
 *     permission. However, the ANTLR project website and university websites
 *     are exempt from this restriction. Exemption may be withdrawn if abused.
 *
 * (2) Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *
 * (3) Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and other materials provided with the distribution.
 *
 * (4) Neither the author's name nor the names of any contributors may be used
 *     to endorse or promote products derived from this software without
 *     specific prior written permission.
 *
 * (5) Where this list of conditions or the following disclaimer, in part or
 *     as a whole is overruled or nullified by applicable law, no permission
 *     is granted to use the software.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,  BUT NOT LIMITED TO,  THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY  AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT  SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE  FOR  ANY  DIRECT,  INDIRECT,  INCIDENTAL,  SPECIAL,  EXEMPLARY,  OR
 * CONSEQUENTIAL  DAMAGES  (INCLUDING,  BUT  NOT  LIMITED  TO,  PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES;  LOSS OF USE,  DATA,  OR PROFITS; OR BUSINESS
 * INTERRUPTION)  HOWEVER  CAUSED  AND ON ANY THEORY OF LIABILITY,  WHETHER IN
 * CONTRACT,  STRICT LIABILITY,  OR TORT  (INCLUDING NEGLIGENCE  OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,  EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 */

grammar smalltalk_message_passing;

options { backtrack = false; k = 1; }


// parser rules

// test rig with start and $ symbols
start :
	msg_expression '.' ;

// a message expression, consisting of receiver and message
msg_expression :
	receiver message
	;

// the receiver of a message
receiver :
	( receiver_id | '(' msg_expression ')' )
	;

// a message for a receiver
message :
	(
	( ( method_sig_head )+ | method_sig_keyword expression )
	( method_sig_keyword expression )*
	)+
	;

// an identifier that is a receiver
receiver_id : IDENT ;

// a non-colon identifier that is part of a method signature
method_sig_head : IDENT ;

// a colon identifier that is part of a method signature
method_sig_keyword : COLON_IDENT ;

// something that serves as an argument, just for testing
expression : ( NUMBER ( ( '+' | '-' | '*' | '/' ) NUMBER )* ) | STRING ;


// lexer rules

// colon identifier
COLON_IDENT : LETTER ( LETTER | DIGIT )* ':' ;

// non-colon identifier
IDENT : LETTER ( LETTER | DIGIT )* ;

// numeric literal
NUMBER : DIGIT ( DIGIT )* ;

// string literal
STRING : '"' ( ' ' | LETTER | DIGIT ) '"';

fragment LETTER : 'a'..'z' | 'A'..'Z' ;

fragment DIGIT : '0'..'9' ;

// ignore ASCII TAB, whitespace, ASCII CR, ASCII LF and ASCII NUL
WHITESPACE : (  ' ' | '\t' | '\u000C' | '\r' | '\n' )+ { $channel = HIDDEN; };

// END OF FILE
