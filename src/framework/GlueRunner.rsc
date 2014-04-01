@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::GlueRunner

import IO;
import List;
import String;
import framework::Types;
import framework::BackEnd;
import grammarlab::lib::Profiler;

import grammarlab::language::GLUE;
import grammarlab::io::GLUE;
import grammarlab::language::glue::Interpreter;

void gmain()
{
	X = startTheClock();
	visit(traversebase())
	{
		case z:zentry(str where, list[ZooValue] meta, _):
		{
			listGlues(z);
		}
	}
	println("Running time: <formatDuration(X)>");
}

void listGlues(ZooEntry z)
{
	for(gfile <- [d | loc d <- (framework::BackEnd::basedir + z.where).ls, d.extension == "glue"])
	{
		println("<z.where> HAS <gfile>");
		if (lastModified(gfile) > lastModified(gfile[file=replaceAll(gfile.file,".glue","ed/grammar.bgf")]))
		{
			glue = loadGlue(gfile);
			execute(glue);
		}
		else
			println("\tNo need for an update, skipped.");
	}
}
