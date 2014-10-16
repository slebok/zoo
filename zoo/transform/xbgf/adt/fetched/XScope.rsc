@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@wiki{scope}
module language::XScope

data XBGFScope =
	globally()
	| nowhere()
	| inlabel(str l)
	| notinlabel(str l)
	| innt(str x)
	| notinnt(str x)
	| comboscope(XBGFScope w1, XBGFScope w2)
;
