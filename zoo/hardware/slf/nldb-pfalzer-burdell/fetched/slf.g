header {
//The MIT License
//
//Copyright (c) 2006-2010  Karl W. Pfalzer
//Copyright (c) 2011-      George P. Burdell
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
package parser.slf;
import  java.io.*;
import  java.util.*;
}
options {
    language="Java";
}

class SlfParser extends Parser;
options {
    k=2;
}
{
	/**
	 *	Track cell declarations.
	 */
	public static Tracker	stTracker = new Tracker();
}

source_text[LibraryFactory lf] returns [List<Library> libs]
{ Library lib = null; libs = new LinkedList<Library>(); }
:	(lib=library[lf] {libs.add(lib);})*
;

libraryName returns [String nm]
{nm=null;}
:	id:IDENT	{nm = id.getText();}
|	str:STRING
	{
		String s = str.getText();
		nm = s.substring(1,s.length()-1);
	}
;

library[LibraryFactory lf] returns [Library lib]
{ lib = null; String libNm=null;}
:	"library" LPAREN libNm=libraryName {lib = lf.createLibrary(libNm);} RPAREN
	LCURLY (library_ele[lib])* RCURLY
;

library_ele [Library lib]
{ Cell cell = null;}
:	key_value[lib]
|	cell[lib]
;

cell [Library lib]
{ Cell cell = null; Token ctk = null;}
:	"cell" LPAREN 
	(	id:IDENT   {ctk = id;}
	|	str:STRING 
			{
				String s = str.getText();
				String nm = s.substring(1,s.length()-1);
				str.setText(nm);
				str.setType(SlfParserTokenTypes.IDENT);
				ctk = str;
			}
	)
	{cell = lib.createCell(ctk); } 
	RPAREN 
	value_set[cell]
;

value_set [KeyValue.Handler kvh]
:	LCURLY (key_value[kvh])* RCURLY {kvh.valueSetDone();}
;

key_value[KeyValue.Handler kvh]
{ ValueType vt = null; List<ValueType> vtl = null; KeyValue kv = null;}
:	id:IDENT  COLON vt=value_type (SEMI)? 			
		{	if (kvh.isKeyValid(id)) {
				kvh.saveKeyValue(new KeyValue(id,vt));
			}
		}
|   id2:IDENT LPAREN (vtl=value_type_list)? RPAREN  
		{	if (kvh.isKeyValid(id2)) {
				kvh.saveKeyValue(new KeyValue(id2,vtl));
			}
		}
		(	value_set[kvh]
		|	SEMI
		|	/*nil*/
		)
;

value_type returns [ValueType vt]
{	vt = null; 
	List<Object> expr = null;
	String str = null;
	Bus bus = null;
	Number num = null;
	Boolean bool = null;
}
:	((IDENT|number) expr_op)=> expr=expr		{vt = new ValueType(expr);}
|	str=kident (bus=bus)? 						{vt = new ValueType(str, bus);}
|	id2:STRING {str = id2.getText();}           {vt = new ValueType(str);}
|	num=number 
		(options{greedy=true;}: str=unit)?      {vt = new ValueType(num, str);}
|	bool=bool                                   {vt = new ValueType(bool);}
;

bus returns [Bus bus]
{ bus = null; Number n = null;}
:	LBRACK n=number  {bus = new Bus(n);}
	(COLON n=number  {bus.add(n);})? RBRACK
;

unit returns [String v]
{ v = null;}
:	id:IDENT {v = id.getText();}
;

value_type_list returns [List<ValueType> vtl]
{ vtl = new LinkedList<ValueType>(); ValueType vt = null;}
:	vt=value_type {vtl.add(vt);}
	(COMMA vt=value_type {vtl.add(vt);})*
;

bool returns [Boolean b]
{ b = true;}
:	"true" | "false" {b = false;}
;

expr returns [List<Object> e]
{ e = new LinkedList<Object>(); ExprVal ev = null; ExprOp op = null;}
:	ev=expr_val {e.add(ev);}
	(op=expr_op ev=expr_val {e.add(op); e.add(ev);} )+
;

expr_val returns [ExprVal val]
{ val = null; Number n = null;}
:	id:IDENT	{ val = new ExprVal(id);}
|	n=number	{ val = new ExprVal(n);}
;

expr_op returns [ExprOp op]
{ op = null;}
:	(	id:STAR
	|	id2:PLUS {id=id2;}
	)
	{ op = new ExprOp(id);}
;

number returns [Number num]
{ num = null;}
:	id:NUMBER {num = new Number(id.getText());}
;

kident returns [String s]
{ s = null; }
:	(	id:IDENT
	|	id2:"cell" 		{id=id2;}
	| 	id3:"library"	{id=id3;}
	)
	{ s = id.getText();}
;

class SlfLexer extends Lexer;
options {
    k=2;
    charVocabulary='\u0000'..'\u00FF';
    testLiterals=false;
}

COLON       : ':'   ;
COMMA       : ','   ;
LCURLY      : '{'   ;
RCURLY      : '}'   ;
LPAREN      : '('   ;
RPAREN      : ')'   ;
LBRACK      : '['   ;
RBRACK      : ']'   ;
SEMI		: ';'   ;
STAR        : '*'   ;
PLUS        : '+'   ;

IDENT
    options {testLiterals=true;}
    :    ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9'|'.'|'/')*
    ;

NUMBER:
	((INTEGER) ('.'|('e'|'E'))) => FLOAT
|	INTEGER
;

protected INTEGER: ('-')? (DIGIT)+ ;

protected FLOAT: (INTEGER) ('.' (DIGIT)+)? (('e'|'E') INTEGER)? ;

STRING
:	'"'
    (	options {
       		generateAmbigWarnings=false;
        }
    	: 	'\\' (WS)+ 
		|   ~('"')	
	)*
	'"'
;

protected DIGIT : ('0'..'9') ;

protected
WS2 :  (CNTRL |' '|'\r'|'\t')
    ;

WS3 : '\\' {$setType(Token.SKIP);}
    ;

WS  :  (WS2 |'\n' {newline();})
        {$setType(Token.SKIP);}
    ;

protected
CNTRL
    : '\u0000'..'\u0008'
    | '\u000B'..'\u000C'
    | '\u000E'..'\u001F'
    | '\u007F'..'\u00FF'
    ;

// Single-line comments
SL_COMMENT
    :   "//"
        (~('\n'|'\r'))* ('\n'|'\r'('\n')?)?
        {$setType(Token.SKIP); newline();}
    ;

// multiple-line comments
ML_COMMENT
    :   "/*"
        (   /*  '\r' '\n' can be matched in one alternative or by matching
                '\r' in one iteration and '\n' in another.  I am trying to
                handle any flavor of newline that comes in, but the language
                that allows both "\r\n" and "\r" and "\n" to all be valid
                newline is ambiguous.  Consequently, the resulting grammar
                must be ambiguous.  I'm shutting this warning off.
             */
            options {
                generateAmbigWarnings=false;
            }
        :
            { LA(2)!='/' }? '*'
        |   '\r' '\n'       {newline();}
        |   '\r'            {newline();}
        |   '\n'            {newline();}
        |   ~('*'|'\n'|'\r')
        )*
        "*/"
        {$setType(Token.SKIP);}
    ;

