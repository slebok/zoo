@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module Plugin

import grammarlab::language::GLUE;
import grammarlab::io::GLUE;
import grammarlab::language::glue::concrete::Top;
import grammarlab::language::glue::Interpreter;

import ParseTree;
import String;
import IO;

public void main()
{
	startGlue();
	//execute(|project://zoo/src/javascript/vdstorm/extract.glue|);
	traverseZoo();
}
