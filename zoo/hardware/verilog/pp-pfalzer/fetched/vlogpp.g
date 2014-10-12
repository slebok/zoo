header {
//The MIT License
//
//Copyright (c) 2006-2010  Karl W. Pfalzer
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
package parser.v2k;
import	java.util.LinkedList;
}

class VlogppLexer extends Lexer;
options {
	k=2;
	charVocabulary='\u0000'..'\u00FF';
	testLiterals=false;
}
{
	//Embelish VlogppLexer class

	static void setPP(Preproc pp) {
		stPP = pp;
	}

	private static Preproc stPP = null;

	@Override
	public void uponEOF() throws TokenStreamException, CharStreamException {
		stPP.uponEOF();
	}

	private static String scrub2nl(String s) {
		String t = "";
		int i = 0;
		while (true) {
			i = s.indexOf("\n", i);
			if (0 <= i) {
				t += "\n";
				i++;
			} else {
				break; //while
			}
		}
		return t;
	}
}

TIC_DIRECTIVE
	:	'`' id:IDENT 
		(	{id.getText().equals("define")}? td:TIC_DEFINE 
				{
					String s = td.getText();
					if (Parser.stDumpDefn) {
						$setText("/*@DEFINE@ "+s+"*/");
					} else {
						String t = scrub2nl(s);
						$setText(t);
					}
				}
		|	{id.getText().equals("include")}? TIC_INCLUDE
		|	{id.getText().equals("protected")}? TIC_PROTECTED {$setType(Token.SKIP);}
		|	{id.getText().equals("timescale")}?  TIC_TIMESCALE	
				{$setType(Token.SKIP);}
		|	{id.getText().equals("ifdef")}? (WS)+ id5:IDENT	
				{stPP.ticIfdef(id5.getText()); $setType(Token.SKIP);}
		|	{id.getText().equals("ifndef")}? (WS)+ id7:IDENT	
				{stPP.ticIfndef(id7.getText()); $setType(Token.SKIP);}
		|	{id.getText().equals("elsif")}? (WS)+ id9:IDENT	
				{stPP.ticElsif(id9.getText()); $setType(Token.SKIP);}
		|	{id.getText().equals("else")}? 
				{stPP.ticElse(); $setType(Token.SKIP);}
		|	{id.getText().equals("endif")}?
				{stPP.ticEndif(); $setType(Token.SKIP);}
		|	{id.getText().equals("undef")}? (WS)+ id10:IDENT
				{stPP.undef(id10.getText()); $setType(Token.SKIP);}
		|	{id.getText().equals("celldefine")}? {$setType(Token.SKIP);}
		|	{id.getText().equals("endcelldefine")}? {$setType(Token.SKIP);}
		|	{id.getText().equals("default_nettype")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("begin_keywords")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("end_keywords")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("line")}?  id11:SKIP_DIRECTIVE2
				{	
					String txt = "`line "+id11.getText();
					$setText(txt);
					//$setType(Token.SKIP);
				}
		|	{id.getText().equals("unconnected_drive")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("nounconnected_drive")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("pragma")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("resetall")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("default_decay_time")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("default_trireg_strength")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("delay_mode_distributed")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("delay_mode_path")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("delay_mode_unit")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("delay_mode_zero")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("protect")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("endprotect")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("suppress_faults")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("enable_portfaults")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("disable_portfaults")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	{id.getText().equals("nosuppress_faults")}?  SKIP_DIRECTIVE
				{$setType(Token.SKIP);}
		|	MACRO_EXPAND[id.getText()] {$setType(Token.SKIP);}
		)
	;

protected
MACRO_EXPAND [String key]
options {ignore=WS;}
	:	{stPP.hasParams(key)}? MACRO_EXPAND_PARMS[key]
		|	//nothing follows
			{
				if (stPP.okToDefine(key)) {
					stPP.expandMacro(key);
				}
			}
	;

protected
MACRO_EXPAND_PARMS [String key]
options {ignore=WS;}
{
	LinkedList<String> parms = null;
}
	:	(WS)* '(' parms=MACRO_EXPAND_PARMS2 ')'
		{
			if (stPP.okToDefine(key)) {
				stPP.expandMacro(key, parms);
			}
		}
	;


protected
MACRO_EXPAND_PARMS2 returns [LinkedList<String> parms]
options {ignore=WS;}
{
	parms = new LinkedList<String>();
	String s = null;
	StringBuffer sbuf = new StringBuffer();
}
	:	(s1:PAREN_CLOSURE2 
			{	s = s1.getText();
				if (',' == s.charAt(0)) {
					if (0 < sbuf.length()) {
						parms.add(sbuf.toString());
					}
					sbuf = new StringBuffer();
				} else {
					sbuf.append(s);
				}
			}
		)* 
		{	if (0 < sbuf.length()) {
				parms.add(sbuf.toString());
			}
		}
	;

//Some closure rules for matching w/in macros
protected
PAREN_CLOSURE
options {ignore=WS;}
	:	'(' (PAREN_CLOSURE2)* ')'
	;

protected
PAREN_CLOSURE2
options {ignore=WS;}
	:	('{')=> CURLY_CLOSURE
	|	('"')=> STRING
	|	PAREN_CLOSURE
	|	~')'
	;

protected
CURLY_CLOSURE
options {ignore=WS;}
	:	'{' (CURLY_CLOSURE2)* '}'
	;

protected
CURLY_CLOSURE2
options {ignore=WS;}
	:	('(')=> PAREN_CLOSURE
	|	('"')=> STRING
	|	CURLY_CLOSURE
	|	~'}'
	;

IDENT 
	:	 ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'$'|'0'..'9')*
	;

    // string literals
STRING :
        '"' (~('"'|'\n'))* '"'
        ;

protected
UNSIZED_NUMBER :
	DIGIT (DIGIT | '_')*
        ;

protected
DIGIT :
        ('0'..'9')
        ;

//TODO: q&d: need to check units, etc.
protected
TIC_TIMESCALE
	:	(WS)+ TIMESCALE_VALUE (WS)* '/' (WS)* TIMESCALE_VALUE
	;

protected
TIMESCALE_VALUE
	:	UNSIZED_NUMBER (WS)* IDENT	
	;

protected
TIC_DEFINE
	:	(WS)+ id:IDENT 
			(	('(')=> TIC_DEFINE_PARMS[id.getText()]
			|	def:DEFINE
				{	
					stPP.addDefine(id.getText(), def.getText());
				}
			)
	;

protected
TIC_DEFINE_PARMS [String id]
{
	LinkedList<String> parms = new LinkedList<String>();
}
	:	'(' ((WS)* id2:IDENT {parms.add(id2.getText());}
			((WS)* ',' (WS)* id3:IDENT {parms.add(id3.getText());})*)? 
			(WS)* ')' def:DEFINE
		{
			stPP.addDefine(id, parms, def.getText());
		}
	;

protected
TIC_INCLUDE
	:	(WS)+ fn:STRING
		{	
			stPP.includeFile(fn.getText());
		}
	;

protected
DEFINE
	:	(	'\\' ('\r')? '\n' {newline();}
		|   ('"')=> STRING
		|	{LA(1) != EOF_CHAR}? ~('\\'|'\n'|'\r')
		)*
		('\r')? ('\n' {newline();})?
	;

WS  :  (CNTRL |' '|'\r'|'\t'|'\n' {newline();})
    ;

protected
CNTRL
	: '\u0000'..'\u0008'
	| '\u000B'..'\u000C'
	| '\u000E'..'\u001F'
	| '\u007F'..'\u00FF'
	;

// skip pre-processor to end of line
protected
SKIP_DIRECTIVE2
    :	(~('\n'|'\r'))*
	;

protected
SKIP_DIRECTIVE
    :	SKIP_DIRECTIVE2 ('\n'|'\r'('\n')?)?
        {newline();}
    ;

// Single-line comments
protected
SL_COMMENT
    :   "//"
        (~('\n'|'\r'))* ('\n'|'\r'('\n')?)?
        {newline();}
    ;

// protected: encrypted code
protected
TIC_PROTECTED
:	({LA(1) != '`'}? 	//TODO: leap of faith that ` is `endprotected
		(   '\r' '\n'       {newline();}
        |   '\r'            {newline();}
        |   '\n'            {newline();}
		|	~('\r'|'\n')
		)
	)+
	"`endprotected"	
;

// multiple-line comments
protected
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
    ;

COMMENT
{ Token tok = null;}
	:	(id:SL_COMMENT {tok=id;} | id2:ML_COMMENT {tok=id2;})
		{
			if (false == Parser.stShowComments) {
				String s = tok.getText();
				String t = scrub2nl(s);
				$setText(t);
			}
		}
	;

//all other valid chars
DUMMY: . ;	
