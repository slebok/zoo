@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::BackEnd

import IO;
import Set;
import List;
import String;
import lang::xml::DOM;
import framework::Types;

loc basedir = |home:///projects/webzoo-prep/zoo/|;
str gitbasedir = "https://github.com/grammarware/zoo/tree/master/zoo/";
str gitbasefile = "https://github.com/grammarware/zoo/blob/master/zoo/";

str shortenpath(loc x) = replaceFirst(x.path, basedir.path, "");

public str countSize(ZooEntry z)
	= "<size({ez | /ez:zentry(_, list[ZooValue] meta, _) <- z, /struct("grammar",_) := ez.meta})> (<size([1 | /struct("grammar",_) <- z])>)";

ZooValue xml2zooval(Node e)
{
	if (element(_, _, _ ) !:= e) return zerror();
	if ([] := e.children)
		return flag(e.name);
	elseif ([charData(str v)] := e.children)
		return keyvalue(e.name,v);
	else
		return struct(e.name, [xml2zooval(ie) | ie:element(_, _, _ ) <- e.children]);
	//println("<ind>--\> found <n> as <children>");
	return zerror();
}

public ZooEntry traverse(str ind, loc x)
{
	ZooEntry ze = zentry(shortenpath(x), [], []);
	if(!isDirectory(x)) return noentry(shortenpath(x));
	bool good = exists(x+"zoo.xml");
	println("<ind>Processing <x>...<if(good){> ZOO!<}>");
	if (!good) return noentry(shortenpath(x));
	entry = parseXMLDOMTrim(readFile(x+"zoo.xml"));
	ze.meta = xml2zooval(entry.root).inner;
	println("<ind>==\> <ze>");
	ze.inner = [zzz | loc ix <- x.ls, ZooEntry zzz := traverse(ind+"  ",ix), noentry(_) !:= zzz];
	return ze;
}

public ZooEntry traversebase() = traverse("",basedir);

public list[ZooEntry] orderedinner(ZooEntry z)
{
	if (struct("contents",list[ZooValue] kvs) <- z.meta)
		return [iz |
			keyvalue("dir", str d) <- kvs,
			iz <- z.inner,
			iz.where == "<z.where>/<d>" ];
	else
		return z.inner;
}
