@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::Traverse

import framework::Meta2XML;
import framework::ZooTree;

import grammarlab::language::glue::abstract::Top;
import grammarlab::language::GLUE;
import grammarlab::io::GLUE;
import grammarlab::language::glue::Interpreter;

import String;
import IO;

public void traverseZoo()
{
	Zoo ztree = [];
	loc zoo = |project://zoo/src|;
	str plan = "", pgra = "";
	list[str] xml = [];
	for (lan <- listEntries(zoo), isDirectory(zoo+lan), lan != "framework")
	{
		ilan = loadGlue(zoo+lan+"info.glue");
		ZooLanguage zlan = zlanguage(getProp("name",ilan), getProp("short",ilan), []);
		if(zlan.short=="") zlan.short = zlan.name;
		println("Processing language <zlan.name>...");
		for (ver  <- listEntries(zoo+lan), isDirectory(zoo+lan+ver))
		{
			iver = loadGlue(zoo+lan+ver+"info.glue");
			ZooVersion zver = zversion(getProp("name",iver), getProp("short",iver), []);
			if(zver.short=="") zver.short = zver.name;
			println("  Processing version <zver.name>...");
			for (
				gra <- listEntries(zoo+lan+ver),
				isDirectory(zoo+lan+ver+gra),
				gra != "test",
				glu <- listEntries(zoo+lan+ver+gra),
				endsWith(glu,".glue")
			)
			{
				iglu = loadGlue(zoo+lan+ver+gra+glu);
				ZooGrammar zgra = zgrammar(getProp("title",iglu), lan+ver+gra, [], iglu);
				println("    Processing grammar <zgra.name>...");
				//println(gluentity);
				//visGlue(zoo+lan+gra+glu);
				//execute(gluentity);
				//xml += glue2xml(gluentity);
				zver.gs += [zgra];
			}
			zlan.vs += [zver];
		}
		ztree += zlan;
	}
	//writeFile(|home:///projects/webslps/_dev/zoo.add.xml|,xmlfile(xml));
	iprintln(ztree);
	println(zoo2xml(ztree));
}