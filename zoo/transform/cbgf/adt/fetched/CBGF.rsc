@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@wiki{ΞBGF}
module language::CBGF

import language::BGF;
import language::XBGF;
import language::XScope;

alias CBGFSequence = list[CBGFCommand];

data CBGFCommand =
	  abridge_detour(BGFProduction p)
	| abstractize_concretize(BGFProduction p) // marked
	| addH_removeH(BGFProduction p) // marked
	| addV_removeV(BGFProduction p)
	| anonymize_deanonymize(BGFProduction p)
	| appear_disapper(BGFProduction p) // marked
	| chain_unchain(BGFProduction p)
	| clone_equate(str x, str y, XBGFScope w)
	| concatT_splitT(str y, list[str] xs, XBGFScope w)
	| concretize_abstractize(BGFProduction p) // marked
	| deanonymize_anonymize(BGFProduction p)
	| define_undefine(list[BGFProduction] ps)
	| designate_unlabel(BGFProduction p)
	| detour_abridge(BGFProduction p)
	| deyaccify_yaccify(list[BGFProduction] ps) //!!!
	| disappear_appear(BGFProduction p) // marked
	//| distribute_distribute(XBGFScope w)
	| downgrade_upgrade(BGFProduction p1,BGFProduction p2) // p1 is marked
	| eliminate_introduce(list[BGFProduction] ps) //!!!
	| equate_clone(str x, str y, XBGFScope w) //!!!
	| extract_inline(BGFProduction p, XBGFScope w)
	| factor_factor(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| fold_unfold(str x, XBGFScope w)
	| horizontal_vertical(XBGFScope w)
	//| importG(list[BGFProduction] ps)
	| inject_project(BGFProduction p) // marked
	| inline_extract(BGFProduction p, XBGFScope w) //!!!
	| introduce_eliminate(list[BGFProduction] ps)
	| iterate_assoc(BGFProduction p)
	| assoc_iterate(BGFProduction p)
	//| lassoc(BGFProduction p)
	| massage_massage(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| narrow_widen(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| permute_permute(BGFProduction p1, BGFProduction p2) //!!!
	| project_inject(BGFProduction p) // marked
	//| rassoc(BGFProduction p)
	| redefine_redefine(list[BGFProduction] ps1, list[BGFProduction] ps2)
	| removeH_addH(BGFProduction p) // marked
	| removeV_addV(BGFProduction p)
	| renameL_renameL(str x, str y)
	| renameN_renameN(str x, str y)
	| renameS_renameS(str x, str y, XBGFScope w) // only inlabel(z)
	| renameT_renameT(str x, str y)
	| replace_replace(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| reroot_reroot(list[str] xs1, list[str] xs2)
	//| splitN(list[BGFProduction] ps, list[BGFProduction] qs, XBGFScope w)
	| splitN_unite(str x, list[BGFProduction] ps, XBGFScope w)
	| splitT_concatT(str x, list[str] ys, XBGFScope w)
	| unchain_chain(BGFProduction p)
	| undefine_define(list[BGFProduction] ps)
	| unfold_fold(str x, XBGFScope w)
	| unite_splitN(str x, list[BGFProduction] ps, XBGFScope w) //!!!
	| unlabel_designate(BGFProduction p) // !!!
	| upgrade_downgrade(BGFProduction p1, BGFProduction p2) // p1 is marked
	| vertical_horizontal(XBGFScope w)
	| widen_narrow(BGFExpression e1, BGFExpression e2, XBGFScope w)
	| yaccify_deyaccify(list[BGFProduction] ps)
	// legacy
	//| atomic(list[XBGFCommand] steps)
	//| strip(str a)
;
