@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::RenderGrammar

import grammarlab::language::Grammar;
import grammarlab::language::XHTML;
import framework::Types;

import IO;
import grammarlab::io::Grammar;
import grammarlab::io::XHTML;
import lang::xml::DOM;
import grammarlab::lib::Profiler;

import framework::FrontEnd;
import framework::BackEnd;
import framework::FancyHTML;
import grammarlab::analyse::Metrics;
import List;
import IO;
import String;

str pathtoroot(str w, str f) = "../../<intercalate("/",[".." | x <- findAll(w,"/")])>/<f>";

void rmain() = rmain(false);
void rmain(bool force)
{
	S = startTheClock();
	zoo = traversebase();
	for (/z:zentry(str where, list[ZooValue] meta, list[ZooEntry] inner) := zoo)
		for (struct("grammar",list[ZooValue] zvs) <- meta)
		{
			// if (lastModified(gfile) > lastModified(gfile[file=replaceAll(gfile.file,".glue","ed/grammar.bgf")]))
			dir = txtbykey(zvs,"dir");
			println("Found <dir> grammar in <where>.");
			if (dir == "fetched") continue;
			mydir = "<where>/<dir>";
			if (!exists(framework::BackEnd::outdir+mydir)) mkDirectory(framework::BackEnd::outdir+mydir);
			if (exists(framework::BackEnd::basedir+(mydir+"/grammar.bgf")))
			{
				// BUG! could not reproduce in a simpler example
				mydir = "<where>/<dir>";
				if (!force &&
					exists(framework::BackEnd::outdir+"<mydir>/index.html") &&
					exists(framework::BackEnd::basedir+"<where>/zoo.xml") &&
					lastModified(framework::BackEnd::basedir+"<mydir>/grammar.bgf") <
					lastModified(framework::BackEnd::outdir+"<mydir>/index.html") &&
					lastModified(framework::BackEnd::basedir+"<where>/zoo.xml") <
					lastModified(framework::BackEnd::outdir+"<mydir>/index.html")
				){
					println("\tNo need to refresh the rendered version.");
					continue;
				}
				g = readBGF(framework::BackEnd::basedir+"<mydir>/grammar.bgf");
				// NB: HACK!
				// TODO: workaround - escaping in GrammarLab concrete syntax
				g = visit(g){case nonterminal("DQUOTE") => terminal("\"")};
				writeHTML(
					bgf2html(txtbykey(zvs,"of"), dir, g, z ),
					framework::BackEnd::outdir+"<mydir>/index.html"
				);
				//println(z);
			}
		}
	println("Running time: <formatDuration(S)>");
}

HTML bgf2html(str name, str t, GGrammar g, ZooEntry z) = html(
		//("xmlns":"http://www.w3.org/1999/xhtml"),
		(),
		doctype("-//W3C//DTD XHTML 1.0 Strict//EN","http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"),
		hhead([
			meta( ("http-equiv":"content-type", "content":"text/html; charset=utf-8") ),
			title( "Grammar Zoo - Browsable <name> Grammar"),
			link( ("href":pathtoroot(z.where,"slps.css"), "rel":"stylesheet", "type":"text/css") )
			// TODO: add Analytics!
		]),
		body( (), [
			heading(1, ("class":"l"), _seq([aname("TOP"),_text("Browsable <name> Grammar")])),
			//<p>Extracted and/or recovered by <strong><a href="http://grammarware.net">Vadim Zaytsev</a></strong>,	see <a href="http://slps.github.io/zoo/">Grammar Zoo</a> for details.
			ahref( ("href":"http://creativecommons.org/licenses/by/3.0/"), img(pathtoroot(z.where,"cc-by.png"),"CC-BY") ),
			para( (), _seq([
				_text("Grammar <t> by "),
				strong((), ahref( ("href":"http://grammarware.net/"), _text("Vadim Zaytsev"))),
				_text(", see the "),
				ahref( ("href":"http://grammarzoo.github.io/"), _text("Grammar Zoo")),
				_text(" entry for details: "),
				ahref( ("href":pathtoroot(z.where,"index.html")+"#<safe4anchor("<z.where>/<t>")>"), _text("<z.where>/<t>") ),
				br(),
				*[src2be("Source used for this grammar: ",zin) | struct(str key, list[ZooValue] zin) <- z.meta, key == "source"]
			])),
			heading(2, ("class":"l"), _text("Summary")),
			ul( ("class":"nl"), metricSummary(g)),
			heading(2, ("class":"l"), _text("Syntax")),
			hpp(g),
			hr(),
			div( ("class":"b"), _seq([
				ahref( ("href":"http://grammarware.github.io/lab"), img( pathtoroot(z.where,"grammarlab.png"), "Powered by GrammarLab" ) ),
				_text("Maintained by Dr. "),
				ahref( ("href":"http://grammarware.net/"), _text("Vadim Zaytsev")),
				_text(" a.k.a. @"),
				ahref( ("href":"http://twitter.com/grammarware"), _text("grammarware")),
				_text("."),
				lastupdated(),
				makelinks([<"↑","#TOP">])
			]) )
	]) );

BodyElement hpp(GGrammar g) = _seq([hpp(p) | p <- g.P]);

BodyElement hpp(GProd p) = pre( (), _seq([ hpplhs(p.lhs), _text(" ::="), hpprhs(p.rhs) ]) );

BodyElement hpplhs(str lhs) = ahref( ("class":"nt", "name":lhs), _text(lhs) );

BodyElement hpprhs(GExpr rhs)
	= (choice(L) := rhs)
	? _seq([*[_text("\n\t"),hpp(e)] | e <- L])
	: _seq([_text("\n\t"),hpp(rhs)]);

// possibly parenthesized
BodyElement PPhpp(e:sequence(_)) = _seq([mmeta("("), hpp(e), mmeta(")")]);
BodyElement PPhpp(e:choice(_)) = _seq([mmeta("("), hpp(e), mmeta(")")]);
BodyElement PPhpp(e:allof(_)) = _seq([mmeta("("), hpp(e), mmeta(")")]);
BodyElement PPhpp(e:except(_,_)) = _seq([mmeta("("), hpp(e), mmeta(")")]);
default BodyElement PPhpp(GExpr e) = hpp(e);

//data GExpr
BodyElement hpp(epsilon()) = _text("ε");
BodyElement hpp(empty()) = _text("φ");
BodyElement hpp(anything()) = _text("α");
BodyElement hpp(val(string())) = _text("string");
BodyElement hpp(val(integer())) = _text("integer");
BodyElement hpp(val(boolean())) = _text("boolean");
BodyElement hpp(nonterminal(str t)) = ahref( ("class":"nt", "href":"#<t>"), _text(t) );
BodyElement hpp(terminal(str t)) = span( ("class":"t"), _text("\"<t>\"") );
BodyElement hpp(label(str name, GExpr expr)) = _seq([_text("["),ahref( ("class":"lbl", "name":name), _text(name) ),_text("]::"),PPhpp(expr)]);
BodyElement hpp(mark(str name, GExpr expr)) = _seq([_text("⟨"),ahref( ("class":"lbl", "name":name), _text(name) ),_text("⟩:"),span(("class":"marked"),PPhpp(expr))]);
//BodyElement hpp(sequence(GExprList exprs)) = _seq([mmeta("("), _seq([*[hpp(e),_text(" ")] | e <- exprs][..-1]), mmeta(")")]);
BodyElement hpp(sequence(GExprList exprs)) = _seq([*[PPhpp(e),_text(" ")] | e <- exprs][..-1]);
BodyElement hpp(choice(GExprList exprs)) = _seq([*[hpp(e),mmeta(" | ")] | e <- exprs][..-1]);
//BodyElement hpp(choice(GExprList exprs)) = _seq([mmeta("("), _seq([*[hpp(e),mmeta(" | ")] | e <- exprs][..-1]), mmeta(")")]);
BodyElement hpp(allof(GExprList exprs)) = _seq([*[hpp(e),mmeta(" &amp; ")] | e <- exprs][..-1]);
BodyElement hpp(not(GExpr expr)) = _seq([mmeta("¬"), PPhpp(expr)]);
BodyElement hpp(except(GExpr expr1, GExpr expr2)) = _seq([PPhpp(expr1), mmeta("\\"), PPhpp(expr2)]);
BodyElement hpp(optional(GExpr expr)) = _seq([PPhpp(expr), mmeta("?")]);
BodyElement hpp(star(GExpr expr)) = _seq([PPhpp(expr), mmeta("*")]);
BodyElement hpp(plus(GExpr expr)) = _seq([PPhpp(expr), mmeta("+")]);
BodyElement hpp(sepliststar(GExpr expr, GExpr sep)) = _seq([mmeta("{"), PPhpp(expr), _text(" "), PPhpp(sep), mmeta("}*")]);
BodyElement hpp(seplistplus(GExpr expr, GExpr sep)) = _seq([mmeta("{"), PPhpp(expr), _text(" "), PPhpp(sep), mmeta("}+")]);
BodyElement hpp(nothing()) = _text("∅");
default BodyElement hpp(GExpr e) = _text("NYI");

BodyElement mmeta(str s) = span( ("class":"meta"), _text(s) );

// comma-separated lists of nonterminals, terminals, labels and markers
BodyElement wrapnL(str x) = code((), ahref( ("class":"nt", "href":"#<x>"), _text(x) ) );
BodyElement wrapnN(str x) = code(("class":"nt"), _text(x));
BodyElement wrapnL(tuple[str x,int n] xn) = posnr(code((), ahref( ("class":"nt", "href":"#<xn.x>"), _text(xn.x) ) ), xn.n);
BodyElement wrapnN(tuple[str x,int n] xn) = posnr(code(("class":"nt"), _text(xn.x)), xn.n);
BodyElement wrapt(tuple[str x,int n] xn) = posnr(hpp(terminal(xn.x)), xn.n);
BodyElement wraplL(tuple[str x,int n] xn) = posnr(code((),_seq([_text("["),ahref(("class":"lbl", "href":"#<xn.x>"), _text(xn.x) ),_text("]")])), xn.n);
BodyElement wraplN(tuple[str x,int n] xn) = posnr(code((),_seq([_text("["),span( ("class":"lbl"), _text(xn.x) ),_text("]")])), xn.n);
BodyElement wrapm(tuple[str x,int n] xn) = posnr(code((),_seq([_text("⟨"),span( ("class":"lbl"), _text(xn.x) ),_text("⟩")])), xn.n);

BodyElement posnr(BodyElement x, int n)
	= n == 1
	? x
	: _seq([x,sup( (), _text(" <n>"))]);

BodyElement csl([], _) = _text("—");
BodyElement csl(list[&T] xs, BodyElement(&T) f) = _seq([*[f(x), _text(", ")] | x <- xs][..-1]);

// ...L means Link; ...N means No link
BodyElement csnlL(list[str] xs) = csl(xs, wrapnL);
BodyElement csnlL(lrel[str,int] xs) = csl(xs, wrapnL);
BodyElement csnlN(lrel[str,int] xs) = csl(xs, wrapnN);
BodyElement cstl(lrel[str,int] xs) = csl(xs, wrapt);
BodyElement csllL(lrel[str,int] xs) = csl(xs, wraplL);
BodyElement csllN(lrel[str,int] xs) = csl(xs, wraplN);
BodyElement csml(lrel[str,int] xs) = csl(xs, wrapm);

list[BodyElement] metricSummary(GGrammar g)
	= [
		li( (), _seq([
			_text("Total "),
			strong( (), _text("<size(g.P)>")),
			_text(" production rules with "),
			strong( (), _text("<PROD(g)>")),
			_text(" top alternatives and "),
			strong( (), _text("<SYMB(g)>")),
			_text(" symbols.")])),
		li( (), _seq([
			_text("Vocabulary: "),
			strong( (), _text("<VOC(g)>")),
			_text(" = "),
			strong( (), _text("<VAR(g)>")),
			_text(" nonterminals + "),
			strong( (), _text("<TERM(g)>")),
			_text(" terminals + "),
			strong( (), _text("<LAB(g)>")),
			_text(" labels + "),
			strong( (), _text("<MAR(g)>")),
			_text(" markers.")
			])),
		*(VAR(g)==0?[]:[li( (), _seq([
			_text("Total "),
			strong( (), _text("<VAR(g)>")),
			_text(" nonterminal symbols: "),
			strong( (), _text("<size(g.N)>")),
			_text(" defined (see below), "),
			strong( (), _text("<ROOT(g)>")),
			_text(" root ("),
			csnlL(listROOT(g)),
			_text("), "),
			strong( (), _text("<TOP(g)>")),
			_text(" top ("),
			csnlL(listTOP(g)),
			_text("), "),
			strong( (), _text("<BOTTOM(g)>")),
			_text(" bottom ("),
			csnlN(freqNonterminals(listBOTTOM(g),g)),
			_text(").")
			]))]),
		*(TERM(g)==0?[]:[li( (), _seq([
			_text("Total "),
			strong( (), _text("<TERM(g)>")),
			_text(" terminal symbols: "),
			strong( (), _text("<KWDS(g)>")),
			_text(" keywords ("),
			cstl(freqTerminals(listKWDS(g),g)),
			_text("), "),
			strong( (), _text("<NUM(g)>")),
			_text(" numerics ("),
			cstl(freqTerminals(listNUM(g),g)),
			_text("), "),
			strong( (), _text("<SIGN(g)>")),
			_text(" signs ("),
			cstl(freqTerminals(listSIGN(g),g)),
			_text(").")
			]))]),
		*(LAB(g)==0?[]:[li( (), _seq([
			_text("Total "),
			strong( (), _text("<LAB(g)>")),
			_text(" labels: "),
			csllL(freqLAB(g)),
			_text(".")
			]))]),
		*(MAR(g)==0?[]:[li( (), _seq([
			_text("Total "),
			strong( (), _text("<MAR(g)>")),
			_text(" markers: "),
			csml(freqMAR(g)),
			_text(".")
			]))])
	];
