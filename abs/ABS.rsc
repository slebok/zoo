@contributor{bgf2src automated exporter - SLPS}
@contributor{Vadim Zaytsev - vadim@grammarware.net - CWI}
module ABS

// from ABS.flex
//lexical LineTerminator = [\r\n] | "\r\n";
//lexical InputCharacter = ![\r\n];
//layout WhiteSpace = LineTerminator | [ \t\f];
layout WS = [\t-\n \r \ ]* !>> [\t-\n \r \ ];
lexical Comment = TraditionalComment	| EndOfLineComment;
lexical TraditionalComment = "/*" ![*] "*/" | "/*" "*"+ "/" | "/*" "*"+ ![*/] "*/"; 
lexical EndOfLineComment = "//" InputCharacter* LineTerminator?;
lexical IDENTIFIER  = [a-z] ([a-zA-Z] | [0-9] | "_")*;
lexical TYPE_IDENTIFIER  = [A-Z] ([a-zA-Z] | [0-9] | "_")*;
lexical IntLiteral = [0] | [1-9][0-9]*;

keyword YYINITIAL =  "module" | "import" | "export" | "from" | "class" | "interface" | "extends" |
"data" | "def" | "implements" | "delta" | "adds" | "modifies" | "removes" | "hasField" | "hasMethod" |
"hasInterface" | "productline" | "features" | "after" | "when" | "product" | "while" | "return" | "skip" |
"get" | "null" | "await" | "if" | "then" | "else" | "suspend" | "duration" | "new" | "this" | "core" |
"original" | "case" | "let" | "in" | "cog" | "type" | "assert" | "builtin" | "root" | "extension" | "group" |
"opt" | "oneof" | "allof" | "ifin" | "ifout" | "exclude" | "require" ;

lexical PRODUCTLINE = "productline" ;
lexical LBRACKET = "[" ;
lexical MINUS = "-" ;
lexical GROUP = "group" ;
lexical RPAREN = ")" ;
lexical PLUS = "+" ;
lexical IMPORT = "import" ;
lexical PRIME = "\'" ;
lexical IMPLEMENTS = "implements" ;
lexical GT = "\>" ;
lexical RBRACE = "}" ;
lexical IFOUT = "ifout" ;
lexical MODULE = "module" ;
lexical EXTENDS = "extends" ;
lexical ADDS = "adds" ;
lexical THIS = "this" ;
lexical HASMETHOD = "hasMethod" ;
lexical AFTER = "after" ;
lexical NEGATION = "~" ;
lexical ASSIGN = "=" ;
lexical INTERFACE = "interface" ;
lexical OROR = "||" ;
lexical RETURN = "return" ;
lexical EQEQ = "==" ;
lexical REQUIRE = "require" ;
lexical HASINTERFACE = "hasInterface" ;
lexical USCORE = "_" ;
lexical DEF = "def" ;
lexical GET = "get" ;
lexical RARROW = "=\>" ;
lexical COLON = ":" ;
lexical MODIFIES = "modifies" ;
lexical ROOT = "root" ;
lexical ELSE = "else" ;
lexical UNTIL = ".." ;
lexical OPT = "opt" ;
lexical LBRACE = "{" ;
lexical AWAIT = "await" ;
lexical REMOVES = "removes" ;
lexical MOD = "%" ;
lexical THEN = "then" ;
lexical GTEQ = "\>=" ;
lexical IFIN = "ifin" ;
lexical WHILE = "while" ;
lexical COG = "cog" ;
lexical ORIGINAL = "original" ;
lexical NEW = "new" ;
lexical DOT = "." ;
lexical CASE = "case" ;
lexical SEMICOLON = ";" ;
lexical GUARDAND = "&" ;
lexical NOTEQ = "!=" ;
lexical CORE = "core" ;
lexical IMPLIES = "-\>" ;
lexical PRODUCT = "product" ;
lexical ANDAND = "&&" ;
lexical QMARK = "?" ;
lexical LTEQ = "\<=" ;
lexical LET = "let" ;
lexical TYPE = "type" ;
lexical BAR = "|" ;
lexical EXTENSION = "extension" ;
lexical OPTFEATURES = "features" ;
lexical DOTORIGINAL = ".original" ;
lexical ASSERT = "assert" ;
lexical BUILTIN = "builtin" ;
lexical EXPORT = "export" ;
lexical DURATION = "duration" ;
lexical DIV = "/" ;
lexical NULL = "null" ;
lexical DATA = "data" ;
lexical MULT = "*" ;
lexical SUSPEND = "suspend" ;
lexical WHEN = "when" ;
lexical LT = "\<" ;
lexical COMMA = "," ;
lexical EXCLUDE = "exclude" ;
lexical CLASS = "class" ;
lexical ALLOF = "allof" ;
lexical SKIP = "skip" ;
lexical BANG = "!" ;
lexical LPAREN = "(" ;
lexical IN = "in" ;
lexical IF = "if" ;
lexical ONEOF = "oneof" ;
lexical FROM = "from" ;
lexical DELTA = "delta" ;
lexical HASFIELD = "hasField" ;
lexical RBRACKET = "]" ;
lexical EQUIV = "\<-\>" ;



// from ABS.parser
start syntac Goal
        = CompilationUnit cu
 ;
syntax CompilationUnit
        = 
        ModuleDeclList m? RootfeatureList r FextensionList ext
 ;
syntax ModuleDecl
        = 
        ModuleNameDecl n ExportList el? ImportList il? DeclList dl? ProductLine pr? ProductList pl? MainBlock b?
 ;
syntax ModuleDeclList
        = ModuleDecl t
        | ModuleDeclList l ModuleDecl t
 ;
syntax ModuleNameDecl
        = 
        MODULE ModuleName n SEMICOLON
 ;
syntax ModuleName
        = 
        TypeName
 ;
syntax SimpleTypeName
        = 
        TYPE_IDENTIFIER id
 ;
syntax SimpleName
        = 
        IDENTIFIER id
 ;
syntax Name
        = SimpleName
        | QualifiedName
 ;
syntax TypeName
        = SimpleTypeName
        | QualifiedTypeName
 ;
syntax AnyName
        = Name
        | TypeName
 ;
syntax QualifiedName
        = 
        TypeName qn DOT IDENTIFIER n
 ;
syntax QualifiedTypeName
        = 
        TypeName qn DOT TYPE_IDENTIFIER n
 ;
syntax Export
        = EXPORT AnyNameList l SEMICOLON
        | EXPORT MULT SEMICOLON
        | EXPORT MULT FROM ModuleName m SEMICOLON
        | EXPORT AnyNameList l FROM ModuleName m SEMICOLON
 ;
syntax Import
        = IMPORT MULT FROM ModuleName m SEMICOLON
        | IMPORT AnyNameList l FROM ModuleName m SEMICOLON
        | IMPORT AnyNameList l SEMICOLON
 ;
syntax ExportList
        = Export t
        | ExportList l Export t
 ;
syntax ImportList
        = Import t
        | ImportList l Import t
 ;
syntax AnyNameList
        = AnyName n
        | AnyNameList l COMMA AnyName n
 ;
syntax DeclList
        = Decl t
        | DeclList l Decl t
 ;
syntax Decl
        = DatatypeDecl
        | TypesynDecl
        | FunctionDecl
        | InterfaceDecl
        | ClassDecl
        | DeltaDecl
 ;
syntax MainBlock
        = 
        AnnotationList al? LBRACE StmtList s? RBRACE
 ;
syntax InitBlock
        = 
        Block
 ;
syntax VarDecl
        = TypeExp t IDENTIFIER i ASSIGN Exp e
        | TypeExp t IDENTIFIER i
 ;
syntax DatatypeDecl
        = AnnotationList al? DATA TYPE_IDENTIFIER id DatatypeparamListDecl p? ASSIGN DataConstructorList l SEMICOLON
        | AnnotationList al? DATA TYPE_IDENTIFIER id DatatypeparamListDecl p? SEMICOLON
 ;
syntax TypesynDecl
        = 
        AnnotationList al? TYPE TYPE_IDENTIFIER lhs ASSIGN Datatypeuse rhs SEMICOLON
 ;
syntax FunctionDecl
        = AnnotationList al? DEF Datatypeuse t IDENTIFIER fn DatatypeparamListDecl p LPAREN ParamDeclList l? RPAREN ASSIGN BUILTIN SEMICOLON
        | AnnotationList al? DEF Datatypeuse t IDENTIFIER fn DatatypeparamListDecl p LPAREN ParamDeclList l? RPAREN ASSIGN ExpFunctionDef ef SEMICOLON
        | AnnotationList al? DEF Datatypeuse t IDENTIFIER fn LPAREN ParamDeclList l? RPAREN ASSIGN BUILTIN SEMICOLON
        | AnnotationList al? DEF Datatypeuse t IDENTIFIER fn LPAREN ParamDeclList l? RPAREN ASSIGN ExpFunctionDef ef SEMICOLON
 ;
syntax ExpFunctionDef
        = 
        DataExp ef
 ;
syntax InterfaceDecl
        = AnnotationList al? INTERFACE TYPE_IDENTIFIER id ExtendsInterfaces i? LBRACE MethodsigList l? RBRACE
 ;
syntax ClassDecl
        = AnnotationList annotations? CLASS TYPE_IDENTIFIER id ParamDecls params? ImplementInterfaces i? LBRACE FieldDeclList fields? InitBlock initBlock? MethodList methods? RBRACE
 ;
syntax DeltaDecl
        = 
        AnnotationList annotations? DELTA TYPE_IDENTIFIER id DeltaParamDecls params? LBRACE FunctionalModifierList fnmodifiers? ClassModifierList modifiers? RBRACE
 ;
syntax DeltaParamDecls
        = 
        LPAREN DeltaParamDeclList f? RPAREN
 ;
syntax DeltaParamDeclList
        = DeltaParamDecl i
        | DeltaParamDeclList l COMMA DeltaParamDecl i
 ;
syntax DeltaParamDecl
        = ParamDecl p
        | TYPE_IDENTIFIER id HasCondition c
 ;
syntax HasCondition
        = HASFIELD FieldDecl f
        | HASMETHOD Methodsig ms
        | HASINTERFACE TypeName n
 ;
syntax FunctionalModifierList
        = FunctionalModifier m
        | FunctionalModifierList l FunctionalModifier m
 ;
syntax FunctionalModifier
        = ADDS FunctionDecl functiondecl
        | ADDS DatatypeDecl datatypedecl
        | ADDS TypesynDecl typesyndecl
 ;
syntax ClassModifierList
        = ClassModifier m
        | ClassModifierList l ClassModifier m
 ;
syntax ClassModifier
        = ADDS QualifiedClassDecl classdecl
        | REMOVES CLASS TYPE_IDENTIFIER id SEMICOLON
        | MODIFIES CLASS TYPE_IDENTIFIER id ImplementInterfaces iface? LBRACE ModifierFragmentList fragments? RBRACE
        | ADDS InterfaceDecl ifacedecl
        | MODIFIES INTERFACE TYPE_IDENTIFIER id LBRACE InfModifierFragmentList fragments? RBRACE
 ;
syntax QualifiedClassDecl
        = AnnotationList annotations? CLASS SimpleQualName id ParamDecls params? ImplementInterfaces i? LBRACE FieldDeclList fields? InitBlock initBlock? MethodList methods? RBRACE
 ;
syntax SimpleQualName
        = TYPE_IDENTIFIER id
        | TYPE_IDENTIFIER mod DOT TYPE_IDENTIFIER id
 ;
syntax InfModifierFragmentList
        = InfModifierFragment f
        | InfModifierFragmentList l InfModifierFragment f
 ;
syntax InfModifierFragment
        = ADDS Methodsig ms SEMICOLON
        | REMOVES Methodsig ms SEMICOLON
 ;
syntax ModifierFragmentList
        = ModifierFragment f
        | ModifierFragmentList l ModifierFragment f
 ;
syntax ModifierFragment
        = ADDS FieldDecl f SEMICOLON
        | REMOVES FieldDecl f SEMICOLON
        | ADDS Method m
        | MODIFIES Method m
        | REMOVES Methodsig ms SEMICOLON
 ;
syntax DataConstructorList
        = DataConstructor i
        | DataConstructorList l BAR DataConstructor i
 ;
syntax DataConstructor
        = 
        TYPE_IDENTIFIER co DataConstructorParams p?
 ;
syntax DataConstructorParams
        = 
        LPAREN ConstructorArgList l? RPAREN
 ;
syntax ConstructorArgList
        = ConstructorArg a
        | ConstructorArgList l COMMA ConstructorArg a
 ;
syntax ConstructorArg
        = Datatypeuse u IDENTIFIER id
        | Datatypeuse u
 ;
syntax ImplementInterfaces
        = 
        IMPLEMENTS IfnameList i
 ;
syntax ExtendsInterfaces
        = 
        EXTENDS IfnameList i
 ;
syntax AnnotationList
        = Annotation a
        | AnnotationList l Annotation a
 ;
syntax Annotation
        = LBRACKET TypeExp type COLON DataExp exp RBRACKET
        | LBRACKET DataExp exp RBRACKET
 ;
syntax Ifname
        = 
        TypeName n
 ;
syntax Datatypeuse
        = AnnotationList l? TypeName n LT DatatypeuseList p GT
        | AnnotationList l? TypeName n
 ;
syntax Datatypeparam
        = 
        TYPE_IDENTIFIER id
 ;
syntax TypeExp
        = TypeName n LT DatatypeuseList p GT
        | TypeName n
 ;
syntax FieldDeclList
        = FieldDecl i SEMICOLON
        | FieldDeclList l FieldDecl i SEMICOLON
 ;
syntax FieldDecl
        = AnnotationList an? TypeExp t IDENTIFIER i ASSIGN DataExp e
        | AnnotationList an? TypeExp t IDENTIFIER i
 ;
syntax ParamDecls
        = 
        LPAREN ParamDeclList f? RPAREN
 ;
syntax ParamDeclList
        = ParamDecl i
        | ParamDeclList l COMMA ParamDecl i
 ;
syntax ParamDecl
        = 
        AnnotationList an? TypeExp t IDENTIFIER i
 ;
syntax MethodList
        = Method i
        | MethodList l Method i
 ;
syntax MethodsigList
        = Methodsig m SEMICOLON
        | MethodsigList l Methodsig m SEMICOLON
 ;
syntax IfnameList
        = Ifname i
        | IfnameList l COMMA Ifname i
 ;
syntax DatatypeuseList
        = Datatypeuse i
        | DatatypeuseList l COMMA Datatypeuse i
 ;
syntax DatatypeparamListDecl
        = 
        LT DatatypeparamList l GT
 ;
syntax DatatypeparamList
        = Datatypeparam p
        | DatatypeparamList l COMMA Datatypeparam p
 ;
syntax Method
        = Methodsig ms Block b
 ;
syntax Methodsig
        = 
        AnnotationList al? TypeExp returntype IDENTIFIER id LPAREN ParamDeclList params? RPAREN
 ;
syntax PureExp
        = PureExpNoIf
        | IfExp
 ;
syntax PureExpNoIf
        = VarOrFieldRef
        | THIS
        | NULL
        | LetExp
        | ConstructorExp
        | FnappExp
        | FnappListExp
        | CaseExp
 ;
syntax VarOrFieldRef
        = THIS DOT IDENTIFIER id
        | IDENTIFIER n
        | THIS callee DOT d
        | THIS callee BANG b IDENTIFIER method?
 ;
syntax FnappListExp
        = 
        Name f ListLiteralExp l
 ;
syntax FnappExp
        = 
        Name f LPAREN DataExpList l? RPAREN
 ;
syntax ConstructorExp
        = TypeName f LPAREN DataExpList l? RPAREN
        | TypeName f
 ;
syntax IfExp
        = 
        IF DataExp e THEN DataExp c ELSE DataExp a
 ;
syntax CaseExp
        = 
        CASE DataExp caseterm LBRACE CaseBranchList branches? RBRACE
 ;
syntax DataExpList
        = DataExp i
        | DataExpList l COMMA DataExp i
 ;
syntax ListLiteralExp
        = 
        LBRACKET DataExpList l? RBRACKET
 ;
syntax DataExp
        = 
        OrExp
 ;
syntax OrExp
        = AndExp
        | OrExp e1 OROR AndExp e2
 ;
syntax AndExp
        = EqualityExp
        | AndExp e1 ANDAND EqualityExp e2
 ;
syntax EqualityExp
        = RelationalExp
        | EqualityExp e1 EQEQ RelationalExp e2
        | EqualityExp e1 NOTEQ RelationalExp e2
 ;
syntax RelationalExp
        = AddExp
        | RelationalExp e1 LT AddExp e2
        | RelationalExp e1 GT AddExp e2
        | RelationalExp e1 LTEQ AddExp e2
        | RelationalExp e1 GTEQ AddExp e2
 ;
syntax AddExp
        = MultExp e
        | AddExp e1 PLUS MultExp e2
        | AddExp e1 MINUS MultExp e2
 ;
syntax MultExp
        = Factor f
        | MultExp e1 MULT Factor e2
        | MultExp e1 DIV Factor e2
        | MultExp e1 MOD Factor e2
 ;
syntax Factor
        = Literal
        | PureExp
        | MINUS Factor e
        | NEGATION Factor b
        | LPAREN OrExp e RPAREN
 ;
syntax Literal
        = IntLiteral i
        | StringLiteral s
 ;
syntax StringLiteral
        = 
        STRINGLITERAL s
 ;
syntax IntLiteral
        = 
        INTLITERAL i
 ;
syntax LetExp
        = 
        LET LPAREN ParamDecl var RPAREN ASSIGN DataExp val IN DataExp exp
 ;
syntax CaseBranchList
        = CaseBranch b
        | CaseBranchList l CaseBranch b
 ;
syntax CaseBranch
        = 
        Pattern lhs RARROW DataExp rhs SEMICOLON
 ;
syntax Pattern
        = IDENTIFIER v
        | ConstructorPattern
        | Literal l
        | USCORE
 ;
syntax ConstructorPattern
        = 
        TypeName co PatternParams p?
 ;
syntax PatternParams
        = 
        LPAREN PatternList l? RPAREN
 ;
syntax PatternList
        = Pattern i
        | PatternList l COMMA Pattern i
 ;
syntax Cog
        = 
        COG g
 ;
syntax Exp
        = EffExp e
        | DataExp e
 ;
syntax PureExpPrefix
        = PureExpNoIf
        | LPAREN IfExp e RPAREN
 ;
syntax EffExp
        = PureExpPrefix p DOT GET
        | NewExp
        | AsyncCall
        | SyncCall
        | OriginalCall
        | IncompleteExp e
 ;
syntax NewExp
        = 
        NEW Cog c? TypeName i LPAREN DataExpList l? RPAREN
 ;
syntax AsyncCall
        = THIS callee BANG IDENTIFIER method LPAREN DataExpList params? RPAREN
        | PureExpPrefix callee BANG IDENTIFIER method LPAREN DataExpList params? RPAREN
 ;
syntax SyncCall
        = THIS callee DOT IDENTIFIER method LPAREN DataExpList params? RPAREN
        | PureExpPrefix callee DOT IDENTIFIER method LPAREN DataExpList params? RPAREN
 ;
syntax OriginalCall
        = ORIGINAL LPAREN DataExpList params? RPAREN
        | DeltaId delta DOTORIGINAL LPAREN DataExpList params? RPAREN
        | CORE DOT ORIGINAL LPAREN DataExpList params? RPAREN
 ;
syntax DeltaId
        = 
        TYPE_IDENTIFIER delta
 ;
syntax IncompleteExp
        = PureExpPrefix callee DOT d IDENTIFIER method?
        | PureExpPrefix callee BANG b IDENTIFIER method?
        | NEW Cog c?
 ;
syntax Stmt
        = AnnotationList al? CompoundStmt s
        | AnnotationList al? StmtWithoutAnnotations s SEMICOLON
 ;
syntax StmtWithoutAnnotations
        = VarOrFieldRef r ASSIGN Exp e
        | AWAIT Guard
        | SKIP
        | SUSPEND
        | DURATION LPAREN DataExp min COMMA DataExp max RPAREN
        | RETURN Exp e
        | VarDecl vd
        | ASSERT DataExp e
        | EffExp e
 ;
syntax CompoundStmt
        = IfThenElseStmt
        | WhileStmt
        | BlockWithoutAnnotations
 ;
syntax Block
        = 
        AnnotationList al? BlockWithoutAnnotations b
 ;
syntax BlockWithoutAnnotations
        = 
        LBRACE StmtList s? RBRACE
 ;
syntax IfThenElseStmt
        = IF LPAREN DataExp e1 RPAREN Stmt s1 ELSE Stmt s2
        | IF LPAREN DataExp e1 RPAREN Stmt s1
 ;
syntax WhileStmt
        = 
        WHILE LPAREN DataExp e1 RPAREN Stmt s1
 ;
syntax StmtList
        = Stmt i
        | StmtList l Stmt i
 ;
syntax Guard
        = VarOrFieldRef r QMARK
        | DURATION LPAREN DataExp min COMMA DataExp max RPAREN
        | DataExp e
        | Guard g1 GUARDAND Guard g2
 ;
syntax ProductLine
        = 
        PRODUCTLINE TYPE_IDENTIFIER id LBRACE OptfeatureList o CorefeatureList c DeltaclauseList d RBRACE
 ;
syntax OptfeatureList
        = ()
        | OPTFEATURES FeatureList l SEMICOLON
 ;
syntax CorefeatureList
        = ()
        | COREFEATURES FeatureList l SEMICOLON
 ;
syntax FeatureList
        = Feature f
        | FeatureList l COMMA Feature f
 ;
syntax Feature
        = TYPE_IDENTIFIER id AttrAssignments attrs?
        | TYPE_IDENTIFIER id PRIME AttrAssignments attrs?
 ;
syntax AttrAssignments
        = 
        LBRACE AttrAssignmentList l RBRACE
 ;
syntax AttrAssignmentList
        = AttrAssignment a
        | AttrAssignmentList l COMMA AttrAssignment a
 ;
syntax AttrAssignment
        = IDENTIFIER n ASSIGN INTLITERAL i
        | IDENTIFIER n ASSIGN TYPE_IDENTIFIER c
 ;
syntax DeltaclauseList
        = ()
        | DeltaclauseList l DeltaClause dc SEMICOLON
 ;
syntax DeltaClause
        = 
        DELTA Deltaspec d AfterCondition a? WhenCondition w?
 ;
syntax AfterCondition
        = 
        AFTER DeltaList l
 ;
syntax Delta
        = 
        TYPE_IDENTIFIER id
 ;
syntax DeltaList
        = Delta id
        | DeltaList l COMMA Delta id
 ;
syntax Deltaspec
        = 
        TYPE_IDENTIFIER id Deltaparams params?
 ;
syntax Deltaparams
        = 
        LPAREN DeltaparamList l RPAREN
 ;
syntax DeltaparamList
        = Deltaparam p
        | DeltaparamList l COMMA Deltaparam p
 ;
syntax Deltaparam
        = TYPE_IDENTIFIER fid DOT IDENTIFIER aid
        | INTLITERAL i
        | TYPE_IDENTIFIER c
 ;
syntax WhenCondition
        = 
        WHEN ApplicationCondition dl
 ;
syntax ApplicationCondition
        = Feature f
        | ApplicationCondition l ANDAND Feature f
 ;
syntax ProductList
        = Product p
        | ProductList l Product p
 ;
syntax Product
        = 
        PRODUCT TYPE_IDENTIFIER id LPAREN FeatureList l? RPAREN SEMICOLON
 ;
syntax FextensionList
        = ()
        | FextensionList l Fextension ext
 ;
syntax Fextension
        = 
        EXTENSION TYPE_IDENTIFIER f LBRACE Group g? AttributeConstraintList acl RBRACE
 ;
syntax RootfeatureList
        = ()
        | RootfeatureList l ROOT FeatureDecl f
 ;
syntax FeatureDecl
        = TYPE_IDENTIFIER f
        | TYPE_IDENTIFIER f LBRACE Group g? AttributeConstraintList acl RBRACE
 ;
syntax Group
        = 
        GROUP Cardinality c LBRACE FnodeList fs RBRACE
 ;
syntax FnodeList
        = Fnode f
        | FnodeList l COMMA Fnode f
        | ()
 ;
syntax Fnode
        = FeatureDecl f
        | OPT FeatureDecl f
 ;
syntax Cardinality
        = ONEOF
        | ALLOF
        | LBRACKET INTLITERAL i UNTIL MULT RBRACKET
        | LBRACKET INTLITERAL i1 UNTIL INTLITERAL i2 RBRACKET
 ;
syntax BoundaryInt
        = MULT
        | INTLITERAL i
        | MINUS INTLITERAL i
 ;
syntax AttributeConstraintList
        = ()
        | AttributeConstraintList acl TYPE_IDENTIFIER t IDENTIFIER id IN LBRACKET BoundaryInt b1 UNTIL BoundaryInt b2 RBRACKET SEMICOLON
        | AttributeConstraintList acl TYPE_IDENTIFIER t LBRACKET BoundaryInt b1 UNTIL BoundaryInt b2 RBRACKET IDENTIFIER id SEMICOLON
        | AttributeConstraintList acl TYPE_IDENTIFIER t IDENTIFIER id SEMICOLON
        | AttributeConstraintList acl IFIN COLON Mexp e SEMICOLON
        | AttributeConstraintList acl IFOUT COLON Mexp e SEMICOLON
        | AttributeConstraintList acl EXCLUDE COLON Featvar f SEMICOLON
        | AttributeConstraintList acl REQUIRE COLON Featvar f SEMICOLON
        | AttributeConstraintList acl Mexp e SEMICOLON
 ;
syntax Featvar
        = 
        TYPE_IDENTIFIER f
 ;
syntax Mexp
        = MandExp
        | Mexp e1 OROR MandExp e2
 ;
syntax MandExp
        = MimplExp
        | MandExp e1 ANDAND MimplExp e2
 ;
syntax MimplExp
        = MeqExp
        | MimplExp e1 IMPLIES MeqExp e2
        | MimplExp e1 EQUIV MeqExp e2
 ;
syntax MeqExp
        = MrelExp
        | MeqExp e1 EQEQ MrelExp e2
        | MeqExp e1 NOTEQ MrelExp e2
 ;
syntax MrelExp
        = MaddExp
        | MrelExp e1 LT MaddExp e2
        | MrelExp e1 GT MaddExp e2
        | MrelExp e1 LTEQ MaddExp e2
        | MrelExp e1 GTEQ MaddExp e2
 ;
syntax MaddExp
        = MmultExp e
        | MaddExp e1 PLUS MmultExp e2
        | MaddExp e1 MINUS MmultExp e2
 ;
syntax MmultExp
        = MfactorExp e
        | MmultExp e1 MULT MfactorExp e2
        | MmultExp e1 DIV MfactorExp e2
        | MmultExp e1 MOD MfactorExp e2
 ;
syntax MfactorExp
        = MlitExp
        | NEGATION MfactorExp e
        | MINUS MfactorExp e
        | LPAREN Mexp e RPAREN
 ;
syntax MlitExp
        = INTLITERAL i
        | IDENTIFIER id
        | TYPE_IDENTIFIER f DOT IDENTIFIER a
        | TYPE_IDENTIFIER id
 ;
