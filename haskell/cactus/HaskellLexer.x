%{
module HaskellLexer where
import Alex
import HaskellAbsSyn
%}

{ ^H = [0-9A-Fa-f]                        }
{ ^L = [A-Z]                              }
{ ^A = [A-Z]                              }
{ ^S = [a-z]                              }
{ ^D = [0-9]                              }
{ ^c = [^!^#^$^%^&^*^+^.^/^<^=^>^?^@^\^^^|^-^~]}
{ ^d = [^(^)^,^;^[^]^`^{^}]               }
{ ^G = [a-zA-Z^!^#^$^%^&^*^+^.^/^<^=^>^?^@^\^^^|^-^~0-9^(^)^,^;^[^]^`^{^}^:^"^']}
{ ^C = [abfnrtv^\^"^'^&]                  }
{ ^W = [^n^r^v^f` '^t]                    }
{ ^e = ` '                                }
{ ^g = [A-Z^@^[^\^]^^^_]                  }

{ %C = (^L (^S|^L|^D|^')*)                }
{ %I = (^S (^S|^L|^D|^')*)                }
{ %V = (^c (^c|^:)*)                      }
{ %a = (^: (^c|^:)*)                      }
{ %O = [0-7]+                             }
{ %H = ^H+                                }
{ %D = ^D+                                }
{ %A = ((^^ ^g)|NUL|SOH|STX|ETX|EOT|ENQ|ACK|BEL|BS|HT|LF|VT|FF|CR|SO|SI|DLE|DC1|DC2|DC3|DC4|NAK|SYN|ETB|CAN|EM|SUB|ESC|FS|GS|RS|US|SP|DEL)}
{ %E = (^\ (^C|%A|%D|(o %O)|(x %H)))      }
{ %G = (^\ ^W+ ^\)                        }

"tokens_lx"/"tokens_acts":-


  <cSym'>          ::= ^}
  <cSym'>          ::= ^;
  <cSym'>          ::= ^{
  <cSym'>          ::= ^)
  <cSym'>          ::= ^(
  <cSym'>          ::= ^,
  <cSym'>          ::= ^=
  <cSym'>          ::= ^]
  <cSym'>          ::= ^[
  <cSym'>          ::= ^|
  <cSym'>          ::= ^!
  <cSym'>          ::= ^-
  <cSym'>          ::= ^\
  <cSym'>          ::= ^@
  <cSym'>          ::= ^_
  <cSym'>          ::= ^~
  <cSym'>          ::= ^`
  <cSym'>          ::= ^:
  <sSym'>          ::= where
  <sSym'>          ::= module
  <sSym'>          ::= ^.^.
  <sSym'>          ::= as
  <sSym'>          ::= qualified
  <sSym'>          ::= import
  <sSym'>          ::= type
  <sSym'>          ::= data
  <sSym'>          ::= newtype
  <sSym'>          ::= class
  <sSym'>          ::= instance
  <sSym'>          ::= default
  <sSym'>          ::= ^=^>
  <sSym'>          ::= ^:^:
  <sSym'>          ::= infixl
  <sSym'>          ::= infixr
  <sSym'>          ::= infix
  <sSym'>          ::= ^-^>
  <sSym'>          ::= deriving
  <sSym'>          ::= in
  <sSym'>          ::= let
  <sSym'>          ::= else
  <sSym'>          ::= then
  <sSym'>          ::= if
  <sSym'>          ::= of
  <sSym'>          ::= case
  <sSym'>          ::= do
  <sSym'>          ::= ^<^-
  <qconid'>        ::= ((%C ^.)? %C)
  <conid'>         ::= %C
  <qvarid'>        ::= ((%C ^.)? %I)
  <varid'>         ::= %I
  <qvarsym'>       ::= ((%C ^.)? %V)
  <varsym'>        ::= %V
  <qconsym'>       ::= ((%C ^.)? %a)
  <consym'>        ::= %a
  <integer'>       ::= (%D|(0 [oO] %O)|(0 [xX] %H))
  <float'>         ::= (%D ^. %D ([eE] [^+^-]? %D)?)
  <char'>          ::= (^' ([a-zA-Z^!^#^$^%^&^*^+^.^/^<^=^>^?^@^^^|^-^~0-9^(^)^,^;^[^]^`^{^}^:^"]|^e|%E) ^')
  <string'>        ::= (^" ([a-zA-Z^!^#^$^%^&^*^+^.^/^<^=^>^?^@^^^|^-^~0-9^(^)^,^;^[^]^`^{^}^:^']|^e|%E|%G)* ^")
  <>               ::= (^-^- ^-* ([^0-^9^v^f^14-^32^"^'^(^)^,0-^59A-^91^]^95-^123^}^127] .*)?)

%{
data Token'
  = Err'           Posn 
  | Tk_CSym        Posn Char   
  | Tk_SSym        Posn String 
  | Tk_qconid      Posn String 
  | Tk_conid       Posn String 
  | Tk_qvarid      Posn String 
  | Tk_varid       Posn String 
  | Tk_qvarsym     Posn String 
  | Tk_varsym      Posn String 
  | Tk_qconsym     Posn String 
  | Tk_consym      Posn String 
  | Tk_integer     Posn String 
  | Tk_float       Posn String 
  | Tk_char        Posn String 
  | Tk_string      Posn String 
  deriving (Eq,Show)

token'pos :: Token' -> Posn
token'pos (Err'           p    ) = p
token'pos (Tk_CSym        p _  ) = p
token'pos (Tk_SSym        p _  ) = p
token'pos (Tk_qconid      p _  ) = p
token'pos (Tk_conid       p _  ) = p
token'pos (Tk_qvarid      p _  ) = p
token'pos (Tk_varid       p _  ) = p
token'pos (Tk_qvarsym     p _  ) = p
token'pos (Tk_varsym      p _  ) = p
token'pos (Tk_qconsym     p _  ) = p
token'pos (Tk_consym      p _  ) = p
token'pos (Tk_integer     p _  ) = p
token'pos (Tk_float       p _  ) = p
token'pos (Tk_char        p _  ) = p
token'pos (Tk_string      p _  ) = p


varsym'        p s = Tk_varsym      p s       
varid'         p s = Tk_varid       p s       
string'        p s = Tk_string      p s       
sSym'          p s = Tk_SSym        p s       
qvarsym'       p s = Tk_qvarsym     p s       
qvarid'        p s = Tk_qvarid      p s       
qconsym'       p s = Tk_qconsym     p s       
qconid'        p s = Tk_qconid      p s       
integer'       p s = Tk_integer     p s       
float'         p s = Tk_float       p s       
consym'        p s = Tk_consym      p s       
conid'         p s = Tk_conid       p s       
char'          p s = Tk_char        p s       
cSym'          p s = Tk_CSym        p (head s)


tokens' :: String -> [Token']
tokens' inp = scan tokens_scan inp

tokens_scan :: Scan Token'
tokens_scan = load_scan (tokens_acts,stop_act) tokens_lx
  where
    stop_act p ""  = []
    --stop_act p inp = [Err' p]
    stop_act p inp = error$"Lex error: line "++show l++", column "++show c++"\n"
     where
      Pn _ l c = p

%}
