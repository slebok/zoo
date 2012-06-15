test:
	cp src.txt src.prepared.txt
	perl -pi -w -e 's/ ⟩/⟩/g;' src.prepared.txt
	../../recovery/hunter/hunter.py src.prepared.txt clafer.edd raw.bgf
	xbgf post-extract.xbgf raw.bgf clafer.bgf
	exbgf deyaccify.exbgf clafer.bgf ext.1.bgf
	exbgf beautify.exbgf ext.1.bgf ext.2.bgf
	cp ext.2.bgf clafer.bgf
	bgf2rsc clafer.bgf Clafer.rsc
	bgf2bnf clafer.bgf clafer.bnf

all:
	cp abs.manual.parser abs.prepared.1
	perl -pi -w -e 's/\/\//\n\/\//g;' abs.prepared.1
	grep -v // abs.prepared.1 > abs.prepared.2
	../../recovery/hunter/hunter.py abs.prepared.2 abs.edd raw.bgf
	../../mutation/naming/enforce.py l_ C! raw.bgf rename.xbgf
	xbgf rename.xbgf raw.bgf ext.1.bgf
	xsltproc --stringparam grammarname ABS ../../export/rascal/bgf2rsc-unsafe.xslt ext.1.bgf > ABS.rsc
	perl -pi -w -e 's/\./ //g;' ABS.rsc
	grep -v Error ABS.rsc > ABS3.rsc

clean:
	rm -f *prepared* raw.bgf ext*.bgf *.rsc *.bnf
