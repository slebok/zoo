http://www.antlr.org/grammar/list:
 ↳  http://www.antlr.org/grammar/ada

Oliver kellogg Mon Aug 4, 2003 12:43
By Oliver Kellogg. Tested on several Ada projects totalling a few ten thousand lines of code. Has tree construction. The parser and tree parser have successfully translated ACES, one of the large standard test suites for Ada compilers.

http://www.antlr.org/grammar/ada/README contents follow:

Last updated: 2003-08-03

The Ada tree structure (ada.g) and superclass (ada.tree.g) have
been tested somewhat due to work on a first real application,
Ada support in kdevelop (http://www.kdevelop.org)

suggestions on the tree structure are still
--

You can see the generated tree as follows:
Define an environment variable, ANTLR_TREE.
Then run the parser program, and redirect the output to a file.

Example in Bourne shell:

$ export ANTLR_TREE=1
$ ada my_ada_program.adb > adatree.tmp

This temporary output file will not be nicely readable because
everything is on a single line. You can get readable output using
the choptree script:

$ choptree adatree.tmp

If you want to additionally run the generated tree through the
AdaTreeParserSuper, then define the symbol ANTLR_TREE_WALK:

$ export ANTLR_TREE_WALK=1

This verifies that the tree produced by the AdaParser matches the
tree expected by the AdaTreeParserSuper.


