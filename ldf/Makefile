test:
	../../../shared/tools/xsd2bgf ../../../shared/xsd/ldf.xsd ldf.raw.bgf
	../../../shared/tools/xbgf fold-roles.xbgf ldf.raw.bgf ldf.1.bgf
	../../../shared/tools/xbgf fold-names.xbgf ldf.1.bgf ldf.2.bgf
	../../../shared/tools/xbgf fold-meta.xbgf ldf.2.bgf ldf.3.bgf
	../../../shared/tools/xbgf rename-types.xbgf ldf.3.bgf ldf.4.bgf
	../../../shared/tools/xbgf beautify.xbgf ldf.4.bgf ldf.final.bgf
	../../../shared/tools/bgf2bnf ldf.final.bgf ldf.final.bnf

clean:
	rm -f *~ ldf.*
