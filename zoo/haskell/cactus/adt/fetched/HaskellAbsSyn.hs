module HaskellAbsSyn where

data Modul
  = Module Modid (Maybe [Export]) ([Impdecl], [Decl])
  deriving (Show, Read, Eq)

data Export
  = ExportQVar   Id
  | ExportType   Qtycon Details
  | ExportModule Modid
  deriving (Show, Read, Eq)

data Impdecl
  = Import (Maybe String) Modid (Maybe Modid) (Maybe [Import])
  deriving (Show, Read, Eq)

data Import
  = ImportVar  Id
  | ImportType Tycon Details
  deriving (Show, Read, Eq)

data Qualtype
  = QualType [Type] Type
  deriving (Show, Read, Eq)

data Fixity
  = InfixL
  | InfixR
  | Infix 
  deriving (Show, Read, Eq)

data Gtycon
  = GTycon     Qtycon
  | UnitTycon 
  | ListTycon 
  | FunTycon  
  | TupleTycon [Char]
  deriving (Show, Read, Eq)

data Simpletype
  = SimpleType Tycon [Tyvar]
  deriving (Show, Read, Eq)

data Constr
  = Constr       Id [(Strictness, Type)]
  | ConstrFields Id [([Id], (Strictness, Type))]
  deriving (Show, Read, Eq)

data Strictness
  = Lazy  
  | Strict
  deriving (Show, Read, Eq)

data Newconstr
  = NewConstr      Id Type
  | NewConstrField Id Id Type
  deriving (Show, Read, Eq)

data Inst
  = ConInst   Gtycon [Tyvar]
  | TupleInst [Tyvar]
  | ListInst  Tyvar
  | FunInst   Tyvar Tyvar
  deriving (Show, Read, Eq)

data Rhs
  = Rhs   Exp [Decl]
  | GdRhs [(Exp, Exp)] [Decl]
  deriving (Show, Read, Eq)

data Alt
  = Alt   Pat Exp [Decl]
  | GdAlt Pat [(Exp, Exp)] [Decl]
  deriving (Show, Read, Eq)

data Gcon
  = UnitCon 
  | NilCon  
  | TupleCon [Char]
  | QCon     Id
  deriving (Show, Read, Eq)

data Modid
  = ModId String
  deriving (Show, Read, Eq)

data Qtycon
  = QTycon String
  deriving (Show, Read, Eq)

data Tycon
  = Tycon String
  deriving (Show, Read, Eq)

data Tyvar
  = Tyvar String
  deriving (Show, Read, Eq)

data Tycls
  = Tycls String
  deriving (Show, Read, Eq)

data Details
  = NoDetails      
  | AllDetails     
  | SpecificDetails [Id]
  deriving (Show, Read, Eq)

data Id
  = Id        String
  | SymId     String
  | QId       String
  | QdSymId   String
  | ConId     String
  | ConsymId  String
  | QConId    String
  | QConsymId String
  | Op        String
  | IdOp      String
  | QOp       String
  | QIdOp     String
  | ConOp     String
  | ConIdOp   String
  | QConOp    String
  | QConIdOp  String
  deriving (Show, Read, Eq)

data Decl
  = Type     Simpletype Type
  | Data     [Type] Simpletype [Constr] (Maybe [QTycls])
  | Newtype  [Type] Simpletype Newconstr (Maybe [QTycls])
  | Class    [Type] Tycls Tyvar (Maybe [Decl])
  | Instance [Type] QTycls Inst (Maybe [Decl])
  | Default  [Type]
  | FunDecl  (Id, [Pat]) Rhs
  | PatDecl  Pat Rhs
  | TypeSig  [Id] Qualtype
  | Fixity   Fixity (Maybe String) [Id]
  deriving (Show, Read, Eq)

data Type
  = FunType   Type Type
  | AppType   Type Type
  | ConType   Gtycon
  | VarType   Tyvar
  | TupleType [Type]
  | ListType  Type
  deriving (Show, Read, Eq)

data Exp
  = TypedExp Exp Qualtype
  | OpExp    Exp Id Exp
  | NegExp   Exp
  | Lambda   [Pat] Exp
  | Let      [Decl] Exp
  | If       Exp Exp Exp
  | Case     Exp [Alt]
  | Do       ([Qual], Exp)
  | App      Exp Exp
  | VarExp   Id
  | ConExp   Gcon
  | Lit      String
  | ParenExp Exp
  | TupleExp [Exp]
  | ListExp  [Exp]
  | Seq      Exp (Maybe Exp) (Maybe Exp)
  | LSection Exp Id
  | RSection Id Exp
  | FieldUpd Exp [(Id, Exp)]
  deriving (Show, Read, Eq)

data Qual
  = GenQual Exp Exp
  | LetQual [Decl]
  | GdGual  Exp
  deriving (Show, Read, Eq)

data Pat
  = OpPat    Pat Id Pat
  | NegPat   Pat
  | VarPat   Id
  | As       Id Pat
  | ConPat   Gcon [Pat]
  | FieldPat Id [(Id, Pat)]
  | LitPat   String
  | Wildcard
  | ParenPat Pat
  | TuplePat [Pat]
  | ListPat  [Pat]
  | IrrPat   Pat
  deriving (Show, Read, Eq)

data QTycls
  = QTycls String
  deriving (Show, Read, Eq)

