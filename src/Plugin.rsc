@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module Plugin

import IO;
import String;
import grammarlab::language::GLUE;
import framework::Traverse;

public void main()
{
	startGlue();
	//execute(|project://zoo/src/javascript/vdstorm/extract.glue|);
	traverseZoo();
}
