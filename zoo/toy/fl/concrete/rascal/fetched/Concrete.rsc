@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module Concrete

start syntax Program = prg: {Function "\n"}+ functions;
syntax Function = fun: Name f Name+ args "=" Expr body;
syntax Expr
	= binary: Expr lexpr Ops op Expr rexpr
	| apply: Name f Expr!apply+ vargs
	| ifThenElse: "if" Expr cond "then" Expr thenbranch "else" Expr elsebranch
	| bracket "(" Expr e ")"
	| argument: Name a
	| literal: Int i
	;

syntax Ops
	= minus: "-"
	| plus: "+"
	| equal: "=="
	;

lexical Name = [a-z]+ \ FLKwd !>> [a-z];
lexical Int = [0] | [1-9][0-9]* !>> [0-9] ;

layout LO = [\ \t]* !>> [\ \t];
keyword FLKwd = "if" | "then" | "else" ;
