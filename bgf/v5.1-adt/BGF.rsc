@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module \syntax::BGF

alias BGFProdList = list[BGFProduction];
alias BGFExprList = list[BGFExpression];
data BGFGrammar =
	grammar (list[str] roots, BGFProdList prods)
;

data BGFProduction =
	production (str label, str lhs, BGFExpression rhs)
;

data BGFExpression =
	  epsilon()
	| empty()
	| val(BGFValue v)
	| anything()
	| terminal(str t)
	| nonterminal(str t)
	| selectable(str selector, BGFExpression expr)
	| sequence(BGFExprList exprs)
	| choice(BGFExprList exprs)
	| allof(BGFExprList exprs)                              // to cover conjunctive grammars
	| marked(BGFExpression expr)
	| optional(BGFExpression expr)
	| not(BGFExpression expr)                               // to cover Boolean grammars
	| plus(BGFExpression expr)
	| star(BGFExpression expr)
	| seplistplus(BGFExpression expr, BGFExpression sep)
	| sepliststar(BGFExpression expr, BGFExpression sep)
;

data BGFValue = string() | integer();
