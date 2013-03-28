@contributor{BGF2Rascal automated exporter - SLPS - http://github.com/grammarware/slps/wiki/BGF2Rascal}
@contributor{Vadim Zaytsev - vadim@grammarware.net - CWI}
@contributor{Stijn de Gouw - CWI, Leiden University}
module lang::ABS

// Comments and whitespace
syntax LAYOUT
  = [\  \t \n \r \f]
  | Comment
  ;
layout LAYOUTLIST 
  = LAYOUT* !>> "//" !>> "/*" !>> [\t\n\ \r\f]
  ;

lexical Comment
  = @category="Comment" "//" ![\n]* [\n] 
    | @category="Comment" "/*" CommentChar* "*/" 
  ;

lexical CommentChar
  = ![*] 
    | Asterisk !>> [/] 
  ;

lexical Asterisk
  = [*] 
  ;

// from ABS.flex
lexical IDENTIFIER_OLD = [a-z] ([a-zA-Z0-9_])*;
syntax IDENTIFIER
  = @category="Identifier" IDENTIFIER_OLD \ YYINITIAL;

keyword YYINITIAL =  "module" | "import" | "export" | "from" | "class" | "interface" | "extends" | "data" | "def" | "implements" | "delta" | "uses" | "adds" | "modifies" | "removes" | "hasField" | "hasMethod" | "hasInterface" | "productline" | "features" | "after" | "when" | "product" | "by" | "while" | "return" | "skip" | "get" | "null" | "await" | "if" | "then" | "else" | "suspend" | "duration" | "new" | "movecogto" | "this" | "core" | "original" | ".original" | "case" | "let" | "in" | "cog" | "type" | "assert" | "builtin" | "root" | "extension" | "group" | "opt" | "oneof" | "allof" | "ifin" | "ifout" | "exclude" | "require" | "critical" | "port" | "rebind" | "location" | "move" | "father" | "sql" ;

keyword SQL =  "select" | "distinct" | "count" | "as" | "from" | "left" | "right" | "join" | "where" | "group" | "by" | "order" | "asc" | "desc" | "insert" | "into" | "values" | "update" | "set" | "not" | "and" | "or" | "true" | "false" | "is" | "null" | "case" | "when" | "then" | "else" | "end" ;
  
lexical TYPE_IDENTIFIER_OLD = [A-Z] ([a-zA-Z0-9_])*;
syntax TYPE_IDENTIFIER
   = @category="Type" TYPE_IDENTIFIER_OLD;

lexical INTLITERAL_OLD = [0] | [1-9][0-9]*;
syntax INTLITERAL
  = @category="Constant" INTLITERAL_OLD \ YYINITIAL;

lexical MODULE = "module";
lexical IMPORT = "import";
lexical EXPORT = "export";
lexical FROM = "from";
lexical CLASS = "class";
lexical INTERFACE = "interface";
lexical EXTENDS = "extends";
lexical DATA = "data";
lexical DEF = "def";
lexical IMPLEMENTS = "implements";
lexical DELTA = "delta";
lexical USES = "uses";
lexical ADDS = "adds";
lexical MODIFIES = "modifies";
lexical REMOVES = "removes";
lexical HASFIELD = "hasField";
lexical HASMETHOD = "hasMethod";
lexical HASINTERFACE = "hasInterface";
lexical PRODUCTLINE = "productline";
lexical OPTFEATURES = "features";
lexical AFTER = "after";
lexical WHEN = "when";
lexical PRODUCT = "product";
lexical BY = "by";
lexical WHILE = "while";
lexical RETURN = "return";
lexical SKIP = "skip";
lexical GET = "get";
lexical NULL = "null";
lexical AWAIT = "await";
lexical IF = "if";
lexical THEN = "then";
lexical ELSE = "else";
lexical SUSPEND = "suspend";
lexical DURATION = "duration";
lexical NEW = "new";
lexical MOVECOGTO = "movecogto";
lexical THIS = "this";
lexical CORE = "core";
lexical ORIGINAL = "original";
lexical DOTORIGINAL = ".original";
lexical CASE = "case";
lexical LET = "let";
lexical IN = "in";
lexical COG = "cog";
lexical TYPE = "type";
lexical ASSERT = "assert";
lexical BUILTIN = "builtin";
lexical ROOT = "root";
lexical EXTENSION = "extension";
lexical GROUP = "group";
lexical OPT = "opt";
lexical ONEOF = "oneof";
lexical ALLOF = "allof";
lexical IFIN = "ifin";
lexical IFOUT = "ifout";
lexical EXCLUDE = "exclude";
lexical REQUIRE = "require";
lexical CRITICAL = "critical";
lexical PORT = "port";
lexical REBIND = "rebind";
lexical LOC = "location";
lexical SUBLOC = "move";
lexical FATHER = "father";
lexical SQL = "sql";
lexical LPAREN = "(";
lexical RPAREN = ")";
lexical LPAREN = "(";
lexical RPAREN = ")";
lexical LBRACE = "{";
lexical RBRACE = "}";
lexical LBRACKET = "[";
lexical RBRACKET = "]";
lexical COMMA = ",";
lexical SEMICOLON = ";";
lexical COLON = ":";
lexical QMARK = "?";
lexical UNTIL = "..";
lexical DOT = ".";
lexical BANG = "!";
lexical ASSIGN = "=";
lexical GUARDAND = "&";
lexical EQEQ = "==";
lexical NOTEQ = "!=";
lexical RARROW = "=\>";
lexical IMPLIES = "-\>";
lexical EQUIV = "\<-\>";
lexical PLUS = "+";
lexical MINUS = "-";
lexical MULT = "*";
lexical DIV = "/";
lexical MOD = "%";
lexical ANDAND = "&&";
lexical OROR = "||";
lexical BAR = "|";
lexical NEGATION = "~";
lexical LT = "\<";
lexical GT = "\>";
lexical LTEQ = "\<=";
lexical GTEQ = "\>=";
lexical USCORE = "_";
lexical PRIME = "\'";
lexical SELECT = "select";
lexical DISTINCT = "distinct";
lexical COUNT = "count";
lexical AS = "as";
lexical FROM = "from";
lexical LEFT = "left";
lexical RIGHT = "right";
lexical JOIN = "join";
lexical WHERE = "where";
lexical GROUP = "group";
lexical BY = "by";
lexical ORDER = "order";
lexical ASC = "asc";
lexical DESC = "desc";
lexical INSERT = "insert";
lexical INTO = "into";
lexical VALUES = "values";
lexical UPDATE = "update";
lexical SET = "set";
lexical NOT = "not";
lexical AND = "and";
lexical OR = "or";
lexical TRUE = "true";
lexical FALSE = "false";
lexical IS = "is";
lexical NULL = "null";
lexical CASE = "case";
lexical WHEN = "when";
lexical THEN = "then";
lexical ELSE = "else";
lexical END = "end";
lexical DOT = ".";
lexical EQ = "=";
lexical PLUS = "+";
lexical MINUS = "-";
lexical MULT = "*";
lexical DIV = "/";
lexical CONCAT = "||";
lexical LT = "\<";
lexical GT = "\>";
lexical LTEQ = "\<=";
lexical GTEQ = "\>=";
lexical NOTEQ = "\<\>";

// from ABS.parser
syntax ABSGoal
        = CompilationUnit cu
 ;
syntax CompilationUnit
        = 
        ModuleDeclList m? DeltaDeclList d? ProductLine pl? ProductList p? Featuremodeldecl fm
 ;
syntax ModuleDecl
        = 
        ModuleNameDecl n ExportList el? ImportList il? DeclList dl? MainBlock b?
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
syntax QualifiedInterfaceDecl
        = 
        AnnotationList al? INTERFACE TypeName id ExtendsInterfaces i? LBRACE MethodsigList l? RBRACE
 ;
syntax ClassDecl
        = AnnotationList annotations? CLASS TYPE_IDENTIFIER id ParamDecls params? ImplementInterfaces i? LBRACE FieldDeclList fields? InitBlock initBlock? MethodList methods? RBRACE
 ;
syntax QualifiedClassDecl
        = AnnotationList annotations? CLASS TypeName id ParamDecls params? ImplementInterfaces i? LBRACE FieldDeclList fields? InitBlock initBlock? MethodList methods? RBRACE
 ;
syntax DeltaDecl
        = 
        DELTA TYPE_IDENTIFIER id DeltaParamDecls params? SEMICOLON DeltaAccessList uses? ModuleModifierList modifiers?
 ;
syntax DeltaDeclList
        = DeltaDecl t
        | DeltaDeclList l DeltaDecl t
 ;
syntax DeltaAccessList
        = DeltaAccess t
        | DeltaAccessList l DeltaAccess t
 ;
syntax DeltaAccess
        = 
        USES ModuleName m SEMICOLON
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
syntax ModuleModifierList
        = ModuleModifier m
        | ModuleModifierList l ModuleModifier m
 ;
syntax ModuleModifier
        = FunctionalModifier m
        | OoModifier m
 ;
syntax FunctionalModifier
        = ADDS FunctionDecl functiondecl
        | ADDS DatatypeDecl datatypedecl
        | ADDS TypesynDecl typesyndecl
        | MODIFIES TypesynDecl typesyndecl
        | MODIFIES DatatypeDecl datatypedecl
 ;
syntax OoModifier
        = ADDS QualifiedClassDecl classdecl
        | REMOVES CLASS TypeName id SEMICOLON
        | MODIFIES CLASS TypeName id ImplementInterfacesAdd ifadd? ImplementInterfacesRemove ifremove? LBRACE ModifierFragmentList fragments? RBRACE
        | ADDS QualifiedInterfaceDecl ifacedecl
        | MODIFIES INTERFACE TypeName id LBRACE InfModifierFragmentList fragments? RBRACE
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
syntax ImplementInterfacesAdd
        = 
        ADDS IfnameList i
 ;
syntax ImplementInterfacesRemove
        = 
        REMOVES IfnameList i
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
        | AnnotationList an? PORT TypeExp t IDENTIFIER i ASSIGN DataExp e
        | AnnotationList an? PORT TypeExp t IDENTIFIER i
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
        | CRITICAL Methodsig ms Block b
 ;
syntax Methodsig
        = 
        AnnotationList al? TypeExp returntype IDENTIFIER id LPAREN ParamDeclList params? RPAREN
 ;
syntax PureExp
        = PureExpNoIf
        | IfExp
        | LocationExp "/"* Component* "/"
        | FatherExp "/"* Component* "/"
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
syntax LocationExp
        = 
        LOC LPAREN PureExp param RPAREN
 ;
syntax FatherExp
        = 
        FATHER LPAREN PureExp param RPAREN
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
syntax SqlStringLiteral
        = 
        SQLSTRINGLITERAL s
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
        AnnotationList annotations? COG
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
        | SQL LPAREN SqlExp e RPAREN
        | AsyncCall
        | SyncCall
        | OriginalCall
        | NewlocExp "/"* Component* "/"
        | IncompleteExp
 ;
syntax NewExp
        = 
        NEW Cog c? TypeName i LPAREN DataExpList l? RPAREN
 ;
syntax NewlocExp
        = 
        NEW LOC
 ;
syntax SqlExp
        = SELECT SqlAttrsDef a FROM SqlRelationRef r OptSqlCondition c SqlGroupingAttributes g SqlOrderingAttributes o
        | SELECT DISTINCT SqlAttrsDef a FROM SqlRelationRef r OptSqlCondition c SqlGroupingAttributes g SqlOrderingAttributes o
        | INSERT INTO SqlRelationRef r LPAREN SqlAttrRefList a RPAREN VALUES LPAREN SqlTupleConstantList v RPAREN
        | UPDATE SqlRelationRef r SET SqlAttrAssignmentList a OptSqlCondition c
 ;
syntax SqlAttrsDef
        = MULT
        | SqlAttrDefList l
 ;
syntax SqlAttrDefList
        = SqlAttrDef a
        | SqlAttrDefList l COMMA SqlAttrDef a
 ;
syntax SqlAttrDef
        = Factor f
        | SqlAggregateFunction fun AS DataExp e
 ;
syntax SqlAttrRefList
        = SqlAttrRef a
        | SqlAttrRefList l COMMA SqlAttrRef a
 ;
syntax SqlAttrRef
        = 
        DataExp
 ;
syntax SqlAttrAssignment
        = 
        DataExp e EQ SqlTupleScalarFunction f
 ;
syntax SqlAttrAssignmentList
        = SqlAttrAssignment a
        | SqlAttrAssignmentList l COMMA SqlAttrAssignment a
 ;
syntax SqlRelationRef
        = SqlAtomicRelationRef
        | SqlRelationRef r1 JOIN SqlAtomicRelationRef r2
        | SqlRelationRef r1 LEFT JOIN SqlAtomicRelationRef r2
        | SqlRelationRef r1 RIGHT JOIN SqlAtomicRelationRef r2
 ;
syntax SqlAtomicRelationRef
        = StringLiteral r
        | VarOrFieldRef r
 ;
syntax OptSqlCondition
        = WHERE SqlOrCondition c
        | ()
 ;
syntax SqlOrCondition
        = SqlAndCondition
        | SqlOrCondition c1 OR op SqlAndCondition c2
 ;
syntax SqlAndCondition
        = SqlCondition
        | SqlAndCondition c1 AND op SqlCondition c2
 ;
syntax SqlCondition
        = LPAREN SqlOrCondition c RPAREN
        | SqlTupleScalarFunction f1 SqlComparisonRelation r SqlTupleScalarFunction f2
        | StringLiteral a IS NULL
        | NOT SqlCondition c
 ;
syntax SqlTupleScalarFunction
        = 
        SqlTupleScalarFunctionConcat
 ;
syntax SqlTupleScalarFunctionConcat
        = SqlTupleScalarFunctionSum
        | SqlTupleScalarFunctionConcat f1 CONCAT SqlTupleScalarFunctionSum f2
 ;
syntax SqlTupleScalarFunctionSum
        = SqlTupleScalarFunctionProduct
        | SqlTupleScalarFunctionSum f1 PLUS SqlTupleScalarFunctionProduct f2
        | SqlTupleScalarFunctionSum f1 MINUS SqlTupleScalarFunctionProduct f2
        | SqlTupleScalarFunctionSum f1 MINUS LPAREN SqlTupleScalarFunctionSum f2 RPAREN
 ;
syntax SqlTupleScalarFunctionProduct
        = SqlTupleScalarFunctionQuotient
        | SqlTupleScalarFunctionProduct f1 MULT SqlTupleScalarFunctionQuotient f2
        | SqlTupleScalarFunctionProduct f1 MULT LPAREN SqlTupleScalarFunctionSum f2 RPAREN
 ;
syntax SqlTupleScalarFunctionQuotient
        = AtomicSqlTupleScalarFunction
        | SqlTupleScalarFunctionQuotient f1 DIV AtomicSqlTupleScalarFunction f2
        | SqlTupleScalarFunctionQuotient f1 DIV LPAREN SqlTupleScalarFunctionSum f2 RPAREN
 ;
syntax AtomicSqlTupleScalarFunction
        = StringLiteral a
        | SqlTupleConstant
        | SqlTupleCaseFunction
 ;
syntax SqlTupleConstant
        = SqlStringLiteral s
        | IntLiteral i
        | MINUS IntLiteral i
        | TRUE
        | FALSE
        | VarOrFieldRef r
 ;
syntax SqlTupleConstantList
        = SqlTupleConstant c
        | SqlTupleConstantList l COMMA SqlTupleConstant c
 ;
syntax SqlTupleCaseFunction
        = 
        CASE SqlTupleCaseBranches b ELSE SqlTupleScalarFunction f END
 ;
syntax SqlTupleCaseBranches
        = SqlTupleCaseBranch b
        | SqlTupleCaseBranches l SqlTupleCaseBranch b
 ;
syntax SqlTupleCaseBranch
        = 
        WHEN SqlOrCondition c THEN SqlTupleScalarFunction f
 ;
syntax SqlComparisonRelation
        = EQ
        | LT
        | GT
        | LTEQ
        | GTEQ
        | NOTEQ
 ;
syntax SqlAggregateFunction
        = COUNT LPAREN MULT RPAREN
        | SqlTupleScalarFunction f
        | IDENTIFIER i LPAREN SqlTupleScalarFunction f RPAREN
 ;
syntax SqlGroupingAttributes
        = GROUP BY SqlAttrRefList a
        | ()
 ;
syntax SqlOrderingAttributes
        = ORDER BY SqlOrderingAttributeList l
        | ()
 ;
syntax SqlOrderingAttributeList
        = SqlOrderingAttribute a
        | SqlOrderingAttributeList l COMMA SqlOrderingAttribute a
 ;
syntax SqlOrderingAttribute
        = DataExp e ASC
        | DataExp e DESC
        | DataExp e
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
        | CORE DOTORIGINAL LPAREN DataExpList params? RPAREN
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
        | MOVECOGTO DataExp
        | SUSPEND
        | DURATION LPAREN DataExp min COMMA DataExp max RPAREN
        | RETURN Exp e
        | VarDecl vd
        | ASSERT DataExp e
        | EffExp e
        | REBIND Exp obj COLON IDENTIFIER field ASSIGN Exp e
        | REBIND IDENTIFIER field ASSIGN Exp e
        | SUBLOC PureExp sub IN PureExp father
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
        | BAR Exp e BAR
 ;
syntax ProductLine
        = 
        PRODUCTLINE TYPE_IDENTIFIER id SEMICOLON OptfeatureList o CorefeatureList c DeltaclauseList d
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
        DELTA Deltaspec d AfterCondition a? FromCondition f? WhenCondition w?
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
syntax FromCondition
        = 
        FROM Appcond ac
 ;
syntax WhenCondition
        = WHEN Appcond ac
        | TO Appcond ac
 ;
syntax Appcond
        = 
        OrAppcond
 ;
syntax OrAppcond
        = AndAppcond
        | OrAppcond ac1 OROR AndAppcond ac2
 ;
syntax AndAppcond
        = FactorAppcond
        | AndAppcond ac1 ANDAND FactorAppcond ac2
 ;
syntax FactorAppcond
        = Feature f
        | NEGATION FactorAppcond ac
        | LPAREN Appcond ac RPAREN
 ;
syntax ProductList
        = Product p
        | ProductList l Product p
 ;
syntax Product
        = PRODUCT TYPE_IDENTIFIER id LPAREN FeatureList l? RPAREN SEMICOLON
        | PRODUCT TYPE_IDENTIFIER id LPAREN FeatureList l? RPAREN LBRACE AdaptationList al RBRACE
 ;
syntax AdaptationList
        = Adaptation ad
        | AdaptationList l Adaptation ad
 ;
syntax Adaptation
        = 
        TYPE_IDENTIFIER product BY TYPE_IDENTIFIER update SEMICOLON
 ;
syntax Featuremodeldecl
        = ()
        | Featuremodeldecl l ROOT FeatureDecl f
        | Featuremodeldecl l EXTENSION Fextension ext
 ;
syntax Fextension
        = 
        TYPE_IDENTIFIER f LBRACE Group g? AttributeConstraintList acl RBRACE
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
syntax IntList
        = INTLITERAL i
        | IntList il COMMA INTLITERAL i
        | MINUS INTLITERAL i
        | IntList il COMMA MINUS INTLITERAL i
 ;
syntax AttributeConstraintList
        = "/"* Attributes* "/"
        | AttributeConstraintList acl TYPE_IDENTIFIER t IDENTIFIER id IN LBRACE IntList il RBRACE SEMICOLON
        | AttributeConstraintList acl TYPE_IDENTIFIER t IDENTIFIER id IN LBRACKET BoundaryInt b1 UNTIL BoundaryInt b2 RBRACKET SEMICOLON
        | AttributeConstraintList acl TYPE_IDENTIFIER t LBRACKET BoundaryInt b1 UNTIL BoundaryInt b2 RBRACKET IDENTIFIER id SEMICOLON
        | AttributeConstraintList acl TYPE_IDENTIFIER t IDENTIFIER id SEMICOLON "/"* Constraints* "/"
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
