all:
	rm -fr bulk
	mkdir bulk
	find zoo/ -name 'extracted' > exts
	tools/mb.py
	sh runthis
	rm -f exts runthis
	chmod 644 bulk/*.bgf
	zip -9 bulk.zip bulk/*.bgf
