module MediaWiki

syntax WikiText = WikiSymbol* wss;

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

