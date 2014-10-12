/*=============================================================================

    Copyright 2013 Nikolay Ognyanov

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

=============================================================================*/

/*=============================================================================

                             XPath 3.0 ANTLR Grammar
                             
=============================================================================*/

grammar XP30;

@header {
/*=============================================================================

    Copyright 2013 Nikolay Ognyanov

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

=============================================================================*/

package xqgrammar;
}

@lexer::header {
/*=============================================================================

    Copyright 2013 Nikolay Ognyanov

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

=============================================================================*/

package xqgrammar;
}

@members {
    // Pass some token codes to super class at creation time.
    boolean dummy = setTokenCodes(NCName, Colon);
}

xPath
    : expr
    ;
paramList
    : param (',' param)*
    ;
param
    : '$' eQName typeDeclaration?
    ;
functionBody
    : enclosedExpr
    ;
enclosedExpr
    : LCurly expr RCurly
    ;
expr
    : exprSingle (',' exprSingle)*
    ;
exprSingle
    : forExpr
    | letExpr
    | quantifiedExpr
    | ifExpr
    | orExpr
    ;
forExpr
    : simpleForClause RETURN exprSingle
    ;
simpleForClause
    : FOR simpleForBinding (',' simpleForBinding)*
    ;
simpleForBinding
    : '$' varName IN exprSingle
    ;
letExpr
    : simpleLetClause RETURN exprSingle
    ;
simpleLetClause
    : LET simpleLetBinding (',' simpleLetBinding)*
    ;
simpleLetBinding
    : '$' varName ':=' exprSingle
    ;
quantifiedExpr
    : (SOME | EVERY) '$' varName IN exprSingle
      (',' '$' varName IN exprSingle)
      SATISFIES exprSingle
    ;
ifExpr
    : IF '(' expr ')' THEN exprSingle ELSE exprSingle
    ;
orExpr
    : andExpr ( OR andExpr )*
    ;
andExpr
    : comparisonExpr ( AND comparisonExpr )*
    ;
comparisonExpr
    : stringConcatExpr 
      ((valueComp | generalComp | nodeComp)stringConcatExpr)?
    ;
stringConcatExpr
    : rangeExpr ('||' rangeExpr)*
    ;
rangeExpr
    : additiveExpr (TO additiveExpr)?
    ;
additiveExpr
    : multiplicativeExpr ( ('+' | '-') multiplicativeExpr )*
    ;
multiplicativeExpr
    : unionExpr ( 
       (  '*' 
        | DIV  {needSpaceBetween(IntegerLiteral);}
               {needSpaceBetween(DecimalLiteral);}
               {needSpaceBetween(DoubleLiteral );}
        | IDIV {needSpaceBetween(IntegerLiteral);}
               {needSpaceBetween(DecimalLiteral);}
               {needSpaceBetween(DoubleLiteral );}
        | MOD  {needSpaceBetween(IntegerLiteral);}
               {needSpaceBetween(DecimalLiteral);}
               {needSpaceBetween(DoubleLiteral );}
        ) 
        unionExpr 
       )*
    ;
unionExpr
    : intersectExceptExpr ( (UNION | '|') intersectExceptExpr )*
    ;
intersectExceptExpr
    : instanceofExpr ( (INTERSECT | EXCEPT) instanceofExpr )*
    ;
instanceofExpr
    : treatExpr ( INSTANCE OF sequenceType )?
    ;
treatExpr
    : castableExpr ( TREAT AS sequenceType )?
    ;
castableExpr
    : castExpr ( CASTABLE AS singleType )?
    ;
castExpr
    : unaryExpr ( CAST AS singleType )?
    ;
unaryExpr
    : ('-' | '+')* valueExpr
    ;
valueExpr
    : simpleMapExpr
    ;
generalComp
    : SymEq  | '!=' | LAngle  | '<=' | RAngle  | '>='
    ;
valueComp
    : EQ | NE | LT | LE | GT | GE
    ;
nodeComp
    : IS | '<<' | '>>'
    ;
simpleMapExpr
    : pathExpr ('!' pathExpr)*
    ;
pathExpr                                              // xgs:leading-lone-slash
    : ('/'  relativePathExpr) => '/'  relativePathExpr
    | ('/'        '*'       ) => '/' '*'
    | '/'
    | '//' relativePathExpr
    | relativePathExpr
    ;
relativePathExpr
    : stepExpr (('/' | '//') stepExpr)*
    ;
stepExpr
    : postfixExpr
    | axisStep
    ;
axisStep
    : (reverseStep | forwardStep) predicateList
    ;
forwardStep
    : forwardAxis nodeTest
    | abbrevForwardStep
    ;
forwardAxis
    : CHILD '::'
    | DESCENDANT '::'
    | ATTRIBUTE '::'
    | SELF '::'
    | DESCENDANT_OR_SELF '::' 
    | FOLLOWING_SIBLING '::'
    | FOLLOWING '::'
    | NAMESPACE '::'
    ;
abbrevForwardStep
    : '@'? nodeTest
    ;
reverseStep
    : reverseAxis nodeTest
    | abbrevReverseStep
    ;
reverseAxis
    : PARENT '::'
    | ANCESTOR '::'
    | PRECEDING_SIBLING '::'
    | PRECEDING '::'
    | ANCESTOR_OR_SELF '::'
    ;
abbrevReverseStep
    : '..'
    ;
nodeTest
    : kindTest
    | nameTest
    ;
nameTest
    : eQName
    | wildcard
    ;
wildcard                                                         // ws:explicit
    : '*'
    | ncName Colon {noSpaceBefore();} '*'    {noSpaceBefore();}
    | '*'    Colon {noSpaceBefore();} ncName {noSpaceBefore();}
    | BracedURILiteral '*'
    ;
postfixExpr
    : primaryExpr (predicate | argumentList)*
    ;
argumentList
    : '(' (argument (',' argument)*)? ')'
    ;
predicateList
    : predicate*
    ;
predicate
    : '[' expr ']'
    ;
primaryExpr
    : literal
    | varRef
    | parenthesizedExpr
    | contextItemExpr 
    | functionCall
    | functionItemExpr
    ;
literal
    : numericLiteral
    | StringLiteral
    ;
numericLiteral
    : IntegerLiteral
    | DecimalLiteral
    | DoubleLiteral
    ;
varRef
    : '$' varName
    ;
varName
    : eQName
    ;
parenthesizedExpr
    : '(' expr? ')'
    ;
contextItemExpr
    : '.'
    ;
functionCall                        // xgs:reserved-function-names // gn:parens
    : efqName argumentList
    ;
argument
    : exprSingle
    | argumentPlaceHolter
    ;
argumentPlaceHolter
    : '?'
    ;
functionItemExpr
    : namedFunctionRef
    | inlineFunctionExpr
    ;
namedFunctionRef
    : eQName '#' IntegerLiteral
    ;
inlineFunctionExpr
    : FUNCTION '(' paramList? ')' (AS sequenceType)? functionBody
    ;
singleType
    : simpleTypeName '?'?
    ;
typeDeclaration
    : AS sequenceType
    ;
sequenceType
    : (EMPTY_SEQUENCE '(' ')')
    | (itemType ((occurrenceIndicator) => occurrenceIndicator)?)
    ;
occurrenceIndicator                                 // xgs:occurance-indicators
    : '?'
    | '*'
    | '+'
    ;
itemType
    : kindTest
    | (ITEM '(' ')')
    | functionTest
    | atomicOrUnionType
    | parenthesizedItemType
    ;
atomicOrUnionType
    : eQName
    ;
kindTest
    : documentTest
    | elementTest
    | attributeTest
    | schemaElementTest
    | schemaAttributeTest
    | piTest
    | commentTest
    | textTest
    | namespaceNodeTest
    | anyKindTest
    ;
anyKindTest
    : NODE '(' ')'
    ;
documentTest
    : DOCUMENT_NODE '(' (elementTest | schemaElementTest)? ')'
    ;
textTest
    : TEXT '(' ')'
    ;
commentTest
    : COMMENT '(' ')'
    ;
namespaceNodeTest
    : NAMESPACE_NODE '(' ')'
    ;
piTest
    : PROCESSING_INSTRUCTION '(' (ncName | StringLiteral)? ')'
    ;
attributeTest
    : ATTRIBUTE '(' (attribNameOrWildcard (',' typeName)?)? ')'
    ;
attribNameOrWildcard
    : attributeName
    | '*'
    ;
schemaAttributeTest
    : SCHEMA_ATTRIBUTE '(' attributeDeclaration ')'
    ;
attributeDeclaration
    : attributeName
    ;
elementTest
    : ELEMENT '(' (elementNameOrWildcard (',' typeName '?'?)?)? ')'
    ;
elementNameOrWildcard
    : elementName
    | '*'
    ;
schemaElementTest
    : SCHEMA_ELEMENT '(' elementDeclaration ')'
    ;
elementDeclaration
    : elementName
    ;
attributeName
    : eQName
    ;
elementName
    : eQName
    ;
simpleTypeName
    : typeName
    ;
typeName
    : eQName
    ;
functionTest
    : (anyFunctionTest | typedFunctionTest)
    ;
anyFunctionTest
    : FUNCTION '(' '*' ')'
    ;
typedFunctionTest
    : FUNCTION '(' (sequenceType (',' sequenceType)*)? ')' AS sequenceType
    ;
parenthesizedItemType
    : '(' itemType ')'
    ;
eQName
    : qName
    | uriQualifiedName
    ;
uriQualifiedName
    : BracedURILiteral ncName {noSpaceBefore();}
    ;
qName
    : ncName (Colon {noSpaceBefore();} ncName {noSpaceBefore();})?
    ;
uriLiteral
    : StringLiteral
    ;
efQName
    : fqName
    | uriQualifiedName
    ;
fqName
    : ncName  Colon {noSpaceBefore();} ncName {noSpaceBefore();}
    | fncName
    ;
ncName
    : fncName
    // reserved function names - not allowed in unprefixed form
    | ATTRIBUTE
    | COMMENT
    | DOCUMENT_NODE
    | ELEMENT
    | EMPTY_SEQUENCE
    | IF
    | ITEM
    | NODE
    | PROCESSING_INSTRUCTION
    | SCHEMA_ATTRIBUTE
    | SCHEMA_ELEMENT
    | TEXT
  //| TYPESWITCH
  //| WHILE                                                    // ext:scripting
    | FUNCTION                                                    // XQuery 3.0
    | NAMESPACE_NODE                                              // XQuery 3.0
  //| SWITCH                                                      // XQuery 3.0
    ;
fncName
    : NCName
    | ANCESTOR
    | ANCESTOR_OR_SELF
    | AND
    | AS
  //| ATTRIBUTE
    | CASTABLE
    | CAST
    | CHILD
  //| COMMENT
    | DESCENDANT
    | DESCENDANT_OR_SELF
    | DIV
  //| DOCUMENT_NODE
  //| ELEMENT
    | ELSE
  //| EMPTY_SEQUENCE
    | EQ
    | EVERY
    | EXCEPT
    | FOLLOWING
    | FOLLOWING_SIBLING
    | FOR
  //| FUNCTION
    | GE
    | GT
    | IDIV
  //| IF
    | IN
    | INSTANCE
    | INTERSECT
    | IS
  //| ITEM
    | LE
    | LET
    | LT
    | MOD
    | NAMESPACE
  //| NAMESPACE_NODE
    | NE
  //| NODE
    | OF
    | OR
    | PARENT
    | PRECEDING
    | PRECEDING_SIBLING
  //| PROCESSING_INSTRUCTION
    | RETURN
    | SATISFIES
  //| SCHEMA_ATTRIBUTE
  //| SCHEMA_ELEMENT
    | SELF
    | SOME
  //| TEXT
    | THEN
    | TO
    | TREAT
    | UNION
    ;

LAngle                  : '<';
RAngle                  : '>';
LCurly                  : '{';
RCurly                  : '}';
SymEq                   : '=';
Colon                   : ':';
LClose                  : '</';
RClose                  : '/>';
Quot                    : '"';
Apos                    : '\'';
fragment
EscapeQuot              : '""';
fragment
EscapeApos              : '\'\'';
fragment
EscapeLCurly            : '{{';
fragment
EscapeRCurly            : '}}';

ANCESTOR                : 'ancestor';
ANCESTOR_OR_SELF        : 'ancestor-or-self';
AND                     : 'and';
AS                      : 'as';
ATTRIBUTE               : 'attribute';
CASTABLE                : 'castable';
CAST                    : 'cast';
CHILD                   : 'child';
COMMENT                 : 'comment';
DESCENDANT              : 'descendant';
DESCENDANT_OR_SELF      : 'descendant-or-self';
DIV                     : 'div';
DOCUMENT_NODE           : 'document-node';
ELEMENT                 : 'element';
ELSE                    : 'else';
EMPTY_SEQUENCE          : 'empty-sequence';
EQ                      : 'eq';
EVERY                   : 'every';
EXCEPT                  : 'except';
FOLLOWING               : 'following';
FOLLOWING_SIBLING       : 'following-sibling';
FOR                     : 'for';
FUNCTION                : 'function';
GE                      : 'ge';
GT                      : 'gt';
IDIV                    : 'idiv';
IF                      : 'if';
IN                      : 'in';
INSTANCE                : 'instance';
INTERSECT               : 'intersect';
IS                      : 'is';
ITEM                    : 'item';
LE                      : 'le';
LET                     : 'let';
LT                      : 'lt';
MOD                     : 'mod';
NAMESPACE               : 'namespace';
NAMESPACE_NODE          : 'namespace-node';
NE                      : 'ne';
NODE                    : 'node';
OF                      : 'of';
OR                      : 'or';
PARENT                  : 'parent';
PRECEDING               : 'preceeding';
PRECEDING_SIBLING       : 'preceeding-sibling';
PROCESSING_INSTRUCTION  : 'processing-instruction';
RETURN                  : 'return';
SATISFIES               : 'satisfies';
SCHEMA_ATTRIBUTE        : 'schema-attribute';
SCHEMA_ELEMENT          : 'schema-element';
SELF                    : 'self';
SOME                    : 'some';
TEXT                    : 'text';
THEN                    : 'then';
TO                      : 'to';
TREAT                   : 'treat';
UNION                   : 'union';

IntegerLiteral
    : Digits
    ;
DecimalLiteral
    : ('.' Digits) | (Digits '.' '0'..'9'*)
    ;
DoubleLiteral
    : (('.' Digits) | (Digits ('.' '0'..'9'*)?)) ('e' | 'E') ('+'|'-')? Digits
    ;
StringLiteral
    : Quot (
          options {greedy=false;}:
          (PredefinedEntityRef | CharRef | EscapeQuot | ~('"'  | '&'))*
      )
      Quot  
    | Apos (
          options {greedy=false;}:
          (PredefinedEntityRef | CharRef | EscapeApos | ~('\'' | '&'))*
      )
      Apos
    ;
PredefinedEntityRef
    : '&' ('lt' | 'gt' | 'apos' | 'quot' | 'amp' ) ';'
    ;
CharRef
    : '&#x' HexDigits ';' {checkCharRef();}
    | '&#'  Digits    ';' {checkCharRef();}
    ;
fragment
BracedURISymbol
    : PredefinedEntityRef | CharRef | ~('&'|'{'|'}')
    ;
BracedURILiteral
    : 'Q{' BracedURISymbol* '}'
    ;
Comment
    : '(:' (options {greedy=false;}: Comment | . )* ':)' { $channel = HIDDEN; }
    ;
NCName
    : NCNameStartChar NCNameChar*
    ;
S
    : ('\u0009' | '\u000A' | '\u000D' | '\u0020')+ { $channel = HIDDEN; }
    ;
fragment
VS
    : ('\u0009' | '\u000A' | '\u000D' | '\u0020')+
    ;
fragment
Digits
    : '0'..'9'+
    ;
fragment
HexDigits
    : ('0'..'9' | 'a'..'f' | 'A'..'F')+
    ;
fragment
Char
    : '\u0009'           | '\u000A'           | '\u000D' 
    | '\u0020'..'\uD7FF' | '\uE000'..'\uFFFD' // | '\u10000'..'\u10FFFF'
    ; 
fragment
NCNameStartChar
    : Letter | '_'
    ;
fragment
NCNameChar
    // NameChar - ':'  http://www.w3.org/TR/REC-xml-names/#NT-NCName
    : 'A'..'Z'           | 'a'..'z'           | '_' 
    | '\u00C0'..'\u00D6' | '\u00D8'..'\u00F6' | '\u00F8'..'\u02FF' 
    | '\u0370'..'\u037D' | '\u037F'..'\u1FFF' | '\u200C'..'\u200D' 
    | '\u2070'..'\u218F' | '\u2C00'..'\u2FEF' | '\u3001'..'\uD7FF' 
    | '\uF900'..'\uFDCF' | '\uFDF0'..'\uFFFD' 
  //| ':'                | '\u10000..'\uEFFFF] // end of NameStartChar
    | '-'                | '.'                | '0'..'9' 
    | '\u00B7'           | '\u0300'..'\u036F' | '\u203F'..'\u2040'
    ;
fragment
Letter
    // http://www.w3.org/TR/REC-xml/#NT-Letter
    : '\u0041'..'\u005A' | '\u0061'..'\u007A' | '\u00C0'..'\u00D6' 
    | '\u00D8'..'\u00F6' | '\u00F8'..'\u00FF' | '\u0100'..'\u0131'
    | '\u0134'..'\u013E' | '\u0141'..'\u0148' | '\u014A'..'\u017E'
    | '\u0180'..'\u01C3' | '\u01CD'..'\u01F0' | '\u01F4'..'\u01F5' 
    | '\u01FA'..'\u0217' | '\u0250'..'\u02A8' | '\u02BB'..'\u02C1'
    | '\u0386'           | '\u0388'..'\u038A' | '\u038C'
    | '\u038E'..'\u03A1' | '\u03A3'..'\u03CE' | '\u03D0'..'\u03D6' 
    | '\u03DA'           | '\u03DC'           | '\u03DE'
    | '\u03E0'           | '\u03E2'..'\u03F3' | '\u0401'..'\u040C' 
    | '\u040E'..'\u044F' | '\u0451'..'\u045C' | '\u045E'..'\u0481' 
    | '\u0490'..'\u04C4' | '\u04C7'..'\u04C8' | '\u04CB'..'\u04CC' 
    | '\u04D0'..'\u04EB' | '\u04EE'..'\u04F5' | '\u04F8'..'\u04F9' 
    | '\u0531'..'\u0556' | '\u0559'           | '\u0561'..'\u0586' 
    | '\u05D0'..'\u05EA' | '\u05F0'..'\u05F2' | '\u0621'..'\u063A' 
    | '\u0641'..'\u064A' | '\u0671'..'\u06B7' | '\u06BA'..'\u06BE' 
    | '\u06C0'..'\u06CE' | '\u06D0'..'\u06D3' | '\u06D5'
    | '\u06E5'..'\u06E6' | '\u0905'..'\u0939' | '\u093D'
    | '\u0958'..'\u0961' | '\u0985'..'\u098C' | '\u098F'..'\u0990'
    | '\u0993'..'\u09A8' | '\u09AA'..'\u09B0' | '\u09B2'
    | '\u09B6'..'\u09B9' | '\u09DC'..'\u09DD' | '\u09DF'..'\u09E1' 
    | '\u09F0'..'\u09F1' | '\u0A05'..'\u0A0A' | '\u0A0F'..'\u0A10' 
    | '\u0A13'..'\u0A28' | '\u0A2A'..'\u0A30' | '\u0A32'..'\u0A33' 
    | '\u0A35'..'\u0A36' | '\u0A38'..'\u0A39' | '\u0A59'..'\u0A5C' 
    | '\u0A5E'           | '\u0A72'..'\u0A74' | '\u0A85'..'\u0A8B' 
    | '\u0A8D'           | '\u0A8F'..'\u0A91' | '\u0A93'..'\u0AA8' 
    | '\u0AAA'..'\u0AB0' | '\u0AB2'..'\u0AB3' | '\u0AB5'..'\u0AB9'
    | '\u0ABD'           | '\u0AE0'           | '\u0B05'..'\u0B0C'
    | '\u0B0F'..'\u0B10' | '\u0B13'..'\u0B28' | '\u0B2A'..'\u0B30'
    | '\u0B32'..'\u0B33' | '\u0B36'..'\u0B39' | '\u0B3D'
    | '\u0B5C'..'\u0B5D' | '\u0B5F'..'\u0B61' | '\u0B85'..'\u0B8A'
    | '\u0B8E'..'\u0B90' | '\u0B92'..'\u0B95' | '\u0B99'..'\u0B9A'
    | '\u0B9C'           | '\u0B9E'..'\u0B9F' | '\u0BA3'..'\u0BA4'
    | '\u0BA8'..'\u0BAA' | '\u0BAE'..'\u0BB5' | '\u0BB7'..'\u0BB9'
    | '\u0C05'..'\u0C0C' | '\u0C0E'..'\u0C10' | '\u0C12'..'\u0C28'
    | '\u0C2A'..'\u0C33' | '\u0C35'..'\u0C39' | '\u0C60'..'\u0C61'
    | '\u0C85'..'\u0C8C' | '\u0C8E'..'\u0C90' | '\u0C92'..'\u0CA8'
    | '\u0CAA'..'\u0CB3' | '\u0CB5'..'\u0CB9' | '\u0CDE'
    | '\u0CE0'..'\u0CE1' | '\u0D05'..'\u0D0C' | '\u0D0E'..'\u0D10'
    | '\u0D12'..'\u0D28' | '\u0D2A'..'\u0D39' | '\u0D60'..'\u0D61'
    | '\u0E01'..'\u0E2E' | '\u0E30'           | '\u0E32'..'\u0E33'
    | '\u0E40'..'\u0E45' | '\u0E81'..'\u0E82' | '\u0E84'
    | '\u0E87'..'\u0E88' | '\u0E8A'           | '\u0E8D'
    | '\u0E94'..'\u0E97' | '\u0E99'..'\u0E9F' | '\u0EA1'..'\u0EA3'
    | '\u0EA5'           | '\u0EA7'           | '\u0EAA'..'\u0EAB'
    | '\u0EAD'..'\u0EAE' | '\u0EB0'           | '\u0EB2'..'\u0EB3'
    | '\u0EBD'           | '\u0EC0'..'\u0EC4' | '\u0F40'..'\u0F47'
    | '\u0F49'..'\u0F69' | '\u10A0'..'\u10C5' | '\u10D0'..'\u10F6'
    | '\u1100'           | '\u1102'..'\u1103' | '\u1105'..'\u1107'
    | '\u1109'           | '\u110B'..'\u110C' | '\u110E'..'\u1112'
    | '\u113C'           | '\u113E'           | '\u1140'
    | '\u114C'           | '\u114E'           | '\u1150'
    | '\u1154'..'\u1155' | '\u1159'           | '\u115F'..'\u1161'
    | '\u1163'           | '\u1165'           | '\u1167'
    | '\u1169'           | '\u116D'..'\u116E' | '\u1172'..'\u1173'
    | '\u1175'           | '\u119E'           | '\u11A8'
    | '\u11AB'           | '\u11AE'..'\u11AF' | '\u11B7'..'\u11B8'
    | '\u11BA'           | '\u11BC'..'\u11C2' | '\u11EB'
    | '\u11F0'           | '\u11F9'           | '\u1E00'..'\u1E9B'
    | '\u1EA0'..'\u1EF9' | '\u1F00'..'\u1F15' | '\u1F18'..'\u1F1D'
    | '\u1F20'..'\u1F45' | '\u1F48'..'\u1F4D' | '\u1F50'..'\u1F57'
    | '\u1F59'           | '\u1F5B'           | '\u1F5D'
    | '\u1F5F'..'\u1F7D' | '\u1F80'..'\u1FB4' | '\u1FB6'..'\u1FBC'
    | '\u1FBE'           | '\u1FC2'..'\u1FC4' | '\u1FC6'..'\u1FCC'
    | '\u1FD0'..'\u1FD3' | '\u1FD6'..'\u1FDB' | '\u1FE0'..'\u1FEC'
    | '\u1FF2'..'\u1FF4' | '\u1FF6'..'\u1FFC' | '\u2126'
    | '\u212A'..'\u212B' | '\u212E'           | '\u2180'..'\u2182'
    | '\u3041'..'\u3094' | '\u30A1'..'\u30FA' | '\u3105'..'\u312C'
    | '\uAC00'..'\uD7A3' | '\u4E00'..'\u9FA5' | '\u3007'
    | '\u3021'..'\u3029'
;
