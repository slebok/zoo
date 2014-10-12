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
package parser.v2k.preprocessor;
import  antlr.LexerSharedInputState;
import  java.io.FileReader;
import  java.io.Reader;
import	java.util.HashMap;
import  static parser.Utils.abnormalExit;
import  parser.v2k.preprocessor.antlrx.*;
}

//////////////////////////////////////////////////////////////////////////////////////
// BEGIN: lexer
//////////////////////////////////////////////////////////////////////////////////////
class PreprocLexer extends Lexer;
options {
	k=2;
	charVocabulary='\u0000'..'\u00FF';
	testLiterals=false;
}

tokens {
	MACRO_EXPANDED;
	TIC_MACRO;
	TIC_FILENM;
	TIC_LINENUM;
	TIC_BEGIN_KEYWORDS;
	TIC_CELLDEFINE;
	TIC_DEFAULT_NETTYPE;
	TIC_DEFINE;
	TIC_ELSE;
	TIC_ELSIF;
	TIC_END_KEYWORDS;
	TIC_ENDCELLDEFINE;
	TIC_ENDIF;
	TIC_ENDPROTECTED;
	TIC_IFDEF;
	TIC_IFNDEF;
	TIC_INCLUDE;
	TIC_LINE;
	TIC_NOUNCONNECTED_DRIVE;
	TIC_PRAGMA;
	TIC_PROTECTED;
	TIC_RESETALL;
	TIC_TIMESCALE;
	TIC_UNCONNECTED_DRIVE;
	TIC_UNDEF;
	TIC_UNDEFINEALL;
	TIC_DEFAULT_DECAY_TIME;
	TIC_DEFAULT_TRIREG_STRENGTH;
	TIC_DELAY_MODE_DISTRIBUTED;
	TIC_DELAY_MODE_PATH;
	TIC_DELAY_MODE_UNIT;
	TIC_DELAY_MODE_ZERO;
	TIC_PROTECT;
	TIC_ENDPROTECT;
	TIC_SUPPRESS_FAULTS;
	TIC_ENABLE_PORTFAULTS;
	TIC_DISENABLE_PORTFAULTS;
	TIC_NOSUPPRESS_FAULTS;
}

{
	private boolean m_expectFilename	= false;

	/**
	 * This method must be called to get tokens (not nextToken()).
	 */
	public Token getNextToken() throws TokenStreamException {
		return Helper.getTheOne().nextToken();
	}

    public boolean getExpectFilename() {
        return m_expectFilename;
    }
    
    void setExpectFilename(boolean val) {
        m_expectFilename = val;
    }
    
	private static int getTicCode(String txt) {
		Integer code = stTicCodes.get(txt);
		return (null == code) ? TIC_MACRO : code;
	}

	private Token processTicOp(Token tok) 
			throws RecognitionException, CharStreamException, TokenStreamException {
		String txt = tok.getText();
		return Helper.getTheOne().processTicOp(getTicCode(txt), txt);
	}

	private static final HashMap<String,Integer> stTicCodes = 
		new HashMap<String,Integer>();
	static {
		stTicCodes.put("__FILE__", new Integer(TIC_FILENM));
		stTicCodes.put("__LINE__", new Integer(TIC_LINENUM));
		stTicCodes.put("begin_keywords", new Integer(TIC_BEGIN_KEYWORDS));
		stTicCodes.put("celldefine", new Integer(TIC_CELLDEFINE));
		stTicCodes.put("default_nettype", new Integer(TIC_DEFAULT_NETTYPE));
		stTicCodes.put("define", new Integer(TIC_DEFINE));
		stTicCodes.put("else", new Integer(TIC_ELSE));
		stTicCodes.put("elsif", new Integer(TIC_ELSIF));
		stTicCodes.put("end_keywords", new Integer(TIC_END_KEYWORDS));
		stTicCodes.put("endcelldefine", new Integer(TIC_ENDCELLDEFINE));
		stTicCodes.put("endif", new Integer(TIC_ENDIF));
		stTicCodes.put("endprotected", new Integer(TIC_ENDPROTECTED));
		stTicCodes.put("ifdef", new Integer(TIC_IFDEF));
		stTicCodes.put("ifndef", new Integer(TIC_IFNDEF));
		stTicCodes.put("include", new Integer(TIC_INCLUDE));
		stTicCodes.put("line", new Integer(TIC_LINE));
		stTicCodes.put("nounconnected_drive", new Integer(TIC_NOUNCONNECTED_DRIVE));
		stTicCodes.put("pragma", new Integer(TIC_PRAGMA));
		stTicCodes.put("protected", new Integer(TIC_PROTECTED));
		stTicCodes.put("resetall", new Integer(TIC_RESETALL));
		stTicCodes.put("timescale", new Integer(TIC_TIMESCALE));
		stTicCodes.put("unconnected_drive", new Integer(TIC_UNCONNECTED_DRIVE));
		stTicCodes.put("undef", new Integer(TIC_UNDEF));
		stTicCodes.put("undefineall", new Integer(TIC_UNDEFINEALL));
		stTicCodes.put("default_decay_time", new Integer(TIC_DEFAULT_DECAY_TIME));
		stTicCodes.put("default_trireg_strength", new Integer(TIC_DEFAULT_TRIREG_STRENGTH));
		stTicCodes.put("delay_mode_distributed", new Integer(TIC_DELAY_MODE_DISTRIBUTED));
		stTicCodes.put("delay_mode_path", new Integer(TIC_DELAY_MODE_PATH));
		stTicCodes.put("delay_mode_unit", new Integer(TIC_DELAY_MODE_UNIT));
		stTicCodes.put("delay_mode_zero", new Integer(TIC_DELAY_MODE_ZERO));
		stTicCodes.put("protect", new Integer(TIC_PROTECT));
		stTicCodes.put("endprotect", new Integer(TIC_ENDPROTECT));
		stTicCodes.put("suppress_faults", new Integer(TIC_SUPPRESS_FAULTS));
		stTicCodes.put("enable_portfaults", new Integer(TIC_ENABLE_PORTFAULTS));
		stTicCodes.put("disable_portfaults", new Integer(TIC_DISENABLE_PORTFAULTS));
		stTicCodes.put("nosuppress_faults", new Integer(TIC_NOSUPPRESS_FAULTS));
	}
}

LPAREN:	'(' ;
RPAREN:	')' ;
LBRACK: '[' ;
RBRACK: ']' ;
LCURLY: '{' ;
RCURLY: '}' ;
EQ    : '=' ;
COMMA : ',' ;

TIC_DIRECTIVE
:	'`' id:IDENT 
		{ Token tok = processTicOp(id); 
		  $setType(tok.getType());
		  $setText(tok.getText());
		}
;

IDENT 
	:	 ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'$'|'0'..'9')*
	;

    // string literals
STRING :
        '"' (~('"'|'\r'|'\n'))* '"'
        ;

IMPL_FILENAME
//Predicate, since macro text could contain << like op
:	{getExpectFilename()}? '<' (~'>')+ '>'
;

//TODO: UNSIZED_NUMBER & DIGIT are not used, so remove
protected
UNSIZED_NUMBER :
	DIGIT (DIGIT | '_')*
        ;

protected
DIGIT :
        ('0'..'9')
        ;

ESC_NL
:	'\\' NL
;

WS  
:	(CNTRL |' '|'\t')
;

NL
:	('\n' | '\r'('\n')?)
    {	newline(); }
;

protected
CNTRL
	: '\u0000'..'\u0008'
	| '\u000B'..'\u000C'
	| '\u000E'..'\u001F'
	| '\u007F'..'\u00FF'
	;

// Single-line comments
protected
SL_COMMENT
    :   "//"
        (~('\n'|'\r'))* (NL)?
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
        |   NL
        |   ~('*'|'\n'|'\r')
        )*
        "*/"
    ;

COMMENT
{ Token tok = null;}
	:	(id:SL_COMMENT {tok=id;} | id2:ML_COMMENT {tok=id2;})
	;

//all other valid chars
DUMMY: . ;	
