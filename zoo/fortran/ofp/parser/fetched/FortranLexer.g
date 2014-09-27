lexer grammar FortranLexer;

options {
    tokenVocab=FortranLexer;
}

@header {
/**
 * Copyright (c) 2005, 2006 Los Alamos National Security, LLC.  This
 * material was produced under U.S. Government contract DE-
 * AC52-06NA25396 for Los Alamos National Laboratory (LANL), which is
 * operated by the Los Alamos National Security, LLC (LANS) for the
 * U.S. Department of Energy. The U.S. Government has rights to use,
 * reproduce, and distribute this software. NEITHER THE GOVERNMENT NOR
 * LANS MAKES ANY WARRANTY, EXPRESS OR IMPLIED, OR ASSUMES ANY
 * LIABILITY FOR THE USE OF THIS SOFTWARE. If software is modified to
 * produce derivative works, such modified software should be clearly
 * marked, so as not to confuse it with the version available from
 * LANL.
 *  
 * Additionally, this program and the accompanying materials are made
 * available under the terms of the Eclipse Public License v1.0 which
 * accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */

/**
 *
 * @author Craig E Rasmussen, Christopher D. Rickett, Jeffrey Overbey
 */
 
package fortran.ofp.parser.java;

import java.io.File;
import java.io.IOException;
import java.util.Stack;

import fortran.ofp.parser.java.FortranToken;
}

@members {
    private Token prevToken;
    private int sourceForm;
    private boolean continueFlag;
    private boolean includeLine;
    private boolean inFormat;
    private ArrayList<String> includeDirs;
    private Stack<FortranStream> oldStreams;

    protected StringBuilder whiteText = new StringBuilder();

    public Token emit() {
        int start = state.tokenStartCharIndex;
        int stop = getCharIndex() - 1;
        // TODO - this is a start at fixing the line:column information in tokens inserted
        // by the lexer.  In future the stop should at least be the length of token text.
        if (stop < 0) {
           stop = start; // for now
        }
        FortranToken t = new FortranToken(input, state.type, state.channel, start, stop);
        t.setLine(state.tokenStartLine);
        t.setText(state.text);
        t.setCharPositionInLine(state.tokenStartCharPositionInLine);

        if (state.channel == HIDDEN) {
            whiteText.append(getText());
        } else {
            t.setWhiteText(whiteText.toString());
            whiteText.delete(0, whiteText.length());
        }

        emit(t);
        return t;
    }

    public boolean isKeyword(Token tk) {
       return isKeyword(tk.getType());
    } // end isKeyword()

    public boolean isKeyword(int tokenType) {
        if (tokenType > T_BEGIN_KEYWORDS && tokenType < T_END_KEYWORDS) {
            return true;
        } else {
            return false;
        }
    } // end isKeyword()


    /**
     * This is necessary because the lexer class caches some values from 
     * the input stream.  Here we reset them to what the current input stream 
     * values are.  This is done when we switch streams for including files.
     */    
    private void resetLexerState() {
        state.tokenStartCharIndex = input.index();
        state.tokenStartCharPositionInLine = input.getCharPositionInLine();
        state.tokenStartLine = input.getLine();
        state.token = null;
        state.text = null;
    }// end resetLexerState()


    // overrides nextToken in superclass
   public Token nextToken() {
      Token tk = super.nextToken();

      if (tk.getType() == EOF) {
         Token eofToken;
         FortranStream fs = getInput();

         tk.setChannel(Token.DEFAULT_CHANNEL);
         eofToken = new FortranToken(this.input, T_EOF, Token.DEFAULT_CHANNEL,
                                     this.input.index(), this.input.index()+1);

         if (this.oldStreams != null && this.oldStreams.empty() == false) {

            // TODO - provide better information about the location of this token
            // It is probably ok for it to start at last character position in file but
            // consider the end position of the token.
            eofToken.setLine(state.tokenStartLine);
            eofToken.setCharPositionInLine(state.tokenStartCharPositionInLine);

            eofToken.setText(fs.getFileName() + ":" + fs.getAbsolutePath());

            tk = eofToken;
            /* We have at least one previous input stream on the stack, 
               meaning we should be at the end of an included file.  
               Switch back to the previous stream and continue.  */
            this.input = this.oldStreams.pop();
            /* Is this ok to do??  */
            resetLexerState();
         }
         else {
            tk.setText(fs.getFileName() + ":" + fs.getAbsolutePath());
            eofToken = tk;
         }

         return tk;
      }

        if (tk.getType() != LINE_COMMENT && tk.getType() != WS &&
            tk.getType() != PREPROCESS_LINE) {
           prevToken = tk;
        } 

        if (tk.getType() == T_EOS && continueFlag == true) {
            tk.setChannel(99);
        } else if (continueFlag == true) {
            if (tk.getType() != LINE_COMMENT && tk.getType() != WS &&
                tk.getType() != PREPROCESS_LINE && tk.getType() != CONTINUE_CHAR) {
                // if the token we have is not T_EOS or any kind of WS or 
                // comment, and we have a continue, then this should be the
                // first token on the line folliwng the '&'.  this means that
                // we only have one '&' (no '&' on the second line) and we 
                // need to clear the flag so we know to process the T_EOS.
                continueFlag = false;
            }
        }

        return tk;
    } // end nextToken()


    public int getIgnoreChannelNumber() {
        // return the channel number that antlr uses for ignoring a token
        return 99;
    }// end getIgnoreChannelNumber()

    
   public FortranStream getInput() {
      return (FortranStream) this.input;
   }
    

   /**
    * Do this here because not sure how to get antlr to generate the 
    * init code.  It doesn't seem to do anything with the @init block below.
    * This is called by FortranMain().
    */
   public FortranLexer(FortranStream input)
   {
      super(input);
      this.sourceForm = input.getSourceForm();
      this.prevToken = null;
      this.continueFlag = false;
      this.includeLine = false;
      this.inFormat = false;
      this.oldStreams = new Stack<FortranStream>();
   } // end constructor()


    public void setIncludeDirs(ArrayList<String> includeDirs) {
        this.includeDirs = includeDirs;
    }// end setIncludeDirs()

    
    private File findFile(String fileName) {
        File tmpFile;
        String tmpPath;
        StringBuffer newFileName;
        
        tmpFile = new File(fileName);
        if(tmpFile.exists() == false) {
            /* the file doesn't exist by the given name from the include line, 
             * so we need to append it to each include dir and search.  */
            for(int i = 0; i < this.includeDirs.size(); i++) {
                tmpPath = this.includeDirs.get(i);

                newFileName = new StringBuffer();

                /* Build the new file name with the path.  Add separator to 
                 * end of path if necessary (unix specific).  */
                newFileName = newFileName.append(tmpPath);
                if(tmpPath.charAt(tmpPath.length()-1) != '/') {
                    newFileName = newFileName.append('/');
                }
                newFileName = newFileName.append(fileName);

                /* Try opening the new file.  */
                tmpFile = new File(newFileName.toString());
                if(tmpFile.exists() == true) {
                    return tmpFile;
                }
            }

            /* File did not exist.  */
            return null;
        } else {
            return tmpFile;
        }
    } // end findFile()


    private String includeFile() {
        String filename = "ERROR: no file name";
        File includedFile = null;

        if (prevToken != null) {
            String charConst = null;
            FortranStream includedStream = null;

            charConst = prevToken.getText();
            filename = charConst.substring(1, charConst.length()-1);

            /* Find the file, including it's complete path.  */
            includedFile = findFile(filename);
            if (includedFile == null) {
                System.err.println("WARNING: Could not find file '" + filename + "'");
                return filename + ":ERROR_FILE_NOT_FOUND";
            }

            /* Create a new stream for the included file.  */
            try {
               // the included file should have the save source form as original
               includedStream = new FortranStream(filename, includedFile.getAbsolutePath(), this.sourceForm);
            } catch(IOException e) {
                System.err.println("WARNING: Could not open file '" + filename + "'");
                e.printStackTrace();
                return includedFile.getAbsolutePath();
            }
            
            /* Save current character stream.  */
            oldStreams.push(getInput());
            this.input = includedStream;
            /* Is this ok to do??  */
            resetLexerState();
        } else {
            System.err.println("ERROR: Unable to determine file name from " + 
                               "include line");
        }

        return filename + ":" + includedFile.getAbsolutePath();

    } // end includeFile()

}

@init {
    prevToken = null;
}

/*
 * Lexer rules
 */

/* 
 * Note: antlr sometimes has LL(*) failures with the grammars, but not always.
 * it seems that it may be the timeout issue that was mentioned..
 */

// Support for language extension points
T_NO_LANGUAGE_EXTENSION : {false}? 'no extension' ;   // can't be recognized


T_EOS 
@after {
    // Throw away T_EOS if at beginning of file or after an include,
    // T_EOS processing by the parser only works after the first statement so
    // any blank lines before statements in a file must be hidden.
    if (prevToken == null) {
        state.channel = HIDDEN;
    } else if (prevToken.getType() == T_EOS || prevToken.getType() == T_INCLUDE_NAME) {
        state.channel = HIDDEN;
    } 

    if (includeLine) {
        // Part of include file handling.
        state.text = includeFile();
        state.type = T_INCLUDE_NAME;
        includeLine = false;
    }

    // Make sure we clear the flag saying we're in a format-stmt
    inFormat = false;
}
      : ';' 
      |  ('\r')? ('\n')
      ;
                

/* if this is a fragment, the generated code never seems to execute the
 * action.  the action needs to set the flag so T_EOS knows whether it should
 * be channel 99'ed or not (ignore T_EOS if continuation is true, which is the
 * case of the & at the end of a line).
 */
CONTINUE_CHAR : '&' {
            continueFlag = !continueFlag;
            $channel = HIDDEN;
        }
              ;


// R427 from char-literal-constant
T_CHAR_CONSTANT
        : ('\'' ( SQ_Rep_Char )* '\'')+ { 
            if (includeLine) 
                $channel = HIDDEN;
        }
        | ('\"' ( DQ_Rep_Char )* '\"')+ { 
            if (includeLine) 
                $channel = HIDDEN;
        }
        ;

T_DIGIT_STRING
	:	Digit_String 
	;

// R412
BINARY_CONSTANT
    : ('b'|'B') '\'' ('0'..'1')+ '\''
    | ('b'|'B') '\"' ('0'..'1')+ '\"'
    ;

// R413
OCTAL_CONSTANT
    : ('o'|'O') '\'' ('0'..'7')+ '\''
    | ('o'|'O') '\"' ('0'..'7')+ '\"'
    ;

// R414
HEX_CONSTANT
    : ('z'|'Z') '\'' (Digit|'a'..'f'|'A'..'F')+ '\''
    | ('z'|'Z') '\"' (Digit|'a'..'f'|'A'..'F')+ '\"'
    ;


WS  :  (' '|'\r'|'\t'|'\u000C') {
            $channel = HIDDEN;
       }
    ;

/*
 * fragments
 */

// R409 digit_string
fragment
Digit_String : Digit+  ;


// R302 alphanumeric_character
fragment
Alphanumeric_Character : Letter | Digit | '_' ;

fragment
Special_Character
    :    ' ' .. '/' 
    |    ':' .. '@' 
    |    '[' .. '^' 
    |    '`' 
    |    '{' .. '~' 
    ;

fragment
Rep_Char : ~('\'' | '\"') ;

fragment
SQ_Rep_Char : ~('\'') ;
fragment
DQ_Rep_Char : ~('\"') ;

fragment
Letter : ('a'..'z' | 'A'..'Z') ;

fragment
Digit : '0'..'9'  ;

PREPROCESS_LINE : '#' ~('\n'|'\r')*  {
            $channel = HIDDEN;
        } ;

T_INCLUDE 
options {k=1;} : 'INCLUDE' {
            includeLine = true;
        };


/*
 * from fortran03_lexer.g
 */

T_ASTERISK      : '*'   ;
T_COLON         : ':'   ;
T_COLON_COLON   : '::'  ;
T_COMMA         : ','   ;
T_EQUALS        : '='   ;
T_EQ_EQ         : '=='  ;
T_EQ_GT         : '=>'  ;
T_GREATERTHAN   : '>'   ;
T_GREATERTHAN_EQ: '>='  ;
T_LESSTHAN      : '<'   ;
T_LESSTHAN_EQ   : '<='  ;
T_LBRACKET      : '['   ;
T_LPAREN        : '('   ;
T_MINUS         : '-'   ;
T_PERCENT       : '%'   ;
T_PLUS          : '+'   ;
T_POWER         : '**'  ;
T_SLASH         : '/'   ;
T_SLASH_EQ      : '/='  ;
T_SLASH_SLASH   : '//'  ;
T_RBRACKET      : ']'   ;
T_RPAREN        : ')'   ;
T_UNDERSCORE    : '_'   ;

// begin Rice additions --------------------------
T_AT			      : '@'   ;
// end Rice additions ----------------------------

T_EQ            : '.EQ.' ;
T_NE            : '.NE.' ;
T_LT            : '.LT.' ;
T_LE            : '.LE.' ;
T_GT            : '.GT.' ;
T_GE            : '.GE.' ;

T_TRUE          : '.TRUE.'  ;
T_FALSE         : '.FALSE.' ;

T_NOT           : '.NOT.' ;
T_AND           : '.AND.' ;
T_OR            : '.OR.'  ;
T_EQV           : '.EQV.' ;
T_NEQV          : '.NEQV.';

T_PERIOD_EXPONENT 
    : '.' ('0'..'9')+ ('E' | 'e' | 'd' | 'D') ('+' | '-')? ('0'..'9')+  
    | '.' ('E' | 'e' | 'd' | 'D') ('+' | '-')? ('0'..'9')+  
    | '.' ('0'..'9')+
    | ('0'..'9')+ ('e' | 'E' | 'd' | 'D') ('+' | '-')? ('0'..'9')+ 
    ;

T_PERIOD        : '.' ;

// begin keyword section (all keywords must appear between
// T_BEGIN_KEYWORDS and T_END_KEYWORDS)
// 
T_BEGIN_KEYWORDS: '__BEGIN_KEYWORDS__';

T_INTEGER       :       'INTEGER'       ;
T_REAL          :       'REAL'          ;
T_COMPLEX       :       'COMPLEX'       ;
T_CHARACTER     :       'CHARACTER'     ;
T_LOGICAL       :       'LOGICAL'       ;

T_ABSTRACT      :       'ABSTRACT'      ;
T_ACQUIRED_LOCK :       'ACQUIRED_LOCK' ;   /* F2008 token */
T_ALL           :       'ALL'           ;   /* F2008 token (also in F2003?) */
T_ALLOCATABLE   :       'ALLOCATABLE'   ;
T_ALLOCATE      :       'ALLOCATE'      ;
T_ASSIGNMENT    :       'ASSIGNMENT'    ;
// ASSIGN statements are a deleted feature.
T_ASSIGN        :       'ASSIGN'        ;
T_ASSOCIATE     :       'ASSOCIATE'     ;
T_ASYNCHRONOUS  :       'ASYNCHRONOUS'  ;
T_BACKSPACE     :       'BACKSPACE'     ;
T_BLOCK         :       'BLOCK'         ;
T_BLOCKDATA     :       'BLOCKDATA'     ;
T_CALL          :       'CALL'          ;
T_CASE          :       'CASE'          ;
T_CLASS         :       'CLASS'         ;
T_CLOSE         :       'CLOSE'         ;
T_CODIMENSION   :       'CODIMENSION'   ;
T_COMMON        :       'COMMON'        ;
T_CONCURRENT    :       'CONCURRENT'    ;
T_CONTAINS      :       'CONTAINS'      ;
T_CONTIGUOUS    :       'CONTIGUOUS'    ;
T_CONTINUE      :       'CONTINUE'      ;
T_CRITICAL      :       'CRITICAL'      ;
T_CYCLE         :       'CYCLE'         ;
T_DATA          :       'DATA'          ;
T_DEFAULT       :       'DEFAULT'       ;
T_DEALLOCATE    :       'DEALLOCATE'    ;
T_DEFERRED      :       'DEFERRED'      ;
T_DO            :       'DO'            ;
T_DOUBLE        :       'DOUBLE'        ;
T_DOUBLEPRECISION:      'DOUBLEPRECISION' ;
T_DOUBLECOMPLEX:        'DOUBLECOMPLEX' ;
T_ELEMENTAL     :       'ELEMENTAL'     ;
T_ELSE          :       'ELSE'          ;
T_ELSEIF        :       'ELSEIF'        ;
T_ELSEWHERE     :       'ELSEWHERE'     ;
T_ENTRY         :       'ENTRY'         ;
T_ENUM          :       'ENUM'          ;
T_ENUMERATOR    :       'ENUMERATOR'    ;
T_ERROR         :       'ERROR'         ;
T_EQUIVALENCE   :       'EQUIVALENCE'   ;
T_EXIT          :       'EXIT'          ;
T_EXTENDS       :       'EXTENDS'       ;
T_EXTERNAL      :       'EXTERNAL'      ;
T_FILE          :       'FILE'          ;
T_FINAL         :       'FINAL'         ;
T_FLUSH         :       'FLUSH'         ;
T_FORALL        :       'FORALL'        ;
T_FORMAT        :       'FORMAT'        { inFormat = true; };
T_FORMATTED     :       'FORMATTED'     ;
T_FUNCTION      :       'FUNCTION'      ;
T_GENERIC       :       'GENERIC'       ;
T_GO            :       'GO'            ;
T_GOTO          :       'GOTO'          ;
T_IF            :       'IF'            ;
T_IMAGES        :       'IMAGES'        ;
T_IMPLICIT      :       'IMPLICIT'      ;
T_IMPORT        :       'IMPORT'        ;
T_IMPURE        :       'IMPURE'        ;
T_IN            :       'IN'            ;
T_INOUT         :       'INOUT'         ;
T_INTENT        :       'INTENT'        ;
T_INTERFACE     :       'INTERFACE'     ;
T_INTRINSIC     :       'INTRINSIC'     ;
T_INQUIRE       :       'INQUIRE'       ;
T_LOCK          :       'LOCK'          ;   /* F2008 token */
T_MEMORY        :       'MEMORY'        ;
T_MODULE        :       'MODULE'        ;
T_NAMELIST      :       'NAMELIST'      ;
T_NONE          :       'NONE'          ;
T_NON_INTRINSIC :       'NON_INTRINSIC' ;
T_NON_OVERRIDABLE:      'NON_OVERRIDABLE';
T_NOPASS        :       'NOPASS'        ;
T_NULLIFY       :       'NULLIFY'       ;
T_ONLY          :       'ONLY'          ;
T_OPEN          :       'OPEN'          ;
T_OPERATOR      :       'OPERATOR'      ;
T_OPTIONAL      :       'OPTIONAL'      ;
T_OUT           :       'OUT'           ;
T_PARAMETER     :       'PARAMETER'     ;
T_PASS          :       'PASS'          ;
T_PAUSE         :       'PAUSE'         ;
T_POINTER       :       'POINTER'       ;
T_PRINT         :       'PRINT'         ;
T_PRECISION     :       'PRECISION'     ;
T_PRIVATE       :       'PRIVATE'       ;
T_PROCEDURE     :       'PROCEDURE'     ;
T_PROGRAM       :       'PROGRAM'       ;
T_PROTECTED     :       'PROTECTED'     ;
T_PUBLIC        :       'PUBLIC'        ;
T_PURE          :       'PURE'          ;
T_READ          :       'READ'          ;
T_RECURSIVE     :       'RECURSIVE'     ;
T_RESULT        :       'RESULT'        ;
T_RETURN        :       'RETURN'        ;
T_REWIND        :       'REWIND'        ;
T_SAVE          :       'SAVE'          ;
T_SELECT        :       'SELECT'        ;
T_SELECTCASE    :       'SELECTCASE'    ;
T_SELECTTYPE    :       'SELECTTYPE'    ;
T_SEQUENCE      :       'SEQUENCE'      ;
T_STOP          :       'STOP'          ;
T_SUBMODULE     :       'SUBMODULE'     ;
T_SUBROUTINE    :       'SUBROUTINE'    ;
T_SYNC          :       'SYNC'          ;   /* F2008 token */
T_TARGET        :       'TARGET'        ;
T_THEN          :       'THEN'          ;
T_TO            :       'TO'            ;
T_TYPE          :       'TYPE'          ;
T_UNFORMATTED   :       'UNFORMATTED'   ;
T_UNLOCK        :       'UNLOCK'        ;   /* F2008 token */
T_USE           :       'USE'           ;
T_VALUE         :       'VALUE'         ;
T_VOLATILE      :       'VOLATILE'      ;
T_WAIT          :       'WAIT'          ;
T_WHERE         :       'WHERE'         ;
T_WHILE         :       'WHILE'         ;
T_WRITE         :       'WRITE'         ;

// begin Rice additions --------------------------
T_WITHTEAM      :       'WITHTEAM'      ;
T_WITH          :       'WITH'          ;
T_TEAM          :       'TEAM'          ;
T_TOPOLOGY      :       'TOPOLOGY'      ;
T_EVENT         :       'EVENT'         ;
T_LOCKSET       :       'LOCKSET'       ;
T_FINISH        :       'FINISH'        ;
T_SPAWN         :       'SPAWN'         ;
T_COPOINTER     :       'COPOINTER'     ;
T_COTARGET      :       'COTARGET'      ;
// end Rice additions ----------------------------

// begin LOPe additions --------------------------
T_HALO          :       'HALO'          ;
T_COPY_FN       :       'COPY_FN'       ;
T_BOUNDARY      :       'BOUNDARY'      ;
T_CYCLIC        :       'CYCLIC'        ;
T_EXCHANGE_HALO :       'EXCHANGE_HALO' ;
// end LOPe additions ----------------------------

// these tokens (without blank characters) are from 3.3.2.2
//

T_ENDASSOCIATE  :       'ENDASSOCIATE'  ;
T_ENDBLOCK      :       'ENDBLOCK'      ;
T_ENDBLOCKDATA  :       'ENDBLOCKDATA'  ;
T_ENDCRITICAL   :       'ENDCRITICAL'   ;
T_ENDDO         :       'ENDDO'         ;
T_ENDENUM       :       'ENDENUM'       ;
T_ENDFILE       :       'ENDFILE'       ;
T_ENDFORALL     :       'ENDFORALL'     ;
T_ENDFUNCTION   :       'ENDFUNCTION'   ;
T_ENDIF         :       'ENDIF'         ;
T_ENDMODULE     :       'ENDMODULE'     ;
T_ENDINTERFACE  :       'ENDINTERFACE'  ;
T_ENDPROCEDURE  :       'ENDPROCEDURE'  ;
T_ENDPROGRAM    :       'ENDPROGRAM'    ;
T_ENDSELECT     :       'ENDSELECT'     ;
T_ENDSUBMODULE  :       'ENDSUBMODULE'  ;
T_ENDSUBROUTINE :       'ENDSUBROUTINE' ;
T_ENDTYPE       :       'ENDTYPE'       ;
T_ENDWHERE      :       'ENDWHERE'      ;

T_END   : 'END'
        ;

T_DIMENSION     :       'DIMENSION'     ;

T_KIND : 'KIND' ;
T_LEN  : 'LEN' ;

T_BIND : 'BIND' ;

// End keyword section (all keywords must appear between
// T_BEGIN_KEYWORDS and T_END_KEYWORDS)
// 
T_END_KEYWORDS : '__END_KEYWORDS__';

//
// Note: Hollerith constants were deleted in F77; Hollerith edit descriptors
// deleted in F95.
//
T_HOLLERITH : Digit_String 'H' 
    { 
        // If we're inside a format stmt we don't want to process it as 
        // a Hollerith constant because it's most likely an H-edit descriptor. 
        // However, the H-edit descriptor needs processed the same way both 
        // here and in the prepass.
        StringBuffer hollConst = new StringBuffer();
        int count = Integer.parseInt($Digit_String.text);

        for(int i = 0; i < count; i++) 
           hollConst = hollConst.append((char)input.LA(i+1));
        for(int i = 0; i < count; i++)
           // consume the character so the lexer doesn't try matching it.
           input.consume();
    };

// Must come after .EQ. (for example) or will get matched first
// TODO:: this may have to be done in the parser w/ a rule such as:
// T_PERIOD T_IDENT T_PERIOD
T_DEFINED_OP
    :    '.' Letter+ '.'
    ;

// // used to catch edit descriptors and other situations
// T_ID_OR_OTHER
// 	:	'ID_OR_OTHER'
// 	;

// extra, context-sensitive terminals that require communication between parser and scanner
// added the underscores so there is no way this could overlap w/ any valid
// idents in Fortran.  we just need this token to be defined so we can 
// create one of them while we're fixing up labeled do stmts.

T_LABEL_DO_TERMINAL : '__LABEL_DO_TERMINAL__' ;
T_LABEL_DO_TERMINAL_INSERTED : '__T_LABEL_DO_TERMINAL_INSERTED__' ;

T_DATA_EDIT_DESC : '__T_DATA_EDIT_DESC__' ;
T_CONTROL_EDIT_DESC : '__T_CONTROL_EDIT_DESC__' ;
T_CHAR_STRING_EDIT_DESC : '__T_CHAR_STRING_EDIT_DESC__' ;

T_STMT_FUNCTION : 'STMT_FUNCTION' ;

T_ASSIGNMENT_STMT : '__T_ASSIGNMENT_STMT__' ;
T_PTR_ASSIGNMENT_STMT : '__T_PTR_ASSIGNMENT_STMT__' ;
T_ARITHMETIC_IF_STMT : '__T_ARITHMETIC_IF_STMT__' ;
T_ALLOCATE_STMT_1 : '__T_ALLOCATE_STMT_1__' ;
T_WHERE_STMT : '__T_WHERE_STMT__' ;
T_IF_STMT : '__T_IF_STMT__' ;
T_FORALL_STMT : '__T_FORALL_STMT__' ;
T_WHERE_CONSTRUCT_STMT : '__T_WHERE_CONSTRUCT_STMT__' ;
T_FORALL_CONSTRUCT_STMT : '__T_FORALL_CONSTRUCT_STMT__' ;
T_INQUIRE_STMT_2 : '__T_INQUIRE_STMT_2__' ;
// text for the real constant will be set when a token of this type is 
// created by the prepass.
T_REAL_CONSTANT : '__T_REAL_CONSTANT__' ; 

T_INCLUDE_NAME: '__T_INCLUDE_NAME__' ;
T_EOF: '__T_EOF__' ;

// R304
T_IDENT
options {k=1;}
	:	Letter ( Alphanumeric_Character )*
	;

//
// Used in format-item processing.  This token is replaced by an edit
// descriptor in the prepass (by FortranLexicalPrepass).  It doesn't really
// matter what this token contains because the format string is parsed
// as a string in the lexical prepass.  The goal is to keep the lexer from
// bombing on strings like 2es15.6 and also not interfer with real literal
// constants and Holleriths.
//
T_EDIT_DESC_MISC
   :   Digit_String
          ( ('e'|'E') (('n'|'N') | ('s'|'S')) )
          ( Alphanumeric_Character )*
   ;

LINE_COMMENT
    : '!'  ~('\n'|'\r')*  
        {
            $channel = HIDDEN;
        }
    ;

/* Need a catch-all rule because of fixed-form being allowed to use any 
   character in column 6 to designate a continuation.  */
MISC_CHAR : ~('\n' | '\r') ;

