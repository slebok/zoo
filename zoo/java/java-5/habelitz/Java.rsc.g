grammar Java;

    
    AND : '&' ;
    AND_ASSIGN : '&=' ;
    ASSIGN : '=' ;
    AT : '@' ;
    BIT_SHIFT_RIGHT : '>>>' ;
    BIT_SHIFT_RIGHT_ASSIGN : '>>>=' ;
    COLON : ':' ;
    COMMA : ',' ;
    DEC : '--' ;
    DIV : '/' ;
    DIV_ASSIGN : '/=' ;
    DOT : '.' ;
    DOTSTAR : '.*' ;
    ELLIPSIS : '...' ;
    EQUAL : '==' ;
    GREATER_OR_EQUAL : '>=' ;
    GREATER_THAN : '>' ;
    INC : '++' ;
    LBRACK : '[' ;
    LCURLY : '{' ;
    LESS_OR_EQUAL : '<=' ;
    LESS_THAN : '<' ;
    LOGICAL_AND : '&&' ;
    LOGICAL_NOT : '!' ;
    LOGICAL_OR : '||' ;
    LPAREN : '(' ;
    MINUS : '-' ;
    MINUS_ASSIGN : '-=' ;
    MOD : '%' ;
    MOD_ASSIGN : '%=' ;
    NOT : '~' ;
    NOT_EQUAL : '!=' ;
    OR : '|' ;
    OR_ASSIGN : '|=' ;
    PLUS : '+' ;
    PLUS_ASSIGN : '+=' ;
    QUESTION : '?' ;
    RBRACK : ']' ;
    RCURLY : '}' ;
    RPAREN : ')' ;
    SEMI : ';' ;
    SHIFT_LEFT : '<<' ;
    SHIFT_LEFT_ASSIGN : '<<=' ;
    SHIFT_RIGHT : '>>' ;
    SHIFT_RIGHT_ASSIGN : '>>=' ;
    STAR : '*' ;
    STAR_ASSIGN : '*=' ;
    XOR : '^' ;
    XOR_ASSIGN : '^=' ;

    
    
    ABSTRACT : 'abstract' ;
    ASSERT : 'assert' ;
    BOOLEAN : 'boolean' ;
    BREAK : 'break' ;
    BYTE : 'byte' ;
    CASE : 'case' ;
    CATCH : 'catch' ;
    CHAR : 'char' ;
    CLASS : 'class' ;
    CONTINUE : 'continue' ;
    DEFAULT : 'default' ;
    DO : 'do' ;
    DOUBLE : 'double' ;
    ELSE : 'else' ;
    ENUM : 'enum' ;
    EXTENDS : 'extends' ;
    FALSE : 'false' ;
    FINAL : 'final' ;
    FINALLY : 'finally' ;
    FLOAT : 'float' ;
    FOR : 'for' ;
    IF : 'if' ;
    IMPLEMENTS : 'implements' ;
    INSTANCEOF : 'instanceof' ;
    INTERFACE : 'interface' ;
    IMPORT : 'import' ;
    INT : 'int' ;
    LONG : 'long' ;
    NATIVE : 'native' ;
    NEW : 'new' ;
    NULL : 'null' ;
    PACKAGE : 'package' ;
    PRIVATE : 'private' ;
    PROTECTED : 'protected' ;
    PUBLIC : 'public' ;
    RETURN : 'return' ;
    SHORT : 'short' ;
    STATIC : 'static' ;
    STRICTFP : 'strictfp' ;
    SUPER : 'super' ;
    SWITCH : 'switch' ;
    SYNCHRONIZED : 'synchronized' ;
    THIS : 'this' ;
    THROW : 'throw' ;
    THROWS : 'throws' ;
    TRANSIENT : 'transient' ;
    TRUE : 'true' ;
    TRY : 'try' ;
    VOID : 'void' ;
    VOLATILE : 'volatile' ;
    WHILE : 'while' ;
    
    
javaSource
    :   compilationUnit;

compilationUnit
    :   annotationList 
        packageDeclaration? 
        importDeclaration* 
        typeDecls*
    ;

typeDecls
    :   typeDeclaration
    |   SEMI
    ;

packageDeclaration
    :   PACKAGE qualifiedIdentifier SEMI  
    ;
    
importDeclaration
    :   IMPORT STATIC? qualifiedIdentifier DOTSTAR? SEMI
    ;
    
typeDeclaration
    :   modifierList
        (   classTypeDeclaration
        |   interfaceTypeDeclaration
        |   enumTypeDeclaration
        |   annotationTypeDeclaration
        )
    ;
    
classTypeDeclaration: CLASS IDENT genericTypeParameterList? classExtendsClause? implementsClause? classBody;
    
classExtendsClause
    :   EXTENDS type;   
    
interfaceExtendsClause
    :   EXTENDS typeList;   
    
implementsClause
    :   IMPLEMENTS typeList;
        
genericTypeParameterList
    :   LESS_THAN genericTypeParameter (COMMA genericTypeParameter)* genericTypeListClosing;

genericTypeListClosing  
                        
                        
                        
    :   GREATER_THAN
    |   SHIFT_RIGHT
    |   BIT_SHIFT_RIGHT
    |   EPSILON
    ;

genericTypeParameter
    :   IDENT bound?;
        
bound
    :   EXTENDS type (AND type)*;

enumTypeDeclaration: ENUM IDENT implementsClause? enumBody;
    
enumBody
    :   LCURLY enumScopeDeclarations RCURLY;

enumScopeDeclarations
    :   enumConstants (COMMA)? enumClassScopeDeclarations?
    ;

enumClassScopeDeclarations
    :   SEMI classScopeDeclarations*;

enumConstants
    :   enumConstant (COMMA enumConstant)*
    ;
    
enumConstant
    :   annotationList IDENT arguments? classBody?
    ;
    
interfaceTypeDeclaration: INTERFACE IDENT genericTypeParameterList? interfaceExtendsClause? interfaceBody;
    
typeList
    :   type (COMMA type)*
    ;
    
classBody
    :   LCURLY classScopeDeclarations* RCURLY;
    
interfaceBody
    :   LCURLY interfaceScopeDeclarations* RCURLY;

classScopeDeclarations
    :   block|   STATIC block|   modifierList
        (   genericTypeParameterList?
            (   type IDENT formalParameterList arrayDeclaratorList? throwsClause? (block | SEMI)|   VOID IDENT formalParameterList throwsClause? (block | SEMI)|   ident=IDENT formalParameterList throwsClause? block)
        |   type classFieldDeclaratorList SEMI)
    |   typeDeclaration
    |   SEMI
    ;
            
interfaceScopeDeclarations
    :   modifierList
        (   genericTypeParameterList?
            (   type IDENT formalParameterList arrayDeclaratorList? throwsClause? SEMI|   VOID IDENT formalParameterList throwsClause? SEMI)
        |   type interfaceFieldDeclaratorList SEMI)
    |   typeDeclaration
    |   SEMI
    ;

classFieldDeclaratorList
    :   classFieldDeclarator (COMMA classFieldDeclarator)*;

classFieldDeclarator
    :   variableDeclaratorId (ASSIGN variableInitializer)?;
    
interfaceFieldDeclaratorList
    :   interfaceFieldDeclarator (COMMA interfaceFieldDeclarator)*;

interfaceFieldDeclarator
    :   variableDeclaratorId ASSIGN variableInitializer;
    
variableDeclaratorId
    :   IDENT arrayDeclaratorList?
    ;

variableInitializer
    :   arrayInitializer
    |   expression
    ;

arrayDeclarator
    :   LBRACK RBRACK;

arrayDeclaratorList
    :   arrayDeclarator+;
    
arrayInitializer
    :   LCURLY (variableInitializer (COMMA variableInitializer)* COMMA?)? RCURLY;

throwsClause
    :   THROWS qualifiedIdentList;

modifierList
    :   modifier*;

modifier
    :   PUBLIC
    |   PROTECTED
    |   PRIVATE
    |   STATIC
    |   ABSTRACT
    |   NATIVE
    |   SYNCHRONIZED
    |   TRANSIENT
    |   VOLATILE
    |   STRICTFP
    |   localModifier
    ;

localModifierList
    :   localModifier*;
    
localModifier
    :   FINAL
    |   annotation
    ;

type
    :   simpleType
    |   objectType
    ;

simpleType 
    :   primitiveType arrayDeclaratorList?;
    
objectType 
    :   qualifiedTypeIdent arrayDeclaratorList?;

objectTypeSimplified
    :   qualifiedTypeIdentSimplified arrayDeclaratorList?;

qualifiedTypeIdent
    :   typeIdent (DOT typeIdent)*;

qualifiedTypeIdentSimplified
    :   typeIdentSimplified (DOT typeIdentSimplified)*;

typeIdent
    :   IDENT genericTypeArgumentList?
    ;

typeIdentSimplified
    :   IDENT genericTypeArgumentListSimplified?
    ;

primitiveType
    :   BOOLEAN
    |   CHAR
    |   BYTE
    |   SHORT
    |   INT
    |   LONG
    |   FLOAT
    |   DOUBLE
    ;

genericTypeArgumentList
    :   LESS_THAN genericTypeArgument (COMMA genericTypeArgument)* genericTypeListClosing;

genericTypeArgument
    :   type
    |   QUESTION genericWildcardBoundType?;
    
genericWildcardBoundType
    :   (EXTENDS | SUPER) type
    ;

genericTypeArgumentListSimplified
    :   LESS_THAN genericTypeArgumentSimplified (COMMA genericTypeArgumentSimplified)* genericTypeListClosing;
    
genericTypeArgumentSimplified
    :   type
    |   QUESTION
    ;
    
qualifiedIdentList
    :   qualifiedIdentifier (COMMA qualifiedIdentifier)*
    ;
    
formalParameterList
    :   LPAREN 
        (   
            formalParameterStandardDecl (COMMA formalParameterStandardDecl)* (COMMA formalParameterVarArgDecl)?|   formalParameterVarArgDecl|   EPSILON)
        RPAREN
    ;
    
formalParameterStandardDecl
    :   localModifierList type variableDeclaratorId;
    
formalParameterVarArgDecl
    :   localModifierList type ELLIPSIS variableDeclaratorId;
    
qualifiedIdentifier
    :   (   IDENT)
        (   DOT ident=IDENT)*
    ;
    


annotationList
    :   annotation*;

annotation
    :   AT qualifiedIdentifier annotationInit?
    ;
    
annotationInit
    :   LPAREN annotationInitializers RPAREN;

annotationInitializers
    :   annotationInitializer (COMMA annotationInitializer)*|   annotationElementValue;
    
annotationInitializer
    :   IDENT ASSIGN annotationElementValue
    ;
    
annotationElementValue
    :   annotationElementValueExpression
    |   annotation
    |   annotationElementValueArrayInitializer
    ;
    
annotationElementValueExpression
    :   conditionalExpression;
    
annotationElementValueArrayInitializer
    :   LCURLY (annotationElementValue (COMMA annotationElementValue)*)? (COMMA)? RCURLY;
    
annotationTypeDeclaration: AT INTERFACE IDENT annotationBody;
    
annotationBody
    :   LCURLY annotationScopeDeclarations* RCURLY;
    
annotationScopeDeclarations
    :   modifierList type
        (   IDENT LPAREN RPAREN annotationDefaultValue? SEMI|   classFieldDeclaratorList SEMI)
    |   typeDeclaration
    ;
    
annotationDefaultValue
    :   DEFAULT annotationElementValue
    ;



block
    :   LCURLY blockStatement* RCURLY;

blockStatement
    :   localVariableDeclaration SEMI
    |   typeDeclaration
    |   statement
    ;
    
localVariableDeclaration
    :   localModifierList type classFieldDeclaratorList;
    
        
statement
    :   block
    |   ASSERT expr1=expression 
        (   COLON expr2=expression SEMI|   SEMI)
    |   IF parenthesizedExpression ifStat=statement 
        (   ELSE elseStat=statement|    EPSILON                                                               )   
    |   FOR LPAREN 
        (   forInit SEMI forCondition SEMI forUpdater RPAREN statement|   localModifierList type IDENT COLON expression RPAREN statement) 
    |   WHILE parenthesizedExpression statement|   DO statement WHILE parenthesizedExpression SEMI|   TRY block (catches finallyClause? | finallyClause)|   SWITCH parenthesizedExpression LCURLY switchBlockLabels RCURLY|   SYNCHRONIZED parenthesizedExpression block|   RETURN expression? SEMI|   THROW expression SEMI|   BREAK IDENT? SEMI|   CONTINUE IDENT? SEMI|   IDENT COLON statement|   expression SEMI
    |   SEMI 
    ;           
        
catches
    :   catchClause+;
    
catchClause
    :   CATCH LPAREN formalParameterStandardDecl RPAREN block
    ;

finallyClause
    :   FINALLY block;

switchBlockLabels
    :   switchCaseLabels switchDefaultLabel? switchCaseLabels;
    
switchCaseLabels
    :   switchCaseLabel*
    ;
        
switchCaseLabel
    :   CASE expression COLON blockStatement*
    ;
    
switchDefaultLabel
    :   DEFAULT COLON blockStatement*
    ;
    
forInit
    :   localVariableDeclaration|   expressionList|                               EPSILON;
    
forCondition
    :   expression?;
    
forUpdater
    :   expressionList?;



parenthesizedExpression
    :   LPAREN expression RPAREN;
    
expressionList
    :   expression (COMMA expression)*
    ;

expression
    :   assignmentExpression;

assignmentExpression
    :   conditionalExpression 
        (   (   ASSIGN
            |   PLUS_ASSIGN
            |   MINUS_ASSIGN
            |   STAR_ASSIGN
            |   DIV_ASSIGN
            |   AND_ASSIGN
            |   OR_ASSIGN
            |   XOR_ASSIGN
            |   MOD_ASSIGN
            |   SHIFT_LEFT_ASSIGN
            |   SHIFT_RIGHT_ASSIGN
            |   BIT_SHIFT_RIGHT_ASSIGN
        ) 
        assignmentExpression)?
    ;
    
conditionalExpression
    :   logicalOrExpression (QUESTION assignmentExpression COLON conditionalExpression)?
    ;

logicalOrExpression
    :   logicalAndExpression (LOGICAL_OR logicalAndExpression)*
    ;

logicalAndExpression
    :   inclusiveOrExpression (LOGICAL_AND inclusiveOrExpression)*
    ;

inclusiveOrExpression
    :   exclusiveOrExpression (OR exclusiveOrExpression)*
    ;

exclusiveOrExpression
    :   andExpression (XOR andExpression)*
    ;

andExpression
    :   equalityExpression (AND equalityExpression)*
    ;

equalityExpression
    :   instanceOfExpression 
        (   (   EQUAL
            |   NOT_EQUAL
            ) 
            instanceOfExpression
        )*
    ;

instanceOfExpression
    :   relationalExpression (INSTANCEOF type)?
    ;

relationalExpression
    :   shiftExpression 
        (   (   LESS_OR_EQUAL
            |   GREATER_OR_EQUAL
            |   LESS_THAN
            |   GREATER_THAN
            )
            shiftExpression
        )*
    ;
    
shiftExpression
    :   additiveExpression
        (   (   BIT_SHIFT_RIGHT
            |   SHIFT_RIGHT
            |   SHIFT_LEFT
            )
            additiveExpression
        )*
    ;

additiveExpression
    :   multiplicativeExpression
        (   (   PLUS
            |   MINUS
            )
            multiplicativeExpression
        )*
    ;

multiplicativeExpression
    :   unaryExpression 
        (   (   STAR
            |   DIV
            |   MOD
            )
            unaryExpression
        )*
    ;
    
unaryExpression
    :   PLUS unaryExpression|   MINUS unaryExpression|   INC postfixedExpression|   DEC postfixedExpression|   unaryExpressionNotPlusMinus
    ;

unaryExpressionNotPlusMinus
    :   NOT unaryExpression|   LOGICAL_NOT unaryExpression|   LPAREN type RPAREN unaryExpression|   postfixedExpression
    ;
    
postfixedExpression
        
    :   (   primaryExpression)
        
        (   outerDot=DOT                            
            (   (   genericTypeArgumentListSimplified?  
                                                        
                    IDENT) 
                (   arguments)?
            |   THIS|   Super=SUPER arguments|   (   SUPER innerDot=DOT IDENT)
                (   arguments)?
            |   innerNewExpression)
        |   LBRACK expression RBRACK)*
        
        (   INC|   DEC)?
    ;    
    
primaryExpression
    :   parenthesizedExpression
    |   literal
    |   newExpression
    |   qualifiedIdentExpression
    |   genericTypeArgumentListSimplified 
        (   SUPER
            (   arguments|   DOT IDENT arguments)
        |   IDENT arguments|   THIS arguments)
    |   (   THIS)
        (   arguments)?
    |   SUPER arguments|   (   SUPER DOT IDENT
        )
        (   arguments|                                               EPSILON)
    |   (   primitiveType)
        (   arrayDeclarator)* 
        DOT CLASS|   VOID DOT CLASS;
    
qualifiedIdentExpression
        
    :   (   qualifiedIdentifier)
        
        (   (   arrayDeclarator)+ 
            (   DOT CLASS)
        |   arguments|   outerDot=DOT
            (   CLASS|   genericTypeArgumentListSimplified 
                (   Super=SUPER arguments|   SUPER innerDot=DOT IDENT arguments|   IDENT arguments)
            |   THIS|   Super=SUPER arguments|   innerNewExpression)
        )?
    ;

newExpression
    :   NEW  
        (   primitiveType newArrayConstruction|   genericTypeArgumentListSimplified? qualifiedTypeIdentSimplified
            (   newArrayConstruction|   arguments classBody?)
        )
    ;
    
innerNewExpression 
    :   NEW genericTypeArgumentListSimplified? IDENT arguments classBody?;

newArrayConstruction
    :   arrayDeclaratorList arrayInitializer
    |   LBRACK expression RBRACK (LBRACK expression RBRACK)* arrayDeclaratorList?
    ;

arguments
    :   LPAREN expressionList? RPAREN;

literal 
    :   HEX_LITERAL
    |   OCTAL_LITERAL
    |   DECIMAL_LITERAL
    |   FLOATING_POINT_LITERAL
    |   CHARACTER_LITERAL
    |   STRING_LITERAL
    |   TRUE
    |   FALSE
    |   NULL
    ;



HEX_LITERAL : '0' ('x'|'X') HEX_DIGIT+ INTEGER_TYPE_SUFFIX? ;

DECIMAL_LITERAL : ('0' | ('1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9') ('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9')*) INTEGER_TYPE_SUFFIX? ;

OCTAL_LITERAL : '0' ('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7')+ INTEGER_TYPE_SUFFIX? ;

HEX_DIGIT: (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9')|('a'|'b'|'c'|'d'|'e'|'f')|('A'|'B'|'C'|'D'|'E'|'F')) ;

INTEGER_TYPE_SUFFIX: ('l'|'L') ;

FLOATING_POINT_LITERAL
    :   (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+ 
        (
            DOT (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))* EXPONENT? FLOAT_TYPE_SUFFIX?
        |   EXPONENT FLOAT_TYPE_SUFFIX?
        |   FLOAT_TYPE_SUFFIX
        )
    |   DOT (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+ EXPONENT? FLOAT_TYPE_SUFFIX?
    ;

EXPONENT: ('e'|'E') ('+'|'-')? (('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'))+ ;

FLOAT_TYPE_SUFFIX: ('f'|'F'|'d'|'D') ;

CHARACTER_LITERAL
    :   '\'' ( ESCAPE_SEQUENCE | BGF_STRING ) '\''
    ;

STRING_LITERAL
    :  '"' ( ESCAPE_SEQUENCE | BGF_STRING )* '"'
    ;

ESCAPE_SEQUENCE: '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\')
    |   UNICODE_ESCAPE
    |   OCTAL_ESCAPE
    ;

OCTAL_ESCAPE: ('0'|'1'|'2'|'3') ('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7') ('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7')
    |   '\\' ('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7') ('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7')
    |   '\\' ('0'|'1'|'2'|'3'|'4'|'5'|'6'|'7')
    ;

UNICODE_ESCAPE: '\\' 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
    ;

IDENT
    :   JAVA_ID_START (JAVA_ID_PART)*
    ;

JAVA_ID_START: 'a'|'b'|'c'|'d'|'e'|'f'|'g'|'h'|'i'|'j'|'k'|'l'|'m'|'n'|'o'|'p'|'q'|'r'|'s'|'t'|'u'|'v'|'w'|'x'|'y'|'z'|'A'|'B'|'C'|'D'|'E'|'F'|'G'|'H'|'I'|'J'|'K'|'L'|'M'|'N'|'O'|'P'|'Q'|'R'|'S'|'T'|'U'|'V'|'W'|'X'|'Y'|'Z'
    ;

JAVA_ID_PART: JAVA_ID_START
    |  '0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'
    ;

WS  :  (' '|'\r'|'\t'|'\u000C'|'\n');

COMMENT
    :   '/*' ( ANYTHING )* '*/';
