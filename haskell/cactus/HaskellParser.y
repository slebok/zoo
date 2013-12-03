{
module HaskellParser where
import Alex
import HaskellLexer(Token'(..), token'pos, tokens')
import HaskellAbsSyn
}

%tokentype { Token' }
%token
   "}"       { Tk_CSym        _ '}'        }
   ";"       { Tk_CSym        _ ';'        }
   "{"       { Tk_CSym        _ '{'        }
   ")"       { Tk_CSym        _ ')'        }
   "("       { Tk_CSym        _ '('        }
   ","       { Tk_CSym        _ ','        }
   "="       { Tk_CSym        _ '='        }
   "]"       { Tk_CSym        _ ']'        }
   "["       { Tk_CSym        _ '['        }
   "|"       { Tk_CSym        _ '|'        }
   "!"       { Tk_CSym        _ '!'        }
   "-"       { Tk_CSym        _ '-'        }
   "\\"      { Tk_CSym        _ '\\'       }
   "@"       { Tk_CSym        _ '@'        }
   "_"       { Tk_CSym        _ '_'        }
   "~"       { Tk_CSym        _ '~'        }
   "`"       { Tk_CSym        _ '`'        }
   ":"       { Tk_CSym        _ ':'        }
   "where"   { Tk_SSym        _ "where"    }
   "module"  { Tk_SSym        _ "module"   }
   ".."      { Tk_SSym        _ ".."       }
   "as"      { Tk_SSym        _ "as"       }
   "qualified"{ Tk_SSym        _ "qualified" }
   "import"  { Tk_SSym        _ "import"   }
   "type"    { Tk_SSym        _ "type"     }
   "data"    { Tk_SSym        _ "data"     }
   "newtype" { Tk_SSym        _ "newtype"  }
   "class"   { Tk_SSym        _ "class"    }
   "instance"{ Tk_SSym        _ "instance" }
   "default" { Tk_SSym        _ "default"  }
   "=>"      { Tk_SSym        _ "=>"       }
   "::"      { Tk_SSym        _ "::"       }
   "infixl"  { Tk_SSym        _ "infixl"   }
   "infixr"  { Tk_SSym        _ "infixr"   }
   "infix"   { Tk_SSym        _ "infix"    }
   "->"      { Tk_SSym        _ "->"       }
   "deriving"{ Tk_SSym        _ "deriving" }
   "in"      { Tk_SSym        _ "in"       }
   "let"     { Tk_SSym        _ "let"      }
   "else"    { Tk_SSym        _ "else"     }
   "then"    { Tk_SSym        _ "then"     }
   "if"      { Tk_SSym        _ "if"       }
   "of"      { Tk_SSym        _ "of"       }
   "case"    { Tk_SSym        _ "case"     }
   "do"      { Tk_SSym        _ "do"       }
   "<-"      { Tk_SSym        _ "<-"       }
   qconid    { Tk_qconid      _ $$         }
   conid     { Tk_conid       _ $$         }
   qvarid    { Tk_qvarid      _ $$         }
   varid     { Tk_varid       _ $$         }
   qvarsym   { Tk_qvarsym     _ $$         }
   varsym    { Tk_varsym      _ $$         }
   qconsym   { Tk_qconsym     _ $$         }
   consym    { Tk_consym      _ $$         }
   integer   { Tk_integer     _ $$         }
   float     { Tk_float       _ $$         }
   char      { Tk_char        _ $$         }
   string    { Tk_string      _ $$         }

%left  "in" "else" "->"
%left  "::"
%left  "-"
%name modul modul

%%
modul :: { Modul }
  : "module" modid exportspec "where" body { (Module $2 (Just $3) $5)  } 
  | "module" modid "where" body            { (Module $2 (Nothing) $4)  } 

body :: { ([Impdecl], [Decl]) }
  : "{" impdecls ";" topdecls "}" { ($2, $4)                  } 
  | "{" impdecls "}"              { ($2, [])                  } 
  | "{" topdecls "}"              { ([], $2)                  } 

impdecls :: { [Impdecl] }
  : impdecl impdecls_1_1 { ($1 : $2)                 } 
  | impdecl              { ($1 : [])                 } 

exportspec :: { [Export] }
  : "(" exports ")" { $2                        } 

exports :: { [Export] }
  :                    { []                        } 
  | export exports_1_1 { ($1 : $2)                 } 
  | export             { ($1 : [])                 } 

export :: { Export }
  : qvar                 { (ExportQVar $1)           } 
  | qtycon exportdetails { (ExportType $1 $2)        } 
  | "module" modid       { (ExportModule $2)         } 

exportdetails :: { Details }
  : details        { $1                        } 

details :: { Details }
  :                     { (NoDetails )              } 
  | "(" ".." ")"        { (AllDetails )             } 
  | "(" details_1_1 ")" { (SpecificDetails $2)      } 
  | "(" ")"             { (SpecificDetails [])      } 

qcname :: { Id }
  : qvar           { $1                        } 
  | qcon           { $1                        } 

impdecl :: { Impdecl }
  : "import" "qualified" modid "as" modid impspec { (Import (Just "qualified") $3 (Just $5) (Just $6)) } 
  | "import" "qualified" modid "as" modid         { (Import (Just "qualified") $3 (Just $5) (Nothing)) } 
  | "import" "qualified" modid impspec            { (Import (Just "qualified") $3 (Nothing) (Just $4)) } 
  | "import" "qualified" modid                    { (Import (Just "qualified") $3 (Nothing) (Nothing)) } 
  | "import" modid "as" modid impspec             { (Import (Nothing) $2 (Just $4) (Just $5)) } 
  | "import" modid "as" modid                     { (Import (Nothing) $2 (Just $4) (Nothing)) } 
  | "import" modid impspec                        { (Import (Nothing) $2 (Nothing) (Just $3)) } 
  | "import" modid                                { (Import (Nothing) $2 (Nothing) (Nothing)) } 

impspec :: { [Import] }
  : "(" imports ")" { $2                        } 

imports :: { [Import] }
  :                    { []                        } 
  | import imports_1_1 { ($1 : $2)                 } 
  | import             { ($1 : [])                 } 

import :: { Import }
  : var                 { (ImportVar $1)            } 
  | tycon importdetails { (ImportType $1 $2)        } 

importdetails :: { Details }
  : details        { $1                        } 

topdecls :: { [Decl] }
  : topdecl topdecls_1_1 { ($1 : $2)                 } 
  | topdecl              { ($1 : [])                 } 

topdecl :: { Decl }
  : "type" simpletype "=" type                             { (Type $2 $4)              } 
  | "data" optcontext simpletype "=" constrs deriving      { (Data $2 $3 $5 (Just $6)) } 
  | "data" optcontext simpletype "=" constrs               { (Data $2 $3 $5 (Nothing)) } 
  | "newtype" optcontext simpletype "=" newconstr deriving { (Newtype $2 $3 $5 (Just $6)) } 
  | "newtype" optcontext simpletype "=" newconstr          { (Newtype $2 $3 $5 (Nothing)) } 
  | "class" optscontext tycls tyvar "where" cdecls         { (Class $2 $3 $4 (Just $6)) } 
  | "class" optscontext tycls tyvar                        { (Class $2 $3 $4 (Nothing)) } 
  | "instance" optscontext qtycls inst "where" idecls      { (Instance $2 $3 $4 (Just $6)) } 
  | "instance" optscontext qtycls inst                     { (Instance $2 $3 $4 (Nothing)) } 
  | "default" "(" defaults ")"                             { (Default $3)              } 
  | decl                                                   { $1                        } 

optcontext :: { [Type] }
  :                { []                        } 
  | context "=>"   { $1                        } 

optscontext :: { [Type] }
  :                { []                        } 
  | scontext "=>"  { $1                        } 

defaults :: { [Type] }
  :                   { []                        } 
  | type defaults_1_1 { ($1 : $2)                 } 
  | type              { ($1 : [])                 } 

decls :: { [Decl] }
  : "{" "}"                { []                        } 
  | "{" decl decls_1_1 "}" { ($2 : $3)                 } 
  | "{" decl "}"           { ($2 : [])                 } 

decl :: { Decl }
  : gendecl        { $1                        } 
  | funlhs rhs     { (FunDecl $1 $2)           } 
  | pat0n rhs      { (PatDecl $1 $2)           } 

cdecls :: { [Decl] }
  :                  { []                        } 
  | cdecl cdecls_1_1 { ($1 : $2)                 } 
  | cdecl            { ($1 : [])                 } 

cdecl :: { Decl }
  : decl           { $1                        } 

idecls :: { [Decl] }
  : "{" "}"                  { []                        } 
  | "{" idecl idecls_1_1 "}" { ($2 : $3)                 } 
  | "{" idecl "}"            { ($2 : [])                 } 

idecl :: { Decl }
  : funlhs rhs     { (FunDecl $1 $2)           } 
  | qfunlhs rhs    { (FunDecl $1 $2)           } 
  | pvar rhs       { (PatDecl $1 $2)           } 
  | pqvar rhs      { (PatDecl $1 $2)           } 

pvar :: { Pat }
  : var            { (VarPat $1)               } 

pqvar :: { Pat }
  : qvar           { (VarPat $1)               } 

gendecl :: { Decl }
  : vars "::" qualtype { (TypeSig $1 $3)           } 
  | fixity integer ops { (Fixity $1 (Just $2) $3)  } 
  | fixity ops         { (Fixity $1 (Nothing) $2)  } 

qualtype :: { Qualtype }
  : optcontext type { (QualType $1 $2)          } 

ops :: { [Id] }
  : op ops_1_1     { ($1 : $2)                 } 
  | op             { ($1 : [])                 } 

vars :: { [Id] }
  : var vars_1_1   { ($1 : $2)                 } 
  | var            { ($1 : [])                 } 

fixity :: { Fixity }
  : "infixl"       { (InfixL )                 } 
  | "infixr"       { (InfixR )                 } 
  | "infix"        { (Infix )                  } 

type :: { Type }
  : btype "->" type { (FunType $1 $3)           } 
  | btype           { $1                        } 

btype :: { Type }
  : btype atype    { (AppType $1 $2)           } 
  | atype          { $1                        } 

atype :: { Type }
  : gtycon                             { (ConType $1)              } 
  | tyvar                              { (VarType $1)              } 
  | "(" type "," type defaults_1_1 ")" { (TupleType ($2 : ($4 : $5))) } 
  | "(" type "," type ")"              { (TupleType ($2 : ($4 : []))) } 
  | "[" type "]"                       { (ListType $2)             } 
  | "(" type ")"                       { $2                        } 

gtycon :: { Gtycon }
  : qtycon                 { (GTycon $1)               } 
  | "(" ")"                { (UnitTycon )              } 
  | "[" "]"                { (ListTycon )              } 
  | "(" "->" ")"           { (FunTycon )               } 
  | "(" "," gtycon_2_1 ")" { (TupleTycon (',' : $3))   } 
  | "(" "," ")"            { (TupleTycon (',' : []))   } 

context :: { [Type] }
  : type           { [$1]                      } 

scontext :: { [Type] }
  : type           { [$1]                      } 

simpletype :: { Simpletype }
  : tycon simpletype_1_1 { (SimpleType $1 $2)        } 
  | tycon                { (SimpleType $1 [])        } 

constrs :: { [Constr] }
  : constr constrs_1_1 { ($1 : $2)                 } 
  | constr             { ($1 : [])                 } 

constr :: { Constr }
  : con constr_1_1            { (Constr $1 $2)            } 
  | con                       { (Constr $1 [])            } 
  | conoptype conop conoptype { (Constr $2 [$1, $3])      } 
  | con "{" fielddecls "}"    { (ConstrFields $1 $3)      } 

strictness :: { Strictness }
  : "!"            { (Strict )                 } 
  |                { (Lazy )                   } 

conoptype :: { (Strictness, Type) }
  : btype          { ((Lazy ), $1)             } 
  | "!" atype      { ((Strict ), $2)           } 

fielddecls :: { [([Id], (Strictness, Type))] }
  :                          { []                        } 
  | fielddecl fielddecls_1_1 { ($1 : $2)                 } 
  | fielddecl                { ($1 : [])                 } 

newconstr :: { Newconstr }
  : con atype                 { (NewConstr $1 $2)         } 
  | con "{" var "::" type "}" { (NewConstrField $1 $3 $5) } 

fielddecl :: { ([Id], (Strictness, Type)) }
  : vars "::" fieldtype { ($1, $3)                  } 

fieldtype :: { (Strictness, Type) }
  : type           { ((Lazy ), $1)             } 
  | "!" atype      { ((Strict ), $2)           } 

deriving :: { [QTycls] }
  : "deriving" dclasses { $2                        } 

dclasses :: { [QTycls] }
  :                             { []                        } 
  | dclass                      { [$1]                      } 
  | "(" ")"                     { []                        } 
  | "(" dclass dclasses_1_1 ")" { ($2 : $3)                 } 
  | "(" dclass ")"              { ($2 : [])                 } 

dclass :: { QTycls }
  : qtycls         { $1                        } 

inst :: { Inst }
  : gtycon                           { (ConInst $1 [])           } 
  | "(" gtycon simpletype_1_1 ")"    { (ConInst $2 $3)           } 
  | "(" gtycon ")"                   { (ConInst $2 [])           } 
  | "(" tyvar "," tyvar inst_1_1 ")" { (TupleInst ($2 : ($4 : $5))) } 
  | "(" tyvar "," tyvar ")"          { (TupleInst ($2 : ($4 : []))) } 
  | "[" tyvar "]"                    { (ListInst $2)             } 
  | "(" tyvar "->" tyvar ")"         { (FunInst $2 $4)           } 

funlhs :: { (Id, [Pat]) }
  : var apat funlhs_2_1 { ($1, ($2 : $3))           } 
  | var apat            { ($1, ($2 : []))           } 
  | pat0n varop pat0n   { ($2, [$1, $3])            } 

qfunlhs :: { (Id, [Pat]) }
  : qvar apat funlhs_2_1 { ($1, ($2 : $3))           } 
  | qvar apat            { ($1, ($2 : []))           } 
  | pat0n qvarop pat0n   { ($2, [$1, $3])            } 

rhs :: { Rhs }
  : "=" exp wheredecls { (Rhs $2 $3)               } 
  | gdrhs wheredecls   { (GdRhs $1 $2)             } 

wheredecls :: { [Decl] }
  :                { []                        } 
  | "where" decls  { $2                        } 

gdrhs :: { [(Exp, Exp)] }
  : gd "=" exp gdrhs_2_1 { (($1, $3) : $4)           } 
  | gd "=" exp           { (($1, $3) : [])           } 

gd :: { Exp }
  : "|" exp0n      { $2                        } 

exp :: { Exp }
  : exp0n "::" qualtype { (TypedExp $1 $3)          } 
  | exp0n               { $1                        } 

exp0n :: { Exp }
  : exp0n qop exp0n %prec "-" { (OpExp $1 $2 $3)          } 
  | "-" exp0n                 { (NegExp $2)               } 
  | exp10n                    { $1                        } 

exp10n :: { Exp }
  : "\\" pat exp10n_2_1 "->" exp   { (Lambda ($2 : $3) $5)     } 
  | "\\" pat "->" exp              { (Lambda ($2 : []) $4)     } 
  | "let" decls "in" exp           { (Let $2 $4)               } 
  | "if" exp "then" exp "else" exp { (If $2 $4 $6)             } 
  | "case" exp "of" "{" alts "}"   { (Case $2 $5)              } 
  | "do" "{" stmts "}"             { (Do $3)                   } 
  | fexp                           { $1                        } 

fexp :: { Exp }
  : fexp aexp      { (App $1 $2)               } 
  | aexp           { $1                        } 

aexp :: { Exp }
  : qvar                         { (VarExp $1)               } 
  | gcon                         { (ConExp $1)               } 
  | literal                      { (Lit $1)                  } 
  | "(" exp ")"                  { (ParenExp $2)             } 
  | "(" exp "," exp aexp_1_1 ")" { (TupleExp ($2 : ($4 : $5))) } 
  | "(" exp "," exp ")"          { (TupleExp ($2 : ($4 : []))) } 
  | "[" exp aexp_1_1 "]"         { (ListExp ($2 : $3))       } 
  | "[" exp "]"                  { (ListExp ($2 : []))       } 
  | "[" exp "," exp ".." exp "]" { (Seq $2 (Just $4) (Just $6)) } 
  | "[" exp "," exp ".." "]"     { (Seq $2 (Just $4) (Nothing)) } 
  | "[" exp ".." exp "]"         { (Seq $2 (Nothing) (Just $4)) } 
  | "[" exp ".." "]"             { (Seq $2 (Nothing) (Nothing)) } 
  | "(" exp0n qop ")"            { (LSection $2 $3)          } 
  | "(" qop exp0n ")"            { (RSection $2 $3)          } 
  | aexp "{" fbinds "}"          { (FieldUpd $1 $3)          } 

qual :: { Qual }
  : exp "<-" exp   { (GenQual $1 $3)           } 
  | "let" decls    { (LetQual $2)              } 
  | exp            { (GdGual $1)               } 

alts :: { [Alt] }
  :                { []                        } 
  | alt alts_1_1   { ($1 : $2)                 } 
  | alt            { ($1 : [])                 } 

alt :: { Alt }
  : pat "->" exp wheredecls { (Alt $1 $3 $4)            } 
  | pat gdpat wheredecls    { (GdAlt $1 $2 $3)          } 

gdpat :: { [(Exp, Exp)] }
  : gd "->" exp gdpat_2_1 { (($1, $3) : $4)           } 
  | gd "->" exp           { (($1, $3) : [])           } 

stmts :: { ([Qual], Exp) }
  : stmts_1_1 exp ";" { ($1, $2)                  } 
  | stmts_1_1 exp     { ($1, $2)                  } 
  | exp ";"           { ([], $1)                  } 
  | exp               { ([], $1)                  } 

stmt :: { Qual }
  : qual ";"       { $1                        } 

fbinds :: { [(Id, Exp)] }
  :                  { []                        } 
  | fbind fbinds_1_1 { ($1 : $2)                 } 
  | fbind            { ($1 : [])                 } 

fbind :: { (Id, Exp) }
  : qvar "=" exp   { ($1, $3)                  } 

pat :: { Pat }
  : pat0n          { $1                        } 

pat0n :: { Pat }
  : pat0n qconop pat0n %prec "-" { (OpPat $1 $2 $3)          } 
  | "-" pat0n                    { (NegPat $2)               } 
  | pat10n                       { $1                        } 

pat10n :: { Pat }
  : apat                 { $1                        } 
  | gcon apat funlhs_2_1 { (ConPat $1 ($2 : $3))     } 
  | gcon apat            { (ConPat $1 ($2 : []))     } 

apat :: { Pat }
  : var                          { (VarPat $1)               } 
  | var "@" apat                 { (As $1 $3)                } 
  | gcon                         { (ConPat $1 [])            } 
  | qcon "{" fpats "}"           { (FieldPat $1 $3)          } 
  | literal                      { (LitPat $1)               } 
  | "_"                          { (Wildcard )               } 
  | "(" pat ")"                  { (ParenPat $2)             } 
  | "(" pat "," pat apat_1_1 ")" { (TuplePat ($2 : ($4 : $5))) } 
  | "(" pat "," pat ")"          { (TuplePat ($2 : ($4 : []))) } 
  | "[" pat apat_1_1 "]"         { (ListPat ($2 : $3))       } 
  | "[" pat "]"                  { (ListPat ($2 : []))       } 
  | "~" apat                     { (IrrPat $2)               } 

fpats :: { [(Id, Pat)] }
  :                { []                        } 
  | fpat fpats_1_1 { ($1 : $2)                 } 
  | fpat           { ($1 : [])                 } 

fpat :: { (Id, Pat) }
  : qvar "=" pat   { ($1, $3)                  } 

gcon :: { Gcon }
  : "(" ")"                { (UnitCon )                } 
  | "[" "]"                { (NilCon )                 } 
  | "(" "," gtycon_2_1 ")" { (TupleCon (',' : $3))     } 
  | "(" "," ")"            { (TupleCon (',' : []))     } 
  | qcon                   { (QCon $1)                 } 

var :: { Id }
  : varid          { (Id $1)                   } 
  | "(" varsym ")" { (SymId $2)                } 

qvar :: { Id }
  : qvarid          { (QId $1)                  } 
  | "(" qvarsym ")" { (QdSymId $2)              } 

con :: { Id }
  : conid          { (ConId $1)                } 
  | "(" consym ")" { (ConsymId $2)             } 

qcon :: { Id }
  : qconid          { (QConId $1)               } 
  | "(" gconsym ")" { (QConsymId $2)            } 

varop :: { Id }
  : varsym         { (Op $1)                   } 
  | "`" varid "`"  { (IdOp $2)                 } 

qvarop :: { Id }
  : qvarsym        { (QOp $1)                  } 
  | "`" qvarid "`" { (QIdOp $2)                } 

conop :: { Id }
  : consym         { (ConOp $1)                } 
  | "`" conid "`"  { (ConIdOp $2)              } 

qconop :: { Id }
  : gconsym        { (QConOp $1)               } 
  | "`" qconid "`" { (QConIdOp $2)             } 

op :: { Id }
  : varop          { $1                        } 
  | conop          { $1                        } 

qop :: { Id }
  : qvarop         { $1                        } 
  | qconop         { $1                        } 

gconsym :: { String }
  : ":"            { ":"                       } 
  | qconsym        { $1                        } 

modid :: { Modid }
  : conid          { (ModId $1)                } 

qtycon :: { Qtycon }
  : qconid         { (QTycon $1)               } 

tycon :: { Tycon }
  : conid          { (Tycon $1)                } 

tyvar :: { Tyvar }
  : varid          { (Tyvar $1)                } 

tycls :: { Tycls }
  : conid          { (Tycls $1)                } 

qtycls :: { QTycls }
  : qconid         { (QTycls $1)               } 

literal :: { String }
  : integer        { $1                        } 
  | float          { $1                        } 
  | char           { $1                        } 
  | string         { $1                        } 

impdecls_1_1 :: { [Impdecl] }
  : ";" impdecl impdecls_1_1 { ($2 : $3)                 } 
  | ";" impdecl              { [$2]                      } 

exports_1_1 :: { [Export] }
  : "," export exports_1_1 { ($2 : $3)                 } 
  | "," export             { [$2]                      } 

details_1_1 :: { [Id] }
  : qcname details_1_1 { ($1 : $2)                 } 
  | qcname             { [$1]                      } 

imports_1_1 :: { [Import] }
  : "," import imports_1_1 { ($2 : $3)                 } 
  | "," import             { [$2]                      } 

topdecls_1_1 :: { [Decl] }
  : ";" topdecl topdecls_1_1 { ($2 : $3)                 } 
  | ";" topdecl              { [$2]                      } 

defaults_1_1 :: { [Type] }
  : "," type defaults_1_1 { ($2 : $3)                 } 
  | "," type              { [$2]                      } 

decls_1_1 :: { [Decl] }
  : ";" decl decls_1_1 { ($2 : $3)                 } 
  | ";" decl           { [$2]                      } 

cdecls_1_1 :: { [Decl] }
  : ";" cdecl cdecls_1_1 { ($2 : $3)                 } 
  | ";" cdecl            { [$2]                      } 

idecls_1_1 :: { [Decl] }
  : ";" idecl idecls_1_1 { ($2 : $3)                 } 
  | ";" idecl            { [$2]                      } 

ops_1_1 :: { [Id] }
  : "," op ops_1_1 { ($2 : $3)                 } 
  | "," op         { [$2]                      } 

vars_1_1 :: { [Id] }
  : "," var vars_1_1 { ($2 : $3)                 } 
  | "," var          { [$2]                      } 

gtycon_2_1 :: { [Char] }
  : "," gtycon_2_1 { (',' : $2)                } 
  | ","            { [',']                     } 

simpletype_1_1 :: { [Tyvar] }
  : tyvar simpletype_1_1 { ($1 : $2)                 } 
  | tyvar                { [$1]                      } 

constrs_1_1 :: { [Constr] }
  : "|" constr constrs_1_1 { ($2 : $3)                 } 
  | "|" constr             { [$2]                      } 

constr_1_1 :: { [(Strictness, Type)] }
  : strictness atype constr_1_1 { (($1, $2) : $3)           } 
  | strictness atype            { [($1, $2)]                } 

fielddecls_1_1 :: { [([Id], (Strictness, Type))] }
  : "," fielddecl fielddecls_1_1 { ($2 : $3)                 } 
  | "," fielddecl                { [$2]                      } 

dclasses_1_1 :: { [QTycls] }
  : "," dclass dclasses_1_1 { ($2 : $3)                 } 
  | "," dclass              { [$2]                      } 

inst_1_1 :: { [Tyvar] }
  : "," tyvar inst_1_1 { ($2 : $3)                 } 
  | "," tyvar          { [$2]                      } 

funlhs_2_1 :: { [Pat] }
  : apat funlhs_2_1 { ($1 : $2)                 } 
  | apat            { [$1]                      } 

gdrhs_2_1 :: { [(Exp, Exp)] }
  : gd "=" exp gdrhs_2_1 { (($1, $3) : $4)           } 
  | gd "=" exp           { [($1, $3)]                } 

exp10n_2_1 :: { [Pat] }
  : pat exp10n_2_1 { ($1 : $2)                 } 
  | pat            { [$1]                      } 

aexp_1_1 :: { [Exp] }
  : "," exp aexp_1_1 { ($2 : $3)                 } 
  | "," exp          { [$2]                      } 

alts_1_1 :: { [Alt] }
  : ";" alt alts_1_1 { ($2 : $3)                 } 
  | ";" alt          { [$2]                      } 

gdpat_2_1 :: { [(Exp, Exp)] }
  : gd "->" exp gdpat_2_1 { (($1, $3) : $4)           } 
  | gd "->" exp           { [($1, $3)]                } 

stmts_1_1 :: { [Qual] }
  : stmt stmts_1_1 { ($1 : $2)                 } 
  | stmt           { [$1]                      } 

fbinds_1_1 :: { [(Id, Exp)] }
  : "," fbind fbinds_1_1 { ($2 : $3)                 } 
  | "," fbind            { [$2]                      } 

apat_1_1 :: { [Pat] }
  : "," pat apat_1_1 { ($2 : $3)                 } 
  | "," pat          { [$2]                      } 

fpats_1_1 :: { [(Id, Pat)] }
  : "," fpat fpats_1_1 { ($2 : $3)                 } 
  | "," fpat           { [$2]                      } 

{
parse' :: String -> Modul
parse' s = modul (tokens' s)


happyError :: [Token'] -> a
happyError tks = error ("Parse error at " ++ lcn ++ "\n")
  where
    lcn = case tks of
            [] -> "end of file"
            tk:_ -> "line " ++ show l ++ ", column " ++ show c
             where
               Pn _ l c = token'pos tk

}
