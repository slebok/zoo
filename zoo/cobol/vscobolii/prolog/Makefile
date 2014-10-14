extract:
	cat fetched/ibm-transformed.pl | grep -v 'terminal("' > prepared.pl
	perl -pi -w -e 's/@\(\"/`/g;' prepared.pl
	perl -pi -w -e 's/\"\)/`/g;' prepared.pl
	perl -pi -w -e 's/-->/::=/g;' prepared.pl
	perl -pi -w -e 's/;/|/g;' prepared.pl
	perl -pi -w -e 's/,//g;' prepared.pl
	perl -pi -w -e 's/#//g;' prepared.pl
	perl -pi -w -e 's/!//g;' prepared.pl
	perl -pi -w -e 's/`/"/g;' prepared.pl
	perl -pi -w -e 's/\./;/g;' prepared.pl
	echo 'importG' > _import.glue
	cat prepared.pl >> _import.glue
	echo '.' >> _import.glue
	rm prepared.pl

fetch:
	cp ${slpsdir}/topics/recovery/grk/grammars/vscobolii/ibm-transformed.pl fetched/

include ../../../Makefile.grammar