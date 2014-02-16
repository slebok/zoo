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
	execute(|project://zoo/src/javascript/vdstorm/extract.glue|);
	//traverseZoo();
}

public void traverseZoo()
{
	loc zoo = |project://zoo/src|;
	str plan = "", pgra = "";
	for (lan <- listEntries(zoo), isDirectory(zoo+lan))
	{
		ilan = loadGlue(zoo+lan+"info.glue");
		println(ilan);
		for (
			gra <- listEntries(zoo+lan),
			isDirectory(zoo+lan+gra),
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
			gluentity = loadGlue(zoo+lan+gra+glu);
			println(gluentity);
			visGlue(zoo+lan+gra+glu);
			execute(gluentity);
		}
	}
}