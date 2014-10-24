@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@wiki{negotiated transformation}
module language::XOutcome

import lib::Rascalware;
import language::BGF;
import language::XBGF;
import language::XScope;

data XBGFOutcome
	= ok()
	| problem(str msg)
	| problemXBGF(str msg, XBGFCommand xbgf)
	| problemProd(str msg, BGFProduction p)
	| problemProd2(str msg, BGFProduction p1, BGFProduction p2)
	| problemPinProds(str msg, BGFProduction p, list[BGFProduction] ps)
	| problemProds(str msg, list[BGFProduction] ps)
	| problemProds2(str msg, list[BGFProduction] ps1, list[BGFProduction] ps2)
	| problemExpr(str msg, BGFExpression e)
	| problemExpr2(str msg, BGFExpression e1, BGFExpression e2)
	| problemStr(str msg, str x)
	| problemStr2(str msg, str x, str y)
	| problemStrs(str msg, list[str] xs)
	| problemScope(str msg, XBGFScope w)
	;

alias XBGFResult = tuple[XBGFOutcome r,BGFGrammar g];

// basic operations on outcomes
public void thw(ok()) {}
public default void thw(XBGFOutcome x) {throw outcome2str(x);}

public void report(ok()) {println("No problems.");}
public default void report(XBGFOutcome x) {println(outcome2str(x)+"!");}

public str outcome2str(ok()) = "";
public str outcome2str(problem(str msg)) = msg;
public str outcome2str(problemXBGF(str msg, XBGFCommand xbgf)) = "<msg>:\n<xbgf>";
public str outcome2str(problemProd(str msg, BGFProduction p)) = "<msg>:\n<p>";
public str outcome2str(problemProd2(str msg, BGFProduction p1, BGFProduction p2)) = "<msg>:\n\t<p1>\nand\n\t<p2>";
public str outcome2str(problemPinProds(str msg, BGFProduction p, list[BGFProduction] ps)) = "<msg>\n\t<p>\nin\n\t<ps>";
public str outcome2str(problemProds(str msg, list[BGFProduction] ps)) = "<msg>:\n<ps>";
public str outcome2str(problemProds2(str msg, list[BGFProduction] ps1, list[BGFProduction] ps2)) = "<msg>:\n<ps1>\nvs\n<ps2>";
public str outcome2str(problemStr(str msg, str x)) = "<msg>: <x>";
public str outcome2str(problemStr2(str msg, str x, str y)) = "<msg>: <x> and <y>";
public str outcome2str(problemStrs(str msg, list[str] xs)) = "<msg>:\n\t<xs>";
public str outcome2str(problemExpr(str msg, BGFExpression e)) = "<msg>:\n\t<e>";
public str outcome2str(problemExpr2(str msg, BGFExpression e1, BGFExpression e2)) = "<msg>:\n<e1> and <e2>";
public str outcome2str(problemScope(str msg, XBGFScope w)) = "<msg> in <w>";
public default str outcome2str(XBGFOutcome x) = "Outcome not implemented: <x>";