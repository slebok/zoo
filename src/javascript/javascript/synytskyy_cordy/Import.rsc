@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module javascript::javascript::synytskyy_cordy::Import

import grammarlab::io::Grammar;
import grammarlab::language::glue::Interpreter;
import IO;

void go()
{
	println("Start.");
	execute(|project://zoo/src/javascript/javascript/synytskyy_cordy/parse.glue|);
	println("Done.");
}