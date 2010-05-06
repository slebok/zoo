all:
	../../../../shared/tools/lll2bgf ../../../recovery/csharp/CSHARP1.0.LLL iso.bgf
	../../../../shared/tools/checkxml bgf iso.bgf
	../../../../shared/tools/checkbgf iso.bgf
	../../../../shared/tools/normbgf iso.bgf iso-cs-1-original.bgf
	../../../../shared/tools/lll2bgf ../../../recovery/csharp/grammars/Final.lll iso.bgf
	../../../../shared/tools/checkbgf iso.bgf
	../../../../shared/tools/normbgf iso.bgf iso-cs-1-browsable.bgf
	rm -f iso.bgf

clean:
	rm -f *.bgf

