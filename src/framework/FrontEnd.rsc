@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::FrontEnd

import IO;
import Set;
import List;
import String;
import lang::xml::DOM;
import grammarlab::language::XHTML;
import grammarlab::io::XHTML;

loc base = |home:///projects/webzoo-prep/zoo/|;
str gitbasedir = "https://github.com/grammarware/zoo/tree/master/zoo/";
str gitbasefile = "https://github.com/grammarware/zoo/blob/master/zoo/";

void main()
{
	//println(base.ls);
	writeHTML(
		zooval2html(traverse("",base), false),
		|project://zoo/web/index.html|
	);
}

data ZooValue
	= keyvalue(str key, str val)
	| flag(str key)
	| struct(str key, list[ZooValue] inner)
	| zerror()
	;
// This is a kind of extended lrel[str,value]:
data ZooEntry
	= zentry(str where, list[ZooValue] meta, list[ZooEntry] inner)
	| noentry(str where)
	;

list[ZooValue] getbykey(ZooEntry e, str key) = [ie | ZooValue ie <- e, ie.key == key];
ZooValue get1bykey(ZooEntry e, str key) = getOneFrom([ie | ZooValue ie <- e, ie.key == key]);
str txtbykey(ZooEntry e, str key) = txtbykey(e.meta, key);
str txtbykey(list[ZooValue] es, str key) = safegetOneFrom([val | ZooValue kv <- es, keyvalue(key,str val) := kv]);

str safegetOneFrom([]) = "";
default str safegetOneFrom(t) = getOneFrom(t);

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

HTML zooval2html(ZooEntry ze, bool debug)
	= html(
		//("xmlns":"http://www.w3.org/1999/xhtml"),
		(),
		doctype("-//W3C//DTD XHTML 1.0 Strict//EN","http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"),
		hhead([
			meta( ("http-equiv":"content-type", "content":"text/html; charset=utf-8") ),
			title( "Grammar Zoo"),
			link( ("href":"slps.css", "rel":"stylesheet", "type":"text/css") )
		]),
		//zentry(str where, list[ZooValue] meta, list[ZooEntry] inner)
		body( ("style":"background-color:#9C9;"), [
			heading(1, (), _text(txtbykey(ze,"name"))),
			div( ("class":"c"), em((),_text(txtbykey(ze,"subtitle"))) ),
			heading(2, (), _text("<countSize(ze)> grammars and counting")),
			div( ("class":"c"), _text("Bulk download of the whole corpus:") ),
			heading(1, (), _text("...links...")),
			hr(),
			*[*lang2html(iz, debug) | iz <- ze.inner]]
		)
	);

str countSize(ZooEntry z)
	= "<size({ez | /ez:zentry(_, list[ZooValue] meta, _) <- z, /struct("grammar",_) := ez.meta})> (<size([1 | /struct("grammar",_) <- z])>)";

list[BodyElement] lang2html(ZooEntry z, bool debug) = [
	maketoptitle(z),
	*[zooval2be(iz, debug) | iz <- z.inner],
	hr()
];

BodyElement maketoptitle(ZooEntry z)
{
	name = txtbykey(z,"name");
	long = txtbykey(z,"long");
	if (long == "") long = name;
	return heading(2, (), _seq([aname("<name>secdot"), _text(long)]));
}

BodyElement makelinks(lrel[str,str] links)
{
	list[BodyElement] res = [];
	for (link <- links)
		res += [_text(" ["), ahref(("href":link[1]),_text(link[0])), _text("]")];
	return span( ("class":"links"), _seq(res) );
}

tuple[str,str] makelink([keyvalue("uri", str uri),keyvalue("name", str name)])
	= <name, uri>;
tuple[str,str] makelink([keyvalue("doi", str doi)])
	= <"DOI", "http://dx.doi.org/<doi>">;
default tuple[str,str] makelink(list[ZooValue] kvs) = <"<kvs>","#">;

lrel[str,str] getlinks(list[ZooValue] zs) = [makelink(inner) | struct("link", list[ZooValue] inner) <- zs];

BodyElement maketitle(ZooEntry z)
{
	name = txtbykey(z,"name");
	long = txtbykey(z,"long");
	if (long == "") long = name; else long = "<long> (<name>)";
	// https://github.com/software-engineering-amsterdam/poly-ql/tree/master/PhilippBeau/IFLessTermFrequency/src/nl/uva/sc/datatypes
	// https://github.com/grammarware/zoo/tree/master/zoo/
	lrel[str,str] links = [<"git",gitbasedir+z.where>];
	if (flag("readme") in z.meta) links += <"ReadMe","<gitbasefile><z.where>/README.txt">;
	links += getlinks(z.meta);
	return heading(3, (), _seq([aname(name), _text(long), makelinks(links) ]));
}

BodyElement src2be(list[ZooValue] zin) = _seq([
	_text("Source: "),
	*[_text("<a>, ") | keyvalue(k,a) <- zin, k == "author" || k == "standard"],
	*[em((),_text("<a>, ")) | keyvalue(k,a) <- zin, k == "title"],
	*[_text("<a>, ") | keyvalue(k,a) <- zin, k == "subtitle"],
	*[*[code((),_text(a)),_text(", ")] | keyvalue(k,a) <- zin, k == "file"],
	*[_text("<th(k)> <k>, ") | keyvalue(k,a) <- zin, k == "version" || k == "edition" || k == "revision"],
	*[_text(" (<a>)") | keyvalue(k,a) <- zin, k == "date"],
	*[_text(", <a>") | keyvalue(k,a) <- zin, k == "specific" || k == "also"],
	makelinks(getlinks(zin))
]);

str th("1") = "1st";
str th("2") = "2nd";
str th("3") = "3rd";
default str th(str n) = "<n>th";

// TODO: fancify tags (links, colours, images, etc)
BodyElement displaytag(str k, str v) = span( ("class":"tag"), _text("<k>:<v>"));

// TODO: make sure it works
BodyElement grammar2be(list[ZooValue] zs, bool debug)
	= _seq([
		strong( (), _text(txtbykey(zs,"dir"))),
		*[displaytag(k,v) | keyvalue(str k, str v) <- zs],
		*(debug?[_text("<zs>")]:[])]);

BodyElement zooval2be(ZooEntry ze, bool debug)
	= _seq([
		maketitle(ze),
		ul((),
			(debug?[li((), _text("<ze.meta>"))]:[])
			+ [li((), src2be(zin)) | struct("source", list[ZooValue] zin) <- ze.meta]
			+ [li((), grammar2be(zin,debug)) | struct("grammar", list[ZooValue] zin) <- ze.meta]
			+ [li((), zooval2be(iz,debug)) | iz <- ze.inner]
	)]);

str shortenpath(loc x) = replaceFirst(x.path, base.path, "");

ZooEntry traverse(str ind, loc x)
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