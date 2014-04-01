@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::FrontEnd

import IO;
import grammarlab::language::XHTML;
import grammarlab::io::XHTML;
import framework::Types;
import framework::BackEnd;
import framework::FancyHTML;
import grammarlab::lib::Profiler;

void main()
{
	X = startTheClock();
	writeHTML(
		zooval2html(traversebase(), false),
		|project://zoo/web/index.html|
	);
	println("Running time: <formatDuration(X)>");
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
			div( ("style":"float:right;", "class":"box"), img( "grammarlab.png", "Powered by GrammarLab" ) ),
			div( ("style":"float:left;", "class":"box"), img( "grammarzoo.png", "GrammarZoo logo" ) ),
			heading(1, (), _seq([aname("TOP"),_text(txtbykey(ze,"name"))])),
			div( ("class":"c"), em((),_text(txtbykey(ze,"subtitle"))) ),
			heading(2, ("class":"fh"), _text("<countEntries(ze)> entries and counting")),
			heading(3, ("class":"sh"), _text("<countGrammars(ze)> grammars: <countAllTypes(ze)>")),
			div( ("class":"c"), _text("Bulk download of the whole corpus:") ),
			heading(1, (), subsectionlinks(ze)),
			hr(),
			*[*lang2html(iz, debug) | iz <- ze.inner],
			footer()
	]) );

BodyElement subsectionlinks(ZooEntry z)
{
	list[BodyElement] res = [];
	for(ZooEntry sec <- orderedinner(z))
		res += [ahref( ("href":"#<safe4anchor(sec.where)>"), _text(txtbykey(sec,"name")) ), _text(" — ")];
	if (res == [])
		return _text("empty!");
	else
		return _seq(res[..-1]);
}

list[BodyElement] lang2html(ZooEntry z, bool debug) = [
	maketoptitle(z),
	*(debug?[div((), _text("<z.meta>"))]:[]),
	*[zooval2be(iz, debug) | iz <- orderedinner(z)],
	hr()
];

BodyElement maketoptitle(ZooEntry z)
{
	//anch = "<safe4anchor(txtbykey(z,"name"))>sector";
	anch = safe4anchor(z.where);
	return _seq([heading(2, (), _seq([
		ahref( ("name":anch, "href":"#<anch>", "title":"<countGrammars(z)> grammars"), 
			_seq([ _text("("), colouredDots(z), _text(")") ])),
		_text(" "),
		_text(maketoptitlename(z)),
		_text(" "),
		ahref( ("href":"#TOP"), _text("(↑)"))
	])),
		heading(2, ("class":"xs"), subsectionlinks(z))
	]);
}

str maketoptitlename(ZooEntry z)
{
	long = txtbykey(z,"long");
	return (long!="")?long:txtbykey(z,"name");
}

BodyElement maketitle(ZooEntry z)
{
	name = txtbykey(z,"name");
	anch = safe4anchor(z.where);
	long = txtbykey(z,"long");
	if (long == "")
		long = name;
	elseif (!isflagset(z,"forgetshort"))
		long = "<long> (<name>)";
	lrel[str,str] links = [<"git",framework::BackEnd::gitbasedir+z.where>];
	if (flag("readme") in z.meta) links += <"ReadMe","<framework::BackEnd::gitbasefile><z.where>/README.txt">;
	links += getlinks(z.meta);
	return span( ("class":"hh"), _seq([
		ahref( ("name":anch, "href":"#<anch>", "title":"<countGrammars(z)> grammars"),
			_seq([ _text("("), colouredDots(z), _text(")") ])),
		_text(" "),
		_text(long),
		makelinks(links) ]));
}

public BodyElement src2be(str src, list[ZooValue] zin) = _seq([
	_text(src),
	*[_text("<a>, ") | keyvalue(k,a) <- zin, k == "author" || k == "standard"],
	*[em((),_text("<a>, ")) | keyvalue(k,a) <- zin, k == "title"],
	*[_text("<a>, ") | keyvalue(k,a) <- zin, k == "subtitle"],
	*[*[code((),_text(a)),_text(", ")] | keyvalue(k,a) <- zin, k == "file"],
	*[_text("<th(a,k)>, ") | keyvalue(k,a) <- zin, k == "version" || k == "edition" || k == "revision"],
	*[_text(a) | keyvalue(k,a) <- zin, k == "venue"],
	*[_text(" <a>") | keyvalue(k,a) <- zin, k == "date"],
	*[_text(", <a>") | keyvalue(k,a) <- zin, k == "specific" || k == "also"],
	makelinks(getlinks(zin))
]);

// TODO: make sure it works
BodyElement grammar2be(str parent, list[ZooValue] zs, bool debug)
{
	// Too bad we don't have 'where' or 'let' in Rascal...
	dir = txtbykey(zs,"dir");
	pdir = "<parent>/<dir>";
	hyper = "<pdir>/index.html";
	dirloc = framework::BackEnd::basedir+pdir;
	anch = safe4anchor(pdir);
	return ul( (),
		[
		li( (), _seq([
			_text("("),
			ahref( ("name":anch, "href":"#<anch>"), colouredArrow(txtbykey(zs,"dir"))),
			_text(") The "),
			strong( (), _text(dir)),
			_text(" grammar is "),
			makelinks(link2allfiles(dirloc)),
			*(exists(framework::BackEnd::outdir+hyper)?[ span( ("class":"red"), makelinks([<"Browse now!",hyper>]))]:[])
		])),
		*displayfiles(parent,zs,debug),
		li( (), _seq([displaytag(parent,k,v) | keyvalue(str k, str v) <- zs])),
		*(debug?[li((),_text("<zs>"))]:[])
		]);
}

list[BodyElement] displayfiles(str parent, list[ZooValue] zs, bool debug)
{
	//public list[ZooValue] getbykey(ZooEntry e, str key) = [ie | ZooValue ie <- e, ie.key == key];
	files = [f | ZooValue ie <- zs, keyvalue("fileused", str f) := ie];
	if(files == []) return [];
	return [li( (), _seq([
		_text("Files used: "),
		makelinks([link2file(framework::BackEnd::basedir+"<parent>/<f>") | f <- files]
	)]))];
}

BodyElement zooval2be(ZooEntry ze, bool debug)
	= _seq([
		dl( (),
		[dt( (), maketitle(ze)),
		*(debug?[dd((), _text("<ze.meta>"))]:[]),
		*listsources(ze),
		*listgrammars(ze, debug),
		*[dd((), zooval2be(iz,debug)) | iz <- orderedinner(ze)]
	])]);

list[BodyElement] listsources(ZooEntry z)
	= (struct("source", _) <- z.meta)
	? [dd((), ul((), [li((), src2be("Source: ",zin)) | struct(str key, list[ZooValue] zin) <- z.meta, key == "source" || key == "item"]))]
	: []
	;

list[BodyElement] listgrammars(ZooEntry z, bool debug)
	= [dd((), grammar2be(z.where,zin,debug)) | struct("grammar", list[ZooValue] zin) <- z.meta];
