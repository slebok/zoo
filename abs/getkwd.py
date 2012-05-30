kwds = '''
"module"      { return sym(Terminals.MODULE); }
"import"      { return sym(Terminals.IMPORT); }
"export"      { return sym(Terminals.EXPORT); }
"from"        { return sym(Terminals.FROM); }
"class"       { return sym(Terminals.CLASS); }
"interface"   { return sym(Terminals.INTERFACE); }
"extends"     { return sym(Terminals.EXTENDS); }
"data"        { return sym(Terminals.DATA); }
"def"         { return sym(Terminals.DEF); }
"implements"  { return sym(Terminals.IMPLEMENTS); }
"delta"       { return sym(Terminals.DELTA); }
"adds"        { return sym(Terminals.ADDS); }
"modifies"    { return sym(Terminals.MODIFIES); }
"removes"     { return sym(Terminals.REMOVES); }
"hasField"    { return sym(Terminals.HASFIELD); }
"hasMethod"   { return sym(Terminals.HASMETHOD); }
"hasInterface" { return sym(Terminals.HASINTERFACE); }
"productline" { return sym(Terminals.PRODUCTLINE); }
"features"    { return sym(Terminals.OPTFEATURES); }
"after"       { return sym(Terminals.AFTER); }
"when"        { return sym(Terminals.WHEN); }
"product"     { return sym(Terminals.PRODUCT); }
"while"       { return sym(Terminals.WHILE); }
"return"      { return sym(Terminals.RETURN); }
"skip"        { return sym(Terminals.SKIP); }
"get"         { return sym(Terminals.GET); }
"null"        { return sym(Terminals.NULL); }
"await"       { return sym(Terminals.AWAIT); }
"if"          { return sym(Terminals.IF); }
"then"        { return sym(Terminals.THEN); }
"else"        { return sym(Terminals.ELSE); }
"suspend"     { return sym(Terminals.SUSPEND); }
"duration"    { return sym(Terminals.DURATION); }
"new"         { return sym(Terminals.NEW); }
"this"        { return sym(Terminals.THIS); }
"core"        { return sym(Terminals.CORE); }
"original"    { return sym(Terminals.ORIGINAL); }
".original"    { return sym(Terminals.DOTORIGINAL); }
"case"        { return sym(Terminals.CASE); }
"let"         { return sym(Terminals.LET); }
"in"          { return sym(Terminals.IN); }
"cog"         { return sym(Terminals.COG); }
"type"        { return sym(Terminals.TYPE); }
"assert"      { return sym(Terminals.ASSERT); }
"builtin"     { return sym(Terminals.BUILTIN); }
//
"root"      { return sym(Terminals.ROOT); }
"extension" { return sym(Terminals.EXTENSION); }
"group"     { return sym(Terminals.GROUP); }
"opt"       { return sym(Terminals.OPT); }
"oneof"     { return sym(Terminals.ONEOF); }
"allof"     { return sym(Terminals.ALLOF); }
//"Int"       { return sym(Terminals.INT); }
//"Bool"      { return sym(Terminals.BOOL); }
//"in"        { return sym(Terminals.IN); }
"ifin"      { return sym(Terminals.IFIN); }
"ifout"     { return sym(Terminals.IFOUT); }
"exclude"   { return sym(Terminals.EXCLUDE); }
"require"   { return sym(Terminals.REQUIRE); }
//"excludes"  { return sym(Terminals.EXCLUDE); }
//"requires"  { return sym(Terminals.REQUIRE); }
//"true"      { return sym(Terminals.TRUE); }
//"tt"        { return sym(Terminals.TRUE); }
//"false"     { return sym(Terminals.FALSE); }
//"ff"        { return sym(Terminals.FALSE); }

"("           { return sym(Terminals.LPAREN); }
")"           { return sym(Terminals.RPAREN); }
"{"           { return sym(Terminals.LBRACE); }
"}"           { return sym(Terminals.RBRACE); }
"["           { return sym(Terminals.LBRACKET); }
"]"           { return sym(Terminals.RBRACKET); }
","           { return sym(Terminals.COMMA); }
";"           { return sym(Terminals.SEMICOLON); }
":"           { return sym(Terminals.COLON); }

"?"           { return sym(Terminals.QMARK); }
".."          { return sym(Terminals.UNTIL); }
"."           { return sym(Terminals.DOT); }
"!"           { return sym(Terminals.BANG); }
"="           { return sym(Terminals.ASSIGN); }
"&"           { return sym(Terminals.GUARDAND); }
"=="          { return sym(Terminals.EQEQ); }
"!="          { return sym(Terminals.NOTEQ); }
"=>"          { return sym(Terminals.RARROW); }
"->"          { return sym(Terminals.IMPLIES); }
"<->"         { return sym(Terminals.EQUIV); }
 "+"	       { return sym(Terminals.PLUS); }
 "-"          { return sym(Terminals.MINUS); }
 "*"          { return sym(Terminals.MULT); }
 "/"          { return sym(Terminals.DIV); }
 "%"          { return sym(Terminals.MOD); }
"&&"          { return sym(Terminals.ANDAND); }
"||"          { return sym(Terminals.OROR); }
"|"          { return sym(Terminals.BAR); }
"~"          { return sym(Terminals.NEGATION); }
"<"          { return sym(Terminals.LT); }
">"          { return sym(Terminals.GT); }
"<="          { return sym(Terminals.LTEQ); }
">="          { return sym(Terminals.GTEQ); }
"_"          { return sym(Terminals.USCORE); }
"'"          { return sym(Terminals.PRIME); }

'''

defs = {}
for line in kwds.split('\n'):
	line = line.strip()
	if line.startswith('//'):
		continue
	elif line == '':
		continue
	else:
		name = line.split('Terminals.')[1].split(')')[0]
		defs[name] = line.split('"')[1]

for a in defs:
	print 'lexical',a,'=', '"'+defs[a]+'"',';'