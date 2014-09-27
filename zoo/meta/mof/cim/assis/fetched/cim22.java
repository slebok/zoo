// =====================================================================
// Title: CIM v2.2(2) parser.
// Filename: cim22.java
// Version: 0.2
// Revision: 0
// Date: 2001.12
//
// Description: cim22 class provides the means to run tests based on the 
// cim22Grammar, an EBNF grammar, developed using ANTLR 2.7.1 (it should
// run under 2.6.0) to parse CIM v2.2(2) (CIM V2.2, 14.06.99, plus 
// Addenda 02) based MOF files. Both files enable the syntax check of 
// v2.4/5/6 CIM models files.
//
// =====================================================================
// Author:  Pedro Assis
// Contact: passis@dee.isep.ipp.pt
// =====================================================================
// History: 
//    2000.11 version 0.1
//			- Basic support for Lexer and parser test.
//    2001.12 version 0.2
//			- Include exception handling.
//						
// =====================================================================
//
// A note on text formatting for better display
// 1) Use Tab stop every 2 characters,
// 2) Text wrapping at column 72 (each line should be 72 characters 
// long.

// antlr 2.x imports
import antlr.collections.*;

// antlr 2.7.1
//
import antlr.RecognitionException;
import antlr.TokenStreamException;

// antlr 2.6.0
//
// import antlr.ParserException;

// Other imports
//
import java.io.*;

/**
	*	@author Pedro Assis
	*	
	*	@author passis@dee.isep.ipp.pt 2000.11
	* @author passis@dee.isep.ipp.pt 2001.12
	*	@version 0.2
	*	@since 0.1
	*/
class cim22 {
  // Dcl of local variables
  //
  private final static boolean STATS_TO_SCREEN = true;
  private final static boolean STATS_TO_FILE = false;
	private static String inputFileName = null;
  private static final int OK = 0;
  private static final int NOT_OK = 1;


  // Dcl of global control variables
  //
	public static boolean lexerRuleTrace = false;
	public static boolean parserRuleTrace = false;
	public static boolean mofElementTrace = false;
	public static int parserTraceLine = 0;
	public static int lexerTraceLine = 0;
	public static int mofElementTraceLine = 0;
	public static int parserErrorLine = 0;
	public static PrintStream mofOut = null;
	public static String parsingMofFileName = new String ();

	/**
    * Program usage.
   	*	@since 0.1
    */
  public static void programUsage () {
    System.out.println("CIM Specification V2.2 Parser Tool, by"
    + " Pedro Assis 2000-01\n");
    System.out.println ("\ncim22 usage\n\tjava cim22 <mof file>/"
		+ "<mof directory>\n\t-lt {lexer rule trace flag}\n\t-pt"
		+ " {parser rule trace flag}\n\t-ct {content trace flag}\n");
  }// public void program usage ()

  /**
    * Stats footprint.
    *	@since 0.1
    */
  public static void statsFootprint (boolean statsToOutput) {
    if (statsToOutput) {
      // Put it on screen.
      //
      System.out.println ("\nTotal parsed MOF elements.. " 
			+ mofElementTraceLine);
      System.out.println ("Total parser rules checked. " 
			+ parserTraceLine);
      System.out.println ("Total lexer rules checked.. " 
      + lexerTraceLine);
      System.out.println ("Total parsing errors....... " 
      + parserErrorLine + "\n");
			if (parserErrorLine == 0)
	      System.out.println ("Parsing file(s) successful!\n");
			else
	      System.out.println ("Edit the output files (p_<file name>) for"
	      + " parsing errors (\"Parsing ERROR...\") \n");
    }// if
    else {
      // Store this in the output file
      //
      cim22.mofOut.println ("\nTotal parsed MOF elements.. "
      + mofElementTraceLine);
      cim22.mofOut.println ("Total parser rules checked. "
      + parserTraceLine);
      cim22.mofOut.println ("Total lexer rules checked.. " 
      + lexerTraceLine + "\n");
      cim22.mofOut.println ("Total parsing errors....... " 
      + parserErrorLine + "\n");
			if (parserErrorLine == 0)
	      cim22.mofOut.println ("Parsing file(s) successful!\n");
			else
	      cim22.mofOut.println ("Edit the output files (p_<file name>) "
	      + "for parsing errors (\"Parsing ERROR...\") \n");
    }// else
  }// public static void statsFootprint ()

  /**
		* Process single MOF files or set of files - directory.
		* @param f MOF File name 
		* @exception Error on creating file input stream
		*	@since 0.1
		*/
	public static void doFile (File f) throws Exception {
		// If this is a directory, walk each file/dir in that directory
		//
		if (f.isDirectory()) {
			String files[] = f.list();
			for (int i=0; i < files.length; i++)
				doFile(new File(f, files[i]));
		} // if

		// otherwise, if this is a mof file, parse it!
		//
		else if ((f.getName().length()>4) &&
				f.getName().substring(f.getName().length()-4).equals(".mof")) {
			System.err.println("JustGo: " + f.getAbsolutePath());
			FileInputStream mofIn = new FileInputStream (f);
			scannerFile (f.getName(), f.getParent(), mofIn);
			mofIn.close ();
		} // else 
	} // public static void doFile (File) throws Exception

  /**
		* Parse a given MOF specification (file).
		* @param f MOF file name
		* @param pf MOF file parent directory
		* @param mofIn Input stream 
		* @exception Error on parsing the input stream (Antlr errors)
		*	@since 0.1
		*/
	public static void scannerFile(String f, String pf, InputStream mofIn)
	throws Exception {
		String fileName = null;
	  File outputFile = null;
	  
		cim22Lexer lexer = new cim22Lexer (mofIn);
	  if (pf != null)
	    fileName = new String (pf + "\\p_" + f + ".txt");
	  else
	    fileName = new String ("\\p_" + f);
		mofOut = new PrintStream (new BufferedOutputStream ( 
		new FileOutputStream (fileName)));
		cim22Parser parser = new cim22Parser (lexer);
		try {
			parser.mofSpecification();
		} // try
		catch(TokenStreamException ex) {
			++parserErrorLine;
			mofOut.println ("Parsing ERROR trace\t#" + parserErrorLine 
			+ "\t: Source file, " + ex);
			ex.printStackTrace(mofOut);   // so we can get stack trace
		} // catch
		catch(RecognitionException ex) {
			++parserErrorLine;
			mofOut.println ("Parsing ERROR trace\t#" + parserErrorLine 
			+ "\t: Source file, " + ex);
			ex.printStackTrace(mofOut);   // so we can get stack trace
		} // catch
// Antlr 2.6.0
//
//		catch (IOException ex) {
//			++parserErrorLine;
//			mofOut.println ("Parsing ERROR trace\t#" + parserErrorLine
//			+ "\t: Source file, " + ex);
//			ex.printStackTrace(mofOut);   // so we can get stack trace
//		}
//		catch(ParserException ex) {
//			++parserErrorLine;
//			mofOut.println ("Parsing ERROR trace\t#" + parserErrorLine 
//			+ "\t: Source file, " + ex);
//			ex.printStackTrace(mofOut);   // so we can get stack trace
//		}
		mofOut.close (); // finalize() not reliable!
		try {
  		outputFile = new File (fileName);
	  	if (outputFile.length () == 0)
		    outputFile.delete ();
		} // try
		catch (SecurityException ex) {
			System.err.println ("System ERROR: Can not access " + fileName
			+ "file \n" + ex);
			ex.printStackTrace(System.err);   // so we can get stack trace
		} // catch
		
	} // public static void scannerFile (String, InputStream) throws
		// Exception

  /**
		* Yep, at last this is the main... ;)
		* @param Standard main args
		* @exception Consume exceptions from all the Classes, methods, ...
		*	@since 0.1
		*/
	public static void main(String[] args) throws Exception {
	  File f = null;
	  
		try {
			if ((args.length > 4) || (args.length < 1)) {
			  programUsage ();
	      System.exit (NOT_OK);
      }// if
			else {
        for (int i = 1; i < args.length; i++) {
				  if (args[i].compareTo ("-lt") == 0)
					  lexerRuleTrace = true;
				  else {
            if (args[i].compareTo ("-pt") == 0)
					    parserRuleTrace = true;
            else {
              if (args[i].compareTo ("-ct") == 0)
                mofElementTrace = true;
              else {
                programUsage ();
                System.exit (NOT_OK);
              }// else
            }// else
          }// else
        }// for
				inputFileName = args[0];
				f = new File(args[0]);
				if (f.exists())
  				doFile (f);
  			else {
  			    System.out.println("CIM Specification V2.2 Parser Tool, by"
            + " Pedro Assis 2000-01\n");
            System.out.println(args[0] + " no such file/directory!");
        }// else
			}// else
 		}// try
		catch(Exception ex) {
			++parserErrorLine;
			mofOut.println ("Parsing ERROR trace\t#" + parserErrorLine 
			+ "\t: Source file, " + ex);		
			ex.printStackTrace (mofOut); // so we can get stack trace
		}// catch
  
  	// Well, by default to the screen.
  	//
  	if (f.exists ())
      statsFootprint (STATS_TO_SCREEN);
	}// public static void main (String []) throws Exception
}// public class cim22
// ===================================================================
// end of file
// ===================================================================
