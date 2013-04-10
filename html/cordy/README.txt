http://www.txl.ca/nresources.html:
 ↳  http://www.txl.ca/examples/Grammars/HTML/README.txt
   ↳  http://www.txl.ca/examples/Grammars/HTML/HTML.tar.gz

TXL 10.5 HTML Grammar

Jim Cordy and TXL forum member SomeDeveloper
Source Transformation Project
Queen's University
September 2007

Copyright 2007, James R. Cordy

Usage:  txl input.html > output.html

TXL 10.5 base grammar for processing HTML input files.
Tested on thousands of HTML source files from various websites.
This is not designed to be a syntax-checking grammar for HTML,
but rather a lightweight gramamr for conveniently supporting source
transofrmations of HTML.

While it's almost impossible to parse  arbitrarily malformed HTML,
this grammar does a good job on all well-formed files and most 
commonly broken ones.  Robust enough to parse almost every HTML file, 
and to accurately point out severe syntax errors in badly malformed ones.

Notes:	May require larger size (-s 100 or more) to resolve large
	or malformed pages.

Grammar extracted and added to the Grammar Zoo on 25 March 2013 by Vadim Zaytsev.
Examples from the original archive are not included.