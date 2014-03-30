@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module framework::RenderGrammar

import grammarlab::language::Grammar;
import grammarlab::language::XHTML;
import framework::Types;

import IO;
import grammarlab::io::Grammar;
import grammarlab::io::XHTML;
import lang::xml::DOM;

import framework::FrontEnd;
import framework::BackEnd;
import framework::FancyHTML;
import DateTime;
import grammarlab::analyse::Metrics;
import List;

void rmain()
{
	bgf = readBGF(|home:///projects/webzoo-prep/zoo/dsl/abs/hats/rascal/extracted/grammar.bgf|);
	zoo = traverse("",|home:///projects/webzoo-prep/zoo/dsl/abs/hats/rascal/|);
	println("<zoo>");
	htm = bgf2html("ABS", "extracted", bgf, zoo );
	writeHTML(htm, |project://zoo/web/test.html|); 
}	

HTML bgf2html(str name, str t, GGrammar g, ZooEntry z) = html(
		//("xmlns":"http://www.w3.org/1999/xhtml"),
		(),
		doctype("-//W3C//DTD XHTML 1.0 Strict//EN","http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"),
		hhead([
			meta( ("http-equiv":"content-type", "content":"text/html; charset=utf-8") ),
			title( "Grammar Zoo - Browsable <name> Grammar"),
			link( ("href":"slps.css", "rel":"stylesheet", "type":"text/css") )
			// TODO: add Analytics!
		]),
		body( (), [
			heading(1, ("class":"l"), _seq([aname("TOP"),_text("Browsable <name> Grammar")])),
			//<p>Extracted and/or recovered by <strong><a href="http://grammarware.net">Vadim Zaytsev</a></strong>,	see <a href="http://slps.github.io/zoo/">Grammar Zoo</a> for details.
			ahref( ("href":"http://creativecommons.org/licenses/by/3.0/"), img("cc-by.png","CC-BY") ),
			para( (), _seq([
				_text("Grammar <t> by "),
				strong((), ahref( ("href":"http://grammarware.net/"), _text("Vadim Zaytsev"))),
				_text(", see the "),
				ahref( ("href":"http://grammarzoo.github.io/"), _text("Grammar Zoo")),
				_text(" entry for details: "),
				ahref( ("href":"index.html#<safe4anchor(z.where+t)>"), _text(z.where+t) ),
				br(),
				src2be("Source used for this grammar: ",z.meta)
			])),
			heading(2, ("class":"l"), _text("Summary")),
			ul( ("class":"nl"), metricSummary(g)),
			heading(2, ("class":"l"), _text("Syntax")),
			hpp(g),
			hr(),
			div( ("class":"b"), _seq([
				ahref( ("href":"http://grammarware.github.io/lab"), img( "grammarlab.png", "Powered by GrammarLab" ) ),
				_text("Maintained by Dr. "),
				ahref( ("href":"http://grammarware.net/"), _text("Vadim Zaytsev")),
				_text(" a.k.a. @"),
				ahref( ("href":"http://twitter.com/grammarware"), _text("grammarware")),
				_text(". Last updated in <namemonth(now().month)> <now().year>."),
				makelinks([<"↑","#TOP">])
			]) )
	]) );

BodyElement hpp(GGrammar g) = _seq([hpp(p) | p <- g.P]);

BodyElement hpp(GProd p) = pre( (), _seq([ hpplhs(p.lhs), _text(" ::=\n"), hpprhs(p.rhs) ]) );

BodyElement hpplhs(str lhs) = ahref( ("class":"nt", "name":lhs), _text(lhs) );

BodyElement hpprhs(GExpr rhs)
	= (choice(L) := rhs)
	? _seq([*[_text("\t"),hpp(e)] | e <- L])
	: _seq([_text("\t"),hpp(rhs)]);

//data GExpr
BodyElement hpp(epsilon()) = _text("ε");
BodyElement hpp(empty()) = _text("φ");
BodyElement hpp(anything()) = _text("α");
BodyElement hpp(val(string())) = _text("string");
BodyElement hpp(val(integer())) = _text("integer");
BodyElement hpp(val(boolean())) = _text("boolean");
BodyElement hpp(nonterminal(str t)) = ahref( ("class":"nt", "href":"#<t>"), _text(t) );
BodyElement hpp(terminal(str t)) = span( ("class":"t"), _text("\"<t>\"") );
BodyElement hpp(label(str name, GExpr expr)) = _seq([_text("["),ahref( ("class":"lbl", "name":name), _text(name) ),_text("]::"),hpp(expr)]);
BodyElement hpp(mark(str name, GExpr expr)) = _seq([_text("\<"),ahref( ("class":"lbl", "name":name), _text(name) ),_text("\>:"),hpp(expr)]);
//BodyElement hpp(sequence(GExprList exprs)) = _seq([mmeta("("), _seq([*[hpp(e),_text(" ")] | e <- exprs][..-1]), mmeta(")")]);
BodyElement hpp(sequence(GExprList exprs)) = _seq([*[hpp(e),_text(" ")] | e <- exprs][..-1]);
BodyElement hpp(choice(GExprList exprs)) = _seq([*[hpp(e),mmeta(" | ")] | e <- exprs][..-1]);
BodyElement hpp(allof(GExprList exprs)) = _seq([*[hpp(e),mmeta(" &amp; ")] | e <- exprs][..-1]);
BodyElement hpp(not(GExpr expr)) = _seq([mmeta("¬"), hpp(expr)]);
BodyElement hpp(except(GExpr expr1, GExpr expr2)) = _seq([hpp(expr1), mmeta("\\"), hpp(expr2)]);
BodyElement hpp(optional(GExpr expr)) = _seq([hpp(expr), mmeta("?")]);
BodyElement hpp(star(GExpr expr)) = _seq([hpp(expr), mmeta("*")]);
BodyElement hpp(plus(GExpr expr)) = _seq([hpp(expr), mmeta("+")]);
BodyElement hpp(sepliststar(GExpr expr, GExpr sep)) = _seq([mmeta("{"), hpp(expr), _text(" "), hpp(sep), mmeta("}*")]);
BodyElement hpp(seplistplus(GExpr expr, GExpr sep)) = _seq([mmeta("{"), hpp(expr), _text(" "), hpp(sep), mmeta("}+")]);
BodyElement hpp(nothing()) = _text("∅");
default BodyElement hpp(GExpr e) = _text("NYI");

BodyElement mmeta(str s) = span( ("class":"meta"), _text(s) );

list[BodyElement] metricSummary(GGrammar g)
{
	list[BodyElement] res = [];
	res += li( (), _seq([
			_text("Total "),
			strong( (), _text("<size(g.P)>")),
			_text(" production rules with "),
			strong( (), _text("<PROD(g)>")),
			_text(" top alternatives.")]));
	res += li( (), _seq([
			_text("Total "),
			strong( (), _text("<VAR(g)>")),
			_text(" nonterminal symbols: "),
			strong( (), _text("<size(g.N)>")),
			_text(" defined.")
			]));
	ts = TOP(g);
	res += li( (), _seq([
			_text("Root nonterminal symbols (<size(g.S)>): "),
			*[*[code((),hpp(nonterminal(t))), _text(", ")] | t <- g.S],
			*((g.S==[])?[_text("—")]:[]),
			_text(" other top nonterminal symbols (<size(ts)>): "),
			*[*[code((),hpp(nonterminal(t))), _text(", ")] | t <- ts],
			_text(".")
			]));
	bs = BOTTOM(g);
	res += li( (), _seq([
			_text("Bottom nonterminal symbols (<size(bs)>): "),
			*[*[code((),hpp(nonterminal(t))), _text(", ")] | t <- bs],
			_text(".")
			]));
//Number of top alternatives: 456
//Number of defined nonterminal symbols: 208
//Root nonterminal symbols: —
//Other top nonterminal symbols: 2: ABSGoal, LAYOUT
//Bottom nonterminal symbols: 134: COMMA, QMARK, BAR, DURATION, LPAREN, RPAREN, GUARDAND, MODULE, SEMICOLON, LBRACE, RBRACE, DOT, LT, GT, ORDER, BY, PORT, ASSIGN, EQEQ, NOTEQ, THIS, BANG, MINUS, NEGATION, REMOVES, CASE, MULT, MOD, DIV, COUNT, OROR, AFTER, AS, DEF, BUILTIN, DATA, TYPE_IDENTIFIER_OLD, PRODUCT, PRIME, ANDAND, TO, WHEN, EQ, CLASS, MODIFIES, INTERFACE, ADDS, IMPLIES, EQUIV, TYPE, LOC, Component, SQL, GET, LET, IN, PLUS, NEW, NULL, OPTFEATURES, LBRACKET, RBRACKET, SQLSTRINGLITERAL, GROUP, DELTA, JOIN, RIGHT, LEFT, FROM, TRUE, FALSE, WHILE, INSERT, INTO, VALUES, UPDATE, SET, SELECT, DISTINCT, COREFEATURES, IF, THEN, ELSE, UNTIL, Constraints, EXCLUDE, COLON, Attributes, REQUIRE, IFIN, IFOUT, EXTENDS, IMPLEMENTS, IMPORT, HASFIELD, HASMETHOD, HASINTERFACE, EXPORT, AND, ORIGINAL, DOTORIGINAL, CORE, OR, CONCAT, END, FATHER, CRITICAL, NOT, IS, RARROW, USES, DESC, ASC, WHERE, Comment, STRINGLITERAL, EXTENSION, ROOT, REBIND, SKIP, SUBLOC, ASSERT, AWAIT, SUSPEND, RETURN, MOVECOGTO, OPT, LTEQ, GTEQ, COG, PRODUCTLINE, ONEOF, ALLOF, USCORE
//Number of used terminal symbols: 1
//Special terminal symbols: 1: "/"
	return res;
}