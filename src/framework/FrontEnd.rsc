@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::FrontEnd

import IO;
import List;
import lang::xml::DOM;
import grammarlab::language::XHTML;
import grammarlab::io::XHTML;

loc base = |home:///projects/webzoo-prep/zoo/|;

void main()
{
	//println(base.ls);
	writeHTML(
		zooval2html(traverse("",base)),
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
	= zentry(loc where, list[ZooValue] meta, list[ZooEntry] inner)
	| noentry(loc where)
	;

list[ZooValue] getbykey(ZooEntry e, str key) = [ie | ZooValue ie <- e, ie.key == key];
ZooValue get1bykey(ZooEntry e, str key) = getOneFrom([ie | ZooValue ie <- e, ie.key == key]);
str txtbykey(ZooEntry e, str key) = safegetOneFrom([val | ZooValue kv <- e.meta, keyvalue(key,str val) := kv]);

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

HTML zooval2html(ZooEntry ze)
	= html(
		//("xmlns":"http://www.w3.org/1999/xhtml"),
		(),
		doctype("-//W3C//DTD XHTML 1.0 Strict//EN","http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"),
		hhead([
			meta( ("http-equiv":"content-type", "content":"text/html; charset=utf-8") ),
			title( "Grammar Zoo"),
			link( ("href":"slps.css", "rel":"stylesheet", "type":"text/css") )
		]),
		//zentry(loc where, list[ZooValue] meta, list[ZooEntry] inner)
		body( ("style":"background-color:#9C9;"), [
			heading(1, (), _text(txtbykey(ze,"name"))),
			div( ("class":"c"), em((),_text(txtbykey(ze,"subtitle"))) ),
			heading(2, (), _text("... grammars and counting")),
			div( ("class":"c"), _text("Bulk download of the whole corpus:") ),
			heading(1, (), _text("...links...")),
			hr(),
			*[*lang2html(iz) | iz <- ze.inner]]
		)
	);

list[BodyElement] lang2html(ZooEntry z) = [
	maketoptitle(z),
	*[zooval2be(iz) | iz <- z.inner]
];

BodyElement maketoptitle(ZooEntry z)
{
	name = txtbykey(z,"name");
	long = txtbykey(z,"long");
	if (long == "") long = name;
	return heading(2, (), _seq([aname("<name>secdot"), _text(long)]));
}

BodyElement maketitle(ZooEntry z)
{
	name = txtbykey(z,"name");
	long = txtbykey(z,"long");
	if (long == "") long = name; else long = "<long> (<name>)";
	return heading(3, (), _seq([aname(name), _text(long)]));
}

BodyElement zooval2be(ZooEntry ze)
	= _seq([
		maketitle(ze),
		ul((),
			[li((), _text("<ze.meta>"))]
			+ [li((), zooval2be(iz)) | iz <- ze.inner]
	)]);

ZooEntry traverse(str ind, loc x)
{
	//alias ZooEntry = zentry(loc where, list[ZooValue] meta, list[ZooEntry] inner)
	ZooEntry ze = zentry(x, [], []);
	if(!isDirectory(x)) return noentry(x);
	bool good = exists(x+"zoo.xml");
	println("<ind>Processing <x>...<if(good){> ZOO!<}>");
	if (!good) return noentry(x);
	entry = parseXMLDOMTrim(readFile(x+"zoo.xml"));
	ze.meta = xml2zooval(entry.root).inner;
	println("<ind>==\> <ze>");
	ze.inner = [zzz | loc ix <- x.ls, ZooEntry zzz := traverse(ind+"  ",ix), noentry(_) !:= zzz];
	return ze;
}