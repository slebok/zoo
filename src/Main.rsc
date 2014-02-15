@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module Main

import grammarlab::language::glue::Interpreter;
import grammarlab::language::GLUE;
//import grammarlab::language::glue::concrete::Top; //regGlue

import ParseTree;
import String;
import IO;

public void main()
{
	startGlue();
	execute(|project://zoo/src/javascript/vdstorm/extract.glue|);
	//traverseZoo();
}

public void traverseZoo()
{
	loc zoo = |project://zoo/src|;
	str plan = "", pgra = "";
	for (
		lan <- listEntries(zoo),
		gra <- listEntries(zoo+lan),
		gra != "test",
		glu <- listEntries(zoo+lan+gra),
		endsWith(glu,".glue")
	)
	{
		if (lan != plan)
		{
			println("Processing language <lan>...");
			plan = lan;
			println("  Processing grammar <gra>...");
			pgra = gra;
		}
		elseif (gra != pgra)
		{
			println("  Processing grammar <gra>...");
			pgra = gra;
		}
		println("    Executing <glu>...");
		execute(zoo+lan+gra+glu);
	}
}