@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module Abstract

data FLPrg = prg(list[FLFun] fs);
data FLFun = fun(str f, list[str] args, FLExpr body);
data FLExpr
	= binary(FLExpr e1, FLOp op, FLExpr e2)
	| apply(str f, list[FLExpr] vargs)
	| ifThenElse(FLExpr c, FLExpr t, FLExpr e)
	| argument(str a)
	| literal(int i)
	;
data FLOp = minus() | plus() | equal();

