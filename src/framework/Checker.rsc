@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::Checker

import IO;
import List;
import framework::Types;
import framework::BackEnd;
import grammarlab::lib::Profiler;

void cmain()
{
	X = startTheClock();
	visit(traversebase())
	{
		case z:zentry(str where, list[ZooValue] meta, _):
		{
			validateReadmes(z);
			validateContents(z);
			validateGrammars(z);
			validateOfs(z);
		}
	}
	println("Running time: <formatDuration(X)>");
}

void validateReadmes(ZooEntry z)
{
	here = exists(framework::BackEnd::basedir + z.where + "/README.txt");
	refd = flag("readme") in z.meta;
	if (!here && refd)
		println("README broken in <z.where>");
	elseif (here && !refd)
		println("README forgotten in <z.where>");
	//elseif (here && refd)
	//	println("README validated in <z.where>");
}

void validateContents(ZooEntry z)
{
	here = [d | loc d <- (framework::BackEnd::basedir + z.where).ls, isDirectory(d)];
	refd = [framework::BackEnd::basedir + z.where + d | xs:struct("contents",kvs) <- z.meta, keyvalue("dir",d) <- kvs];
	if (isEmpty(refd))
	{
		//println("DIRs not explicit in <z.where>");
		return;
	}
	for (loc x <- here, x notin refd)
		println("DIR <x.path> forgotten in <z.where>");
	for (loc x <- refd, x notin here)
		println("DIR <x.path> broken in <z.where>");
	//for (loc x <- refd, x in here)
	//	println("DIR <x.path> validated in <z.where>");
}

void validateGrammars(ZooEntry z)
{
	here = [d | loc d <- (framework::BackEnd::basedir + z.where).ls, isDirectory(d)];
	refd = [framework::BackEnd::basedir + z.where + d | xs:struct("grammar",kvs) <- z.meta, keyvalue("dir",d) <- kvs];
	if (isEmpty(refd)) return;
	for (loc x <- here, x notin refd)
		println("GRAMMAR <x.file> forgotten in <z.where>");
	for (loc x <- refd, x notin here)
		println("GRAMMAR <x.file> broken in <z.where>");
	for (loc x <- refd, x in here)
		if (x.ls == [])
			println("GRAMMAR <x.file> empty in <z.where>");
		//else
		//	println("GRAMMAR <x.file> validated in <z.where>");
}

void validateOfs(ZooEntry z)
{
	for (struct("grammar",L) <- z.meta)
	{
		dir = txtbykey(L,"dir");
		of =  txtbykey(L,"of");
		if (dir != "fetched" && of == "")
			println("At <z.where>, <dir> is a grammar OF WHAT?");
	}
}