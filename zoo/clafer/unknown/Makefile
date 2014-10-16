extract:
	cp fetched/src.txt src.prepared.txt
	perl -pi -w -e 's/ ⟩/⟩/g;' src.prepared.txt
	${slpsdir}/topics/recovery/hunter/hunter.py src.prepared.txt clafer.edd raw.bgf
	xbgf post-extract.xbgf raw.bgf extracted/grammar.bgf
	# exbgf deyaccify.exbgf clafer.bgf ext.1.bgf
	# exbgf beautify.exbgf ext.1.bgf ext.2.bgf
	# cp ext.2.bgf clafer.bgf
	# # bgf2rsc clafer.bgf Clafer.rsc
	# bgf2bnf clafer.bgf clafer.bnf


clean:
	rm -f *prepared* raw.bgf ext*.bgf *.rsc *.bnf

include ../../Makefile.grammar