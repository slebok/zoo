@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::FrontEnd

import IO;
import DateTime;
import grammarlab::language::XHTML;
import grammarlab::io::XHTML;
import framework::Types;
import framework::BackEnd;

void main()
{
	writeHTML(
		zooval2html(traversebase(), false),
		|project://zoo/web/index.html|
	);
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
			heading(2, (), _text("<countSize(ze)> grammars and counting")),
			div( ("class":"c"), _text("Bulk download of the whole corpus:") ),
			heading(1, (), sectorlinks(ze)),
			hr(),
			*[*lang2html(iz, debug) | iz <- ze.inner],
			div( ("class":"last"), _seq([strong( (),
				_seq([
					_text("All grammars are distributed on terms of the "),
					ahref( ("href":"http://creativecommons.org/licenses/by/3.0/"), _text("CC-BY")),
					_text(" license as well as on terms of any other license bound to the source of our research in a way that enforces its propagation to derivatives.")
				])
			),
				br(),
				_text("The page is maintained by Dr. "),
				ahref( ("href":"http://grammarware.net/"), _text("Vadim Zaytsev")),
				_text(" a.k.a. @"),
				ahref( ("href":"http://twitter.com/grammarware"), _text("grammarware")),
				_text(". Last updated in <namemonth(now().month)> <now().year>."),
				makelinks([<"↑","#TOP">]),
				br(),
				ahref( ("href":"http://creativecommons.org/licenses/by/3.0/"), img("cc-by.png","CC-BY") ),
				ahref( ("href":"http://validator.w3.org/check/referer"), img("vxhtml.png","Valid XHTML 1.0") ),
				ahref( ("href":"http://jigsaw.w3.org/css-validator/check/referer"), img("vcss.png","Valid CSS 2.1") )
			]) )
		])
	);

str namemonth(1) = "January";
str namemonth(2) = "February";
str namemonth(3) = "March";
str namemonth(4) = "April";
str namemonth(5) = "May";
str namemonth(6) = "June";
str namemonth(7) = "July";
str namemonth(8) = "August";
str namemonth(9) = "September";
str namemonth(10) = "October";
str namemonth(11) = "November";
str namemonth(12) = "December";

BodyElement sectorlinks(ZooEntry z)
{
	list[BodyElement] res = [];
	for(ZooEntry sec <- z.inner)
		res += [ahref( ("href":"#<safe4anchor(txtbykey(sec,"name"))>sector"), _text(txtbykey(sec,"name")) ), _text(" — ")]; 
	return _seq(res[..-1]);
}

list[BodyElement] lang2html(ZooEntry z, bool debug) = [
	maketoptitle(z),
	*(debug?[div((), _text("<z.meta>"))]:[]),
	*[zooval2be(iz, debug) | iz <- orderedinner(z)],
	hr()
];

BodyElement maketoptitle(ZooEntry z) = heading(2, (), _seq([aname("<safe4anchor(txtbykey(z,"name"))>sector"), _text(maketoptitlename(z))]));

str maketoptitlename(ZooEntry z)
{
	long = txtbykey(z,"long");
	return (long!="")?long:txtbykey(z,"name");
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
	lrel[str,str] links = [<"git",framework::BackEnd::gitbasedir+z.where>];
	if (flag("readme") in z.meta) links += <"ReadMe","<framework::BackEnd::gitbasefile>/<z.where>/README.txt">;
	links += getlinks(z.meta);
	return heading(3, (), _seq([aname(safe4anchor(name)), _text(long), makelinks(links) ]));
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
BodyElement displaytag(str k, str v) = span( ("class":"tag"), _seq([em( (), _text("<k>")), _text(" : <v>")]));

BodyElement link2allfiles(str parent, str dir)
	= makelinks([ link2file(f) | loc f <- (framework::BackEnd::basedir+"<parent>/<dir>").ls ]);

// TODO: make sure it works
BodyElement grammar2be(str parent, list[ZooValue] zs, bool debug)
	= ul( (),
		[
		li( (), _seq([
			_text("The "),
			strong( (), _text(txtbykey(zs,"dir"))),
			_text(" grammar is "),
			link2allfiles(parent, txtbykey(zs,"dir"))
		])),
		li( (), _seq([displaytag(k,v) | keyvalue(str k, str v) <- zs])),
		*(debug?[li((),_text("<zs>"))]:[])
		]);

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
	? [dd((), ul((), [li((), src2be(zin)) | struct("source", list[ZooValue] zin) <- z.meta]))]
	: []
	;

list[BodyElement] listgrammars(ZooEntry z, bool debug)
	= [dd((), grammar2be(z.where,zin,debug)) | struct("grammar", list[ZooValue] zin) <- z.meta];
