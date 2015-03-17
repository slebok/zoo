@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::BackEnd

import IO;
import Set;
import List;
import String;
import lang::xml::DOM;
import framework::Types;

loc basedir = |home:///projects/webzoo-prep/zoo/|;
//loc outdir = |home:///projects/zoo/web/|;
loc outdir = |home:///projects/slebok/zoo/|;
//str gitbasedir = "https://github.com/grammarware/zoo/tree/master/zoo/";
str gitbasedir = "https://bitbucket.org/grammarware/zoobackup/src/master/zoo/";
//str gitbasefile = "https://github.com/grammarware/zoo/blob/master/zoo";
str gitbasefile = "https://bitbucket.org/grammarware/zoobackup/src/master/zoo/";

public lrel[str,str] link2allfiles(loc x)
	= isDirectory(x)
	? [link2file(f) | loc f <- x.ls ]
	: [link2file(x)];

public tuple[str,str] link2file(loc x)
	= isDirectory(x)
	? <x.file, gitbasedir+shortenpath(x)>
	: <x.file, gitbasefile+shortenpath(x)>;

str shortenpath(loc x) = replaceFirst(x.path, basedir.path, "");

public int countEntries(ZooEntry z)
	= size({ez | /ez:zentry(_, list[ZooValue] meta, _) <- z, /struct("grammar",_) := ez.meta});

public int countGrammars(ZooEntry z)
	= size([1 | /struct("grammar",_) <- z]);

public int countByType(ZooEntry z, str t)
	= size([1 | /struct("grammar",list[ZooValue] inner) <- z, keyvalue("dir", t) in inner]);

public str countAllTypes(ZooEntry z)
	= intercalate(" + ",["<k> <v>" | <k,v> <- reverse(sort([<countByType(z,t),t> | t <- allUsedTypes(z)]))]);

public set[str] allUsedTypes(ZooEntry z)
	= {t | /struct("grammar",list[ZooValue] inner) <- z, keyvalue("dir", t) <- inner};

public ZooValue xml2zooval(Node e)
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

str getcolour(ZooEntry z)
{
	gs = allUsedTypes(z);
	if (countGrammars(z)==0) return "black";
	if ("recovered" in gs) return "purple";
	if ("corrected" in gs) return "green";
	if ("extracted" in gs) return "yellow";
	if ("fetched" in gs) return "red"; 
	return "cyan";
}
