@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::GlueRunner

import IO;
import grammarlab::io::XBGF;
import List;
import String;
import framework::Types;
import framework::BackEnd;
import grammarlab::lib::Profiler;

import grammarlab::language::GLUE;
import grammarlab::language::glue::abstract::Top;
import grammarlab::io::GLUE;
import grammarlab::language::glue::Interpreter;
import grammarlab::language::GET;

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
	here = [d | loc d <- (framework::BackEnd::basedir + z.where).ls, d.extension == "glue", !startsWith(d.file,"_")];
	// TODO: sort GLUEs so that extract.glue happens before connect.glue etc
	// the following is a dirty hack
	here = reverse(sort(here));
	for(gfile <- here)
	{
		println("<z.where> HAS <gfile>");
		if (lastModified(gfile) > lastModified(gfile[file=replaceAll(gfile.file,".glue","ed/grammar.bgf")]))
		{
			glue = loadGlue(gfile);
			iprintln(glue);
			execute(glue);
		}
		else
			println("\tNo need for an update, skipped.");
	}
	GLUE glue = [];
	//expd
	//framework::BackEnd::basedir + z.where + d
	for (g <- {xs | xs:struct("grammar",kvs) <- z.meta, /keyvalue("toolused","xbgf") := kvs, /keyvalue("fileused",xbgf) := kvs, endsWith(xbgf,".xbgf")})
	{
		dir = txtbykey(g.inner,"dir");
		verb = endsWith(dir,"ed") ? replaceLast(dir,"ed","") : dir;
		src = txtbykey(g.inner,"derivedFrom");
		f = replaceLast(dir,"ed",".glue");
		println("Would have liked to fix <dir> in <z.where>");
		glue = [
			glaction(extract(
      			GETbgf(),
      			|home:///projects/webzoo-prep/zoo/<z.where>/<src>/grammar.bgf|))
      	];
		println("\t[read] <src>/grammar.bgf");
		for (keyvalue("fileused",xbgf) <- g.inner, endsWith(xbgf,".xbgf"))
		{
			println("\t[do] <xbgf>");
			glue += [grammarlab::language::glue::abstract::Top::xbgf(x) | x <- readXBGF(framework::BackEnd::basedir + z.where + xbgf)];
		}
		println("\t[write] <dir>/grammar.bgf");
		glue += glaction(export(
      			GETbgf(),
      			|home:///projects/webzoo-prep/zoo/<z.where>/<dir>/grammar.bgf|,
      			"Unknown"));
		//readXBGF(framework::BackEnd::basedir + z.where + xbgf);
		loc tgt = framework::BackEnd::basedir + "<z.where>/_<verb>.glue";
		writeGlue(glue, tgt);
		println("Written to <tgt>");
		/*
		[
  glaction(extract(
      GETrscs(),
      |home:///projects/webzoo-prep/zoo/markup/textual/csv/rascal/concrete/fetched/CSV.rsc|)),
  glaction(export(
      GETbgf(),
      |home:///projects/webzoo-prep/zoo/markup/textual/csv/rascal/concrete/extracted/grammar.bgf|,
      "Unknown")),
  glaction(export(
      GETbgf(),
      |home:///projects/webzoo-prep/zoo/markup/textual/csv/rascal/concrete/connected/grammar.bgf|,
      "Unknown"))
]
		*/
	}
}
