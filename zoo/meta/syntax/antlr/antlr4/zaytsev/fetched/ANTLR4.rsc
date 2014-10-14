module grammarlab::extract::ANTLR4

import grammarlab::language::Grammar;
import grammarlab::io::Grammar;

start syntax ANTLR4Grammar = //DOC_COMMENT?
		GrammarType Id ";"
		PrequelConstruct*
		RuleSpec*
		ModeSpec* ;
syntax GrammarType = ("lexer" | "parser")? "grammar";
lexical Id = [a-zA-Z_01-9]+ !>> [a-zA-Z_01-9];
syntax PrequelConstruct = OptionsSpec
	|	DelegateGrammars
	|	TokensSpec
	|	Action
	;
syntax OptionsSpec = "options" "{" (Option ";")* "}";
syntax Option = Id "=" OptionValue;
syntax OptionValue = Id ("." Id)*
	|	STRING_LITERAL
	|	ACTION
	|	INT
	;

lexical STRING_LITERAL = [\'] (ESC_SEQ | ![\'\r\n\\])* [\'];
lexical ESC_SEQ = [\\][btnfr\"\'\\];
lexical ACTION = [{] ![}]* [}];
lexical INT = [0-9]+ !>> [0-9];

syntax DelegateGrammars = "import" {DelegateGrammar ","}+ ";" ;
syntax DelegateGrammar = Id ("=" Id)?;

lexical BLOCK_COMMENT = [/][*] BCEL* [*][/];
lexical BCEL = ![*] | [*] !>> [/];
lexical LINE_COMMENT = [/][/] ![\n]* [\n];
lexical LAYOUT = [\t-\n \r \  ] | LINE_COMMENT | BLOCK_COMMENT ;
layout ANTLR4Layout = LAYOUT* !>> [\t-\n \r \  ] !>> "//" !>> "/*";

syntax TokensSpec = "tokens" "{" {Id ","}+ "}";
syntax Action = "@" (ActionScopeName "::")? Id ACTION;
syntax ModeSpec = "mode" Id ";" LexerRule*;
syntax RuleSpec = ParserRuleSpec | LexerRule;
syntax LexerRule = "fragment"? Id ":" {LexerAlt "|"}+ ";" ;
syntax LexerAlt = LexerElements+ LexerCommands?;
syntax LexerElement = LabeledLexerElement EbnfSuffix?
	|	LexerAtom EbnfSuffix?
	|	LexerBlock EbnfSuffix?
	|	ACTION "?"?
	;
syntax LexerBlock = "(" {LexerAlt "|"}+ ")";
syntax LabeledLexerElement = Id ("=" | "+=") (LexerAtom | Block);

syntax ParserRuleSpec = RuleModifier* Id ARG_ACTION?
        RuleReturns? ThrowsSpec? LocalsSpec?
		RulePrequel*
		":" RuleBlock ";" ExceptionGroup;
syntax RuleModifier = "public" | "private" | "protected" | "fragment";
syntax RuleReturns = "returns" ARG_ACTION;
syntax ThrowsSpec = "throws" {Id ","}+;
syntax LocalsSpec = "locals" ARG_ACTION	;
syntax RulePrequel = OptionsSpec | RuleAction;
syntax ExceptionGroup = ("catch" ARG_ACTION ACTION)* ("finally" ACTION)?;
syntax RuleBlock = {LabeledAlt "|"}+ ;
syntax LabeledAlt = Alternative ("#" Id)?;
syntax Alternative = ElementOptions? Element*;
syntax ElementOptions = "\<" {ElementOption ","}+ "\>";
syntax Element
	= LabeledElement EbnfSuffix?
	| Atom EbnfSuffix?
	| Ebnf
	| ACTION "?"?
	;
syntax LabeledElement = Id ("=" | "+=") (Atom | Block);
syntax Ebnf = Block EbnfSuffix?;
syntax EbnfSuffix = ("?" | "*" | "+") "?"?;
syntax RuleAction = "@" Id ACTION;

syntax Atom
	= Range
	| (Id | STRING_LITERAL) ElementOptions?
	| Id ARG_ACTION? ElementOptions?
	| "~" (SetElement | BlockSet)
	| "." ElementOptions?
	;
syntax Range = STRING_LITERAL ".." STRING_LITERAL;
syntax SetElement = Id ElementOptions?
	|	STRING_LITERAL ElementOptions?
	|	Range;
	//|	LEXER_CHAR_SET;
syntax Block = "(" ( OptionsSpec? RuleAction* ":" )? AltList ")";
syntax AltList = {Alternative "|"}+;
syntax BlockSet = "(" {SetElement "|"}+ ")";

// E.g., channel(HIDDEN), skip, more, mode(INSIDE), push(INSIDE), pop
syntax LexerCommands = "-\>" {LexerCommand ","}+;
syntax LexerCommand = (Id | "mode") ( "(" (Id | INT) ")" )?;

// [int x, List<String> a[]]
lexical ARG_ACTION = [\[] AACHAR* [\]];
lexical AACHAR = ![\[\]] | ARG_ACTION;

GGrammar extractG(loc z)
{
	parse(#start[ANTLR4Grammar],z);
	return grammar([],[],[]);
}

test bool a4g01() {GGrammar g = extractG(|home:///projects/webzoo-prep/zoo/_a4_/icalendar/fetched/ICalendar.g4|);return true;}
/*
>>>20:43<<<<< lab zaytsev$ find ../webzoo-prep/ -name "*.g4"
../webzoo-prep//zoo/_a4_/icalendar/fetched/ICalendar.g4
../webzoo-prep//zoo/_a4_/idl/fetched/IDL.g4
../webzoo-prep//zoo/_a4_/iri/fetched/IRI.g4
../webzoo-prep//zoo/_a4_/java/fetched/Java.g4
../webzoo-prep//zoo/_a4_/java8/fetched/Java8.g4
../webzoo-prep//zoo/_a4_/lua/fetched/Lua.g4
../webzoo-prep//zoo/_a4_/pcre/fetched/PCRE.g4
../webzoo-prep//zoo/_a4_/pgn/fetched/PGN.g4
../webzoo-prep//zoo/_a4_/r/fetched/R.g4
../webzoo-prep//zoo/_a4_/r/fetched/RFilter.g4
../webzoo-prep//zoo/_a4_/redcode/fetched/redcode.g4
../webzoo-prep//zoo/_a4_/scala/fetched/scala.g4
../webzoo-prep//zoo/_a4_/scss/fetched/ScssLexer.g4
../webzoo-prep//zoo/_a4_/scss/fetched/ScssParser.g4
../webzoo-prep//zoo/_a4_/sqlite/fetched/SQLite.g4
../webzoo-prep//zoo/_a4_/swift/fetched/Swift.g4
../webzoo-prep//zoo/_a4_/tnsnames/fetched/tnsnames.g4
../webzoo-prep//zoo/_a4_/tnt/fetched/tnt.g4
../webzoo-prep//zoo/_a4_/turtle/fetched/TURTLE.g4
../webzoo-prep//zoo/_a4_/webidl/fetched/WebIDL.g4
../webzoo-prep//zoo/assembly/6502/fetched/asm6502.g4
../webzoo-prep//zoo/basic/jvm/fetched/jvmBasic.g4
../webzoo-prep//zoo/c/c11/harwell/fetched/C.g4
../webzoo-prep//zoo/clojure/parr/fetched/Clojure.g4
../webzoo-prep//zoo/erlang/parr/fetched/Erlang.g4
../webzoo-prep//zoo/hardware/verilog/2001-parr/fetched/Verilog2001.g4
../webzoo-prep//zoo/html/everett/fetched/HTMLLexer.g4
../webzoo-prep//zoo/html/everett/fetched/HTMLParser.g4
../webzoo-prep//zoo/js/kiers/fetched/ECMAScript.g4
../webzoo-prep//zoo/js/kiers-vitorelli/fetched/ECMAScript.CSharpTarget.g4
../webzoo-prep//zoo/logo/everett/fetched/logo.g4
../webzoo-prep//zoo/logo/kiers/fetched/UCBLogo.g4
../webzoo-prep//zoo/markup/graphical/dot/parr/fetched/DOT.g4
../webzoo-prep//zoo/markup/scientific/fasta/everett/fetched/fasta.g4
../webzoo-prep//zoo/markup/scientific/gff/everett/fetched/gff3.g4
../webzoo-prep//zoo/markup/textual/csv/parr/fetched/CSV.g4
../webzoo-prep//zoo/markup/textual/json/concrete/parr/fetched/JSON.g4
../webzoo-prep//zoo/markup/textual/wiki/creole/everett/fetched/creole.g4
../webzoo-prep//zoo/meta/syntax/abnf/fetched/Abnf.g4
../webzoo-prep//zoo/meta/syntax/antlr/antlr4/fetched/ANTLRv4Lexer.g4
../webzoo-prep//zoo/meta/syntax/antlr/antlr4/fetched/ANTLRv4Parser.g4
../webzoo-prep//zoo/meta/syntax/bnf/everett/fetched/bnf.g4
../webzoo-prep//zoo/objective-c/cuche-parr-mejia/fetched/ObjC.g4
../webzoo-prep//zoo/python/v3.x/v3.3.5/parr/fetched/Python3.g4
../webzoo-prep//zoo/smalltalk/redline/fetched/Smalltalk.g4
../webzoo-prep//zoo/xmlware/xml/parr/fetched/XMLLexer.g4
../webzoo-prep//zoo/xmlware/xml/parr/fetched/XMLParser.g4
*/