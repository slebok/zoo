replicate:

again:
	# cat ABS.parser | sed 's/[A-Za-z]* \([a-z_]*\) =$/\1 =/' > abs.prepared.0
	cp abs.prepared.0 abs.prepared.1
	perl -pi -w -e 's/\/\//\n\/\//g;' abs.prepared.1
	grep -v // abs.prepared.1 > abs.prepared.2
	../../recovery/hunter/hunter.py abs.prepared.2 abs.edd raw.bgf
	../../mutation/naming/enforce.py l_ C! raw.bgf rename.xbgf
	xbgf rename.xbgf raw.bgf ext.1.bgf
	xsltproc --stringparam grammarname ABS ../../export/rascal/bgf2rsc-unsafe.xslt ext.1.bgf > ABS.rsc
	perl -pi -w -e 's/\./ //g;' ABS.rsc
	grep -v Error ABS.rsc > ABS3.rsc

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
	rm -f *prepared* raw.bgf ext*.bgf rename.xbgf *.rsc

include ../../../Makefile.grammar