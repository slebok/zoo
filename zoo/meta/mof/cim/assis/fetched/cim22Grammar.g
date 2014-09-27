header {
	import java.io.*;
	import java.util.Vector;
	import java.util.Hashtable;
}
// =====================================================================
// Title: CIM v2.2.2 parser.
// Filename: cim22Grammar.g
// Version: 0.2
// Revision: 0
// Date: 2001.12
//
// Description: This is a complete CIM v2.2.2(*) meta-model parser, 
// based on an ANTLR 2.7.1 grammar. It makes use of the available DMTF
// MOF syntax grammar description - this should be LL(1) parseable 
// (k=1).
//
// (*) CIM V2.2, 14.06.99, plus Addenda 02  
// =====================================================================
// Author:  Pedro Assis
// Contact: passis@dee.isep.ipp.pt
// =====================================================================
// History: 
//    2000.11 version 0.1
//			- Lexer and basic parser development.
//    2001.12 version 0.2
//			- The associationDcl and indicationDcl rules are deprecated. The
//			ASSOCIATION and INDICATION qualifiers are not required to be the
//			firsts ones in the Class qualifier list as suggested in Appendix
//			A of the CIM Specification Version 2.2, June 14, 1999. These 
//			rules	collapse in the classDcl. The association and indication 
//			class	identification must be done by class qualifier 
//			post-processing.
//
//			- The qualifiers propagation rules are subject to rules named 
//			flavors. Although allowed by the CIM ABNF qualifiers flavors are
//			NOT allowed to change within a namespace since this can lead to
//			contradictions. They are established at the	qualifier
//			declaration	(qualifierDcl). 
//
//			- Since instances are not a CIM meta-element they should not
//			have a qualifier list, and it should retain their class
//			qualifiers list. But the CIM ABNF allows it. This is a CIM ABNF
//			error. Any subclass inherits the superclass properties, 
//			references, methods, qualifiers if their flavors values allow
//			it. This should be done	in a post-processing routines.
//						
// =====================================================================
// A note on text formatting for better display
// 1) Use Tab stop every 2 characters,
// 2) Text wrapping at column 72 (each line should be 72 characters 
// long.
//						
// =====================================================================
/**
  * Header source code must be placed ->before<- any ANTLR-generated
	* code in the output parser. Comments are not allowed before this
	* header
  *
  * Rather than have the programmer specify a bunch of command-line
	* arguments to the parser generator the options section is used.
  * This solution is preferable because it associates the required
	* options with the grammar rather than ANTLR invocation.
  *
  * The tokens section defines literals and assign to them a valid 
	* label. These productions are case-insensitive (caseSensitive = 
	* false in the lexer).
  *
  * Comments are allowed before the grammatical rules.
  *  
	* Special care has to be taken to the definition of user qualifiers.
	* It is required that all Qualifiers definitions appear at the head 
	* of the MOF file. If not another syntactic evaluation stage has to 
	* exist between the previous ones. This is required to support the
	* CIM meta-model extensibility.
	*
  * Credit notice:
  * The inline comments are from their original sources texts,
  * namely: ANTLR Reference Manual and CIM Specifications.
  *
  * @author Pedro Assis
  * @author passis@dee.isep.ipp.pt 11.2000
	* @author passis@dee.isep.ipp.pt 12.2001
  *
  */
class cim22Parser extends Parser;
options {
	k=1;
}
tokens {
	REFERENCE = "reference";
	BOOLEAN   = "boolean";
	NULL      = "null";
	UINT8     = "uint8";
	SINT8     = "sint8";
	UINT16    = "uint16";
	SINT16    = "sint16";
	UINT32    = "uint32";
	SINT32    = "sint32";
	UINT64    = "uint64";
	SINT64    = "sint64";
	REAL32    = "real32";
	REAL64    = "real64";
	CHAR16    = "char16";
	STRING    = "string";
	DATETIME  = "datetime";
}
{
	public void reportError(RecognitionException ex) {
		++cim22.parserErrorLine;
		cim22.mofOut.println("Parsing ERROR trace\t#" 
		+ cim22.parserErrorLine + "\t: Source file " + ex);
  }// public void reportError(RecognitionException)
}
/**
	* Parser rule description starts here. The semantic analysis is made
	* in the action part of each rule.
	*
	* Enables several MOF specifications in the same MOF file
	*/
mofSpecification
	: (mofProduction
			{ 
			  ++cim22.mofElementTraceLine;
				if (cim22.mofElementTrace)
					cim22.mofOut.println ("Parsing success \t#" 
					+ cim22.mofElementTraceLine	+ "\t: End mofProduction");
			}
		)+
	;
/**
	* High level declarations. All schema elements - Class(es),
	* Property(ies), Qualifier(s), Method(s) and Namespace(s) use case
	* insensitive naming, but case must be unchanged.
	*
	* Parser rules - identifiers beginning with a lowercase letter are
	* references to ANTLR parser rules. The subsequent characters may be
	* any letter, digit or underscore. This rules apply to a stream of
	* tokens.
	*
	* Lexer rules - rules defined within the lexer grammar must begin 
	* with an uppercase letter. These rules match characters on the input
	* stream.
	*
	* Token references - identifiers beginning with an uppercase letter
	* are token references. The subsequent characters may be any letter,
	* digit or underscore.
	*/
mofProduction
	: ( compilerDirective
		| qualifierDcl
		| classDcl
		| instanceDcl
		| LBRACK
			(qualifierList
				( classDcl
				| instanceDcl
				)
			)
		)
	;
/**
  *	Compiler directive - #pragma.
	*
  */
compilerDirective
	: HASH_PRAGMA
		pragmaName
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine + "\t: compilerDirective");
		}
	;
/**
	*
	*/
pragmaName
	:	( pragmaInclude
		| pragmaInstanceLocale
		| pragmaLocale
		| pragmaNamespace
		| pragmaNonLocal
		| pragmaNonLocalType
		| pragmaSource
		| pragmaSourceType
		)
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: pragmaName");
		}	
	;
/**
  *	Has a filename as a parameter. This pragma as the effect
  *	of textually inserting the contents of the included file
  *	at the point where the include pragma is encountered.
	*
	* >>> Terminating Rule >>>
  */
pragmaInclude
{
	String cimPragmaInclude = null;
}
	:	"include" 
		LPAREN
		lbl_1:STRING_VALUE
			{
				// If include file name has '"' then remove them
				if (lbl_1.getText().charAt(0) == '"')
					cimPragmaInclude = lbl_1.getText().substring (1,
					lbl_1.getText().length() - 1);
			}
		RPAREN
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: pragmaInclude (" 
				+ cimPragmaInclude + ")");
		}	
	;
/**
  *	Declares the locale used for instances described in the MOF
  *	file. This pragma specifies the locale when "INSTANCE OF"
  *	MOF statement includes strings or char16 properties. This
  *	locale is different from the locale specified by #pragma
  *	locale().
  *
  *	The locale is specified as a parameter of the form ll_cc
  *	ll for the language code (ISO/IEC 639) and cc for the country
  *	code (ISO/IEC 3166).
  */
pragmaInstanceLocale
{
	String cimCountryLocale = null;
}
	:	"instancelocale"
		LPAREN
		cimCountryLocale = cLocale
		RPAREN
		{
			// If locale has '"' then remove them.
			//
			if (cimCountryLocale.charAt(0) == '"')
				cimCountryLocale = cimCountryLocale.substring (1,
				cimCountryLocale.length() - 1);
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: pragmaInstanceLocale");
		}
	;
/**
  *	Declares the locale used for a particular MOF file. When not
  *	specified, the assumed locale is "en_US".
  *	The locale is specified as a parameter of the form ll_cc
  *	ll for the language code (ISO/IEC 639) and cc for the country
  *	code (ISO/IEC 3166).
  */
pragmaLocale
{
	String cimCountryLocale = null;
}
	:	"locale"
		LPAREN
		cimCountryLocale = cLocale
		RPAREN
				{
			// If locale has '"' then remove them.
			//
			if (cimCountryLocale.charAt(0) == '"')
				cimCountryLocale = cimCountryLocale.substring (1,
				cimCountryLocale.length() - 1);
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: pragmaInstanceLocale");
		}
	;
/**
  *	"en_US" is the default locale.
	*
	* >>> Terminating Rule >>>
  */
cLocale returns [String cimCountryLocale]
{
	cimCountryLocale = new String ("en_US");
}
	: ( lbl_1:STRING_VALUE
			{ 
				cimCountryLocale = lbl_1.getText ();
			} 
		)
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: cLocale (" + cimCountryLocale 
				+ ")"); 
		}
	;
/**
  *	This pragma is used to specify a Namespace path.
  *
  *	Syntax: <namespacetype>://<namespacehandle>
  */
pragmaNamespace
{
	String cimNameSpacePath = null;
}
	:	"namespace"
		LPAREN
		cimNameSpacePath = nameSpacePath
		RPAREN
		{
			// If name space path has '"' then remove them.
			//
			if (cimNameSpacePath.charAt(0) == '"')
				cimNameSpacePath = cimNameSpacePath.substring (1, 
				cimNameSpacePath.length() - 1);
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine + "\t: pragmaNamespace");
		}
	;
/**
  *	Indicates the location of an instance (applies to Reference).
  *
  *	Syntax: <namespacetype>://<namespacehandle>
  */
pragmaNonLocal
{
	String cimNameSpacePath = null;
}
	:	"nonlocal"
		LPAREN
		cimNameSpacePath = nameSpacePath
		RPAREN
		{
			// If name space path has '"' then remove them.
			//
			if (cimNameSpacePath.charAt(0) == '"')
				cimNameSpacePath = cimNameSpacePath.substring (1,
				cimNameSpacePath.length() - 1);
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: pragmaNonLocal");
		}
	;
/**
  *	Indicates the type of the location of an instance (applies 
  *	to Reference).
  *
  *	Syntax: <namespacetype>
  */
pragmaNonLocalType
{
	String cimNameSpaceHandle = null;
}
	:	"nonlocaltype"
		LPAREN		
		cimNameSpaceHandle = nameSpaceHandle
		RPAREN
		{
			// If name space path has '"' then remove them.
			//
			if (cimNameSpaceHandle.charAt(0) == '"')
				cimNameSpaceHandle = cimNameSpaceHandle.substring (1,
				cimNameSpaceHandle.length() - 1);
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: pragmaNonLocalType");
		}
	;
/**
  *	Indicates the location of an instance (applies to Reference,
  *	Class, Association and Indication).
  *
  *	Syntax: <namespacetype>://<namespacehandle>
  */
pragmaSource
{
	String cimNameSpacePath = null;
}
	:	"source"
		LPAREN
		cimNameSpacePath = nameSpacePath
		RPAREN
		{
			// If name space path has '"' then remove them.
			//
			if (cimNameSpacePath.charAt(0) == '"')
				cimNameSpacePath = cimNameSpacePath.substring (1, 
				cimNameSpacePath.length() - 1);
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: pragmaSource"); 
		}

	;
/**
  *	Indicates the type of the location of an instance (applies 
  *	to Reference, Class, Association and Indication).
  *
  *	Syntax: <namespacetype>
  */
pragmaSourceType
{
	String cimNameSpaceHandle = null;
}
	:	"sourcetype"
		LPAREN
		cimNameSpaceHandle = nameSpaceHandle
		RPAREN
		{
			// If name space handle has '"' then remove them.
			//
			if (cimNameSpaceHandle.charAt(0) == '"')
				cimNameSpaceHandle = cimNameSpaceHandle.substring (1,
				cimNameSpaceHandle.length() - 1);
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: pragmaSourceType");
		}
	;
/**
  *	Object naming - namespace path.
  *
  *	The namespace path syntax must be checked after the parser
  *	pass.
	* 
	* >>> Terminating Rules >>>
  */
nameSpacePath returns [String cimNameSpacePath]
{
	cimNameSpacePath = null;
}
	: lbl_1:STRING_VALUE
		{
			++cim22.parserTraceLine;
			cimNameSpacePath = lbl_1.getText();
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: nameSpacePath (" 
				+ cimNameSpacePath + ")");
		}
	;
/**
	* >>> Terminating Rules >>>
	*/
nameSpaceType returns [String cimNameSpaceType]
{
	cimNameSpaceType = null;
}
	: lbl_1:STRING_VALUE
		{
			++cim22.parserTraceLine;
			cimNameSpaceType = lbl_1.getText();
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: nameSpaceType ("
				+ cimNameSpaceType + ")");
		}
	;
/**
	* >>> Terminating Rules >>>
	*/
nameSpaceHandle returns [String cimNameSpaceHandle]
{
	cimNameSpaceHandle = null;
}
	: lbl_1:STRING_VALUE
		{
			++cim22.parserTraceLine;
			cimNameSpaceHandle = lbl_1.getText();
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine + "\t: nameSpaceHandle (" 
				+ cimNameSpaceHandle + ")");
		}
	;
/**
  *	Class declaration
  *
  *	The ALIAS qualifier applies to properties, methods,
  *	references and instances. So, the alias should be
  *	removed!? The CIM ABNF allows alias after the class name
	* as an optional field.
  */
classDcl
{
	String cimClassName = null;
	String cimClassAlias = null;
	String cimSuperClassName = null;
}

	:	"class"
		cimClassName = className
		(cimClassAlias = alias)?
		(cimSuperClassName  = superClass)?
		LCURLY
		(classFeature)*
		RCURLY
		SEMI
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: class");
	  }
	;
/**
	* >>> Terminating Rule >>>
	*/
className returns [String cimClassName]
{
	cimClassName = null;
}
	: lbl_1:IDENTIFIER
		{
			++cim22.parserTraceLine;
			cimClassName = lbl_1.getText();
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: className (" + cimClassName 
				+ ")");
		}
	;
/**
	*
	*/
alias returns [String cimAlias]
{
	cimAlias = null;
}
	: "as"
		cimAlias = aliasIdentifier
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: alias");
		}
	;
/**
	* >>> Terminating Rule >>>
	*/
aliasIdentifier returns [String cimAliasIdentifier]
{
	cimAliasIdentifier = null;
}
	: DOLLAR
		lbl_1:IDENTIFIER
		{
			++cim22.parserTraceLine;
			cimAliasIdentifier = lbl_1.getText();
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: aliasIdentifier ("
				+ cimAliasIdentifier + ")");
		}
	;
/**
	*
	*/
superClass returns [String cimSuperClassName]
{
	cimSuperClassName = null;
}
	: COLON
		cimSuperClassName = className
		{ 
			++cim22.parserTraceLine;
  		if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: superClass");
		}
	;
/**
	*
	*/
classFeature
	:	(LBRACK qualifierList)?
		(methodAndPropertyDcl
			( propertyDcl
			| parameterDcl
			)
		| referenceDcl
		)
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: classFeature");
		}
	;
/**
	*
	*/
methodAndPropertyDcl
{
	String cimDataType = null;
	String cimMethodAndPropertyName = null;
}
	:	cimDataType = dataType
		cimMethodAndPropertyName = methodAndPropertyName
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#" 
				+ cim22.parserTraceLine	+ "\t: methodAndPropertyDcl");
		}
	;
/**
	*
	*/
propertyDcl
	:	(array)?
		(defaultValue)?
		SEMI
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: propertyDcl");
		}
	;
/**
	*
	*/
parameterDcl
	:	LPAREN
		(parameterList)?
		RPAREN
		SEMI
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: parameterDcl");
		}	
	;
/**
	*
	*/
referenceDcl
{
	String cimReferenceName = null;
	String cimObjectRef = null;
}
	:	cimObjectRef = objectRef
		cimReferenceName = referenceName
		(defaultValue)?
		SEMI
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: referenceDcl");
		}
	;
/**
  *	At least one qualifier exist...
  */
qualifierList
	:	qualifier
		(COMMA qualifier)*
		RBRACK
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: qualifierList");
		}
	;
/**
	*
	*/
qualifier
{
	String cimQualifierName = null;
}
	:	cimQualifierName = qualifierName
		(qualifierParameter)?
		(flavorList)?
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: qualifier");
		}
	;
/**
	*
	*/
flavorList
{
	String cimFlavor = null;
}
	:	COLON
		(cimFlavor = flavor)+
		{ 
			++cim22.parserTraceLine;
  		if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: flavorList");
		}
	;
/**
	*
	*/
qualifierParameter
	:	( (LPAREN	( constantValue 
				| ((STRING_VALUE)+)
				) 
		   RPAREN)
		| arrayInitializer
		)
		{
			++cim22.parserTraceLine;
  		if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: qualifierParameter");
		}
	;
/**
  *	The flavor establish qualifiers transmission rules 
  *	from classes to subclasses and classes to instances.
  * 
  *	EnableOverride (by default is true) means that
  *	the qualifier can be overridable.
  *
  *	DisableOverrride (by default is false) means that
  *	the qualifier cannot be overriden.
  *
  *	ToSubclass (by default is true) means that the 
  *	qualifier is inherited by nay subclass.
  *
  *	Restricted (by default is false) means that the
  *	qualifier only applies to the current class.
  *
  *	Translatable (by default is false) means that
  *	the qualifier can be specified in multiple
  *	locales.
	*
	* >>> Terminating Rule >>>	
  */
flavor returns [String cimFlavor]
{
	cimFlavor = null;
}
	: ( "enableoverride"  { cimFlavor = new String ("enableoverride"); }
		| "disableoverride" { cimFlavor = new String ("disableoverride"); }
		| "tosubclass"      { cimFlavor = new String ("tosubclass"); }
		| "restricted"      { cimFlavor = new String ("restricted"); }
		| "translatable"    { cimFlavor = new String ("translatable"); }
		)
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: flavor (" + cimFlavor + ")");
		}
	;
/**
  *	CIM_Core2x.mof (x = 4, 5, 6) declares a property named "Locale",
  * CIM_Application2x.mof declares a property named "Source",
  *	CIM_Support2x.mof declares a value named "Reference",
  *	so it is necessary to include those tokens here.
	*
	* >>> Terminating Rule >>>	
  */
methodAndPropertyName returns [String cimMethodAndPropertyName]
{
	cimMethodAndPropertyName = null;
}
	: ( lbl_1:IDENTIFIER  { cimMethodAndPropertyName = lbl_1.getText(); }
		| "locale"      { cimMethodAndPropertyName = new String ("locale"); }
		| "source"      { cimMethodAndPropertyName = new String ("source"); }
		| "reference"   { cimMethodAndPropertyName = new String ("reference"); }
		)
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: methodAndPropertyName (" 
				+ cimMethodAndPropertyName + ")"); 
		}
	;
/**
	* >>> Terminating Rule >>>	
	*/
referenceName returns [String cimReferenceName]
{
	cimReferenceName = null;
}
	: lbl_1:IDENTIFIER
		{
			++cim22.parserTraceLine;
			cimReferenceName = lbl_1.getText();
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: referenceName (" 
				+ cimReferenceName + ")");
		}
	;
/**
	* >>> Terminating Rule >>>	
	*/
dataType returns [String cimDataType]
{
	cimDataType = null;
} 
	: ( "uint8"   { cimDataType = new String ("uint8"); }
		| "sint8"   { cimDataType = new String ("sint8"); }
		| "uint16"  { cimDataType = new String ("uint16"); }
		| "sint16"  { cimDataType = new String ("sint16"); }
		| "uint32"  { cimDataType = new String ("uint32"); }
		| "sint32"  { cimDataType = new String ("sint32"); }
		| "uint64"  { cimDataType = new String ("uint64"); }
		| "sint64"  { cimDataType = new String ("sint64"); }
		| "real32"  { cimDataType = new String ("real32"); }
		| "real64"  { cimDataType = new String ("real64"); }
		| "char16"  { cimDataType = new String ("char16"); }
		| "string"  { cimDataType = new String ("string"); }
		| "boolean" { cimDataType = new String ("boolean"); }
		| "datetime"{ cimDataType = new String ("datetime"); }
		)
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: dataType ("
				+ cimDataType + ")");
		}
	;
/**
	* >>> Terminating Rule >>>	
	*/
objectRef returns [String cimObjectRef]
{
	cimObjectRef = null;
}
	: cimObjectRef = className 
		"ref"
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: objectRef (" + cimObjectRef 
				+ ")");
		}
	;
/**
	* At least one parameter exist...
  */
parameterList
	:	parameter 
		(COMMA parameter)*
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: parameterList");
		}
	;
/**
	*
	*/
parameter
{
	String cimDataType = null;
	String cimParameterName = null;
}
	:	(LBRACK qualifierList)?
		( cimDataType = dataType
		| cimDataType = objectRef
		)
		cimParameterName = parameterName
		(array)?
		{
			++cim22.parserTraceLine;
  		if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: parameter");
		}
	;
/**
	* >>> Terminating Rule >>>	
  */
parameterName returns [String cimParameterName]
{ 
	cimParameterName = null;
}
	: lbl_1:IDENTIFIER
		{
			++cim22.parserTraceLine;
			cimParameterName = new String (lbl_1.getText());
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: parameterName ("
				+ cimParameterName + ")"); 
		}
	;
/**
	*
	*/
array
	:	LBRACK
		(numberValue)?
		RBRACK
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: array");
		}
	;
/**
	*
	*/
defaultValue
	:	ASSIGN
		initializer
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: defaultValue");
		}
	;
/**
	*
	*/
initializer
{
	String cimReferenceInitializer = null;
}
	:	( constantValue
		| STRING_VALUE
		| arrayInitializer
		| cimReferenceInitializer = referenceInitializer
		)
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: initializer");
		}
	;
/**
	* (STRING_VALUE)+ allows multiple strings within the same array
	* initializer value. To change this remove the "+" operator.
	*/
arrayInitializer
	:	LCURLY
		( constantValue
		| (STRING_VALUE)+
		)
		(COMMA 	( constantValue 
			| (STRING_VALUE)+
			)
		)*
		RCURLY
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: arrayInitializer");
		}
	;
/**
  *
  */
constantValue
	:	( numberValue 
		| CHAR_VALUE 
		| ("true" | "false")
		| ("null")
		)
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: constantValue");
		}
	;
/**
	* >>> Terminating Rule >>>	
  */
numberValue
	:	NUMBER_VALUE
		{ 

			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: numberValue");  
		}
	;
/**
  *	Should include objectHandle
  */
referenceInitializer returns [String cimReferenceInitializer]
{ 
	cimReferenceInitializer = null;
}
	: cimReferenceInitializer = aliasIdentifier
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: referenceInitializer");
		}
	;
/**
  *	Qualifiers are values that provide additional information
  *	about classes, associations, indications, methods, method
  *	parameters, triggers, instances, properties or references.
  *
  *	All qualifiers have a name, type, value, scope, flavor and
  *	default value.
  *
  *	Several types of qualifiers exist - meta, standard and 
  *	optional.
  *
  *	All qualifiers must be declared before use. Their flavor can
	* not be changed, after the qualifier declaration, within the
	* the same namespace. Different namespaces can use different
	* flavors. 
  */
qualifierDcl
{
	String cimQualifierName = null;
}
	:	"qualifier"
		cimQualifierName = qualifierName
		qualifierType
		scope
		(defaultFlavor)?
		SEMI
		{ 
			++cim22.parserTraceLine;
  		if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: qualifierDcl");
		}
	;
/**
  *	Although the IDENTIFIER rule should be match for any
  *	qualifier name, this must include "schema"..."nonlocaltype" 
  *	strings, which are tokens in the parser, and so not recognized 
  * as IDENTIFIERs
  *
	* >>> Terminating Rule >>> 
  */
qualifierName returns [String cimQualifierName]
{ 
	cimQualifierName = null; 
}
	: ( lbl_1:IDENTIFIER{ cimQualifierName = lbl_1.getText ();}
		| "association"   { cimQualifierName = new String ("Association"); }
		| "indication"    { cimQualifierName = new String ("Indication"); }	
		| "schema"        { cimQualifierName = new String ("Schema"); }
		| "class"         { cimQualifierName = new String ("Class"); }
		| "property"      { cimQualifierName = new String ("Property"); }
		| "reference"     { cimQualifierName = new String ("Reference"); }
		| "method"        { cimQualifierName = new String ("Method"); }
		| "parameter"     { cimQualifierName = new String ("Parameter"); }
		| "any"           { cimQualifierName = new String ("Any"); }
		| "source"        { cimQualifierName = new String ("Source"); }
		| "sourcetype"    { cimQualifierName = new String ("Sourcetype"); }
		| "nonlocal"      { cimQualifierName = new String ("Nonlocal"); }
		| "nonlocaltype"  { cimQualifierName = new String ("Nonlocaltype"); }
    )
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: qualifierName ("
				+ cimQualifierName + ")");
		}
	;
/**
	*
	*/
qualifierType
{
	String cimDataType = null;
}
	:	COLON
		cimDataType = dataType
		(array)?
		(defaultValue)?
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: qualifierType"); 
		}	;
/**
	*
	*/
scope
{
	String cimMetaElement = null;
}
	:	COMMA
		"scope"
		LPAREN
		cimMetaElement = metaElement 
		(COMMA cimMetaElement = metaElement)*
		RPAREN
		{   
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: scope");
		}
	;
/**
	* >>> Terminating Rule >>>
	*/
metaElement returns [String cimMetaElement]
{
	cimMetaElement = null; 
}
	: ( "schema"      { cimMetaElement = new String ("schema"); }
		| "class"       { cimMetaElement = new String ("class"); }
 		| "association" { cimMetaElement = new String ("association"); }
		| "indication"  { cimMetaElement = new String ("indication"); }
		| "property"    { cimMetaElement = new String ("property"); }
		| "reference"   { cimMetaElement = new String ("reference"); }
		| "method"      { cimMetaElement = new String ("method"); }
		| "parameter"   { cimMetaElement = new String ("parameter"); }
		| "any"         { cimMetaElement = new String ("any"); }
		)
		{   
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: metaElement (" + cimMetaElement
				+ ")");
		}
	;
/**
	*
	*/
defaultFlavor
{ 
	String cimFlavor = null;
}
	:	COMMA
		"flavor" 
		LPAREN
		cimFlavor = flavor 
		(COMMA cimFlavor = flavor)*
		RPAREN
		{
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: defaultFlavor"); 
		}
	;
/**
  *
  */
instanceDcl
{
	String cimInstanceClassName = null;
	String cimInstanceAlias = null;
}
	:	"instance"
		"of"
		cimInstanceClassName = className
		(cimInstanceAlias = alias)?
		LCURLY
		(
			(LBRACK qualifierList)?
			valueInitializer
		)+
		RCURLY
		SEMI
		{ 
			++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: instanceDcl");
		}
	;
/**
	*
	*/
valueInitializer
{
	String cimInitializerName = null;
}	
	:	cimInitializerName = initializerName
		ASSIGN
		initializer 
		SEMI
		{ 
      ++cim22.parserTraceLine;
			if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: valueInitializer"); 
		}
	;
/**
	* >>> Terminating Rule >>>
	*/
initializerName returns [String cimInitializerName]
{
	cimInitializerName = null;
}
	: lbl_1:IDENTIFIER
		{ 
      ++cim22.parserTraceLine;
			cimInitializerName = lbl_1.getText ();
      if (cim22.parserRuleTrace)
				cim22.mofOut.println ("Parser rule trace\t#"
				+ cim22.parserTraceLine	+ "\t: initializerName ("
				+ cimInitializerName + ")");
		}
	;
/**
  *	This is a complete lexer for the CIM meta-model v2.4
  *	Schema name must not include "_"!
  *
  *	@author Pedro Assis
  *	@author passis@dee.isep.ipp.pt 11.2000
  * 
  */
class cim22Lexer extends Lexer;
options {
	k=2;
	caseSensitive=false;
	caseSensitiveLiterals=false;
 	charVocabulary='\3'..'\377';
}
/**
  *	Operators
  */
SEMI					:	';'	;
LPAREN				:	'('	;
RPAREN				:	')'	;
LBRACK				:	'['	;
RBRACK				:	']'	;
LCURLY				:	'{'	;
RCURLY				:	'}' ;
COLON					:	':'	;
COMMA					:	','	;
ASSIGN				:	'='	;
DOLLAR				:	'$'	;
DOUBLE_QUOTE	:	'"'	;
SINGLE_QUOTE	:	'\'';
DIV						:	'/'	;
/**
  *	Antlr warning issues due to potential conflicts 
  *	with NUMBER_VALUE rule.
  */
protected	
PLUS	:	'+'	;
/**
	*
	*/	
protected
MINUS	:	'-'	;
/**
	*
	*/
protected
DOT		:	'.'	;
/**
  *	Preprocessing directive
  */
HASH_PRAGMA
	:	"#pragma"
	;
/**
  *	Names of the CIM metamodel elements
  */
IDENTIFIER
options {
  testLiterals = true;
}
	:	('a'..'z'|'_') ('a'..'z'|'_'|'0'..'9')*
		{ 
      ++cim22.lexerTraceLine;
		  if (cim22.lexerRuleTrace)
				cim22.mofOut.println ("Lexer rule trace\t#"
				+ cim22.lexerTraceLine + "\t: identifier (" + $getText + ")");
		}
	;
/**
  * Ignore all forms of white spaces.
	*
	* >>> Terminating Rule >>>
	*/
WS	
	:	( ' '
		| '\t'
		| '\n'  { newline(); }
		| '\r')
		{ $setType(Token.SKIP); }
	;
/**
  * Single-line comments.
	*
	* >>> Terminating Rules >>>
	*/
SL_COMMENT
	: "//"
		(~('\n'|'\r'))* ('\n'|'\r'('\n')?)
		{ 
		  $setType(Token.SKIP);
			newline();
		}
	;
/**
	* Multiple-line comments
	*
	* >>> Terminating Rules >>>
	*/
ML_COMMENT
	: "/*"
		( options {
				generateAmbigWarnings=false;
			}
		:
			{ LA(2)!='/' }? '*'
		| '\r' '\n' {newline();}
		| '\r'      {newline();}
		| '\n'      {newline();}
		| ~('*'|'\n'|'\r')
		)*
		"*/"
		{ 
		  $setType(Token.SKIP);
		}
	;
/**
	*
	*/	
CHAR_VALUE 	
	:	SINGLE_QUOTE
		(ESC|~'\'') 
		SINGLE_QUOTE
		{ 
      ++cim22.lexerTraceLine;
		  if (cim22.lexerRuleTrace)
				cim22.mofOut.println ("Lexer rule trace\t#"
				+ cim22.lexerTraceLine + "\t: char (" + $getText + ")"); 
		}
	;
/**
	*
	*/
STRING_VALUE 	
	:	DOUBLE_QUOTE 
		(ESC|~'"')* 
		DOUBLE_QUOTE
		{ 
      ++cim22.lexerTraceLine;
		  if (cim22.lexerRuleTrace)
				cim22.mofOut.println ("Lexer rule trace\t#"
				+ cim22.lexerTraceLine + "\t: string (" + $getText + ")"); 
		}
	;
/**
	*
	*/
protected
ESC	
	:	'\\'
		( 'n'
		| 't'
		| 'v'   	
		| 'b'
		| 'r'
		| 'f'
		| 'a'  	
		| '\\'
		| '?'     
		| SINGLE_QUOTE
		| DOUBLE_QUOTE
		| ('0' | '1' | '2' | '3')
		(
			/* Since a digit can occur in a string literal,
			 * which can follow an ESC reference, ANTLR
			 * does not know if you want to match the digit
			 * here (greedy) or in string literal.
			 * The same applies for the next two decisions
			 * with the warnWhenFollowAmbig option.
			 */
			options {
				warnWhenFollowAmbig = false;
			}
			: OCTAL_DIGIT
				( options {
					warnWhenFollowAmbig = false;
				}
				:	OCTAL_DIGIT
				)?
		)?
		|   'x' HEX_DIGIT
			( options {
				warnWhenFollowAmbig = false;
			}
			:	HEX_DIGIT
			)?
		)
	;
/**
	*
	*/
protected
OCTAL_DIGIT
	:	'0'..'7'
	;
/**
	*
	*/
protected
HEX_DIGIT
 	:	('0'..'9' | 'a'..'f')
	;
/**
	*
	*/
protected
BIN_DIGIT
	:	('0'..'1')
	;
/**
	*
	*/
protected
SOME_DECIMAL_DIGIT
	:	('2'..'9')
	;
/**
	* protected 
  */
REAL_VALUE
	: (DOT (BIN_DIGIT | SOME_DECIMAL_DIGIT)+ 
		(('e') (MINUS | PLUS)? (BIN_DIGIT | SOME_DECIMAL_DIGIT)+)?)
		{ 
		  $setType(REAL_VALUE); 
      ++cim22.lexerTraceLine;
			if (cim22.lexerRuleTrace)
				cim22.mofOut.println ("Lexer rule trace\t#"
				+	cim22.lexerTraceLine + "\t: Real (" + $getText + ")");
		}
	;
/**
	*
	*/
protected
INT_VALUE
	: ()
		{
			$setType(INT_VALUE); 
		}
	;
/**
	*
	*/
protected
DECIMAL_VALUE
	:	(((BIN_DIGIT | SOME_DECIMAL_DIGIT)+)?
			( REAL_VALUE
			| INT_VALUE
			)
		)
	;
/**
	* >>> Terminating Rule >>>
	*/
NUMBER_VALUE
	: (MINUS | PLUS)?
		( (HEX_VALUE: ("0x")(BIN_DIGIT | SOME_DECIMAL_DIGIT | ('a'..'f'))+)
			{ 
			  $setType(HEX_VALUE.getType()); 
        ++cim22.lexerTraceLine;
				if (cim22.lexerRuleTrace)
					cim22.mofOut.println ("Lexer rule trace\t#"
					+	cim22.lexerTraceLine + "\t: Hexadecimal (" + $getText
					+ ")");
			}
		| (	(BIN_DIGIT)+ 
					(	(BIN_VALUE:   ('b')) 
						{ 
		  				$setType(BIN_VALUE.getType());
			      	++cim22.lexerTraceLine;
							if (cim22.lexerRuleTrace) 
								cim22.mofOut.println ("Lexer rule trace\t#"
								+	cim22.lexerTraceLine + "\t: Binary (" + $getText
								+ ")");
						}
					| (SOME_DECIMAL_DIGIT DECIMAL_VALUE)
						{
						}
					| (REAL_VALUE)
						{ 
						}
					| (INT_VALUE)
						{
				      ++cim22.lexerTraceLine;
							if (cim22.lexerRuleTrace)
								cim22.mofOut.println ("Lexer rule trace\t#"
								+	cim22.lexerTraceLine + "\t: Integer (" + $getText
								+ ")"); 
						}
					)
			)
		| (SOME_DECIMAL_DIGIT DECIMAL_VALUE)
			{
			}
		)
	;
// ===================================================================
// end of file
// ===================================================================
