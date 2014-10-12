header {
/*
#  The MIT License
# 
#  Copyright 2006-2010 Karl W. Pfalzer.
#  Copyright 2012-     George P. Burdell.
# 
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
# 
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
# 
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
*/
package nldb.parser;
import  java.util.List;
import  java.util.LinkedList;
import  nldb.*;
import static nldb.Util.invariant;
import static nldb.Util.error;
import static nldb.Util.warn;
}
options {
    language="Java";
}

class VnlParser extends Parser;
options {
    k=2;
}
{
    private static Library stWorkLib = Library.getWorkLib();

	@Override
    public void reportError(RecognitionException ex) {
        String m = ex.getMessage();
        if (null == m) {m = "unknown parse error";}
        error("PARSE-1", ex.getFilename(), ex.getLine(), ex.getColumn(), m);
    }

	@Override
    public void reportError(String s) {
        error("PARSE-2", s);
    }

	@Override
    public void reportWarning(String s) {
		warn("PARSE-2", s);
    }

public void start() {
try {
    source_text();
}
catch (RecognitionException re) {
error("PARSE-2", re.toString());
}
catch (TokenStreamException re) {
error("PARSE-2", re.toString());  
}
}
}

//A.1.2 Verilog source text
source_text
:   (description)*
        EOF
;

description
:   module_declaration
;

module_declaration
{ String mid=null; List<String> lopd=null; Module mod=null;}
:   "module" mid=module_identifier (lopd=list_of_ports)? SEMI
            {	mod = new Module(mid,lopd);
				if (!stWorkLib.add(mod)) {
					error("DEFN-1", mid);
				}
			}
        (module_item[mod])*
        "endmodule"
;

list_of_ports returns [List<String> lop]
{ lop = null;}
:   LPAREN (lop=list_of_port_identifiers)? RPAREN
;

module_item[Module mod]
:   port_declaration[mod]
|   (assign_statement[mod])=> assign_statement[mod]
|   net_declaration[mod]
|   module_instantiation[mod]
;

port_declaration[Module mod]
{List<String> lop=null; Range rng=null; int dir=LA(1);}
:   ("inout"|"input"|"output") (rng=range)? lop=list_of_port_identifiers
        {
            Port.EDir pdir=null;
            switch (dir) {
                case VnlParserTokenTypes.LITERAL_input:
                    pdir = Port.EDir.eIn; break;
                case VnlParserTokenTypes.LITERAL_inout:
                    pdir = Port.EDir.eInout; break;
                case VnlParserTokenTypes.LITERAL_output:
                    pdir = Port.EDir.eOut; break;
                default:
                    invariant(false);
            }
            mod.portDecl(pdir,rng,lop);
        }
        SEMI
;

list_of_port_identifiers returns [List<String> lopd]
{ lopd=new LinkedList<String>(); String id=null;}
:   id=port_identifier              {lopd.add(id);}
        (COMMA id=port_identifier   {lopd.add(id);} )*
;

list_of_net_identifiers returns [List<String> lon]
{ lon = new LinkedList<String>(); String id=null;}
:   id=net_identifier				{lon.add(id);}
		(COMMA id=net_identifier	{lon.add(id);})*
;

net_declaration[Module mod]
{Range rng=null; List<String> lon;}
:   "wire" (rng=range)? lon=list_of_net_identifiers
        SEMI {mod.netDecl(rng, lon);}
;

range returns [Range rng]
{rng=null;}
:   LBRACK rng=constant_range_expression RBRACK
;

module_instantiation[Module mod]
{ String ref=null;}
:   ref=module_identifier
		(parameter_instance)?
        module_instance[mod,ref]
        (COMMA module_instance[mod,ref])*
        SEMI
;

module_instance[Module mod, String ref]
{String inst=null; Cell cell=null;}
:    inst=module_instance_identifier
            {cell = mod.createCell(ref,inst);}
        LPAREN (list_of_port_connections[cell])? RPAREN
;

//NOTE: Put here so we can process xilinx netlists
//but we throw it out.
parameter_instance
:	POUND LPAREN parameter_instance_ele (COMMA parameter_instance_ele)* RPAREN
;

parameter_instance_ele
{ Expression unused=null;}
:	DOT IDENT LPAREN unused=expression RPAREN
|	unused=expression
;

list_of_port_connections[Cell cell]
{PortConnection pc=null;}
:   pc=ordered_port_connection            {cell.addConn(pc);}
        (COMMA pc=ordered_port_connection {cell.addConn(pc);})*
|   pc=named_port_connection              {cell.addConn(pc);}
        (COMMA pc=named_port_connection   {cell.addConn(pc);})*
;

ordered_port_connection returns [PortConnection pc]
{Expression expr=null; pc=null;}
:   expr=expression
        {pc = new PortConnection(expr);}
;

named_port_connection returns [PortConnection pc]
{String id=null; Expression expr=null; pc=null;}
:   DOT id=port_identifier (LPAREN (expr=expression)? RPAREN)?
        {pc = new PortConnection(id,expr);}
;

concatenation returns [Concat cc]
{ cc=null; Expression expr=null;
  List<Expression> exprs = new LinkedList<Expression>();}
:   LCURLY expr=expression      {exprs.add(expr);}
        (COMMA expr=expression  {exprs.add(expr);} )*
        RCURLY                  {cc = new Concat(exprs);}
;

multiple_concatenation returns [MultipleConcat mc]
{ mc=null; Expression expr=null; Concat cc=null;}
:   LCURLY expr=constant_expression cc=concatenation RCURLY
        {mc = new MultipleConcat(expr,cc);}
;

constant_expression returns [Expression expr]
{expr=null;}
:   expr=expression
;

constant_range_expression returns [Range rng]
{rng=null; Vnumber lb=null, rb=null;}
:   lb=number COLON rb=number
        {rng = new Range(lb,rb);}
;

assign_statement[Module mod]
{ String id=null; Range rng=null; Expression expr=null;}
:   ("wire" | "assign") id=net_identifier (rng=part_select)? 
		ASSIGN expr=expression SEMI
			{mod.addAssign(new Assign(id,rng,expr));}
;

expression returns [Expression expr]
{expr=null; Primary pr=null;}
:   pr=primary
        {expr = new Expression(pr);}
;

part_select returns [Range rng]
{rng=null; Vnumber lb=null, rb=null;}
:   LBRACK lb=number (COLON rb=number)? RBRACK
        {rng = new Range(lb,rb);}
;

primary returns [Primary prim]
{ prim=null; Vnumber vn=null; String id=null; Range rng=null;
  MultipleConcat mc=null; Concat cc=null; Expression expr=null;}
:   vn=number
        {prim = new Primary(vn);}
|   id=identifier (rng=part_select)?
        {prim = new Primary(id,rng);}
|   (multiple_concatenation)=> mc=multiple_concatenation
        {prim = new Primary(mc);}
|   cc=concatenation
        {prim = new Primary(cc);}
|   LPAREN expr=expression RPAREN
        {prim = new Primary(expr);}
;

//A.8.7 Numbers
number returns [Vnumber n]
{n=null;}
:   id:NUMBER
        {n = new Vnumber(id.getText());}
;

identifier returns [String nm]
{ nm=null;}
:   id1:IDENT           {nm = id1.getText();}
|   id2:ESCAPED_IDENT   {nm = id2.getText();}
;

module_identifier returns [String nm]
{ nm=null; Token la1 = LT(1);}
:   (   ("and"|"nand"|"nor"|"or"|"xor"|"xnor")
            {nm = la1.getText();}
    |   nm=identifier
    )
;

module_instance_identifier returns [String nm]
{ nm=null; }
:   nm=identifier
;

net_identifier returns [String nm]
{ nm=null; }
:   nm=identifier
;

port_identifier returns [String nm]
{ nm=null; }
:   nm=identifier
;

class VnlLexer extends Lexer;
options {
    k=2;
    charVocabulary='\u0000'..'\u00FF';
    testLiterals=false;
}

  // Operators
COLON       : ':'   ;
COMMA       : ','   ;
DOT         : '.'   ;
ASSIGN      : '='   ;
LBRACK      : '['   ;
RBRACK      : ']'   ;
LCURLY      : '{'   ;
RCURLY      : '}'   ;
LPAREN      : '('   ;
RPAREN      : ')'   ;
POUND		: '#'	;
SEMI        : ';'   ;

IDENT
    options {testLiterals=true;}
    :    ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'$'|'0'..'9')*
    ;

ESCAPED_IDENT :
        '\\' (~ (' '|'\r'|'\t'|'\n'))+
        ;

   // a numeric literal
NUMBER :
    ( (SIZE (WS)*)? BASE (WS)* SIZED_DIGIT ) => SIZED_NUMBER
    | UNSIZED_NUMBER
    ;

protected
SIZED_NUMBER :
    (SIZE (WS)*)? BASE (WS)* SIZED_DIGIT (SIZED_DIGIT | '_')*
    ;

protected
SIZE :
    (DIGIT)+
    ;

protected
BASE :
    '\'' ( 'd' | 'D' | 'h' | 'H' | 'o' | 'O' | 'b' | 'B' )
    ;

protected
SIZED_DIGIT :
    DIGIT | HEXDIGIT
    ;

protected
UNSIZED_NUMBER :
    DIGIT (DIGIT | '_')*
        ;

protected
DIGIT :
        ('0'..'9')
        ;

protected
HEXDIGIT :
        ('A'..'F'|'a'..'f')
        ;

protected
WS2 :  (CNTRL |' '|'\r'|'\t')
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

