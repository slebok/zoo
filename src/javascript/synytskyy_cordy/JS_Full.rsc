@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module javascript::synytskyy_cordy::JS_Full

extend javascript::synytskyy_cordy::JS_TXL;
extend lang::std::Layout;
//import lang::std::Whitespace;

import IO;
import ParseTree;

// js_hex_number "0[xX][0123456789abcdefABCDEF]+"
lexical HexNumber = [0][xX][0123456789abcdefABCDEF]+;
// number        "\d+(.\d*)?([eE][+-]?\d+)?" | ".\d+([eE][+-]?\d+)?"
lexical Number
	= [0-9]+ ([.] [0-9]*)? ([eE][+\-]? [0-9]+)?
	| [.] [0-9]+ ([eE][+\-]? [0-9]+)?
	;
// js_regexp     "/[(\\/)(\\^)(\\)(^/)#[/\n]]*/[(gi)(ig)gi]?m?g?\:[.,;}\)\]( \))        \n]"  
//                | "/[(\\/)(\\^)(\\\\)(^/)#[/\n]]*/[(gi)(ig)gi]?m?g?\:[.,;}\)\]	\n]"  
lexical RegExp
	= "/" ("\\/" | "\\^" | "\\" | "^/" | "#" | "/" | "\n")* "/"
		("gi" | "ig" | "g" | "i")? [m]? [g]? ":"
		[.,;})\]        \n]
	| "/" ("\\/" | "\\^" | "\\\\" | "^/" | "#" | "/" | "\n")* "/"
		("gi" | "ig" | "g" | "i")? [m]? [g]? ":"
		[.,;})\]	\n]
	;
lexical CharLit = [\'] ![\']* [\'];
lexical StringLit = [\"] ![\"]* [\"];
lexical Identifier = [0-9a-zA-Z_$]+ !>> [0-9a-zA-Z_$];

void do()
{
	println(parse(#start[Program],|project://zoo/src/javascript/test/ga.js|));
	println(parse(#start[Program],|project://zoo/src/javascript/test/jquery.clipboard.js|));
}