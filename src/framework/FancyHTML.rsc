@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::FancyHTML

import String;
import DateTime;
import framework::Types;
import framework::BackEnd;
import grammarlab::language::XHTML;

BodyElement onedot(str colour) = span( ("style":"color:<colour>"), _text("•"));
BodyElement onearrow(str colour) = strong( ("style":"color:<colour>"), _text("→"));

public BodyElement colouredDots(list[ZooValue] zs) = colouredDots(zentry("",zs,[])); 

public BodyElement colouredDots(ZooEntry z)
{
	if (countGrammars(z)==0) return onedot("black");
	list[BodyElement] res = [];
	set[str] gs = allUsedTypes(z);
	if ("fetched" in gs) res += onedot("red"); 
	if ("extracted" in gs) res += onedot("yellow");
	if ("corrected" in gs || "recovered" in gs) res += onedot("green");
	if ("adapted" in gs) res += onedot("purple");
	if (res == [])
		return onedot("cyan");
	elseif ([_] := res)
		return res[0];
	else
		return _seq(res);
}

BodyElement colouredArrow("fetched") = onearrow("red");
BodyElement colouredArrow("extracted") = onearrow("yellow");
BodyElement colouredArrow("corrected") = onearrow("green");
BodyElement colouredArrow("recovered") = onearrow("green");
BodyElement colouredArrow("adapted") = onearrow("purple");
default BodyElement colouredArrow(str dir) = onearrow("black");

public BodyElement makelinks(lrel[str,str] links)
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

public lrel[str,str] getlinks(list[ZooValue] zs) = [makelink(inner) | struct("link", list[ZooValue] inner) <- zs];

public str namemonth(1) = "January";
public str namemonth(2) = "February";
public str namemonth(3) = "March";
public str namemonth(4) = "April";
public str namemonth(5) = "May";
public str namemonth(6) = "June";
public str namemonth(7) = "July";
public str namemonth(8) = "August";
public str namemonth(9) = "September";
public str namemonth(10) = "October";
public str namemonth(11) = "November";
public str namemonth(12) = "December";
public default str namemonth(int n) = "The <n>th Month";

public str th("1", str k) = "1st <k>";
public str th("2", str k) = "2nd <k>";
public str th("3", str k) = "3rd <k>";
public str th(n:/^[0-9]+$/ , str k) = "<n>th <k>";
public default str th(str n, str k) = "<k> <n>";

public BodyElement footer()
	= div( ("class":"last"), _seq([strong( (),
		_seq([
			_text("All grammars are distributed on terms of the "),
			ahref( ("href":"http://creativecommons.org/licenses/by/3.0/"), _text("CC-BY")),
			_text(" license as well as on terms of any other license bound to the source of our research in a way that enforces its propagation to derivatives.")
		])),
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
	]));

public str safe4anchor(str s)
{
	for (weird <- [" ", "\t", "/", "#", "–", "—"])
		s = replaceAll(s,weird,"_");
	return s;
}

// TODO: fancify tags (links, colours, images, etc)
BodyElement displaytag(_, k:"level", str v) = span( ("class":"tag"), _seq([em( (), _text("<k>")), strong((),_text(" : <v>"))]));
BodyElement displaytag(str parent, k:"derivedFrom", str v)
	= span( ("class":"tag"), _seq([em( (), _text("<k>")), _text(" : "), ahref( ("href":link2grammar(parent,v)), _text(v))]));
BodyElement displaytag(str parent, k:"subsetOf", str v)
	= span( ("class":"tag"), _seq([em( (), _text("<k>")), _text(" : "), ahref( ("href":link2grammar(parent,v)), _text(v))]));
BodyElement displaytag(str parent, k:"partOf", str v)
	= span( ("class":"tag"), _seq([em( (), _text("<k>")), _text(" : "), ahref( ("href":link2grammar(parent,v)), _text(v))]));
default BodyElement displaytag(_, str k, str v) = span( ("class":"tag"), _seq([em( (), _text("<k>")), _text(" : <v>")]));

str link2grammar(str parent, str goal)
{
	if (!startsWith(goal,"/")) return "#"+safe4anchor("<parent>/<goal>");
	return "#"+safe4anchor(replaceFirst(goal,"/",""));
}