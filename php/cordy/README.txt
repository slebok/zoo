http://www.txl.ca/nresources.html:
 ↳  http://www.txl.ca/examples/Grammars/PHP/README.txt
   ↳  http://www.txl.ca/examples/Grammars/PHP/PHP345.tar.gz

TXL Grammar for PHP 3,4,5
J.R. Cordy, Queen's University, June 2007
Version 1.0, July 2011

After the SDF PHP grammar by Eric Bouwers and Martin Bravenboer in PhpFront
http://www.program-transformation.org/PHP/PhpFront

This is an analysis grammar for PHP versions 3,4 and 5 derived from the 
source above. It has been tested on several thousand examples from open source 
PHP applications including the entire Moodle source, but may still fail on
severely malformed examples.

Known limitations and bugs:

1. This grammar is known to fail on examples where HTML is interspersed in
   the middle of PHP statements.  This would be difficult to fix.
   Recommended workaround: edit to move split to statement boundary.

2. This grammar is intended primarily for analysis tasks and has not yet 
   been tuned for high fidelity transformations.  In particular it does not 
   yet offer the option of preserving comments and formatting.

3. PHP has the strange property that keywords are case insensitive but 
   variable names are not.  This grammar approximates this by ignoring case, 
   which may cause problems when transforming variables.  If the strict 
   PHP rule is required, use phpkw.txl as a preprocessor to normalize the
   keywords in the PHP source, and then use this grammar with -nocase to
   do case-sensitive processing.

---
Rev 27.7.11

See PHP345/README.txt for the original unchanged read me file.
Grammar extracted and added to the Grammar Zoo on 30 March 2013 by Vadim Zaytsev.
