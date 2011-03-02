/** Java 1.5/JSR14/JSR201/JSR175 Recognizer
 *
 * Run 'java Main [-showtree] directory-full-of-java-files'
 *
 * [The -showtree option pops up a Swing frame that shows
 *  the AST constructed from the parser.]
 *
 * Run 'java Main <directory full of java files>'
 *
 * Contributing authors:
 *		John Mitchell		johnm@non.net
 *		Terence Parr		parrt@magelang.com
 *		John Lilley			jlilley@empathy.com
 *		Scott Stanchfield	thetick@magelang.com
 *		Markus Mohnen       mohnen@informatik.rwth-aachen.de
 *      Peter Williams      pete.williams@sun.com
 *      Allan Jacobs        Allan.Jacobs@eng.sun.com
 *      Steve Messick       messick@redhills.com
 *      John Pybus			john@pybus.org
 *
 * Version 1.00 December 9, 1997 -- initial release
 * Version 1.01 December 10, 1997
 *		fixed bug in octal def (0..7 not 0..8)
 * Version 1.10 August 1998 (parrt)
 *		added tree construction
 *		fixed definition of WS,comments for mac,pc,unix newlines
 *		added unary plus
 * Version 1.11 (Nov 20, 1998)
 *		Added "shutup" option to turn off last ambig warning.
 *		Fixed inner class def to allow named class defs as statements
 *		synchronized requires compound not simple statement
 *		add [] after builtInType DOT class in primaryExpression
 *		"const" is reserved but not valid..removed from modifiers
 * Version 1.12 (Feb 2, 1999)
 *		Changed LITERAL_xxx to xxx in tree grammar.
 *		Updated java.g to use tokens {...} now for 2.6.0 (new feature).
 *
 * Version 1.13 (Apr 23, 1999)
 *		Didn't have (stat)? for else clause in tree parser.
 *		Didn't gen ASTs for interface extends.  Updated tree parser too.
 *		Updated to 2.6.0.
 * Version 1.14 (Jun 20, 1999)
 *		Allowed final/abstract on local classes.
 *		Removed local interfaces from methods
 *		Put instanceof precedence where it belongs...in relationalExpr
 *			It also had expr not type as arg; fixed it.
 *		Missing ! on SEMI in classBlock
 *		fixed: (expr) + "string" was parsed incorrectly (+ as unary plus).
 *		fixed: didn't like Object[].class in parser or tree parser
 * Version 1.15 (Jun 26, 1999)
 *		Screwed up rule with instanceof in it. :(  Fixed.
 *		Tree parser didn't like (expr).something; fixed.
 *		Allowed multiple inheritance in tree grammar. oops.
 * Version 1.16 (August 22, 1999)
 *		Extending an interface built a wacky tree: had extra EXTENDS.
 *		Tree grammar didn't allow multiple superinterfaces.
 *		Tree grammar didn't allow empty var initializer: {}
 * Version 1.17 (October 12, 1999)
 *		ESC lexer rule allowed 399 max not 377 max.
 *		java.tree.g didn't handle the expression of synchronized
 *		statements.
 * Version 1.18 (August 12, 2001)
 *      	Terence updated to Java 2 Version 1.3 by
 *		observing/combining work of Allan Jacobs and Steve
 *		Messick.  Handles 1.3 src.  Summary:
 *		o  primary didn't include boolean.class kind of thing
 *      	o  constructor calls parsed explicitly now:
 * 		   see explicitConstructorInvocation
 *		o  add strictfp modifier
 *      	o  missing objBlock after new expression in tree grammar
 *		o  merged local class definition alternatives, moved after declaration
 *		o  fixed problem with ClassName.super.field
 *      	o  reordered some alternatives to make things more efficient
 *		o  long and double constants were not differentiated from int/float
 *		o  whitespace rule was inefficient: matched only one char
 *		o  add an examples directory with some nasty 1.3 cases
 *		o  made Main.java use buffered IO and a Reader for Unicode support
 *		o  supports UNICODE?
 *		   Using Unicode charVocabulay makes code file big, but only
 *		   in the bitsets at the end. I need to make ANTLR generate
 *		   unicode bitsets more efficiently.
 * Version 1.19 (April 25, 2002)
 *		Terence added in nice fixes by John Pybus concerning floating
 *		constants and problems with super() calls.  John did a nice
 *		reorg of the primary/postfix expression stuff to read better
 *		and makes f.g.super() parse properly (it was METHOD_CALL not
 *		a SUPER_CTOR_CALL).  Also:
 *
 *		o  "finally" clause was a root...made it a child of "try"
 *		o  Added stuff for asserts too for Java 1.4, but *commented out*
 *		   as it is not backward compatible.
 *
 * Version 1.20 (October 27, 2002)
 *
 *      Terence ended up reorging John Pybus' stuff to
 *      remove some nondeterminisms and some syntactic predicates.
 *      Note that the grammar is stricter now; e.g., this(...) must
 *	be the first statement.
 *
 *      Trinary ?: operator wasn't working as array name:
 *          (isBig ? bigDigits : digits)[i];
 *
 *      Checked parser/tree parser on source for
 *          Resin-2.0.5, jive-2.1.1, jdk 1.3.1, Lucene, antlr 2.7.2a4,
 *	    and the 110k-line jGuru server source.
 *
 * Version 1.21 (October 17, 2003)
 *	Fixed lots of problems including:
 *	Ray Waldin: add typeDefinition to interfaceBlock in java.tree.g
 *  He found a problem/fix with floating point that start with 0
 *  Ray also fixed problem that (int.class) was not recognized.
 *  Thorsten van Ellen noticed that \n are allowed incorrectly in strings.
 *  TJP fixed CHAR_LITERAL analogously.
 *
 * Version 1.22 (April 14, 2004)
 *  Changed vocab to be ..\uFFFE to avoid -1 char. removed dummy VOCAB rule.
 *
 * Version 1.21.2 (March, 2003)
 *      Changes by Matt Quail to support generics (as per JDK1.5/JSR14)
 *      Notes:
 *      o We only allow the "extends" keyword and not the "implements"
 *        keyword, since thats what JSR14 seems to imply.
 *      o Thanks to Monty Zukowski for his help on the antlr-interest
 *        mail list.
 *      o Thanks to Alan Eliasen for testing the grammar over his
 *        Fink source base
 *
 * Version 1.22+assert+JSR14 (2004-06-10)
 *      Merged ANTLR version 1.22 with javaG.g version 1.21.2 and added
 *      the ability to enable the "assert" keyword at runtime via the lexer.
 *      Also made changes to generics rules for a saner AST creation.
 *
 * Version 1.22+assert+JSR14+JSR201 (2004-06-12)
 *      Added support for enums, varargs, enhanced for loop, and import static
 *
 * Version 1.22+assert+JSR14+JSR201+JSR175 (2004-06-14)
 *      Added support for metadata (JSR 175). Refactored the field rule into
 *      classField and interfaceField.
 *
 * Version 1.22+assert+JSR14+JSR201+JSR175+AST (2004-07-02)
 *      Various changes to improve AST generation; also made the tree parser
 *      recognize all the fancy new stuff. Added the ability to enable the
 *      "enum" keyword at runtime (just like "assert").
 *
 * Version 1.22+assert+JSR14+JSR201+JSR175+AST+fixes (2004-08-17)
 *      Bug fixes and support for wildcard type arguments and constructor
 *      type parameters (new in final draft of JSR 14). Formatting cleanup.
 *
 * Version 1.22+assert+JSR14+JSR201+JSR175+AST+fixes^2 (2004-08-31)
 *      Fixes for bugs identified by Michael Studman:
 *      - allow annotations with an empty list of args
 *      - allow annotations in annotation member array initializers
 *      - saner enum constant initialization ast construction
 *      - also removed some cruft in rule postfixExpression
 *
 * This grammar is in the PUBLIC DOMAIN
 */
class JavaRecognizer extends Parser;
options {
	k = 2;                           // two token lookahead
	exportVocab=Java;                // Call its vocabulary "Java"
	codeGenMakeSwitchThreshold = 2;  // Some optimizations
	codeGenBitsetTestThreshold = 3;
	defaultErrorHandler = false;     // Don't generate parser error handlers
	buildAST = true;
}

tokens {
	BLOCK; MODIFIERS; OBJBLOCK; SLIST; CTOR_DEF; METHOD_DEF; VARIABLE_DEF;
	INSTANCE_INIT; STATIC_INIT; TYPE; CLASS_DEF; INTERFACE_DEF;
	PACKAGE_DEF; ARRAY_DECLARATOR; EXTENDS_CLAUSE; IMPLEMENTS_CLAUSE;
	PARAMETERS; PARAMETER_DEF; LABELED_STAT; TYPECAST; INDEX_OP;
	POST_INC; POST_DEC; METHOD_CALL; EXPR; ARRAY_INIT;
	IMPORT; UNARY_MINUS; UNARY_PLUS; CASE_GROUP; ELIST; FOR_INIT; FOR_CONDITION;
	FOR_ITERATOR; EMPTY_STAT; FINAL="final"; ABSTRACT="abstract";
	STRICTFP="strictfp"; SUPER_CTOR_CALL; CTOR_CALL;
	ASSERT; TYPE_ARGS; TYPE_ARGS_END; TYPE_PARAMS; WILDCARD;
	ENUM; ENUM_DEF; ENUM_CONST; ENUM_CONST_INIT;
	ANNOTATION_DEF; ANNOTATION_MEMBER_DEF; ANNOTATION; ANNOTATIONS;
	ANNOTATION_INIT_EMPTY; ANNOTATION_INIT_VALUE; ANNOTATION_INIT_LIST;
	ANNOTATION_INIT_MEMBER; ANNOTATION_ARRAY_INIT;
}

{
    /**
     * Counts the number of LT seen in the typeArguments production.
     * It is used in semantic predicates to ensure we have seen
     * enough closing '>' characters; which actually may have been
     * either GT, SR or BSR tokens.
     */
    private int ltCounter = 0;
}

// Compilation Unit: In Java, this is a single file.  This is the start
//   rule for this parser
compilationUnit
	:	// A compilation unit starts with an optional package definition
		// Metadata makes a mess of things: even package definitions can be
		// annotated, although _only_ in one file (not enforced here ;))
		(	( annotations "package" ) => packageDefinition
		|	/* nothing */
		)

		// Next we have a series of zero or more import statements
		( importDefinition )*

		// Wrapping things up with any number of class or interface
		//    definitions
		( typeDefinition )*

		EOF!
	;


// Package statement: "package" followed by an identifier.
packageDefinition
	options {defaultErrorHandler = true;} // let ANTLR handle errors
	:	annotations p:"package"^ {#p.setType(PACKAGE_DEF);} identifier SEMI!
	;


// Import statement: import followed by a package or class name
// JSR 201 allows the optional "static" keyword
importDefinition
	options {defaultErrorHandler = true;}
	:	i:"import"^ {#i.setType(IMPORT);} ("static")? identifierStar SEMI!
	;

// A type definition in a file is either a class, interface, enumeration or
// annotation type definition.
typeDefinition
	options {defaultErrorHandler = true;}
	:	m:modifiers!
		( classDefinition[#m]
		| enumDefinition[#m]
		| interfaceDefinition[#m]
		| annotationTypeDefinition[#m]
		)
	|	SEMI!
	;

/** A declaration is the creation of a reference or primitive-type variable
 *  Create a separate Type/Var tree for each var in the var list.
 */
declaration!
	:	m:modifiers t:typeSpec[false] v:variableDefinitions[#m,#t]
		{#declaration = #v;}
	;

// A type specification is a type name with possible brackets afterwards
//   (which would make it an array type).
typeSpec[boolean addImagNode]
	: classTypeSpec[addImagNode]
	| builtInTypeSpec[addImagNode]
	;

// built in types are not reference types, everything else is
referenceTypeSpec[boolean addImagNode]
	: classTypeSpec[addImagNode]
	| arrayTypeSpec[addImagNode]
	;

// A class type specification is a class type with either:
// - possible brackets afterwards
//   (which would make it an array type).
// - generic type arguments after
classTypeSpec[boolean addImagNode]
	:	classOrInterfaceType[false]
		(options{greedy=true;}: // match as many as possible
			lb:LBRACK^ {#lb.setType(ARRAY_DECLARATOR);} RBRACK!
		)*
		{
			if ( addImagNode ) {
				#classTypeSpec = #(#[TYPE,"TYPE"], #classTypeSpec);
			}
		}
	;

classOrInterfaceType[boolean addImagNode]
	:	IDENT typeArguments
		(options{greedy=true;}: // match as many as possible
			DOT^
			IDENT typeArguments
		)*
		{
			if ( addImagNode ) {
				#classOrInterfaceType = #(#[TYPE,"TYPE"],
					#classOrInterfaceType);
			}
		}
	;

typeArguments
{int currentLtLevel = 0;}
	:
		{currentLtLevel = ltCounter;}
		(
			lt:LT^	{ ltCounter++; #lt.setType(TYPE_ARGS); }
			typeArgument
			(options{greedy=true;}: // match as many as possible
				// The second test is needed to construct trees properly
				// in the case when we have ">>" or ">>>" tokens
				// (test case: "var<O1<I1<M1>>, O2<I2>> a;"
				// The first test is needed because otherwise
				// stuff breaks when guessing (e.g. declaration)
				// because semantic actions are not executed and the
				// second test would always fail (trees are not constructed
				// while guessing, so no problem there).
				{inputState.guessing !=0 || ltCounter == currentLtLevel + 1}?
					COMMA! typeArgument
			)*

			(   // turn warning off since Antlr generates the right code,
				// plus we have our semantic predicate below
				options{generateAmbigWarnings=false;}:
				typeArgumentsEnd!
			)?
		)
		// make sure we have gobbled up enough '>' characters
		// if we are at the "top level" of nested typeArgument productions
		{(currentLtLevel != 0) || ltCounter == currentLtLevel}?
	|	{#typeArguments = #(#[TYPE_ARGS,"TYPE_ARGS"], #typeArguments);}
	;

// either reference type or wildcard type with optional lower or upper bound
typeArgument
	:	(	q:QUESTION^ {#q.setType(WILDCARD);}
			( // faux conflict on "extends" because typeArgsEnd may be empty
				options{greedy=true;}:
				"extends" referenceTypeSpec[true]
			|	"super" referenceTypeSpec[true]
			)?
		)
	|	referenceTypeSpec[true]
	;

// this gobbles up *some* amount of '>' characters, and counts how many
// it gobbled.
protected
typeArgumentsEnd
	:	(	GT {ltCounter-=1;}
		|	SR {ltCounter-=2;}
		|	BSR {ltCounter-=3;}
		)
		{ #typeArgumentsEnd.setType(TYPE_ARGS_END); }
	;

// A builtin type specification is a builtin type with possible brackets
// afterwards (which would make it an array type).
builtInTypeSpec[boolean addImagNode]
	:	builtInType
		(options{greedy=true;}: // match as many as possible
			lb:LBRACK^ {#lb.setType(ARRAY_DECLARATOR);} RBRACK!
		)*
		{
			if ( addImagNode ) {
				#builtInTypeSpec = #(#[TYPE,"TYPE"], #builtInTypeSpec);
			}
		}
	;

// An array type specification is a builtin type with brackets afterwards
arrayTypeSpec[boolean addImagNode]
	:	builtInType
		(options{greedy=true;}: // match as many as possible
			lb:LBRACK^ {#lb.setType(ARRAY_DECLARATOR);} RBRACK!
		)+
		{
			if ( addImagNode ) {
				#arrayTypeSpec = #(#[TYPE,"TYPE"], #arrayTypeSpec);
			}
		}
	;

// A type name. which is either a (possibly qualified and parameterized)
// class name or a primitive (builtin) type
type
	:	classOrInterfaceType[false]
	|	builtInType
	;

// The primitive types.
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

// A (possibly-qualified) java identifier.  We start with the first IDENT
//   and expand its name by adding dots and following IDENTS
identifier
	:	IDENT  ( DOT^ IDENT )*
	;

identifierStar
	:	IDENT
		( DOT^ IDENT )*
		( DOT^ STAR  )?
	;

// A list of zero or more modifiers.  We could have used (modifier)* in
//   place of a call to modifiers, but I thought it was a good idea to keep
//   this rule separate so they can easily be collected in a Vector if
//   someone so desires
// JSR 175 says that annotations are allowed everywhere modifiers are.
// A nondeterminism warning is masked by the greedy option.
modifiers
	:	( options{greedy=true;} : modifier | annotation )*
		{#modifiers = #([MODIFIERS, "MODIFIERS"], #modifiers);}
	;

// modifiers for Java classes, interfaces, class/instance vars and methods
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
//	|	"const"			// reserved word, but not valid
	|	"volatile"
	|	"strictfp"
	;

// Definition of an enumeration (JSR 201)
enumDefinition![AST modifiers]
	:	ENUM IDENT
		// it might implement some interfaces...
		ic:implementsClause
		// now parse the body of the enum
		eb:enumBlock
		{#enumDefinition = #(#[ENUM_DEF,"ENUM_DEF"], modifiers,IDENT,ic,eb);}
	;

// This is the body of an enumeration.  It can contain a list of comma
// separated identifiers (the enum values), and optionally, seperated by a
// semicolon, some declarations like in a class at the end.
// The values of the enumeration may be annotated.
enumBlock
	:	LCURLY! // next line has a nondeterminism warning without option greedy
			( enumConst ( options {greedy=true;} : COMMA! enumConst )* )?
			( COMMA! )?	// optional comma at end of value list
			( SEMI! ( classField | SEMI! )* )?
		RCURLY!
		{#enumBlock = #([OBJBLOCK, "OBJBLOCK"], #enumBlock);}
	;

// Each enum value is in fact a class instance, and can be followed by the
// usual class declarations.
enumConst
	:	annotations IDENT enumConstInit ( classBlock )?
		{#enumConst = #([ENUM_CONST, "ENUM_CONST"], #enumConst);}
	;

// This is really a constructor invocation.
enumConstInit
	:	lp:LPAREN^ argList RPAREN! { #lp.setType(ENUM_CONST_INIT); }
	|	{#enumConstInit = #([ENUM_CONST_INIT, ""], #enumConstInit);}
	;

// Definition of an annotation type (JSR 175)
annotationTypeDefinition![AST modifiers]
	:	AT "interface" IDENT
		// now parse the body of the annotation type
		ab:annotationBlock
		{#annotationTypeDefinition = #(#[ANNOTATION_DEF,"ANNOTATION_DEF"],
									modifiers,IDENT,ab);}
	;

// This is the body of an annotation type. Only inner type definitions and
// members (which use a notation similar to methods) are allowed.
annotationBlock
	:	LCURLY!
			( annotationField | SEMI! )*
		RCURLY!
		{#annotationBlock = #([OBJBLOCK, "OBJBLOCK"], #annotationBlock);}
	;

annotationField!
	:
		mods:modifiers
		(	it:innerTypeDef[#mods]		// inner type definition
			{#annotationField = #it;}
		|	ts:typeSpec[false]
			(	i:IDENT LPAREN RPAREN dv:defaultValue SEMI
				{#annotationField =
						#(#[ANNOTATION_MEMBER_DEF,"ANNOTATION_MEMBER_DEF"],
						mods, #(#[TYPE,"TYPE"],ts), i, dv); }
			|	v:variableDefinitions[#mods,#ts] SEMI
				{#annotationField = #v;}
			)
		)
	;

// Annotation members may have optional default values.
defaultValue
	:	( "default"^ annotationMemberValue )?
	;

annotations
	:	( annotation )*
		{#annotations = #([ANNOTATIONS, "ANNOTATIONS"], #annotations);}
	;

annotation
	:	AT^ identifier annotationInit
		{#AT.setType(ANNOTATION);}
	;

// The initialization (list of assignments, single value, or nothing).
annotationInit
	:	(	lp:LPAREN^
			(	annotationMemberInit
				( COMMA! annotationMemberInit )*
				{#lp.setType(ANNOTATION_INIT_LIST);}
			|	annotationMemberValue	{#lp.setType(ANNOTATION_INIT_VALUE);}
			|	{#lp.setType(ANNOTATION_INIT_EMPTY);}
			)
			RPAREN!
		)
	|	{#annotationInit = #([ANNOTATION_INIT_EMPTY, "AN_INIT_EMPTY"]);}
	;

annotationMemberInit
	:	IDENT ASSIGN! annotationMemberValue
		{#annotationMemberInit =
		 #([ANNOTATION_INIT_MEMBER, "AN_INIT_MEMBER"], #annotationMemberInit);}
	;

annotationMemberValue
	:	annotation
	|	conditionalExpression
		{#annotationMemberValue = #(#[EXPR,"EXPR"],#annotationMemberValue);}
	|	annotationMemberArrayInitializer
	;

// This is an initializer used to set up an array as an annotation member
// value.
annotationMemberArrayInitializer
	:	lc:LCURLY^ {#lc.setType(ANNOTATION_ARRAY_INIT);}
			(	annotationMemberValue
				(
					// CONFLICT: does a COMMA after an initializer start a new
					//           initializer or start the option ',' at end?
					//           ANTLR generates proper code by matching
					//           the comma as soon as possible.
					options {
						warnWhenFollowAmbig = false;
					}
				:
					COMMA! annotationMemberValue
				)*
			)?
			(COMMA!)?
		RCURLY!
	;

// Definition of a Java class
classDefinition![AST modifiers]
	:	"class" IDENT
		// it _might_ have type paramaters
		tp:typeParameters
		// it _might_ have a superclass...
		sc:superClassClause
		// it might implement some interfaces...
		ic:implementsClause
		// now parse the body of the class
		cb:classBlock
		{#classDefinition = #(#[CLASS_DEF,"CLASS_DEF"],
							   modifiers,IDENT,tp,sc,ic,cb);}
	;

superClassClause!
	:	( "extends" classOrInterfaceType[false] )?
		{#superClassClause = #(#[EXTENDS_CLAUSE,"EXTENDS_CLAUSE"],
			#superClassClause);}
	;

// Definition of a Java Interface
interfaceDefinition![AST modifiers]
	:	"interface" IDENT
		// it _might_ have type paramaters
		tp:typeParameters
		// it might extend some other interfaces
		ie:interfaceExtends
		// now parse the body of the interface
		ib:interfaceBlock
		{#interfaceDefinition = #(#[INTERFACE_DEF,"INTERFACE_DEF"],
									modifiers,IDENT,tp,ie,ib);}
	;

typeParameters
{int currentLtLevel = 0;}
	:
		{currentLtLevel = ltCounter;}
		(
			lt:LT^	{ ltCounter++; #lt.setType(TYPE_PARAMS); }
			typeParameter (COMMA! typeParameter)*
			(typeArgumentsEnd!)?
		)
		// make sure we have gobbled up enough '>' characters
		// if we are at the "top level" of nested typeArgument productions
		{(currentLtLevel != 0) || ltCounter == currentLtLevel}?
	|	{#typeParameters = #(#[TYPE_PARAMS,"TYPE_PARAMS"], #typeParameters);}
	;

typeParameter
	:	IDENT
		(   // I'm pretty sure Antlr generates the right thing here:
			options{generateAmbigWarnings=false;}:
			"extends" classOrInterfaceType[true]
			(BAND! classOrInterfaceType[true])*
		)?
	;

// This is the body of an interface.
interfaceBlock
	:	LCURLY!
			( interfaceField | SEMI! )*
		RCURLY!
		{#interfaceBlock = #([OBJBLOCK, "OBJBLOCK"], #interfaceBlock);}
	;

// This is the body of a class.  You can have fields and extra semicolons,
// That's about it (until you see what a field is...)
classBlock
	:	LCURLY!
			( classField | SEMI! )*
		RCURLY!
		{#classBlock = #([OBJBLOCK, "OBJBLOCK"], #classBlock);}
	;

// An interface can extend several other interfaces...
interfaceExtends
	:	(
		e:"extends"!
		classOrInterfaceType[false] ( COMMA! classOrInterfaceType[false] )*
		)?
		{#interfaceExtends = #(#[EXTENDS_CLAUSE,"EXTENDS_CLAUSE"],
							#interfaceExtends);}
	;

// A class can implement several interfaces...
implementsClause
	:	(
			i:"implements"! classOrInterfaceType[false]
							( COMMA! classOrInterfaceType[false] )*
		)?
		{#implementsClause = #(#[IMPLEMENTS_CLAUSE,"IMPLEMENTS_CLAUSE"],
								 #implementsClause);}
	;

// Fields that are type definitions.
protected
innerTypeDef![AST modifiers]
	: 	(	ed:enumDefinition[modifiers]        // inner enum
			{#innerTypeDef = #ed;}

		|	cd:classDefinition[modifiers]       // inner class
			{#innerTypeDef = #cd;}

		|	id:interfaceDefinition[modifiers]   // inner interface
			{#innerTypeDef = #id;}

		|	ad:annotationTypeDefinition[modifiers]   // inner annotation type
			{#innerTypeDef = #ad;}
		)
		;

protected
memberDef![AST modifiers, AST typeParams, boolean allowMethodBody]
	:
		// A generic method has the typeParameters before the return type.
		// This is not allowed for variable definitions, but this production
		// allows it; a semantic check could be used if you wanted.
		t:typeSpec[false]  // method or variable declaration(s)
		(	IDENT  // the name of the method

			// parse the formal parameter declarations.
			LPAREN! param:parameterDeclarationList RPAREN!

			rt:declaratorBrackets[#t]

			// get the list of exceptions that this method is
			// declared to throw
			(tc:throwsClause)?

			( SEMI | {allowMethodBody}? s2:compoundStatement )
			{#memberDef = #(#[METHOD_DEF,"METHOD_DEF"],
							 modifiers,
							 typeParams,
							 #(#[TYPE,"TYPE"],rt),
							 IDENT,
							 param,
							 tc,
							 s2);}
		|	v:variableDefinitions[modifiers,#t] SEMI
//			{#field = #(#[VARIABLE_DEF,"VARIABLE_DEF"], v);}
			{#memberDef = #v;} // omit tp here, as it is not legal anyway
		)
	;

// An interface can contain inner type definitions, methods and constant
// definitions. Generalizing the latter, memberDef allows member variables.
// To detect and prevent that, use a semantic check.
interfaceField!
	:
		mods:modifiers
		(	it:innerTypeDef[#mods]		// inner type definition
			{#interfaceField = #it;}
		|	tp:typeParameters md:memberDef[#mods, #tp, false]
			// method or variable definition
			{#interfaceField = #md;}
		)
	;

// Now the various things that can be defined inside a class...
classField!
	:	// method, constructor, or variable declaration
		mods:modifiers
		(	it:innerTypeDef[#mods]	// inner type definition
			{#classField = #it;}

		|	tp:typeParameters
			(	h:ctorHead s:constructorBody // constructor
				{#classField = #(#[CTOR_DEF,"CTOR_DEF"], mods, tp, h, s);}

			|	md:memberDef[#mods, #tp, true] // method or variable definition
				{#classField = #md;}
			)
		)

	// "static { ... }" class initializer
	|	"static" s3:compoundStatement
		{#classField = #(#[STATIC_INIT,"STATIC_INIT"], s3);}

	// "{ ... }" instance initializer
	|	s4:compoundStatement
		{#classField = #(#[INSTANCE_INIT,"INSTANCE_INIT"], s4);}
	;

constructorBody
	:	lc:LCURLY^ {#lc.setType(SLIST);}
			( options { greedy=true; } : explicitConstructorInvocation)?
			(statement)*
		RCURLY!
	;

/** Catch obvious constructor calls, but not the expr.super(...) calls */
explicitConstructorInvocation
	:	typeArguments
		(	"this"! lp1:LPAREN^ argList RPAREN! SEMI!
			{#lp1.setType(CTOR_CALL);}
		|	"super"! lp2:LPAREN^ argList RPAREN! SEMI!
			{#lp2.setType(SUPER_CTOR_CALL);}
		)
	;

variableDefinitions[AST mods, AST t]
	:	variableDeclarator[getASTFactory().dupTree(mods),
						   getASTFactory().dupList(t)]
		(	COMMA!
			variableDeclarator[getASTFactory().dupTree(mods),
							   getASTFactory().dupList(t)]
		)*
	;

/** Declaration of a variable.  This can be a class/instance variable,
 *   or a local variable in a method
 * It can also include possible initialization.
 */
variableDeclarator![AST mods, AST t]
	:	id:IDENT d:declaratorBrackets[t] v:varInitializer
		{#variableDeclarator = #(#[VARIABLE_DEF,"VARIABLE_DEF"],
								mods, #(#[TYPE,"TYPE"],d), id, v);}
	;

declaratorBrackets[AST typ]
	:	{#declaratorBrackets=typ;}
		(lb:LBRACK^ {#lb.setType(ARRAY_DECLARATOR);} RBRACK!)*
	;

varInitializer
	:	( ASSIGN^ initializer )?
	;

// This is an initializer used to set up an array.
arrayInitializer
	:	lc:LCURLY^ {#lc.setType(ARRAY_INIT);}
			(	initializer
				(
					// CONFLICT: does a COMMA after an initializer start a new
					//           initializer or start the option ',' at end?
					//           ANTLR generates proper code by matching
					//           the comma as soon as possible.
					options {
						warnWhenFollowAmbig = false;
					}
				:
					COMMA! initializer
				)*
			)?
			(COMMA!)?
		RCURLY!
	;

// The two "things" that can initialize an array element are an expression
//   and another (nested) array initializer.
initializer
	:	expression
	|	arrayInitializer
	;

// This is the header of a method.  It includes the name and parameters
//   for the method.
//   This also watches for a list of exception classes in a "throws" clause.
ctorHead
	:	IDENT  // the name of the method

		// parse the formal parameter declarations.
		LPAREN! parameterDeclarationList RPAREN!

		// get the list of exceptions that this method is declared to throw
		(throwsClause)?
	;

// This is a list of exception classes that the method is declared to throw
throwsClause
	:	"throws"^ identifier ( COMMA! identifier )*
	;


// A list of formal parameters
parameterDeclarationList
	:	( parameterDeclaration ( COMMA! parameterDeclaration )* )?
		{#parameterDeclarationList = #(#[PARAMETERS,"PARAMETERS"],
									#parameterDeclarationList);}
	;

// A formal parameter.
// The ellipsis is the support for varargs (JSR 201)
// This rule allows ellipsis on any parameter, not just the last (as specified
// by JSR 201), so a semantic check is needed for that.
parameterDeclaration!
	:	pm:parameterModifier t:typeSpec[false] ( el:ELLIPSIS )? id:IDENT
		pd:declaratorBrackets[#t]
		{#parameterDeclaration = #(#[PARAMETER_DEF,"PARAMETER_DEF"],
									pm, #([TYPE,"TYPE"],pd,el), id);}
	;

// Parameters can be final. And annotated. Or even both.
parameterModifier
	:	( "final" | annotation )*
		{#parameterModifier = #(#[MODIFIERS,"MODIFIERS"], #parameterModifier);}
	;

// Compound statement.  This is used in many contexts:
//   Inside a class definition prefixed with "static":
//      it is a class initializer
//   Inside a class definition without "static":
//      it is an instance initializer
//   As the body of a method
//   As a completely indepdent braced block of code inside a method
//      it starts a new scope for variable definitions

compoundStatement
	:	lc:LCURLY^ {#lc.setType(SLIST);}
			// include the (possibly-empty) list of statements
			(statement)*
		RCURLY!
	;


statement
	// A list of statements in curly braces -- start a new scope!
	:	compoundStatement

	// declarations are ambiguous with "ID DOT" relative to expression
	// statements.  Must backtrack to be sure.  Could use a semantic
	// predicate to test symbol table to see what the type was coming
	// up, but that's pretty hard without a symbol table ;)
	|	(declaration)=> declaration SEMI!

	// An expression statement.  This could be a method call,
	// assignment statement, or any other expression evaluated for
	// side-effects.
	|	expression SEMI!

	// class or enum definition
	|	m:modifiers! ( enumDefinition[#m] |	classDefinition[#m] )

	// Attach a label to the front of a statement
	|	IDENT c:COLON^ {#c.setType(LABELED_STAT);} statement

	// If-else statement
	|	"if"^ LPAREN! expression RPAREN! statement
		(
			// CONFLICT: the old "dangling-else" problem...
			//           ANTLR generates proper code matching
			//           as soon as possible.  Hush warning.
			options {
				warnWhenFollowAmbig = false;
			}
		:
			"else"! statement
		)?

	// For statement, with support for the enhanced variant (JSR 201)
	|	"for"^
			LPAREN!
			(
				( parameterDeclaration COLON ) =>
				parameterDeclaration COLON! expression
			|
				forInit SEMI!   // initializer
				forCond	SEMI!   // condition test
				forIter         // updater
			)
			RPAREN!
			statement                     // statement to loop over

	// While statement
	|	"while"^ LPAREN! expression RPAREN! statement

	// do-while statement
	|	"do"^ statement "while"! LPAREN! expression RPAREN! SEMI!

	// get out of a loop (or switch)
	|	"break"^ (IDENT)? SEMI!

	// do next iteration of a loop
	|	"continue"^ (IDENT)? SEMI!

	// Return an expression
	|	"return"^ (expression)? SEMI!

	// switch/case statement
	|	"switch"^ LPAREN! expression RPAREN! LCURLY!
			( casesGroup )*
		RCURLY!

	// exception try-catch block
	|	tryBlock

	// throw an exception
	|	"throw"^ expression SEMI!

	// synchronize a statement
	|	"synchronized"^ LPAREN! expression RPAREN! compoundStatement

	// asserts (this can be enabled/disabled via the lexer)
	|	ASSERT^ expression ( COLON! expression )? SEMI!

	// empty statement
	|	s:SEMI {#s.setType(EMPTY_STAT);}
	;

casesGroup
	:	(	// CONFLICT: to which case group do the statements bind?
			//           ANTLR generates proper code: it groups the
			//           many "case"/"default" labels together then
			//           follows them with the statements
			options {
				greedy = true;
			}
			:
			aCase
		)+
		caseSList
		{#casesGroup = #([CASE_GROUP, "CASE_GROUP"], #casesGroup);}
	;

aCase
	:	("case"^ expression | "default") COLON!
	;

caseSList
	:	(statement)*
		{#caseSList = #(#[SLIST,"SLIST"],#caseSList);}
	;

// The initializer for a for loop
forInit
		// if it looks like a declaration, it is
	:	(	(declaration)=> declaration
		// otherwise it could be an expression list...
		|	expressionList
		)?
		{#forInit = #(#[FOR_INIT,"FOR_INIT"],#forInit);}
	;

forCond
	:	(expression)?
		{#forCond = #(#[FOR_CONDITION,"FOR_CONDITION"],#forCond);}
	;

forIter
	:	(expressionList)?
		{#forIter = #(#[FOR_ITERATOR,"FOR_ITERATOR"],#forIter);}
	;

// an exception handler try/catch block
tryBlock
	:	"try"^ compoundStatement
		(handler)*
		( finallyClause )?
	;

finallyClause
	:	"finally"^ compoundStatement
	;

// an exception handler
handler
	:	"catch"^ LPAREN! parameterDeclaration RPAREN! compoundStatement
	;


// expressions
// Note that most of these expressions follow the pattern
//   thisLevelExpression :
//       nextHigherPrecedenceExpression
//           (OPERATOR nextHigherPrecedenceExpression)*
// which is a standard recursive definition for a parsing an expression.
// The operators in java have the following precedences:
//    lowest  (13)  = *= /= %= += -= <<= >>= >>>= &= ^= |=
//            (12)  ?:
//            (11)  ||
//            (10)  &&
//            ( 9)  |
//            ( 8)  ^
//            ( 7)  &
//            ( 6)  == !=
//            ( 5)  < <= > >=
//            ( 4)  << >>
//            ( 3)  +(binary) -(binary)
//            ( 2)  * / %
//            ( 1)  ++ -- +(unary) -(unary)  ~  !  (type)
//                  []   () (method call)  . (dot -- identifier qualification)
//                  new   ()  (explicit parenthesis)
//
// the last two are not usually on a precedence chart; I put them in
// to point out that new has a higher precedence than '.', so you
// can validy use
//     new Frame().show()
//
// Note that the above precedence levels map to the rules below...
// Once you have a precedence chart, writing the appropriate rules as below
//   is usually very straightfoward



// the mother of all expressions
expression
	:	assignmentExpression
		{#expression = #(#[EXPR,"EXPR"],#expression);}
	;


// This is a list of expressions.
expressionList
	:	expression (COMMA! expression)*
		{#expressionList = #(#[ELIST,"ELIST"], expressionList);}
	;


// assignment expression (level 13)
assignmentExpression
	:	conditionalExpression
		(	(	ASSIGN^
			|	PLUS_ASSIGN^
			|	MINUS_ASSIGN^
			|	STAR_ASSIGN^
			|	DIV_ASSIGN^
			|	MOD_ASSIGN^
			|	SR_ASSIGN^
			|	BSR_ASSIGN^
			|	SL_ASSIGN^
			|	BAND_ASSIGN^
			|	BXOR_ASSIGN^
			|	BOR_ASSIGN^
			)
			assignmentExpression
		)?
	;


// conditional test (level 12)
conditionalExpression
	:	logicalOrExpression
		( QUESTION^ assignmentExpression COLON! conditionalExpression )?
	;


// logical or (||)  (level 11)
logicalOrExpression
	:	logicalAndExpression (LOR^ logicalAndExpression)*
	;


// logical and (&&)  (level 10)
logicalAndExpression
	:	inclusiveOrExpression (LAND^ inclusiveOrExpression)*
	;


// bitwise or non-short-circuiting or (|)  (level 9)
inclusiveOrExpression
	:	exclusiveOrExpression (BOR^ exclusiveOrExpression)*
	;


// exclusive or (^)  (level 8)
exclusiveOrExpression
	:	andExpression (BXOR^ andExpression)*
	;


// bitwise or non-short-circuiting and (&)  (level 7)
andExpression
	:	equalityExpression (BAND^ equalityExpression)*
	;


// equality/inequality (==/!=) (level 6)
equalityExpression
	:	relationalExpression ((NOT_EQUAL^ | EQUAL^) relationalExpression)*
	;


// boolean relational expressions (level 5)
relationalExpression
	:	shiftExpression
		(	(	(	LT^
				|	GT^
				|	LE^
				|	GE^
				)
				shiftExpression
			)*
		|	"instanceof"^ typeSpec[true]
		)
	;


// bit shift expressions (level 4)
shiftExpression
	:	additiveExpression ((SL^ | SR^ | BSR^) additiveExpression)*
	;


// binary addition/subtraction (level 3)
additiveExpression
	:	multiplicativeExpression ((PLUS^ | MINUS^) multiplicativeExpression)*
	;


// multiplication/division/modulo (level 2)
multiplicativeExpression
	:	unaryExpression ((STAR^ | DIV^ | MOD^ ) unaryExpression)*
	;

unaryExpression
	:	INC^ unaryExpression
	|	DEC^ unaryExpression
	|	MINUS^ {#MINUS.setType(UNARY_MINUS);} unaryExpression
	|	PLUS^  {#PLUS.setType(UNARY_PLUS);} unaryExpression
	|	unaryExpressionNotPlusMinus
	;

unaryExpressionNotPlusMinus
	:	BNOT^ unaryExpression
	|	LNOT^ unaryExpression

		// use predicate to skip cases like: (int.class)
	|	(LPAREN builtInTypeSpec[true] RPAREN) =>
		lpb:LPAREN^ {#lpb.setType(TYPECAST);} builtInTypeSpec[true] RPAREN!
		unaryExpression

		// Have to backtrack to see if operator follows.  If no operator
		// follows, it's a typecast.  No semantic checking needed to parse.
		// if it _looks_ like a cast, it _is_ a cast; else it's a "(expr)"
	|	(LPAREN classTypeSpec[true] RPAREN unaryExpressionNotPlusMinus)=>
		lp:LPAREN^ {#lp.setType(TYPECAST);} classTypeSpec[true] RPAREN!
		unaryExpressionNotPlusMinus

	|	postfixExpression
	;

// qualified names, array expressions, method invocation, post inc/dec
postfixExpression
	:
		primaryExpression

		(
			DOT^ "this"

		|	DOT^ ta1:typeArguments!
			(	IDENT
				(	lp:LPAREN^ {#lp.setType(METHOD_CALL);}
					{astFactory.addASTChild(currentAST, #ta1);}
					argList
					RPAREN!
				)?
			|	"super"
				(	// (new Outer()).super()  (create enclosing instance)
					lp3:LPAREN^ {#lp3.setType(SUPER_CTOR_CALL);}
					{astFactory.addASTChild(currentAST, #ta1);}
					argList
					RPAREN!
				|	DOT^ ta2:typeArguments! IDENT
					(	lps:LPAREN^ {#lps.setType(METHOD_CALL);}
						{astFactory.addASTChild(currentAST, #ta2);}
						argList
						RPAREN!
					)?
				)
			)
		|	DOT^ newExpression
		|	lb:LBRACK^ {#lb.setType(INDEX_OP);} expression RBRACK!
		)*

		(	// possibly add on a post-increment or post-decrement.
			// allows INC/DEC on too much, but semantics can check
			in:INC^ {#in.setType(POST_INC);}
	 	|	de:DEC^ {#de.setType(POST_DEC);}
		)?
 	;

// the basic element of an expression
primaryExpression
	:	identPrimary ( options {greedy=true;} : DOT^ "class" )?
	|	constant
	|	"true"
	|	"false"
	|	"null"
	|	newExpression
	|	"this"
	|	"super"
	|	LPAREN! assignmentExpression RPAREN!
		// look for int.class and int[].class
	|	builtInType
		( lbt:LBRACK^ {#lbt.setType(ARRAY_DECLARATOR);} RBRACK! )*
		DOT^ "class"
	;

/** Match a, a.b.c refs, a.b.c(...) refs, a.b.c[], a.b.c[].class,
 *  and a.b.c.class refs.  Also this(...) and super(...).  Match
 *  this or super.
 */
identPrimary
	:	ta1:typeArguments!
		IDENT
		// Further proof that java designers should lay off the drugs:
		// Syntax for method invocation with type arguments is
		//   <String> foo ("bla")  instead of  foo <String> ("bla")
		(
			options {
				// .ident could match here or in postfixExpression.
				// We do want to match here.  Turn off warning.
				greedy=true;
				// This turns the ambiguity warning of the second alternative
				// off. See below. (The "false" predicate makes it non-issue)
				warnWhenFollowAmbig=false;
			}
			// bah, great, we have a new nondeterminism because of those
			// stupid typeArguments... only a syntactic predicate will help...
			// The problem is that this loop here conflicts with
			//  DOT typeArguments "super"  in postfixExpression (k=2)
			// A proper solution would require a lot of refactoring...
		:	(DOT typeArguments IDENT) =>
				DOT^ ta2:typeArguments! IDENT
		|	{false}?	// FIXME: this is very ugly but it seems to work...
						// this will also produce an ANTLR warning!
				// Unfortunately a syntactic predicate can only select one of
				// multiple alternatives on the same level, not break out of
				// an enclosing loop, which is why this ugly hack (a fake
				// empty alternative with always-false semantic predicate)
				// is necessary.
		)*
		(
			options {
				// ARRAY_DECLARATOR here conflicts with INDEX_OP in
				// postfixExpression on LBRACK RBRACK.
				// We want to match [] here, so greedy.  This overcomes
				// limitation of linear approximate lookahead.
				greedy=true;
			}
		:	(	lp:LPAREN^ {#lp.setType(METHOD_CALL);}
				// if the input is valid, only the last IDENT may
				// have preceding typeArguments... rather hacky, this is...
				{if (#ta2 != null) astFactory.addASTChild(currentAST, #ta2);}
				{if (#ta2 == null) astFactory.addASTChild(currentAST, #ta1);}
				argList RPAREN!
			)
		|	( options {greedy=true;} :
				lbc:LBRACK^ {#lbc.setType(ARRAY_DECLARATOR);} RBRACK!
			)+
		)?
	;

/** object instantiation.
 *  Trees are built as illustrated by the following input/tree pairs:
 *
 *  new T()
 *
 *  new
 *   |
 *   T --  ELIST
 *           |
 *          arg1 -- arg2 -- .. -- argn
 *
 *  new int[]
 *
 *  new
 *   |
 *  int -- ARRAY_DECLARATOR
 *
 *  new int[] {1,2}
 *
 *  new
 *   |
 *  int -- ARRAY_DECLARATOR -- ARRAY_INIT
 *                                  |
 *                                EXPR -- EXPR
 *                                  |      |
 *                                  1      2
 *
 *  new int[3]
 *  new
 *   |
 *  int -- ARRAY_DECLARATOR
 *                |
 *              EXPR
 *                |
 *                3
 *
 *  new int[1][2]
 *
 *  new
 *   |
 *  int -- ARRAY_DECLARATOR
 *               |
 *         ARRAY_DECLARATOR -- EXPR
 *               |              |
 *             EXPR             1
 *               |
 *               2
 *
 * Note that the typeArguments are no error here, you can write things like:
 * 		Foo f = new <Bar> Foo <Baz> ();
 * The first type arguments are for the constructor, the second for the class.
 */
newExpression
	:	"new"^ typeArguments type
		(	LPAREN! argList RPAREN! (classBlock)?

			//java 1.1
			// Note: This will allow bad constructs like
			//    new int[4][][3] {exp,exp}.
			//    There needs to be a semantic check here...
			// to make sure:
			//   a) [ expr ] and [ ] are not mixed
			//   b) [ expr ] and an init are not used together

		|	newArrayDeclarator (arrayInitializer)?
		)
	;

argList
	:	(	expressionList
		|	/*nothing*/
			{#argList = #[ELIST,"ELIST"];}
		)
	;

newArrayDeclarator
	:	(
			// CONFLICT:
			// newExpression is a primaryExpression which can be
			// followed by an array index reference.  This is ok,
			// as the generated code will stay in this loop as
			// long as it sees an LBRACK (proper behavior)
			options {
				warnWhenFollowAmbig = false;
			}
		:
			lb:LBRACK^ {#lb.setType(ARRAY_DECLARATOR);}
				(expression)?
			RBRACK!
		)+
	;

constant
	:	NUM_INT
	|	CHAR_LITERAL
	|	STRING_LITERAL
	|	NUM_FLOAT
	|	NUM_LONG
	|	NUM_DOUBLE
	;


//----------------------------------------------------------------------------
// The Java scanner
//----------------------------------------------------------------------------
class JavaLexer extends Lexer;

options {
	exportVocab=Java;      // call the vocabulary "Java"
	testLiterals=false;    // don't automatically test for literals
	k=4;                   // four characters of lookahead
	charVocabulary='\u0003'..'\u7FFE';
	// without inlining some bitset tests, couldn't do unicode;
	// I need to make ANTLR generate smaller bitsets; see
	// bottom of JavaLexer.java
	codeGenBitsetTestThreshold=20;
}

{
	/** flag for enabling the "assert" keyword */
	private boolean assertEnabled = false;
	/** flag for enabling the "enum" keyword */
	private boolean enumEnabled = false;

	/** Enable the "assert" keyword */
	public void enableAssert() { assertEnabled = true; }
	/** Disable the "assert" keyword */
	public void disableAssert() { assertEnabled = false; }
	/** Query the "assert" keyword state */
	public boolean isAssertEnabled() { return assertEnabled; }
	/** Enable the "enum" keyword */
	public void enableEnum() { enumEnabled = true; }
	/** Disable the "enum" keyword */
	public void disableEnum() { enumEnabled = false; }
	/** Query the "enum" keyword state */
	public boolean isEnumEnabled() { return enumEnabled; }
}


// OPERATORS
QUESTION		:	'?'		;
LPAREN			:	'('		;
RPAREN			:	')'		;
LBRACK			:	'['		;
RBRACK			:	']'		;
LCURLY			:	'{'		;
RCURLY			:	'}'		;
COLON			:	':'		;
COMMA			:	','		;
//DOT			:	'.'		;
//ELLIPSIS		:	"..."	;
ASSIGN			:	'='		;
EQUAL			:	"=="	;
LNOT			:	'!'		;
BNOT			:	'~'		;
NOT_EQUAL		:	"!="	;
DIV				:	'/'		;
DIV_ASSIGN		:	"/="	;
PLUS			:	'+'		;
PLUS_ASSIGN		:	"+="	;
INC				:	"++"	;
MINUS			:	'-'		;
MINUS_ASSIGN	:	"-="	;
DEC				:	"--"	;
STAR			:	'*'		;
STAR_ASSIGN		:	"*="	;
MOD				:	'%'		;
MOD_ASSIGN		:	"%="	;
SR				:	">>"	;
SR_ASSIGN		:	">>="	;
BSR				:	">>>"	;
BSR_ASSIGN		:	">>>="	;
GE				:	">="	;
GT				:	">"		;
SL				:	"<<"	;
SL_ASSIGN		:	"<<="	;
LE				:	"<="	;
LT				:	'<'		;
BXOR			:	'^'		;
BXOR_ASSIGN		:	"^="	;
BOR				:	'|'		;
BOR_ASSIGN		:	"|="	;
LOR				:	"||"	;
BAND			:	'&'		;
BAND_ASSIGN		:	"&="	;
LAND			:	"&&"	;
SEMI			:	';'		;
AT				:	'@'		;


// Whitespace -- ignored
WS	:	(	' '
		|	'\t'
		|	'\f'
			// handle newlines
		|	(	options {generateAmbigWarnings=false;}
			:	"\r\n"  // Evil DOS
			|	'\r'    // Macintosh
			|	'\n'    // Unix (the right way)
			)
			{ newline(); }
		)+
		{ _ttype = Token.SKIP; }
	;

// Single-line comments
SL_COMMENT
	:	"//"
		(~('\n'|'\r'))* ('\n'|'\r'('\n')?)?
		{$setType(Token.SKIP); newline();}
	;

// multiple-line comments
ML_COMMENT
	:	"/*"
		(	/*	'\r' '\n' can be matched in one alternative or by matching
				'\r' in one iteration and '\n' in another.  I am trying to
				handle any flavor of newline that comes in, but the language
				that allows both "\r\n" and "\r" and "\n" to all be valid
				newline is ambiguous.  Consequently, the resulting grammar
				must be ambiguous.  I'm shutting this warning off.
			 */
			options {
				generateAmbigWarnings=false;
			}
		:
			{ LA(2)!='/' }? '*'
		|	'\r' '\n'		{newline();}
		|	'\r'			{newline();}
		|	'\n'			{newline();}
		|	~('*'|'\n'|'\r')
		)*
		"*/"
		{$setType(Token.SKIP);}
	;


// character literals
CHAR_LITERAL
	:	'\'' ( ESC | ~('\''|'\n'|'\r'|'\\') ) '\''
	;

// string literals
STRING_LITERAL
	:	'"' (ESC|~('"'|'\\'|'\n'|'\r'))* '"'
	;


// escape sequence -- note that this is protected; it can only be called
//   from another lexer rule -- it will not ever directly return a token to
//   the parser
// There are various ambiguities hushed in this rule.  The optional
// '0'...'9' digit matches should be matched here rather than letting
// them go back to STRING_LITERAL to be matched.  ANTLR does the
// right thing by matching immediately; hence, it's ok to shut off
// the FOLLOW ambig warnings.
protected
ESC
	:	'\\'
		(	'n'
		|	'r'
		|	't'
		|	'b'
		|	'f'
		|	'"'
		|	'\''
		|	'\\'
		|	('u')+ HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
		|	'0'..'3'
			(
				options {
					warnWhenFollowAmbig = false;
				}
			:	'0'..'7'
				(
					options {
						warnWhenFollowAmbig = false;
					}
				:	'0'..'7'
				)?
			)?
		|	'4'..'7'
			(
				options {
					warnWhenFollowAmbig = false;
				}
			:	'0'..'7'
			)?
		)
	;


// hexadecimal digit (again, note it's protected!)
protected
HEX_DIGIT
	:	('0'..'9'|'A'..'F'|'a'..'f')
	;


// an identifier.  Note that testLiterals is set to true!  This means
// that after we match the rule, we look in the literals table to see
// if it's a literal or really an identifer
IDENT
	options {testLiterals=true;}
	:	('a'..'z'|'A'..'Z'|'_'|'$') ('a'..'z'|'A'..'Z'|'_'|'0'..'9'|'$')*
		{
			// check if "assert" keyword is enabled
			if (assertEnabled && "assert".equals($getText)) {
				$setType(ASSERT); // set token type for the rule in the parser
			}
			// check if "enum" keyword is enabled
			if (enumEnabled && "enum".equals($getText)) {
				$setType(ENUM); // set token type for the rule in the parser
			}
		}
	;


// a numeric literal
NUM_INT
	{boolean isDecimal=false; Token t=null;}
	:	'.' {_ttype = DOT;}
		(	'.' '.' {_ttype = ELLIPSIS;}
		|	(	('0'..'9')+ (EXPONENT)? (f1:FLOAT_SUFFIX {t=f1;})?
				{
				if (t != null && t.getText().toUpperCase().indexOf('F')>=0) {
					_ttype = NUM_FLOAT;
				}
				else {
					_ttype = NUM_DOUBLE; // assume double
				}
				}
			)?
		)

	|	(	'0' {isDecimal = true;} // special case for just '0'
			(	('x'|'X')
				(											// hex
					// the 'e'|'E' and float suffix stuff look
					// like hex digits, hence the (...)+ doesn't
					// know when to stop: ambig.  ANTLR resolves
					// it correctly by matching immediately.  It
					// is therefor ok to hush warning.
					options {
						warnWhenFollowAmbig=false;
					}
				:	HEX_DIGIT
				)+

			|	//float or double with leading zero
				(('0'..'9')+ ('.'|EXPONENT|FLOAT_SUFFIX)) => ('0'..'9')+

			|	('0'..'7')+									// octal
			)?
		|	('1'..'9') ('0'..'9')*  {isDecimal=true;}		// non-zero decimal
		)
		(	('l'|'L') { _ttype = NUM_LONG; }

		// only check to see if it's a float if looks like decimal so far
		|	{isDecimal}?
			(	'.' ('0'..'9')* (EXPONENT)? (f2:FLOAT_SUFFIX {t=f2;})?
			|	EXPONENT (f3:FLOAT_SUFFIX {t=f3;})?
			|	f4:FLOAT_SUFFIX {t=f4;}
			)
			{
			if (t != null && t.getText().toUpperCase() .indexOf('F') >= 0) {
				_ttype = NUM_FLOAT;
			}
			else {
				_ttype = NUM_DOUBLE; // assume double
			}
			}
		)?
	;


// a couple protected methods to assist in matching floating point numbers
protected
EXPONENT
	:	('e'|'E') ('+'|'-')? ('0'..'9')+
	;


protected
FLOAT_SUFFIX
	:	'f'|'F'|'d'|'D'
	;

