@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module syntax::BGF

data BGFGrammar =
	grammar (list[str] roots, list[BGFProduction] prods)
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
	| sequence(list[BGFExpression] exprs)
	| choice(list[BGFExpression] exprs)
	| marked(BGFExpression expr)
	| optional(BGFExpression expr)
	| plus(BGFExpression expr)
	| star(BGFExpression expr)
	| starsepplus(BGFExpression expr, BGFExpression sep)
	| starsepstar(BGFExpression expr, BGFExpression sep)
;

data BGFValue = string() | integer();
