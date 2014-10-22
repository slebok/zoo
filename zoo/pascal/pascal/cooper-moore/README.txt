http://www.thefreecountry.com/sourcecode/grammars.shtml
	http://www.moorecad.com/standardpascal/yacclex.html

101 Uses for a Yacc

A parser generator such as Yacc/lex is how you get the front end of a compiler out quickly. It takes a description of the language, and gives you a C program (yes, I know, where is the Pascal generation version) that parses an input Pascal program and passes this information to the back end, the intermediate or direct machine code encoder.

Thats the good news. The bad news is that it leaves the major part of the compiler, the semantics, undone.

However, there are many reasons you might want to use a generated front end:  
	Cross reference generator
	Language translator
	Prettyprinter
	Or, you might want to actually build a compiler.

pascal.y    Contains the yacc parser generator specification.
pascal.l    Contains the lex scanner generator specification.

Pascal grammar in Yacc format, based originally on BNF given
in "Standard Pascal -- User Reference Manual", by Doug Cooper.
This in turn is the BNF given by the ANSI and ISO Pascal standards,
and so, is PUBLIC DOMAIN. The grammar is for ISO Level 0 Pascal.
The grammar has been massaged somewhat to make it LALR, and added
the following extensions.
	constant expressions
	otherwise statement in a case
	productions to correctly match else's with if's
	beginnings of a separate compilation facility

Grammar in a broad sense fetched automatically on 23 October 2014 by Vadim Zaytsev, http://grammarware.net
