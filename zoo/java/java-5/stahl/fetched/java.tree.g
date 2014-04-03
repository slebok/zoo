/** Java 1.3 AST Recognizer Grammar
 *
 * Author: (see java.g preamble)
 *
 * This grammar is in the PUBLIC DOMAIN
 */
class JavaTreeParser extends TreeParser;

options {
	importVocab = Java;
}

compilationUnit
	:	(packageDefinition)?
		(importDefinition)*
		(typeDefinition)*
	;

packageDefinition
	:	#( PACKAGE_DEF annotations identifier )
	;

importDefinition
	:	#( IMPORT ( "static" )? identifierStar )
	;

typeDefinition
	:	#(CLASS_DEF modifiers IDENT typeParameters extendsClause
			implementsClause objBlock)
	|	#(INTERFACE_DEF modifiers IDENT typeParameters extendsClause
			interfaceBlock)
	|	#(ENUM_DEF modifiers IDENT implementsClause enumBlock)
	|	#(ANNOTATION_DEF modifiers IDENT annotationBlock)
	;

// new rule: for e.g. foo.bar.baz[].class (parser rule identPrimary), where
// type arguments are _not_ allowed
simpleTypeSpecArray
	:	#( ARRAY_DECLARATOR simpleTypeSpecArray )
	|	simpleType
	;

simpleType
	:	identifier
	|	builtInType
	;

typeSpec
	:	#(TYPE typeSpecArray)
	;

typeSpecArray
	:	#( ARRAY_DECLARATOR typeSpecArray )
	|	type
	;

type:	classOrInterfaceType
	|	builtInType
	;

typeParameters
	:	#( TYPE_PARAMS ( typeParameter )* )
	;

typeParameter
	:	IDENT ( "extends" ( typeSpec )+ )?
	;

classOrInterfaceType
	:	IDENT typeArguments
	|	#( DOT classOrInterfaceType IDENT typeArguments ( ELLIPSIS )? )
	;

typeArguments
	:	#( TYPE_ARGS
			(	typeSpec
			|	#( WILDCARD ( ( "extends" | "super" ) typeSpec )? )
			)*
		)
	;

builtInType
	:	"void"
	|	"boolean"
	|	"byte"
	|	"char"
	|	"short"
	|	"int"
	|	"float"
	|	"long"
	|	"double"
	;

modifiers
	:	#( MODIFIERS ( modifier | annotation )* )
	;

modifier
	:	"private"
	|	"public"
	|	"protected"
	|	"static"
	|	"transient"
	|	"final"
	|	"abstract"
	|	"native"
	|	"threadsafe"
	|	"synchronized"
	|	"const"
	|	"volatile"
	|	"strictfp"
	;

extendsClause
	:	#(EXTENDS_CLAUSE (classOrInterfaceType)* )
	;

implementsClause
	:	#(IMPLEMENTS_CLAUSE (classOrInterfaceType)* )
	;


interfaceBlock
	:	#(	OBJBLOCK
			(	methodDecl
			|	variableDef
			|	typeDefinition
			)*
		)
	;

objBlock
	:	#(	OBJBLOCK
			(	ctorDef
			|	methodDef
			|	variableDef
			|	typeDefinition
			|	#(STATIC_INIT slist)
			|	#(INSTANCE_INIT slist)
			)*
		)
	;

enumBlock
	:	#(	OBJBLOCK
			( enumConst )*
			(	ctorDef
			|	methodDef
			|	variableDef
			|	typeDefinition
			|	#(STATIC_INIT slist)
			|	#(INSTANCE_INIT slist)
			)*
		)
	;

enumConst
	:	#(ENUM_CONST annotations IDENT enumConstInit ( objBlock )? )
	;

enumConstInit
	:	#(ENUM_CONST_INIT (elist)? )
	;
	
annotationBlock
	:	#(	OBJBLOCK
			(	annotationMember
			|	variableDef
			|	typeDefinition
			)*
		)
	;

annotationMember
	:	#(ANNOTATION_MEMBER_DEF modifiers typeSpec IDENT
			( #( "default" annotationMemberValue ) )? )
	;

annotations
	:	#(ANNOTATIONS ( annotation )* )
	;

annotation
	:	#(ANNOTATION identifier annotationInit )
	;

annotationInit
	:	ANNOTATION_INIT_EMPTY
	|	#( ANNOTATION_INIT_VALUE annotationMemberValue )
	|	#( ANNOTATION_INIT_LIST (
			#( ANNOTATION_INIT_MEMBER IDENT annotationMemberValue )
		)* )
	;

annotationMemberValue
	:	annotation
	|	expression
	|	annotationMemberArrayInitializer
	;

annotationMemberArrayInitializer
	:	#(ANNOTATION_ARRAY_INIT (annotationMemberValue)*)
	;

ctorDef
	:	#(CTOR_DEF modifiers typeParameters methodHead (slist)?)
	;

methodDecl
	:	#(METHOD_DEF modifiers typeParameters typeSpec methodHead)
	;

methodDef
	:	#(METHOD_DEF modifiers typeParameters typeSpec methodHead (slist)?)
	;

variableDef
	:	#(VARIABLE_DEF modifiers typeSpec variableDeclarator varInitializer)
	;

parameterDef
	:	#(PARAMETER_DEF modifiers typeSpec IDENT )
	;

objectinitializer
	:	#(INSTANCE_INIT slist)
	;

variableDeclarator
	:	IDENT
	|	LBRACK variableDeclarator
	;

varInitializer
	:	#(ASSIGN initializer)
	|
	;

initializer
	:	expression
	|	arrayInitializer
	;

arrayInitializer
	:	#(ARRAY_INIT (initializer)*)
	;

methodHead
	:	IDENT #( PARAMETERS (parameterDef)* ) (throwsClause)?
	;

throwsClause
	:	#( "throws" (identifier)* )
	;

identifier
	:	IDENT
	|	#( DOT identifier IDENT )
	;

identifierStar
	:	IDENT
	|	#( DOT identifier (STAR|IDENT) )
	;

slist
	:	#( SLIST (stat)* )
	;

stat:	typeDefinition
	|	variableDef
	|	expression
	|	#(LABELED_STAT IDENT stat)
	|	#("if" expression stat (stat)? )
	|	#(	"for" (
				parameterDef expression
			|	#(FOR_INIT ((variableDef)+ | elist)?)
				#(FOR_CONDITION (expression)?)
				#(FOR_ITERATOR (elist)?)
			)	stat
		)
	|	#("while" expression stat)
	|	#("do" stat expression)
	|	#("break" (IDENT)? )
	|	#("continue" (IDENT)? )
	|	#("return" (expression)? )
	|	#("switch" expression (caseGroup)*)
	|	#("throw" expression)
	|	#("synchronized" expression stat)
	|	tryBlock
	|	slist // nested SLIST
	|	#(ASSERT expression (expression)?)
	|	EMPTY_STAT
	;

caseGroup
	:	#(CASE_GROUP (#("case" expression) | "default")+ slist)
	;

tryBlock
	:	#( "try" slist (handler)* (#("finally" slist))? )
	;

handler
	:	#( "catch" parameterDef slist )
	;

elist
	:	#( ELIST (expression)* )
	;

expression
	:	#(EXPR expr)
	;

expr:	#(QUESTION expr expr expr)	// trinary operator
	|	#(ASSIGN expr expr)			// binary operators...
	|	#(PLUS_ASSIGN expr expr)
	|	#(MINUS_ASSIGN expr expr)
	|	#(STAR_ASSIGN expr expr)
	|	#(DIV_ASSIGN expr expr)
	|	#(MOD_ASSIGN expr expr)
	|	#(SR_ASSIGN expr expr)
	|	#(BSR_ASSIGN expr expr)
	|	#(SL_ASSIGN expr expr)
	|	#(BAND_ASSIGN expr expr)
	|	#(BXOR_ASSIGN expr expr)
	|	#(BOR_ASSIGN expr expr)
	|	#(LOR expr expr)
	|	#(LAND expr expr)
	|	#(BOR expr expr)
	|	#(BXOR expr expr)
	|	#(BAND expr expr)
	|	#(NOT_EQUAL expr expr)
	|	#(EQUAL expr expr)
	|	#(LT expr expr)
	|	#(GT expr expr)
	|	#(LE expr expr)
	|	#(GE expr expr)
	|	#(SL expr expr)
	|	#(SR expr expr)
	|	#(BSR expr expr)
	|	#(PLUS expr expr)
	|	#(MINUS expr expr)
	|	#(DIV expr expr)
	|	#(MOD expr expr)
	|	#(STAR expr expr)
	|	#(INC expr)
	|	#(DEC expr)
	|	#(POST_INC expr)
	|	#(POST_DEC expr)
	|	#(BNOT expr)
	|	#(LNOT expr)
	|	#("instanceof" expr expr)
	|	#(UNARY_MINUS expr)
	|	#(UNARY_PLUS expr)
	|	primaryExpression
	;

primaryExpression
	:	IDENT
	|	#(	DOT
			(	expr
				(	IDENT
				|	arrayIndex
				|	"this"
				|	"class"
				|	newExpression
				|	"super"
				)
//			|	#(ARRAY_DECLARATOR typeSpecArray)
			|	builtInType ("class")?
			)
		)
	|	#(ARRAY_DECLARATOR simpleTypeSpecArray)
	|	arrayIndex
	|	#(METHOD_CALL primaryExpression typeArguments elist)
	|	ctorCall
	|	#(TYPECAST typeSpec expr)
	|	newExpression
	|	constant
	|	"super"
	|	"true"
	|	"false"
	|	"this"
	|	"null"
	|	typeSpec // type name used with instanceof
	;

ctorCall
	:	#( CTOR_CALL typeArguments elist )
	|	#( SUPER_CTOR_CALL
			(	typeArguments elist
			|	primaryExpression typeArguments elist
			)
		 )
	;

arrayIndex
	:	#(INDEX_OP expr expression)
	;

constant
	:	NUM_INT
	|	CHAR_LITERAL
	|	STRING_LITERAL
	|	NUM_FLOAT
	|	NUM_DOUBLE
	|	NUM_LONG
	;

newExpression
	:	#(	"new" typeArguments type
			(	newArrayDeclarator (arrayInitializer)?
			|	elist (objBlock)?
			)
		)
	;

newArrayDeclarator
	:	#( ARRAY_DECLARATOR (newArrayDeclarator)? (expression)? )
	;
