grammar Dart;

BREAK      : 'break';
CASE       : 'case';
CATCH      : 'catch';
CONST      : 'const';
CONTINUE   : 'continue';
DEFAULT    : 'default';
DO         : 'do';
ELSE       : 'else';
FALSE      : 'false';
FINAL      : 'final';
FINALLY    : 'finally';
FOR        : 'for';
IF         : 'if';
IN         : 'in';
NEW        : 'new';
NULL       : 'null';
RETURN     : 'return';
SUPER      : 'super';
SWITCH     : 'switch';
THIS       : 'this';
THROW      : 'throw';
TRUE       : 'true';
TRY        : 'try';
VAR        : 'var';
VOID       : 'void';
WHILE      : 'while';


ABSTRACT   : 'abstract';
ASSERT     : 'assert';
CLASS      : 'class';
EXTENDS    : 'extends';
FACTORY    : 'factory';
GET        : 'get';
IMPLEMENTS : 'implements';
IMPORT     : 'import';
INTERFACE  : 'interface';
IS         : 'is';
LIBRARY    : 'library';
NATIVE     : 'native';
NEGATE     : 'negate';
OPERATOR   : 'operator';
SET        : 'set';
SOURCE     : 'source';
STATIC     : 'static';
TYPEDEF    : 'typedef';





compilationUnit
    : HASHBANG? directive* topLevelDefinition* EOF
    ;

directive
    : '#' identifier arguments ';'
    ;

topLevelDefinition
    :  classDefinition
    |  interfaceDefinition
    |  functionTypeAlias
    | functionDeclaration functionBodyOrNative
    | returnType? getOrSet identifier formalParameterList functionBodyOrNative
    | FINAL type? staticFinalDeclarationList ';'
    | constInitializedVariableDeclaration ';'
    ;

classDefinition
    : CLASS identifier typeParameters? superclass? interfaces?
      '{' classMemberDefinition* '}'
    | CLASS identifier typeParameters? interfaces? NATIVE STRING
      '{' classMemberDefinition* '}'
    ;

typeParameter
    : identifier (EXTENDS type)?
    ;

typeParameters
    : '<' typeParameter (',' typeParameter)* '>'
    ;

superclass
    : EXTENDS type
    ;

interfaces
    : IMPLEMENTS typeList
    ;

superinterfaces
    : EXTENDS typeList
    ;



classMemberDefinition
    : declaration ';'
    | constructorDeclaration ';'
    | methodDeclaration functionBodyOrNative
    | CONST factoryConstructorDeclaration functionNative
    ;

functionBodyOrNative
    : NATIVE functionBody
    | functionNative
    | functionBody
    ;

functionNative
    : NATIVE STRING? ';'
    ;



methodDeclaration
    : factoryConstructorDeclaration
    | STATIC functionDeclaration
    | specialSignatureDefinition
    | functionDeclaration initializers?
    | namedConstructorDeclaration initializers?
    ;



declaration
    : constantConstructorDeclaration (redirection | initializers)?
    | functionDeclaration redirection
    | namedConstructorDeclaration redirection
    | ABSTRACT specialSignatureDefinition
    | ABSTRACT functionDeclaration
    | STATIC FINAL type? staticFinalDeclarationList
    | STATIC? constInitializedVariableDeclaration
    ;

initializers
    : ':' superCallOrFieldInitializer (',' superCallOrFieldInitializer)*
    ;

redirection
    : ':' THIS ('.' identifier)? arguments
    ;

fieldInitializer
    : (THIS '.')? identifier '=' conditionalExpression
    ;


superCallOrFieldInitializer
    : SUPER arguments
    | SUPER '.' identifier arguments
    | fieldInitializer
    ;

staticFinalDeclarationList
    : staticFinalDeclaration (',' staticFinalDeclaration)*
    ;

staticFinalDeclaration
    : identifier '=' constantExpression
    ;

interfaceDefinition
    : INTERFACE identifier typeParameters? superinterfaces?
      factorySpecification? '{' (interfaceMemberDefinition)* '}'
    ;

factorySpecification
   : FACTORY type
   ;

functionTypeAlias
    : TYPEDEF functionPrefix typeParameters? formalParameterList ';'
    ;

interfaceMemberDefinition
    : STATIC FINAL type? initializedIdentifierList ';'
    | functionDeclaration ';'
    | constantConstructorDeclaration ';'
    | namedConstructorDeclaration ';'
    | specialSignatureDefinition ';'
    | variableDeclaration ';'
    ;

factoryConstructorDeclaration
    : FACTORY qualified typeParameters? ('.' identifier)? formalParameterList
    ;

namedConstructorDeclaration
    : identifier '.' identifier formalParameterList
    ;

constructorDeclaration
    : identifier formalParameterList (redirection | initializers)?
    | namedConstructorDeclaration (redirection | initializers)?
    ;

constantConstructorDeclaration
    : CONST qualified formalParameterList
    ;

specialSignatureDefinition
    : STATIC? returnType? getOrSet identifier formalParameterList
    | returnType? OPERATOR userDefinableOperator formalParameterList
    ;

getOrSet
    : GET
    | SET
    ;

userDefinableOperator
    : multiplicativeOperator
    | additiveOperator
    | shiftOperator
    | relationalOperator
    | bitwiseOperator
    | '=='
    | '~' 
    | NEGATE
    | '[' ']'
    | '[' ']' '='
    ;

prefixOperator
    : additiveOperator
    | negateOperator
    ;

postfixOperator
    : incrementOperator
    ;

negateOperator
    : '!'
    | '~'
    ;

multiplicativeOperator
    : '*'
    | '/'
    | '%'
    | '~/'
    ;

assignmentOperator
    : '='
    | '*='
    | '/='
    | '~/='
    | '%='
    | '+='
    | '-='
    | '<<='
    | '>' '>' '>' '='
    | '>' '>' '='
    | '&='
    | '^='
    | '|='
    ;

additiveOperator
    : '+'
    | '-'
    ;

incrementOperator
    : '++'
    | '--'
    ;

shiftOperator
    : '<<'
    | '>' '>' '>'
    | '>' '>'
    ;

relationalOperator
    : '>' '='
    | '>'
    | '<='
    | '<'
    ;

equalityOperator
    : '=='
    | '!='
    | '==='
    | '!=='
    ;

bitwiseOperator
    : '&'
    | '^'
    | '|'
    ;

formalParameterList
    : '(' namedFormalParameters? ')'
    | '(' normalFormalParameter normalFormalParameterTail? ')'
    ;

normalFormalParameterTail
    : ',' namedFormalParameters
    | ',' normalFormalParameter normalFormalParameterTail?
    ;

normalFormalParameter
    : functionDeclaration
    | fieldFormalParameter
    | simpleFormalParameter
    ;

simpleFormalParameter
    : declaredIdentifier
    | identifier
    ;

fieldFormalParameter
   : finalVarOrType? THIS '.' identifier
   ;

namedFormalParameters
    : '[' defaultFormalParameter (',' defaultFormalParameter)* ']'
    ;

defaultFormalParameter
    : normalFormalParameter ('=' constantExpression)?
    ;

returnType
    : VOID
    | type
    ;

finalVarOrType
    : FINAL type?
    | VAR
    | type
    ;





declaredIdentifier
    : FINAL type? identifier
    | VAR identifier
    | type identifier
    ;

identifier
    : IDENTIFIER_NO_DOLLAR
    | IDENTIFIER
    | ABSTRACT
    | ASSERT
    | CLASS
    | EXTENDS
    | FACTORY
    | GET
    | IMPLEMENTS
    | IMPORT
    | INTERFACE
    | IS
    | LIBRARY
    | NATIVE
    | NEGATE
    | OPERATOR
    | SET
    | SOURCE
    | STATIC
    | TYPEDEF
    ;

qualified
    : identifier ('.' identifier)?
    ;

type
    : qualified typeArguments?
    ;

typeArguments
    : '<' typeList '>'
    ;

typeList
    : type (',' type)*
    ;

block
    : '{' statements '}'
    ;

statements
    : statement*
    ;

statement
    : label* nonLabelledStatement
    ;

nonLabelledStatement
    : block
    | initializedVariableDeclaration ';'
    | iterationStatement
    | selectionStatement
    | tryStatement
    | BREAK identifier? ';'
    | CONTINUE identifier? ';'
    | RETURN expression? ';'
    | THROW expression? ';'
    | expression? ';'
    | ASSERT '(' conditionalExpression ')' ';'
    | functionDeclaration functionBody
    ;

label
    : identifier ':'
    ;

iterationStatement
    : WHILE '(' expression ')' statement
    | DO statement WHILE '(' expression ')' ';'
    | FOR '(' forLoopParts ')' statement
    ;

forLoopParts
    : forInitializerStatement expression? ';' expressionList?
    | declaredIdentifier IN expression
    | identifier IN expression
    ;

forInitializerStatement
    : initializedVariableDeclaration ';'
    | expression? ';'
    ;

selectionStatement
    : IF '(' expression ')' statement ( ELSE statement)?
    | SWITCH '(' expression ')' '{' switchCase* defaultCase? '}'
    ;

switchCase
    : label? (CASE expression ':')+ statements
    ;

defaultCase
    : label? (CASE expression ':')* DEFAULT ':' statements
    ;

tryStatement
    : TRY block (catchPart+ finallyPart? | finallyPart)
    ;

catchPart
    : CATCH '(' declaredIdentifier (',' declaredIdentifier)? ')' block
    ;

finallyPart
    : FINALLY block
    ;

variableDeclaration
    : declaredIdentifier (',' identifier)*
    ;

initializedVariableDeclaration
    : declaredIdentifier ('=' expression)? (',' initializedIdentifier)*
    ;

initializedIdentifierList
    : initializedIdentifier (',' initializedIdentifier)*
    ;

initializedIdentifier
    : identifier ('=' expression)?
    ;

constInitializedVariableDeclaration
    : declaredIdentifier ('=' constantExpression)?
      (',' constInitializedIdentifier)*
    ;

constInitializedIdentifier
    : identifier ('=' constantExpression)?
    ;





constantExpression
    : expression
    ;

expression
    : assignableExpression assignmentOperator expression
    | conditionalExpression
    ;

expressionList
    : expression (',' expression)*
    ;

arguments
    : '(' argumentList? ')'
    ;


argumentList
    : namedArgument (',' namedArgument)*
    | expressionList (',' namedArgument)*
    ;

namedArgument
    : label expression
    ;

assignableExpression
    : primary (arguments* assignableSelector)+
    | SUPER assignableSelector
    | identifier
    ;

conditionalExpression
    : logicalOrExpression ('?' expression ':' expression)?
    ;

logicalOrExpression
    : logicalAndExpression ('||' logicalAndExpression)*
    ;

logicalAndExpression
    : bitwiseOrExpression ('&&' bitwiseOrExpression)*
    ;

bitwiseOrExpression
    : bitwiseXorExpression ('|' bitwiseXorExpression)*
    | SUPER ('|' bitwiseXorExpression)+
    ;

bitwiseXorExpression
    : bitwiseAndExpression ('^' bitwiseAndExpression)*
    | SUPER ('^' bitwiseAndExpression)+
    ;

bitwiseAndExpression
    : equalityExpression ('&' equalityExpression)*
    | SUPER ('&' equalityExpression)+
    ;

equalityExpression
    : relationalExpression (equalityOperator relationalExpression)?
    | SUPER equalityOperator relationalExpression
    ;

relationalExpression
    : shiftExpression (isOperator type | relationalOperator shiftExpression)?
    | SUPER relationalOperator shiftExpression
    ;

isOperator
    : IS '!'?
    ;

shiftExpression
    : additiveExpression (shiftOperator additiveExpression)*
    | SUPER (shiftOperator additiveExpression)+
    ;

additiveExpression
    : multiplicativeExpression (additiveOperator multiplicativeExpression)*
    | SUPER (additiveOperator multiplicativeExpression)+
    ;

multiplicativeExpression
    : unaryExpression (multiplicativeOperator unaryExpression)*
    | SUPER (multiplicativeOperator unaryExpression)+
    ;

unaryExpression
    : postfixExpression
    | prefixOperator unaryExpression
    | negateOperator SUPER
    | '-' SUPER  
    | incrementOperator assignableExpression
    ;

postfixExpression
    : assignableExpression postfixOperator
    | primary selector*
    ;

selector
    : assignableSelector
    | arguments
    ;

assignableSelector
    : '[' expression ']'
    | '.' identifier
    ;


primary
    :  primaryNoFE
    | primaryFE
    ;

primaryFE
    : functionExpression
    | primaryNoFE
    ;

primaryNoFE
    : THIS
    | SUPER assignableSelector
    | literal
    | identifier
    | CONST? typeArguments? compoundLiteral
    | (NEW | CONST) type ('.' identifier)? arguments
    | expressionInParentheses
    ;

expressionInParentheses
    :'(' expression ')'
    ;


literal
    : NULL
    | TRUE
    | FALSE
    | HEX_NUMBER
    | NUMBER
    | STRING
    ;

compoundLiteral
    : listLiteral
    | mapLiteral
    ;




listLiteral
    : '[' (expressionList ','?)? ']'
    ;

mapLiteral
    : '{' (mapLiteralEntry (',' mapLiteralEntry)* ','?)? '}'
    ;

mapLiteralEntry
    : STRING ':' expression
    ;

functionExpression
    : (returnType? identifier)? formalParameterList functionExpressionBody
    ;

functionDeclaration
    : returnType? identifier formalParameterList
    ;

functionPrefix
    : returnType? identifier
    ;

functionBody
    : '=>' expression ';'
    | block
    ;

functionExpressionBody
    : '=>' expression
    | block
    ;




libraryUnit
    : libraryDefinition EOF
    ;

libraryDefinition
    : LIBRARY '{' libraryBody '}'
    ;

libraryBody
    : libraryImport? librarySource?
    ;

libraryImport
    : IMPORT '=' '[' importReferences? ']'
    ;

importReferences
    : importReference (',' importReference)* ','?
    ;

importReference
    : (IDENTIFIER ':')? STRING
    ;

librarySource
    : SOURCE '=' '[' sourceUrls? ']'
    ;

sourceUrls
    : STRING (',' STRING)* ','?
    ;





IDENTIFIER_NO_DOLLAR
    : IDENTIFIER_START_NO_DOLLAR IDENTIFIER_PART_NO_DOLLAR*
    ;

IDENTIFIER
    : IDENTIFIER_START IDENTIFIER_PART*
    ;

HEX_NUMBER
    : '0x' HEX_DIGIT+
    | '0X' HEX_DIGIT+
    ;

NUMBER
    : DIGIT+ NUMBER_OPT_FRACTIONAL_PART EXPONENT? NUMBER_OPT_ILLEGAL_END
    | '.' DIGIT+ EXPONENT? NUMBER_OPT_ILLEGAL_END
    ;

NUMBER_OPT_FRACTIONAL_PART
    :  ('.' DIGIT+)
    | EPSILON
    ;

NUMBER_OPT_ILLEGAL_END
    : EPSILON
    | EMPTY
    ;

HEX_DIGIT
    : 'a'|'b'|'c'|'d'|'e'|'f'
    | 'A'|'B'|'C'|'D'|'E'|'F'
    | DIGIT
    ;

IDENTIFIER_START
    : IDENTIFIER_START_NO_DOLLAR
    | '$'
    ;

IDENTIFIER_START_NO_DOLLAR
    : LETTER
    | '_'
    ;

IDENTIFIER_PART_NO_DOLLAR
    : IDENTIFIER_START_NO_DOLLAR
    | DIGIT
    ;

IDENTIFIER_PART
    : IDENTIFIER_START
    | DIGIT
    ;

LETTER
    : 'a'|'b'|'c'|'d'|'e'|'f'|'g'|'h'|'i'|'j'|'k'|'l'|'m'|'n'|'o'|'p'|'q'|'r'|'s'|'t'|'u'|'v'|'w'|'x'|'y'|'z'
    | 'A'|'B'|'C'|'D'|'E'|'F'|'G'|'H'|'I'|'J'|'K'|'L'|'M'|'N'|'O'|'P'|'Q'|'R'|'S'|'T'|'U'|'V'|'W'|'X'|'Y'|'Z'
    ;

DIGIT
    : '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
    ;

EXPONENT
    : ('e' | 'E') ('+' | '-')? DIGIT+
    ;

STRING
    : '@'? MULTI_LINE_STRING
    | SINGLE_LINE_STRING
    ;

MULTI_LINE_STRING
    : '"""' ANY* '"""'
    | '\'\'\'' ANY* '\'\'\''
    ;

SINGLE_LINE_STRING
    : '"' STRING_CONTENT_DQ* '"'
    | '\'' STRING_CONTENT_SQ* '\''
    | '@' '\'' ( ANY )* '\''
    | '@' '"' ( ANY )* '"'
    ;

STRING_CONTENT_DQ
    : ANY
    | '\\' ANY
    ;

STRING_CONTENT_SQ
    : ANY
    | '\\' ANY
    ;

NEWLINE
    : '\n'
    | '\r'
    ;

BAD_STRING
    : UNTERMINATED_STRING NEWLINE
    ;

UNTERMINATED_STRING
    : '@'? '\'' (ANY)*
    | '@'? '"' (ANY)*
    ;

HASHBANG
    : '#!' ANY* (NEWLINE)?
    ;





WHITESPACE
    : ('\t' | ' ' | NEWLINE)+
    ;

SINGLE_LINE_COMMENT
    : '//' ANY* (NEWLINE)?
    ;

MULTI_LINE_COMMENT
    : '/*' (ANY)* '*/'
    ;
