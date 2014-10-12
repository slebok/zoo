// =====================================================================
// Title: CIM MOF to Java
// Filename: TranslateCIM.g
// Version: 0.9
// Date: 2008-10-01
// Author: Pete Siemsen
// Contact: siemsen@ucar.edu, 303-497-1810
//
// Thanks to Pedro Assis, passis@dee.isep.ipp.pt, for his ANTLR 2
// grammar named cim22grammar.g, which served as a starting point for
// this grammar.
//
//     This ANTLR 3 grammar generates a translator that translates CIM
//     MOF files into Java source files.  The CIM (Common Information
//     Model) is a set of standard object definitions defined by the DMTF
//     (Distributed Management Task Force).  CIM objects are defined
//     using MOF (Managed Object Format) syntax, which is defined in the
//     CIM Infrastructure Specification, which is available on the DMTF
//     website at http://www.dmtf.org/home.
//
//     ANTLR is a parser generator that provides several ways to get
//     the job done.  For this job, this grammar produces a single-phase
//     (a.k.a single-pass) parser.  In ANTLR-speak, it's a lexer and
//     parser, it doesn't use ASTs, it uses StringTemplates to generate
//     output, and it's a generator, not a rewriter.
//
// TODO:
//  1. Use "init" or "after" actions (see page 86 of the ANTLR book) to
//     increment a counter each time a rule fires.  Then see if any of
//     the rules never fire, and delete those rules from this grammar.
//  2. How do I implement the idea that a className has to start with
//     'CIM_' and the rest of the name can't have an underscore?
//
// =====================================================================
// =====================================================================
// History:
//    2000.11 version 0.1 (Pedro Assis)
//          - Lexer and basic parser development.
//    2007.07 version 0.3 (Pete Siemsen)
//          1. My goal is to produce a translator that converts CIM MOF
//             files to the corresponding Java files.  I don't care if
//             this grammar is precisely implements the DMTF's definition
//             of MOF syntax as defined in Appendix A of the CIM
//             Infrastructure Specification.  In other words, I consider
//             this grammar to be correct if it translates all the CIM
//             MOF files.  MOF language constructs that appear in the
//             specification of the MOF language but don't actually
//             appear in any of the CIM MOF files aren't important.
//             Like, this grammar doesn't know about MOF "instances".
//     2008.02
//           It produces compileable Java!  Now to make it produce good
//           Java.
//
// =====================================================================


grammar TranslateCIM;

options {output=template;}


@header {
package com.kyben.translatecim;  

import java.io.*;
import java.util.ListIterator;
import java.util.HashSet;
import java.util.Calendar;
import java.util.Map;
import java.text.SimpleDateFormat;
}


@members {
    HashMap<String,qualifierDefinition> qualifierDefinitions = new HashMap<String,qualifierDefinition>();
    HashMap<String,String> classSubDirectories = new HashMap<String,String>();
    HashSet<String> accessedSubDirs;
    HashSet<String> outputDirectoryNames = new HashSet<String>();
    String TCVersion = "0.9.1";
    String cimMajorVersion = null;
    String cimMinorVersion = null;
    String incSubDirectory = null;
    boolean noDeprecated;
    boolean noEnums;
    StringTemplateGroup templates = null;
    String outputDirectory = null;     // from the command line, test
    String currentInputFileName = "";  // this gets a new value with each "pragma include" statement
    String currentISO8601DateTime = null;
    
    HashSet<String> javaKeywords = new HashSet<String>();
    HashSet<String> javaClasses = new HashSet<String>();
    
    public class qualifierDefinition {
        String  name;
        String  type;
        boolean isArray;
        ArrayList<String> scopes;
        ArrayList<String> flavors;
        
        qualifierDefinition(String  qName,
                            String  qType,
                            boolean qIsArray,
                            ArrayList<String> qScopes,
                            ArrayList<String> qFlavors) {
            this.name    = qName;
            this.type    = qType;
            this.isArray = qIsArray;
            this.scopes  = qScopes;
            this.flavors = qFlavors;
        }

        public String toString() {
            String str =
                "name: \""    + name    + "\"\n" +
                "type: \""    + type    + "\"\n" +
                "isArray: \"" + isArray + "\"\n" +
                "scopes: \""  + scopes  + "\"\n" +
                "flavors: \"" + flavors + "\"\n";
            return str;
        }
    }

    //
    // The parser calls this method whenever a CIM class is used in a property
    // declaration, method declaration, or method REF.  This method emits an error if
    // the CIM class is undefined.  Otherwise, it updates the list of subdirectories
    // that need to be imported in order to resolve the reference to the class.
    //
    void checkClassName(Token classNameToken) throws RecognitionException {
        String classNam = classNameToken.getText();
        if (classSubDirectories.containsKey(classNam)) {
            String subDir = classSubDirectories.get(classNam);
            if (!subDir.equals(incSubDirectory)) {
                accessedSubDirs.add(subDir);
            }
        } else {
            RecognitionException r = new RecognitionException(input);
            throw new UndefinedClassException(
                                              currentInputFileName + "(" + r.line + ":" + r.charPositionInLine + ")" +
                                              ": class " + classNam + " not defined");
        }
    }
    
    String htmlNewLineString = "<br><br>";
    int htmlNewLineStringLength = htmlNewLineString.length();
    
    String htmlize(String str) {
        if (str == null) {
            return null;
        }
        int len = str.length();
        StringBuilder retstr = new StringBuilder(len + 20);
        for (char estr : str.toCharArray()) {
            switch (estr) {
            case '&':
                retstr.append("&amp;");
                break;
            case '<':
                retstr.append("&lt;");
                break;
            case '>':
                retstr.append("&gt;");
                break;
            case '\n':
                retstr.append(htmlNewLineString);
                break;
            default:
                retstr.append(estr);
            }
        }
        return retstr.toString();
    }

    // javadocize does:
    // 1. break into separate lines (on line length and when you see <br><br>)
    // 2. wrap @see on around every reference to a CIM class (not implemented yet)
    // 3. escape "@" when it appears as the first character on a line (not impremented yet)
    ArrayList<String> javadocize(String str) {
        if (str == null) {
            return null;
        }
        ArrayList<String> retArrayList = new ArrayList<String>();
        String[] result = str.split("\\s");
        StringBuilder currentLine = new StringBuilder();
        for (int x=0; x<result.length; x++) {
            String newWord = result[x];
            while (newWord.contains(htmlNewLineString)) {
                int lineEnd = newWord.indexOf(htmlNewLineString);
                currentLine.append(newWord.substring(0, lineEnd+htmlNewLineStringLength));
                retArrayList.add(currentLine.toString());
                currentLine.setLength(0);
                newWord = newWord.substring(lineEnd+htmlNewLineStringLength);
            }
            if ((currentLine.length() + newWord.length()) > 75) {
                retArrayList.add(currentLine.toString());
                currentLine.setLength(0);
            }
            currentLine.append(" " + newWord);
        }
        retArrayList.add(currentLine.toString());
        return retArrayList;
    }

    String canonicalizeValue(String inValue) {
        String retValue = inValue;
        retValue = retValue.replace(" ", "_");
        retValue = retValue.replace("#", "_");
        retValue = retValue.replace("&", "_and_");
        retValue = retValue.replace("(", "_");
        retValue = retValue.replace(")", "_");
        retValue = retValue.replace("+", "_plus_");
        retValue = retValue.replace("-", "_");
        retValue = retValue.replace(".", "_");
        retValue = retValue.replace(",", "_");
        retValue = retValue.replace("/", "_");
        retValue = retValue.replace("\\", "_");
        retValue = retValue.replace("'", "_");
        retValue = retValue.replace(":", "_");
        retValue = retValue.replace("<", "_");
        retValue = retValue.replace("=", "_");
        retValue = retValue.replace(">", "_");
        retValue = retValue.replace("|", "_");
        return retValue;
    }

    //
    //  Given a string and a hashset of unique strings, make sure the string doesn't
    //  appear in the hashset.  If it does, generate a new, unique string that
    //  doesn't appear in the hashset and return it.  Store the new string in the
    //  hashset so it won't be allowed later.
    //
    String makeUnique(String valueName, HashSet<String> uniqueValueNames) {
        String originalValueName = valueName;
        int j = 1;
        while (uniqueValueNames.contains(valueName)) {
            valueName = originalValueName + "_" + Integer.toString(j);
            j++;
        }
        uniqueValueNames.add(valueName);
        return valueName;
    }
    
    // Debugging methods.
    public static void printKeys(Map m) {
        System.out.println("printkeys: Size = " + m.size() + ", ");
        System.out.println("printkeys: Keys: ");
        System.out.println(m.keySet()); 
    }
    public static void printValues(Map m) {
        System.out.println("printkeys: Values: ");
        System.out.println(m.values());
    }
} // end of @members


@lexer::header {
    package com.kyben.translatecim;

    import java.io.*;
} // end of @lexer::header


@lexer::members {
    // This stolen straight from the ANTLR Wiki page titled "How do I implement include files?"
    class SaveStruct {
        SaveStruct(CharStream input) {
            this.input = input;
            this.marker = input.mark();
        }
        public CharStream input;
        public int marker;
    }

    Stack<SaveStruct> includes = new Stack<SaveStruct>();

    // We should override this method for handling EOF of included file
     public Token nextToken(){
       Token token = super.nextToken();

       if(token==Token.EOF_TOKEN && !includes.empty()){
        // We've got EOF and have non empty stack.
         SaveStruct ss = includes.pop();
         setCharStream(ss.input);
         input.rewind(ss.marker);
         //this should be used instead of super [like below] to handle exits from nested includes
         //it matters, when the 'include' token is the last in previous stream (using super, lexer 'crashes' returning EOF token)
         token = this.nextToken();
       }

      // Skip first token after switching on another input.
      // You need to use this rather than super as there may be nested include files
       if(((CommonToken)token).getStartIndex() < 0)
         token = this.nextToken();

       return token;
     }

} // end of @lexer::members


//==================================================================================================================
// Parser rules  ===================================================================================================
//==================================================================================================================


mofSpecification [String  majVersion,
                  String  minVersion,
                  String  stgFileName,
                  String  outputDirectoryName,
                  boolean noDeprecatedIn,
                  boolean noEnumsIn]
    @init {
            System.out.println("Starting parser phase, reading token stream, creating java files in " + outputDirectoryName);
            cimMajorVersion  = majVersion;
            cimMinorVersion  = minVersion;
            outputDirectory  = outputDirectoryName;
            noDeprecated     = noDeprecatedIn;
            noEnums          = noEnumsIn;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
            currentISO8601DateTime = sdf.format(Calendar.getInstance().getTime());
            javaKeywords.add("boolean");
            javaClasses.add("System");

            // Load the template group file (named something.stg) into the "templates" variable
            try {
                FileReader groupFileR = new FileReader(stgFileName);
                templates = new StringTemplateGroup(groupFileR);
                groupFileR.close();
            } catch (IOException e) {
                throw new CantReadStgFileException(": couldn't read string template group file " + e.getMessage());
            }
            setTemplateLib(templates);
    }
    : (mofProduction)+
    {
        // Create and write the build file.
        String buildFileName = outputDirectory + File.separator + "compile.sh";
        try {
            BufferedWriter buildFile = new BufferedWriter(new FileWriter(buildFileName));
            buildFile.write("#!/bin/bash\n");
            for (String oDirName : outputDirectoryNames) {
//    			System.out.println("mofSpecification: oDirName = \"" + oDirName + "\"");  // dbg
                buildFile.write("javac -cp /tmp " + oDirName + File.separator + "*.java\n");
            }
            buildFile.close();
        } catch (IOException e) {
            throw new CantCreateBuildFileException("couldn't create build file " + e.getMessage());
        }
    }
    ;


mofProduction
//	@init {
//    	System.out.println("mofProduction: initializing");  // dbg
//	}
    : compilerDirective
    | qualifierDeclaration
    | classDeclaration
    {
//        System.out.println("mofProduction: called");  // dbg
        if ($classDeclaration.className != null) {      // omitted (deprecated) classes are null
            classSubDirectories.put($classDeclaration.className, incSubDirectory);
            // Create the output subdirectory if it doesn't exist.
            String outputSubDirectoryName = outputDirectory + File.separator + incSubDirectory;
            File outputSubDirectory = new File(outputSubDirectoryName);
            if (!outputSubDirectory.isDirectory()) {
                outputSubDirectory.mkdirs();
            }
            outputDirectoryNames.add(outputSubDirectoryName);    // save the subdirectory name so we can create a "build file" later
            // Create and write the output file.
            String outputFileName= outputSubDirectoryName + File.separator + $classDeclaration.className + ".java";
            try {
                BufferedWriter outputFile = new BufferedWriter(new FileWriter(outputFileName));
                // System.out.println("writing file \"" + outputFileName + "\"");
                outputFile.write($classDeclaration.st.toString());
                outputFile.close();
            } catch (IOException e) {
                RecognitionException r = new RecognitionException(input);
                throw new CantCreateOutputFileException(
                    currentInputFileName + "(" + r.line + ":" + r.charPositionInLine + ")" +
                    ": couldn't create output file " + e.getMessage());
            }
        }
    }   
    ;


compilerDirective
//	@init {
//        System.out.println("compilerDirective: initializing");  // dbg
//	}
    : PragmaInclude
    {
        currentInputFileName = $PragmaInclude.text;
//        System.out.println("new current filename = " + currentInputFileName);  // dbg
    }
    | PragmaLocale
    ;


qualifierDeclaration
//	@init {
//        System.out.println("qualifierDeclaration: initializing");  // dbg
//	}
    : QUALIFIER qualifierName COLON qualifierType qualifierScopeList ( qFl=qualifierFlavorList )? SEMICOLON
    {
        ArrayList<String> fl = (qFl == null) ? new ArrayList<String>() : qFl.fList;
//        System.out.println("qualifierDefinition: called, name = " + $qualifierName.text);  // dbg
        qualifierDefinitions.put($qualifierName.text.toLowerCase(),
                                 new qualifierDefinition( $qualifierName.text,
                                                          $qualifierType.type,
                                                          $qualifierType.isArray,
                                                          $qualifierScopeList.sList,
                                                          fl));
    }
    ;


qualifierName
    : Identifier
    ;


qualifierType returns [String type, boolean isArray, String defaultVal]
    @init {
        boolean qualifierIsArray = false;
        String defValue = "";
        // System.out.println("qualifierType: called");
    }
    : dataType (array{qualifierIsArray=true;})? ( EQUALS qi=qualifierInitializer )?
    {
        retval.type = $dataType.text;
        retval.isArray = qualifierIsArray;
        // System.out.println("qualifierType: defValue = " + defValue);
        if (qi != null) {
            retval.defaultVal = $qualifierInitializer.text;    // this is never used!!!!!!!!!!!!!!!!!!!!!
        }
    }
    ;


qualifierScopeList returns [ArrayList<String> sList]
    @init {
        $sList = new ArrayList<String>();
        // System.out.println("qualifierScopeList: called");
    }
    : COMMA SCOPE LPAREN m1=metaElement {$sList.add($m1.text);}
                  (COMMA m2=metaElement {$sList.add($m2.text);})* RPAREN
    ;


metaElement
    :  (  ANY
        | CLASS
        | METHOD
        | PARAMETER
        | PROPERTY
        | REFERENCE
        | Identifier
       )
    ;


qualifierFlavorList returns [ArrayList fList]
    @init {
        $fList = new ArrayList();
        // System.out.println("qualifierFlavorList: called");
    }
    : COMMA FLAVOR LPAREN f1=flavor {$fList.add($f1.text);}
                   (COMMA f2=flavor {$fList.add($f2.text);} )* RPAREN
    ;


flavor
    : ENABLEOVERRIDE
    | DISABLEOVERRIDE
    | TOSUBCLASS
    | RESTRICTED
    | TRANSLATABLE
    ;
    
    
classDeclaration returns [ String className ]
    scope {
        ArrayList features;
    }
    @init {
//    	System.out.println("classDeclaration: initializing");  // dbg
        $classDeclaration::features = new ArrayList();
    }
    : classDeclarationHeader classDeclarationTrailer
    {
        if ($classDeclarationHeader.className == null) {  // this means "if it's deprecated and we're skipping deprecated classes"
            return retval;
        }
        String superClassName = null;
        if ($classDeclarationTrailer.superClassToken != null) {
            checkClassName($classDeclarationTrailer.superClassToken);
            superClassName = $classDeclarationTrailer.superClassToken.getText();
        }
        retval.className = $classDeclarationHeader.className;
        ArrayList<String> importStatements = new ArrayList<String>();
        for (String it : accessedSubDirs) {
            StringTemplate iStatement = templateLib.getInstanceOf("importTemplate", new STAttrMap().put("subDirectory", it));
            importStatements.add(iStatement.toString());
        }
        // System.out.println("classDeclaration: finishing, abstract = " + $classDeclarationHeader.qualifierHash.containsKey("Abstract"));
        // System.out.println("classDeclaration: finishing, className = " + $classDeclarationHeader.className);
    }
    -> classFileTemplate(TranslateCIMVersion = {TCVersion},
                         currentDateTime     = {currentISO8601DateTime},
                         majorCimVersion     = {cimMajorVersion},
                         minorCimVersion     = {cimMinorVersion},
                         subPackage          = {incSubDirectory},
                         deprecated          = {$classDeclarationHeader.qualifierHash.get("Deprecated")},
                         classComment        = {javadocize(htmlize((String)$classDeclarationHeader.qualifierHash.get("Description")))},
                         abstract            = {$classDeclarationHeader.qualifierHash.containsKey("Abstract")},
                         cimClassName        = {$classDeclarationHeader.className},
                         mofSuperClass       = {superClassName},
                         features            = {$classDeclaration::features},
                         imports             = {importStatements}
    )
    ;
    
    
classDeclarationHeader returns [ HashMap qualifierHash, String className]
    : cq=qualifierList CLASS className
    {
        // System.out.println("classDeclarationHeader: called, className = \"" + $className.text + "\"");
        // printKeys($cq.qualifierHash);
        // printValues($cq.qualifierHash);
        if ($cq.qualifierHash.containsKey("Deprecated"  ) && noDeprecated) {
            return retval;  // return with className = null
        }
        retval.className = $className.text;
        retval.qualifierHash = $cq.qualifierHash;
        // Get the subdirectory name and check that the output file name matches the class name.
        File incFile = new File( currentInputFileName );
        incSubDirectory = incFile.getParent();
        // System.out.println("classDeclarationHeader: called, incSubDirectory = \"" + incSubDirectory + "\"");
        String incBaseName = incFile.getName();
        // System.out.println("classDeclarationHeader: incBaseName = \"" + incBaseName + "\"");
        if (!incBaseName.startsWith($className.text)) {
            RecognitionException r = new RecognitionException(input);
            throw new ClassNameDoesntMatchFileNameException(
            currentInputFileName + "(" + r.line + ":" + r.charPositionInLine + ")" +
                                      ": class name " + $className + " doesn't match file name");
        }
    }
    ;


classDeclarationTrailer returns [ Token superClassToken ]
    @init {
//        System.out.println("classDeclarationTrailer: initializing");
        accessedSubDirs = new HashSet<String>();      // replace any old one with a new one !
    }
    : alias? ( scl=superClass )? LCURLY classFeature* RCURLY SEMICOLON
    {
        if (scl != null) {
            retval.superClassToken = $scl.token;
        }
    }
    ;


className returns [ Token token ]
    : Identifier
    {
        retval.token = input.LT(-1);
    }
    ;


alias
    : AS aliasIdentifier
    ;


aliasIdentifier
    : DOLLAR Identifier
    ;


superClass returns [ Token token ]
    : COLON className
    {
        retval.token = $className.token;
    }
    ;


classFeature
//  	@init {
//      	System.out.println("classFeature: initializing");  // dbg
//  	}
    : classFeaturePiece
    {
        // System.out.println("classFeature: called");
        if ($classFeaturePiece.st != null) {
            $classDeclaration::features.add($classFeaturePiece.st);
        }
    }
    ;


classFeaturePiece
    scope {
        HashMap featureQualifierHash;
    }
//  	@init {
//      	System.out.println("classFeaturePiece: initializing");  // dbg
//  	}
    : qualifierList {$classFeaturePiece::featureQualifierHash = $qualifierList.qualifierHash;} featureBodyDeclaration
    -> classFeatureTemplate(comment     = {javadocize(htmlize((String)$qualifierList.qualifierHash.get("Description")))},
                            deprecated  = {$qualifierList.qualifierHash.get("Deprecated")},
                            featureBody = {$featureBodyDeclaration.strng})
    ;


featureBodyDeclaration returns [ String strng ]
//  	@init {
//      	System.out.println("featureBodyDeclaration: initializing");  // dbg
//  	}
    : dataPropertyDeclaration
    {
        if ($dataPropertyDeclaration.st != null) {
            retval.strng = $dataPropertyDeclaration.st.toString();
        }
    }
    | referencePropertyDeclaration
    {
        if ($referencePropertyDeclaration.st != null) {
            retval.strng = $referencePropertyDeclaration.st.toString();
        }
    }
    | methodDeclaration
    {
        if ($methodDeclaration.st != null) {
            retval.strng = $methodDeclaration.st.toString();
        }
    }
    ;


dataPropertyDeclaration
    scope {
        ArrayList<String> constantNames;
    }
    @init {
//        System.out.println("dataPropertyDeclaration: initializing");  // dbg
        boolean isArray = false;
        String classPropertyText = null;
        $dataPropertyDeclaration::constantNames = new ArrayList<String>();
    }
    : dataType nonReservedName ( arr=array )? (EQUALS dV=initializer )? SEMICOLON
    {
//        System.out.println("dataPropertyDeclaration: property = \"" + $nonReservedName.nrString + "\"");  // dbg
        if ($classFeaturePiece::featureQualifierHash.containsKey("Deprecated") && noDeprecated) {
            return retval;   // return without setting dataPropertyDeclaration.st
        }

        boolean enumerable = true;
        if (noEnums ||
            !$classFeaturePiece::featureQualifierHash.containsKey("Values") ||
            (!$dataType.text.equals("uint8" ) &&
             !$dataType.text.equals("sint8" ) &&
             !$dataType.text.equals("uint16") &&
             !$dataType.text.equals("sint16") &&
             !$dataType.text.equals("uint32") &&
             !$dataType.text.equals("sint32") &&
             !$dataType.text.equals("string"))) {
            enumerable = false;
        }

        ArrayList<String> classPropertyValuesLines = new ArrayList<String>();
        ArrayList<String> classPropertyValuesComments = new ArrayList<String>();
        StringTemplate classPropertyValuesLineList = templates.getInstanceOf("classPropertyValuesLineList");
        ArrayList<String> namedInitializers = new ArrayList<String>();
        if ($classFeaturePiece::featureQualifierHash.containsKey("Values")) {
            if (!$classFeaturePiece::featureQualifierHash.containsKey("ValueMap")) {
                RecognitionException r = new RecognitionException(input);
                throw new ValuesButNoValueMapException(
                    currentInputFileName + "(" + r.line + ":" + r.charPositionInLine + ")" +
                    ": property " + $nonReservedName.nrString + " has a Values qualifier but no ValueMap qualifier");
            }

            ArrayList<String> valueMapList = (ArrayList)$classFeaturePiece::featureQualifierHash.get("ValueMap");
            ArrayList<String> valuesList = (ArrayList)$classFeaturePiece::featureQualifierHash.get("Values");
            if (valueMapList.size() != valuesList.size()) {
                RecognitionException r = new RecognitionException(input);
                throw new ValuesDontMatchValueMapException(
                    currentInputFileName + "(" + r.line + ":" + r.charPositionInLine + ")" +
                    ": property " + $nonReservedName.nrString + " has Values and ValueMaps qualifiers with differing numbers of elements");
            }

            HashSet<String> uniqueValueNames = new HashSet<String>();
            for (int i = 0; i < valuesList.size(); i++) {
                String valueName = makeUnique(canonicalizeValue(valuesList.get(i)), uniqueValueNames);
                String valueMap  = valueMapList.get(i);
                if (valueName.endsWith("_Reserved") ||
                    valueMap.contains("..")) {
                    StringTemplate classPropertyValuesComment = templates.getInstanceOf("classPropertyValuesComment");
                    classPropertyValuesComment.setAttribute("enumerable",    enumerable);
                    classPropertyValuesComment.setAttribute("constantName",  valueName);
                    classPropertyValuesComment.setAttribute("constantValue", valueMap);
                    classPropertyValuesComments.add(classPropertyValuesComment.toString());
                } else {
                    if (enumerable) {
                        if (javaKeywords.contains(valueName)) {
                            valueName = "cim_" + valueName;
                        } else {
                            char first = valueName.charAt(0);
                            if ((first >= '0') && (first <= '9')) {
                                valueName = "cim_" + valueName;
                            }
                        }
                    } else {
                        valueName = $nonReservedName.nrString.toUpperCase() + '_' + valueName;
                    }
                    if ($dataType.st.toString().equals("String")) {
                        valueMap = "\"" + valueMap + "\"";
                    }
                    StringTemplate classPropertyValuesLine = templates.getInstanceOf("classPropertyValuesLine");
                    classPropertyValuesLine.setAttribute("enumerable",    enumerable);
                    classPropertyValuesLine.setAttribute("type",          $dataType.st);
                    classPropertyValuesLine.setAttribute("constantName",  valueName);
                    classPropertyValuesLine.setAttribute("constantValue", valueMap);
                    classPropertyValuesLines.add(classPropertyValuesLine.toString());
                }
            }

            classPropertyValuesLineList.setAttribute("enumerable",  enumerable);
            classPropertyValuesLineList.setAttribute("valuesLines", classPropertyValuesLines);

            if (dV != null) {
                for (int z = 0; z < dV.initializerList.size(); z++) {
                    String initialValue = dV.initializerList.get(z);
                    if ($classFeaturePiece::featureQualifierHash.containsKey("Values") && enumerable) {
                        // lookup the name of the value here.
                        for (int i = 0; i < valueMapList.size(); i++) {
                            if (valueMapList.get(i).equals(initialValue)) {
                                namedInitializers.add(canonicalizeValue(valuesList.get(i)));
                                break;
                            }
                        }
                    }
                }
            }
        } else {
            if (dV != null) {
                namedInitializers.add(dV.initializerList.get(0));
            }
        }
        
        // turn namedInitializers into an initializerFragment
        StringTemplate initializerFragment = templates.getInstanceOf("initializerFragment");
        initializerFragment.setAttribute("enumerable",        enumerable);
        initializerFragment.setAttribute("isArray",           (arr!=null));
        initializerFragment.setAttribute("name",              $nonReservedName.nrString);
        initializerFragment.setAttribute("initializerPieces", namedInitializers);
        
        if ($classFeaturePiece::featureQualifierHash.containsKey("ArrayType")) {
            if (arr==null) {
                RecognitionException r = new RecognitionException(input);
                throw new ArrayTypeOnNonArrayException(
                    currentInputFileName + "(" + r.line + ":" + r.charPositionInLine + ")" +
                    ": property " + $nonReservedName.nrString + " has the ArrayType qualifier, but isn't an array");
            }
        }
    }
    -> classDataProperty(enumerable      = {enumerable},
                         deprecated      = {$classFeaturePiece::featureQualifierHash.containsKey("Deprecated")},
                         type            = {$dataType.st},
                         isArray         = {arr!=null},
                         name            = {$nonReservedName.nrString},
                         initializerFrag = {initializerFragment.toString()},
                         valuesLineList  = {classPropertyValuesLineList.toString()},
                         valuesComments  = {classPropertyValuesComments}
                        );


referencePropertyDeclaration
    : className REF nonReservedName ( arr=array )? SEMICOLON
    {
        if ($classFeaturePiece::featureQualifierHash.containsKey("Deprecated"  ) && noDeprecated) {
            return retval;   // return, skipping the setting of referencePropertyDeclaration.st
        }
        checkClassName($className.token);
    }
    -> classReferencePropertyTemplate(deprecated = {$classFeaturePiece::featureQualifierHash.containsKey("Deprecated")},
                                      type       = {$className.text},
                                      isArray    = {arr!=null},
                                      name       = {$nonReservedName.nrString})
    ;
    

methodDeclaration
    scope {
        boolean thisMethodIsDeprecated;
    }
    @init {
        boolean mpexists = false;
        StringTemplate mParmList = null;
    }
    : dataType methodName LPAREN (methodParameterList{mpexists=true;})? RPAREN SEMICOLON
    {
        if ($classFeaturePiece::featureQualifierHash.containsKey("Deprecated"  ) && noDeprecated) {
            return retval;   // return, skipping the setting of methodDeclaration.st
        }
        if (mpexists) {
            mParmList = $methodParameterList.st;
        }
    }
    -> classMethodTemplate(deprecated       = {$classFeaturePiece::featureQualifierHash.containsKey("Deprecated")},
                           type             = {$dataType.st},
                           name             = {$methodName.text},
                           parameters       = {mParmList},
                           bogusReturnValue = {$dataType.defaultVal})
    ;
    
    
methodName
    : Identifier
    ;


methodParameterList
    scope {
        List mparms;
    }
    @init {
        $methodParameterList::mparms = new ArrayList();
    }
    : methodParameter (COMMA methodParameter)*
    -> methodParameterListTemplate(parms={$methodParameterList::mparms})
    ;


methodParameter
    : methodParm
    {
        $methodParameterList::mparms.add($methodParm.st);
    }
    | methodRef
    {
        $methodParameterList::mparms.add($methodRef.st);
    }
    ;


methodParm
    : mq=qualifierList? dataType nonReservedName ( arr=array )?
    -> methodParameterTemplate(comment = {javadocize(htmlize((String)$mq.qualifierHash.get("Description")))},
                               type    = {$dataType.st},
                               isArray = {arr!=null},
                               name    = {$nonReservedName.nrString})
    ;
    
    
methodRef
    : mq=qualifierList? className REF nonReservedName ( arr=array )?
    {
        if ($methodDeclaration::thisMethodIsDeprecated) {
            return retval;
        }
        checkClassName($className.token);
    }
    -> methodReferenceTemplate(comment       = {$mq.qualifierHash.get("Description")},
                               className     = {$className.text},
                               isArray       = {arr!=null},
                               referenceName = {$nonReservedName.nrString})
    ;


nonReservedName returns [ String nrString ]
    : Identifier
    {
        if (javaClasses.contains($Identifier.text)) {
            retval.nrString = "cim_" + $Identifier.text;
        } else {
            retval.nrString = $Identifier.text;
        }
    }
    ;


qualifierList returns [ HashMap qualifierHash ]
    scope {
        HashMap qh;
    }
    @init {
        $qualifierList::qh = new HashMap();
        // System.out.println("qualifierList: initializing");
    }
        : LBRACK qualifier (COMMA qualifier)* RBRACK
    {
        // System.out.println("qualifierList: returning with qualifierHash set");
        // printKeys($qualifierList::qh);  // dbg
        // System.out.println("qualifierList: yo.");
        $qualifierHash = $qualifierList::qh;
    }
    ;


qualifier
    : Identifier qp=qualifierParameter? flavorList?
    {
        // System.out.println("qualifier: looking up " + $Identifier.text.toLowerCase() + " in qualifierDefinitions");
        qualifierDefinition qqDef = (qualifierDefinition)qualifierDefinitions.get($Identifier.text.toLowerCase());
        if (qqDef == null) {
                RecognitionException r = new RecognitionException(input);
                throw new UndefinedQualifierException(
                    currentInputFileName + "(" + r.line + ":" + r.charPositionInLine + ")" +
                    ": qualifier " + $Identifier.text + " not defined");
        }
        $qualifierList::qh.put(qqDef.name, (qp == null) ? "" : qp.qualifierVal);
    }
    ;


qualifierParameter returns [ Object qualifierVal ]
    : ( LPAREN ( constantValue | stringConstant {retval.qualifierVal = $stringConstant.string;} ) RPAREN )
    | arrayInitializer
    {
        retval.qualifierVal = $arrayInitializer.initList;
    }
    ;


flavorList
    : COLON flavor+
    ;


dataType returns [ StringTemplate defaultVal ]
//  @init {
//      System.out.println("dataType: initializing");
//  }
    : BOOLEAN  { $defaultVal = templateLib.getInstanceOf("booleanDefaultValueTemplate" ); } -> booleanTemplate()
    | CHAR16   { $defaultVal = templateLib.getInstanceOf("char16DefaultValueTemplate"  ); } -> char16Template()
    | DATETIME { $defaultVal = templateLib.getInstanceOf("datetimeDefaultValueTemplate"); } -> datetimeTemplate()
    | REAL32   { $defaultVal = templateLib.getInstanceOf("real32DefaultValueTemplate"  ); } -> real32Template()
    | REAL64   { $defaultVal = templateLib.getInstanceOf("real64DefaultValueTemplate"  ); } -> real64Template()
    | SINT16   { $defaultVal = templateLib.getInstanceOf("sint16DefaultValueTemplate"  ); } -> sint16Template()
    | SINT32   { $defaultVal = templateLib.getInstanceOf("sint32DefaultValueTemplate"  ); } -> sint32Template()
    | SINT64   { $defaultVal = templateLib.getInstanceOf("sint64DefaultValueTemplate"  ); } -> sint64Template()
    | SINT8    { $defaultVal = templateLib.getInstanceOf("sint8DefaultValueTemplate"   ); } -> sint8Template()
    | STRING   { $defaultVal = templateLib.getInstanceOf("strDefaultValueTemplate"     ); } -> strTemplate()
    | UINT16   { $defaultVal = templateLib.getInstanceOf("uint16DefaultValueTemplate"  ); } -> uint16Template()
    | UINT32   { $defaultVal = templateLib.getInstanceOf("uint32DefaultValueTemplate"  ); } -> uint32Template()
    | UINT64   { $defaultVal = templateLib.getInstanceOf("uint64DefaultValueTemplate"  ); } -> uint64Template()
    | UINT8    { $defaultVal = templateLib.getInstanceOf("uint8DefaultValueTemplate"   ); } -> uint8Template()
    ;


array
    : LBRACK IntegralConstant? RBRACK
    ;
    
    
qualifierInitializer
    : constantValue
    | DoubleQuotedString
    ;


initializer returns [ ArrayList<String> initializerList ]
    @init {
        $initializerList = new ArrayList<String>();
        // System.out.println("initializer: called");
    }
    : constantValue
    {
        retval.initializerList.add($constantValue.text);
    }
    | DoubleQuotedString
    {
        retval.initializerList.add($DoubleQuotedString.text);
    }
    | arrayInitializer
    {
        retval.initializerList = $arrayInitializer.initList;
    }
    | cimReferenceInitializer = referenceInitializer
    {
        retval.initializerList.add($cimReferenceInitializer.text);
    }
    ;


arrayInitializer returns [ ArrayList<String> initList]
    @init {
        $initList = new ArrayList<String>();
    }
    : LCURLY  ( c1=constantValue {$initList.add($c1.text);} | s1=stringConstant {$initList.add($s1.string);} )
      ( COMMA ( c2=constantValue {$initList.add($c2.text);} | s2=stringConstant {$initList.add($s2.string);} ) )* RCURLY
    ;


constantValue
//@init {
//  System.out.println("constantValue: called");
//}
    : ( IntegralConstant
        | CharacterConstant
        | TRUE
        | FALSE
        | NULL
      )
    ;


referenceInitializer
    : aliasIdentifier
    ;


stringConstant returns [String string]
    : strs+=DoubleQuotedString+
    {
        StringBuilder retstr = new StringBuilder(list_strs.size() * 60);  // for speed, estimate the initial size 
        ListIterator lstrs = list_strs.listIterator();
        while (lstrs.hasNext()) {
            String dqString = ((Token)lstrs.next()).getText();
            String bareString = dqString.substring(1,dqString.length()-1);  // strip off the leading and trailing double quotes
            bareString = bareString.replaceAll("\\\\'", "'");
            bareString = bareString.replaceAll("\\\\\"", "\"");
            bareString = bareString.replaceAll("\\\\n", "\n");
            retstr.append(bareString);
        }
        retval.string = retstr.toString();
    }
    ;


//==================================================================================================================
// Lexer rules =====================================================================================================
//==================================================================================================================

ANY             : 'any' | 'Any'                         ;
AS              : 'as'                                  ;
BACKSLASH       : '\\'                                  ;
BOOLEAN         : 'boolean' | 'Boolean'                 ;
CHAR16          : 'char16'                              ;
CLASS           : 'class'                               ;
COLON           : ':'                                   ;
COMMA           : ','                                   ;
DATETIME        : 'datetime' | 'dateTime'               ;   
DISABLEOVERRIDE : 'DisableOverride' | 'disableoverride' ;
DOLLAR          : '$'                                   ;
DOUBLEQUOTE     : '"'                                   ;
ENABLEOVERRIDE  : 'EnableOverride'                      ;
EQUALS          : '='                                   ;
FALSE           : 'False' | 'false' | 'FALSE'           ;
FLAVOR          : 'Flavor'                              ;
LBRACK          : '['                                   ;
LCURLY          : '\{'                                  ;
LPAREN          : '('                                   ;
METHOD          : 'Method'                              ;
MINUS           : '-'                                   ;
NULL            : 'null'                                ;
PARAMETER       : 'Parameter'                           ;
PLUS            : '+'                                   ;
PRAGMAINCLUDE   : '#pragma include'                     ;
PRAGMALOCALE    : '#pragma locale'                      ;
PROPERTY        : 'Property'                            ;
QUALIFIER       : 'Qualifier'                           ;
RBRACK          : ']'                                   ;
RCURLY          : '\}'                                  ;
REAL32          : 'real32'                              ;
REAL64          : 'real64'                              ;
REF             : 'REF' | 'ref'                         ;
REFERENCE       : 'Reference'                           ;
RESTRICTED      : 'Restricted'                          ;
RPAREN          : ')'                                   ;
SCOPE           : 'Scope'                               ;
SEMICOLON       : ';'                                   ;
SINGLEQUOTE     : '\''                                  ;
SINT8           : 'sint8'                               ;
SINT16          : 'sint16'                              ;
SINT32          : 'sint32'                              ;
SINT64          : 'sint64'                              ;
SOURCETYPE      : 'Sourcetype'                          ;
STRING          : 'string' | 'String'                   ;
TOSUBCLASS      : 'tosubclass' | 'ToSubclass'           ;
TRANSLATABLE    : 'Translatable'                        ;
TRUE            : 'True' | 'true' | 'TRUE'              ;
UINT8           : 'uint8'                               ;
UINT16          : 'uint16'                              ;
UINT32          : 'uint32'                              ;
UINT64          : 'uint64'                              ;

PragmaInclude
    : PRAGMAINCLUDE WhiteSpace LPAREN f=DoubleQuotedString RPAREN
    {
        String quotedIncludeFileName = f.getText();
        String newIncludeFileName = quotedIncludeFileName.substring(1, quotedIncludeFileName.length()-1);

        // In order to open the new include file, we have to get the current file's directory
        String currentInputFileName = ((ANTLRFileStream)input).getSourceName();
        File currentInputFile = new File(currentInputFileName);
        String currentInputSubDirectory = currentInputFile.getParent();
        String fullCurFileName = "";
        try {
            fullCurFileName = currentInputFile.getCanonicalPath();
        } catch (IOException e) {
            System.out.println("Couldn't get path" + e.getMessage());
            System.exit(1);
        }
        currentInputFile = new File(fullCurFileName);
        currentInputSubDirectory = currentInputFile.getParent();

        String fullNewIncludeFileName = currentInputSubDirectory + '/' + newIncludeFileName;
        
//        System.out.println("PragmaInclude (lexer!): pushing into " + fullNewIncludeFileName);  // dbg

        // This is stolen from the ANTLR Wiki page titled "How do I implement include files?",
        // except that I added better error handling.
        SaveStruct ss = new SaveStruct(input);
        includes.push(ss);
        // switch to the new input stream
        try {
            setCharStream(new ANTLRFileStream(fullNewIncludeFileName));
        } catch(IOException e) {
            RecognitionException r = new RecognitionException(input);
            throw new CantReadIncludeFileException(
                   currentInputFile.getName() + "(" + r.line + ":" + r.charPositionInLine + ")" +
                   ": couldn't read include file " + e.getMessage());
        }
        // We have to call emit here because the call to setCharStream cleared the token stream,
        // which means the parser won't see any tokens from the include statement itself.  The
        // parser needs to see the include statement to learn the name of the input file, in
        // order to create output files in the proper subdirectories.
        emit(new CommonToken(PragmaInclude,newIncludeFileName));
    }
    ;

PragmaLocale
    : PRAGMALOCALE WhiteSpace LPAREN DoubleQuotedString RPAREN
    {
        System.out.println("PragmaLocale: ignoring pragma locale " + $DoubleQuotedString.text);
    }
    ;
        
Identifier
    : ( 'a'..'z' | 'A'..'Z' | '_' ) ( 'a'..'z' | 'A'..'Z' | '_' | '0'..'9' )*
    ;

WhiteSpace
    : ( ' ' | '\t' | '\n' | '\r')+ {$channel=HIDDEN;}
    ;

InlineComment
    : '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    ;

MultiLineComment
    : '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
    ;

CharacterConstant
    : SINGLEQUOTE ( EscapeSequence | ~( '\\' | '\'' ) ) SINGLEQUOTE
    ;

DoubleQuotedString
    : DOUBLEQUOTE ( EscapeSequence | StupidEscapeSequence | ~( '\\' | '"' ) )* DOUBLEQUOTE
    ;

fragment
EscapeSequence
    : BACKSLASH ( 'b' | 't' | 'n' | 'f' | 'r' | DOUBLEQUOTE | SINGLEQUOTE | BACKSLASH)
    | HexEscape
    ;

// I need StupidEscapeSequence to handle an illegality in some CIM source files.
// In the old cimv216.mof file, some of the filenames that appeared in "pragma include"
// statements contained backslashes Microsoft-style path separator characters.  The
// MOF specification says backslashes in strings are escape sequences, so the path
// separators were technically illegal.  Nevertheless, we have to parse the backslashes
// in the filenames as regular characters, so the following hack uses the fact that CIM
// file names happen to start with "C" or "P" to define some special "escape sequences".
// What a stupid problem, and what an inelegant solution.  Sigh.
fragment
StupidEscapeSequence
    : BACKSLASH ( 'C' | 'P' )
    ;

fragment
HexEscape
    : BACKSLASH 'x' HexDigit
    | BACKSLASH 'x' HexDigit HexDigit
    | BACKSLASH 'x' HexDigit HexDigit HexDigit
    | BACKSLASH 'x' HexDigit HexDigit HexDigit HexDigit
    ;

IntegralConstant
    : (MINUS | PLUS)? DecimalConstant
    | BinaryConstant
    | OctalConstant
    | HexConstant
    ;

fragment
DecimalConstant
    : ('0' | '1'..'9' '0'..'9'*) ;

fragment
BinaryConstant
    : ('0' | '1')+ ('b' | 'B')
    ;

fragment
OctalConstant
    : '0' ('0'..'7')+ ;

fragment
HexConstant
    : '0' ('x'|'X') HexDigit+ ;

fragment
HexDigit
    : ('0'..'9'|'a'..'f'|'A'..'F') ;

FloatingPointConstant
    : (MINUS | PLUS)? ('0'..'9')+ '.' ('0'..'9')* Exponent?
    | '.' ('0'..'9')+ Exponent?
    | ('0'..'9')+ Exponent
    ;

fragment
Exponent : ('e'|'E') (MINUS | PLUS)? ('0'..'9')+
    ;

// ===================================================================
// end of file
// ===================================================================
