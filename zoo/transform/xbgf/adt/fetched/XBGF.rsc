@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@wiki{XBGF}
module language::XBGF

import language::BGF;
import language::XScope;

alias XBGFSequence = list[XBGFCommand];

data XBGFCommand =
	  abridge(BGFProduction p)
	| abstractize(BGFProduction p) // marked
	| addH(BGFProduction p) // marked
	| addV(BGFProduction p)
	| addC(BGFProduction p) // conjunctive extension
	| anonymize(BGFProduction p) // marked
	| appear(BGFProduction p) // marked
	| bypass()
	| chain(BGFProduction p)
	| clone(str x, str y, XBGFScope w)
	| concatT(list[str] xs, str y, XBGFScope w)
	| concretize(BGFProduction p) // marked
	| deanonymize(BGFProduction p)
	| define(list[BGFProduction] ps)
	| designate(BGFProduction p)
	| detour(BGFProduction p)
	| deyaccify(str x)
	| disappear(BGFProduction p) // marked
	| distribute(XBGFScope w)
	| downgrade(BGFProduction p1,BGFProduction p2) // p1 is marked
	| eliminate(str x)
	| equate(str x, str y)
	| extract(BGFProduction p, XBGFScope w)
	| factor(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| fold(str x, XBGFScope w)
	| horizontal(XBGFScope w)
	| importG(list[BGFProduction] ps)
	| inject(BGFProduction p) // marked
	| inline(str x)
	| introduce(list[BGFProduction] ps)
	| iterate(BGFProduction p)
	| lassoc(BGFProduction p)
	| massage(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| narrow(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| permute(BGFProduction p)
	| project(BGFProduction p) // marked
	| rassoc(BGFProduction p)
	| redefine(list[BGFProduction] ps)
	| removeH(BGFProduction p) // marked
	| removeV(BGFProduction p)
	| renameL(str x, str y)
	| renameN(str x, str y)
	| renameS(str x, str y, XBGFScope w) // only inlabel(z)
	| renameT(str x, str y)
	| replace(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| reroot(list[str] xs)
	//| splitN(list[BGFProduction] ps, list[BGFProduction] qs, XBGFScope w)
	| splitN(str x, list[BGFProduction] ps, XBGFScope w)
	| splitT(str x, list[str] ys, XBGFScope w)
	| unchain(BGFProduction p)
	| undefine(list[str] xs)
	| unfold(str x, XBGFScope w)
	| unite(str x, str y)
	| unlabel(str x) // ???
	| upgrade(BGFProduction p1, BGFProduction p2) // p1 is marked
	| vertical(XBGFScope w)
	| widen(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| yaccify(list[BGFProduction] ps)
	// legacy
	| atomic(list[XBGFCommand] steps)
	| strip(str a)
;

