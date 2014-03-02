@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::Traverse

import framework::Meta2XML;

import grammarlab::language::GLUE;
import grammarlab::io::GLUE;
import grammarlab::language::glue::Interpreter;

import String;
import IO;

public void traverseZoo()
{
	loc zoo = |project://zoo/src|;
	str plan = "", pgra = "", xml = "";
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
			xml += glue2xml(gluentity);
		}
	}
	writeFile(|home:///projects/webslps/_dev/zoo.add.xml|,xml);
}