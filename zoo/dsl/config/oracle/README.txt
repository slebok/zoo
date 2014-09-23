http://www.harward.us/~nharward/
	http://www.harward.us/~nharward/antlr/OracleNetServicesV3.g

Copyright 2007 by Nathaniel Harward

 ANTLRv3 grammar for Oracle Network Services configuration files

 This grammar can parse entries in an Oracle Network Services configuration
 file (tnsnames.ora, listener.ora, sqlnet.ora, cman.ora, ldap.ora...), based
 on the Oracle 10g document:

 http://download-west.oracle.com/docs/cd/B19306_01/network.102/b14213/syntax.htm

 This grammar does not strictly conform to the document.  In paricular it does
 not enforce that parameters start at column 0, and that continuation lines do
 not start in column 0 -- whitespace is ignored (as are comments).  All other
 rules should be observed.

 The Oracle "spec" above is a little vague as a standalone language/syntax
 definition: I don't see how "NAMES.DIRECTORY_PATH= (TNSNAMES, ONAMES)" is
 valid since ',' is not listed as a delimiter.  Of course I might have just
 misunderstood the document :)  At any rate, if you come across valid syntax
 that this grammar does not allow please let me know so I can post a fix.


Grammar fetched to the Grammar Zoo on 23 Sep 2014 by Vadim Zaytsev.
