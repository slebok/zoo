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

Examples, grammar/prettyprinter:	

	txl Examples/index.html
	txl Examples/nlearn.html
	txl Examples/nresources.html

	txl MalformedExamples/index.html
	txl MalformedExamples/nlearn.html
	txl MalformedExamples/nresources.html

Report problems to cordy@cs.queensu.ca

(In answer to the obvious question, the reason browsers have 
no trouble parsing HTML when it's so difficult to parse is: 
they don't parse!) 
