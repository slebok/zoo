@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module Main

import grammarlab::language::GLUE;

import ParseTree;

public void main()
{
	//grammarlab::language::GLUE::go();
	Tree t = char(0);
	try
		t = getGlue(|project://zoo/src/javascript/synytskyy_cordy/parse.glue|);
	catch ParseError:
		println("Ungrammatical!");
	if (/amb(_) := t)
		println("Ambiguous!");
	else
		regGlue();
}