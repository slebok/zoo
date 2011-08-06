module MediaWiki

syntax WikiText = WikiSymbol*;

syntax WikiSymbol
	= MWWord w
	| WikiLink wl;

syntax WikiLink
	= simple: "[[" PageName destination "]]"
	| barred: "[[" PageName destination "|" MWWord+ description "]]"
	;
	
lexical MWWord
	= ![\ \t\n\r\[\]]+ !>> ![\ \t\n\r\[\]]
	;

// http://en.wikipedia.org/wiki/Wikipedia:Naming_conventions_(technical_restrictions)#Forbidden_characters
lexical PageName
	= ![#\<\>\[\]|{}\t\n\r]+ !>> ![#\<\>\[\]|{}\t\n\r] 
	;

layout MediaWiki = [\ \t\n\r]* !>> [\ \t\n\r];

// needed if you want to run an eclipse editor
public WikiText parsewikitext(str i, loc s){return parse(#WikiText, i, s);}
// import util::IDE;
// import MediaWiki;
// registerLanguage("MediaWiki","wiki",parsewikitext);
// registerContributions("MediaWiki",{popup(menu("ANTLR",[edit("transform", ppWT)]))});


public str ppWT((WikiText)`<WikiSymbol* wss>`)
{
 return "<for(ws <- wss){><ppWS(ws)><}>";
}

public str ppWS((WikiSymbol)`<MWWord w>`)
{
 return "<w>";
}

public str ppWS((WikiSymbol)`<WikiLink wl>`)
{
 if ( wl.prod.def.name == "simple" )
  return "[[<wl.destination>]]";
 else
  return "[[<wl.description>|<wl.destination>]]";
}

// import MediaWiki;
// parse(#WikiText,|project://wiki/src/test.wiki|)
// parse(#WikiText,"some [[Wiki]] text")
// ppWT(parse(#WikiText,"some [[Wiki]] text"))
