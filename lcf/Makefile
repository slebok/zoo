include ../Makefile.language

sync:
	git log ../../../shared/xsd/lcf.xsd  | grep 'commit ' > hashes.lst
	./versions.py
