grammar MicroXPath;

/* 
  This ANTLR 3.0 compatible grammar intends to implement a simple subset of XPath 1.0.
  Current functionality should allow any set of actions to explore and select XPath 
  nodes and attributes in the forward axis.
  
  This translation is based upon the MicroXPath grammar definition.
  http://senzhang.netfirms.com/mxpath.htm
  
  As always, this is free for usage and modification. 
  
  Translated by Jesús Zazueta.
  Bugs and comments welcome: jjzazuet@gmail.com
 */

options { output = ast; }

// ---------------- Parser Rules ---------------- //
xPath
    :    pathExpr
    ;

pathExpr
    :    ('/' relativePathExpr?) 
    |    ('//' relativePathExpr) 
    |    relativePathExpr
    ;

relativePathExpr
    :    primaryStep = stepExpr
         (( '/' | '//' ) trailingStep = stepExpr )*
    ;
    
stepExpr
    :    ( '.' 
         | abbrevForwardStep
         ) (predicate)?
    ;

abbrevForwardStep
    :    attributeFlag = '@'? (stQName = qName | stNodeExpansion =  '*')   
    ;

predicate
    :    '[' predicateExpr ']'
    ;
     
predicateExpr
    :    expr (('and'|'or') expr)* |  '(' expr ')'
    ; 
  
expr
    :    pathExpr (comparisonexpr | containmentexpr); 

comparisonexpr : (ComparisonOp ) literal; 
containmentexpr : ('contains' | 'excludes') '(' StringLiteral ')';

literal : StringLiteral | numericLiteral | VarRef;
numericLiteral: IntegerLiteral | DecimalLiteral | DoubleLiteral;
qName: (NCName ':' NCName) | NCName;

// ---------------- Lexer Rules ---------------- //
Letter
    :  '\u0024' | '\u005f'|
       '\u0041'..'\u005a' | '\u0061'..'\u007a' | 
       '\u00c0'..'\u00d6' | '\u00d8'..'\u00f6' | 
       '\u00f8'..'\u00ff' | '\u0100'..'\u1fff' | 
       '\u3040'..'\u318f' | '\u3300'..'\u337f' | 
       '\u3400'..'\u3d2d' | '\u4e00'..'\u9fff' | 
       '\uf900'..'\ufaff'
    ;

IntegerLiteral :  ('0'..'9')+;
DecimalLiteral :  ('.' ('0'..'9')+)  | (('0'..'9')+ '.' '0'..'9'*);
DoubleLiteral  :  (('.' ('0'..'9')+) | (('0'..'9')+ ('.' '0'..'9'*)?)) ('e' | 'E') ('+' | '-')? ('0'..'9')+;

StringLiteral : '"' ~('"')* '"' | '\'' ~('\'')* '\'';

ComparisonOp : '=' | '<' | '>' | '!=' | '<=' | '>=';

VarRef: '$' NCName;

NCName : (Letter) (Letter | ('0'..'9') | '.' | '-')*;

WS: (' '|'\t'|'\u000C') {skip();};
