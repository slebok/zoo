module bgf2rsc::GeneratedLLL
import util::IDE; // needed only for advanced IDE support
start syntax LLLGrammar = LLLLayoutList LLLProduction+ LLLLayoutList;
syntax LLLProduction = LLLNonterminal ":" {LLLDefinition "|"}+ ";";
syntax LLLDefinition = LLLSymbol+;
syntax LLLSymbol
 = @category="Identifier" nonterminal: LLLNonterminal
 | @category="Constant" terminal: LLLTerminal
 | group: "(" LLLDefinition ")"
 | optional: LLLSymbol "?"
 | star: LLLSymbol "*"
 | plus: LLLSymbol "+"
 | sepliststar: "{" LLLSymbol LLLSymbol "}*"
 | seplistplus: "{" LLLSymbol LLLSymbol "}+";
lexical LLLTerminal = "\"" LLLTerminalSymbol* "\"";
lexical LLLTerminalSymbol = ![\"];
lexical LLLNonterminal = [A-Za-z_01-9\-/]+ !>> [A-Za-z_01-9\-/];
layout LLLLayoutList = LLLLayout* !>> [\t-\n \r \ ]!>> "#";
lexical LLLLayout = [\t-\n \r \ ] | LLLComment ;
lexical LLLComment = @category="Comment" "#"![\n]* [\n];
Tree getLLL(str s,loc z) = parse(#LLLGrammar,z);
public void registerLLL() = registerLanguage("LLL","lll",getLLL);