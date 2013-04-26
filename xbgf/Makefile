include ../Makefile.language

sync:
	git log ../../../shared/xsd/xldf.xsd  | grep 'commit ' > hashes.lst
	./versions.py
