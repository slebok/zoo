module XBGFSyntax

alias XBGFSequence = list[XBGFCommand];

data XBGFCommand =
	  abridge(BGFProduction p)
	| abstractize(BGFProduction p) // marked
	| addV(BGFProduction p)
	| narrow(BGFExpression e1, BGFExpression e2, BGFContext w)
	| replace(BGFExpression e1, BGFExpression e2, BGFContext w)
	| yaccify(BGFProduction p1, BGFProduction p2)
;

data BGFContext =
	globally()
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
