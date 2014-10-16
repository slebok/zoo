http://www.cse.chalmers.se/~hallgren/CactusExample/

The Haskell 98 grammar in Cactus

Here is an example of how to write grammar files for Cactus.

The grammar used in this example is the grammar of Haskell 98, as given in Appendix B.4 of The Haskell 98 Report.

My main goal when creating this Cactus representation of the Haskell grammar was to follow the grammar in the report as closely as possible. (Put the Cactus file and grammar in the Haskell Report side by side and compare!). The idea is that simple visual inspection of the grammar, together with correct implementation of the parser generator tools, should be enough to obtain a Haskell parser that is ensured to be correct with respect to the Haskell Report.

Files

Cactus produces the following files (and some more):
HaskellParser.y, parser specification for Happy.
HaskellLexer.x, lexer specification for Alex,
Note that the generated files as surprisingly readable!
Cactus can also produce output for flex, yacc and C.

Shortcomings

Haskell's layout rules have been ignored.
The support for Unicode in the Haskell syntax has been ignored.
The special identifiers "as", "hiding" and "qualified" are treated as reserved keywords (but this is simple to fix).
Nested comments have been ignored.
The Haskell grammar in report is not an LR grammar. As a result, the Happy translation of the Cactus grammar contains a number of conflicts, some of which have been solved by adding precedence specification to the grammar. (Some of these conflicts may be caused by the way Cactus translates EBNF to BNF, but others are inherent in the Haskell grammar. I think the right solution to this, rather than manually rewriting and obscuring the grammar, is to use more powerful parsing techniques, such as nondeterministic LR parsing...)
Thomas Hallgren
(March, 2002) (some notes added in June 2003)

Grammar in a broad sense fetched on 16 October 2014 by Vadim Zaytsev, http://grammarware.net
