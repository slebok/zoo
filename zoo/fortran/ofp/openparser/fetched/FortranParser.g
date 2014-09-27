//
// TODO:
//   1. Fix lexer so that the single quote "'" character can be in the text
//   2. Fix to work without a program_stmt (just an end_program_stmt). DONE.
//   3. Implement CheckForIncludes
//   4. Implememt error handling
//

parser grammar FortranParser;

options {
   language=C;
   tokenVocab=FortranLexer;

   // If generating AST or a tree walker...
   //
   output=AST;
   ASTLabelType=pANTLR3_BASE_TREE;
}

tokens {
   // Imaginary nodes for intermediate processing
   //
   OFPAssignmentStmt;
   OFPAttrSpec;
   OFPBind;
   OFPCharSelector;
   OFPComment;
   OFPCommentList;
   OFPDataRef;
   OFPDeclarationConstruct;
   OFPDeclarationConstructList;
   OFPDeclarationTypeSpec;
   OFPDesignator;
   OFPEntityDeclList;
   OFPExecutionPart;
   OFPExecutablePartConstructList;
   OFPExpr;
   OFPGenericSpec;
   OFPImplicitPart;
   OFPImportStmtList;
   OFPIntentIn;
   OFPIntentInOut;
   OFPIntentOut;
   OFPInternalSubprogramPart;
   OFPInterfaceStmt;
   OFPEndInterfaceStmt;
   OFPIntLiteralConstant;
   OFPIntrinsicTypeSpec;
   OFPKindParam;
   OFPKindSelector;
   OFPLabel;
   OFPList;
   OFPMainProgram;
   OFPModule;
   OFPModuleName;
   OFPModuleNature;
   OFPModuleStmt;
   OFPEndModuleStmt;
   OFPName;
   OFPObjectName;
   OFPOnlyList;
   OFPOptional;
   OFPPartRef;
   OFPPartRefList;
   OFPPrefixList;
   OFPProgramName;
   OFPProgramStmt;
   OFPEndProgramStmt;
   OFPRenameList;
   OFPSpecificationPart;
   OFPSuffix;
   OFPTypeDeclarationStmt;
   OFPUnimplemented;
   OFPUseStmt;
   OFPUseStmtList;
   OFPVariable;

// TODO - make go away
   OFPBeginStmt;
   OFPEndStmt;

   OFPKindSelector;      
   OFPCharSelector;
   OFPLengthSelector;

//   OFPFunctionSubprogram;
//   OFPSubroutineSubprogram;
//   OFPModule;
   OFPSubmodule;
   OFPBlockData;

   // Sage nodes
   //
   SgSourceFile;
   SgGlobal;
   SgProcedureHeaderStatement;

   SgClassDefinition;

   SgFunctionParameterList;
   SgFunctionDefinition;
   SgFunctionDeclaration;
   SgInitializedName;

   SgImplicitStatement;

   SgBasicBlock;

   OFPTypeLogical;
   OFPTypeInteger;
   OFPTypeReal;
   OFPTypeDouble;
   OFPTypeComplex;
   OFPTypeDComplex;     // TODO - what is the real OFPType?
   OFPTypeCharacter;
}

/*
 * This is the header for the Java target.
 */
///@header {
///package fortran.ofp.parser.java;
///}

@members {

#include "ofpbase.h"
#include "../parser/c/ActionEnums.h"
#include "OFPFrontEnd.h"
#include    <stdio.h>

/* Remove prefix necessary for Java target
 */
#define IActionEnums_ 

/* Macro for java error message
 *  TODO - FIXME
 */
#define SYSTEM_ERR_PRINT(msg)

/* Global variables for counting items.
 */
int gCount1;
int gCount2;

/* TODO - IMPLEMENT_ME
 */
void checkForInclude() {return;}


/* These are the members for the Java target.
 */
///JAVA
///JAVA   public void initialize(String[] args, String kind, String filename, String path)
///JAVA   {
///JAVA      action = FortranParserActionFactory.newAction(args, this, kind, filename);
///JAVA      initialize(this, action, filename, path);
///JAVA      action.start_of_file(filename, path);
///JAVA   }
///JAVA
///JAVA   public void eofAction()
///JAVA   {
///JAVA      action.end_of_file(filename, pathname);
///JAVA   }

static ANTLR3_BOOLEAN
hasPayload(pANTLR3_BASE_TREE tree)
{
   if (tree->getChildCount(tree) < 1) return ANTLR3_FALSE;
   else                               return ANTLR3_TRUE;
}


/** Set the token boundaries for the child at childIndex of tree.
 *  If childIndex is < 0, set the token boundaries on the tree itself.
 */
static void
treeSetTokenBoundaries(pANTLR3_BASE_TREE     tree,
                       pANTLR3_COMMON_TOKEN  start,
                       pANTLR3_COMMON_TOKEN  stop,
                       int                   childIndex
                      )
{
   pANTLR3_BASE_TREE child;
   pOFP_BASE_RTN ss;
   if (childIndex < 0) {
      /* This is the root of a tree node, make sure it's not empty. */
      if (tree->getChildCount(tree) < 1) {
         const char * text = tree->getText(tree)->chars;
         printf("treeSetTokenBoundaries: root with no children: \%s\n", text);
         return;
      }
      child = tree;
   }
   else {
      child = tree->getChild(tree, childIndex);
   }
   ss = (pOFP_BASE_RTN) malloc(sizeof(OFP_BASE_RTN));
   ss->start = start;  ss->stop = stop;
   child->u = ss;
}

/** Set the token boundaries for a list at childIndex of tree.
 */
static void
treeSetListBoundaries(pANTLR3_BASE_TREE tree, int childIndex)
{
   int                count;
   pANTLR3_BASE_TREE  child = tree->getChild(tree, childIndex);

   if (child == NULL) {
      printf("treeSetListBoundaries: child is NULL, tree==\%s\n", tree->getText(tree)->chars);
      return;
   }

   count = child->getChildCount(child);
   if (count > 0) {
      pANTLR3_BASE_TREE  start = child->getChild(child, 0);
      pANTLR3_BASE_TREE  stop  = child->getChild(child, count-1);
      pOFP_BASE_RTN      ss    = (pOFP_BASE_RTN) malloc(sizeof(OFP_BASE_RTN));
      if (start->u == NULL || stop->u == NULL) {
         printf("treeSetListBoundaries: start/stop->u is NULL, child==\%s\n", child->getText(child)->chars);
         return;
      }
      ss->start = (*(pOFP_BASE_RTN)start->u).start;
      ss->stop  = (*(pOFP_BASE_RTN)start->u).stop;
      child->u = ss;
   }
}

/** Hand coded start rule
 */
FortranParser_shared_return
program_rule_start(pFortranParser ctx)
{
   int program_type, count, finished;

   pANTLR3_BASE_TREE root;

   FortranParser_shared_return retval, program_unit_ret;

   FortranParser_main_program_return               main_program_ret;
   FortranParser_subroutine_subprogram_return      subroutine_subprogram_ret;
   FortranParser_ext_function_subprogram_return    ext_function_subprogram_ret;
   FortranParser_module_return                     module_ret;
   FortranParser_submodule_return                  submodule_ret;
   FortranParser_block_data_return                 block_data_ret;

   /* Initialize rule variables
    */
   root = NULL;

   main_program_ret             .tree  =  NULL;
   subroutine_subprogram_ret    .tree  =  NULL;
   ext_function_subprogram_ret  .tree  =  NULL;
   module_ret                   .tree  =  NULL;
   submodule_ret                .tree  =  NULL;
   block_data_ret               .tree  =  NULL;

   retval.tree  = NULL;
   retval.start = LT(1);
   retval.stop  = retval.start;

   root = (pANTLR3_BASE_TREE)(ADAPTOR->nilNode(ADAPTOR));

   finished  =  0;
   count     =  0;
   while (!finished)
   {
      program_type = ofpGetProgramUnitType(ISTREAM);

      switch ( program_type ) 
      {
         case T_PROGRAM:
            main_program_ret             =  main_program(ctx);
            program_unit_ret.tree        =  main_program_ret.tree;
            program_unit_ret.start       =  main_program_ret.start;
            program_unit_ret.stop        =  main_program_ret.stop;               break;
         case T_SUBROUTINE:
            subroutine_subprogram_ret    =  subroutine_subprogram(ctx);
            program_unit_ret.tree        =  subroutine_subprogram_ret.tree;
            program_unit_ret.start       =  subroutine_subprogram_ret.start;
            program_unit_ret.stop        =  subroutine_subprogram_ret.stop;      break;
         case T_FUNCTION:
            ext_function_subprogram_ret  =  ext_function_subprogram(ctx);
            program_unit_ret.tree        =  ext_function_subprogram_ret.tree;
            program_unit_ret.start       =  ext_function_subprogram_ret.start;
            program_unit_ret.stop        =  ext_function_subprogram_ret.stop;    break;
         case T_MODULE:
            module_ret                   =  module(ctx);
            program_unit_ret.tree        =  module_ret.tree;
            program_unit_ret.start       =  module_ret.start;
            program_unit_ret.stop        =  module_ret.stop;                     break;
         case T_SUBMODULE:
            submodule_ret                =  submodule(ctx);
            program_unit_ret.tree        =  submodule_ret.tree;
            program_unit_ret.start       =  submodule_ret.start;
            program_unit_ret.stop        =  submodule_ret.stop;                  break;
         case T_BLOCKDATA:
            block_data_ret               =  block_data(ctx);
            program_unit_ret.tree        =  block_data_ret.tree;
            program_unit_ret.start       =  block_data_ret.start;
            program_unit_ret.stop        =  block_data_ret.stop;                 break;
         default:
            /* EOF or error condition */
            finished = 1;
      }

      /* 
       */
      // don't think we need FOLLOWPUSH and FOLLOWPOP();
      if (HASEXCEPTION())
      {
         goto ruleprogramEx;
      }
      if (HASFAILED())
      {
         return retval;
      }

      if (!finished)
      {
         /* add program_unit to the tree structure */
         count += 1;
         ADAPTOR->addChild(ADAPTOR, root, program_unit_ret.tree);
      }

      if (count == 0)
      {
         /* mismatchedSetEx()
          */
         CONSTRUCTEX();
         EXCEPTION->type = ANTLR3_EARLY_EXIT_EXCEPTION;
         EXCEPTION->name = (void *)ANTLR3_EARLY_EXIT_NAME;

         goto ruleprogramEx;
      }

   } // end while (!finished)

   // This is where rules clean up and exit
   //
//   goto ruleprogramEx; /* Prevent compiler warnings */
   ruleprogramEx: ;

   retval.stop = LT(-1);

   if (HASEXCEPTION())
   {
      PREPORTERROR();
      PRECOVER();
      retval.tree = (pANTLR3_BASE_TREE)(ADAPTOR->errorNode(ADAPTOR, INPUT, retval.start, LT(-1), EXCEPTION));
   }
   else
   {
      retval.tree = (pANTLR3_BASE_TREE)(ADAPTOR->rulePostProcessing(ADAPTOR, root));
      ADAPTOR->setTokenBoundaries(ADAPTOR, retval.tree, retval.start, retval.stop);
   }

   return retval;
}


}

//tokens {
//   OFP_Program;
//}

/*
 * Section/Clause 1: Overview
 */


/*
 * Section/Clause 2: Fortran concepts
 */


/*
 * Got rid of the following rules: 
 * program
 * program_unit
 * external_subprogram
 *
 * this was done because Main() should now handle the top level rules
 * to try and reduce the amount of backtracking that must be done!
 * --Rickett, 12.07.06
 *
 * for some reason, leaving these three rules in, even though main() 
 * does NOT call them, prevents the parser from failing on the tests:
 * main_program.f03
 * note_6.24.f03
 * it appears to be something with the (program_unit)* part of the 
 * program rule.  --12.07.06
 *  --resolved: there's a difference in the code that is generated for 
 *              the end_of_stmt rule if these three rules are in there.
 *              to get around this, i modified the end_of_stmt rule.  
 *              see it for more details.  --12.11.06
 * 
 */

/*
 * R201-F08 program
 *    is  program-unit 
 *        [ program-unit ] ... 
 */
program
   :  program_unit+
   ;

////////////
// R201-F08
//
// Removed from grammar and called explicitly
//


/*
 * R202-F08 program-unit
 *    is  main-program
 *    or  external-subprogram
 *    or  module
 *    or  submodule     // NEW_TO_2008
 *    or  block-data
 */

////////////
// R202-F08
//
// Removed from grammar and called explicitly
//

program_unit
   :   subroutine_subprogram
   ;

/*
 * R203-F08 external-subprogram
 *    is  function-subprogram 
 *    or  subroutine-subprogram
 */

////////////
// R203-F08
//
// Removed from grammar and called explicitly
//


////////////
// R204-F08
//
// Implemented in "Extras" section
//
//----------------------------------------------------------------------------------------
///JAVA specification_part
///JAVA @init{int numUseStmts=0; int numImportStmts=0; int numDeclConstructs=0;}
///JAVA    :   ( use_stmt               {numUseStmts++;}       )*
///JAVA        ( import_stmt            {numImportStmts++;}    )*
///JAVA        ( declaration_construct  {numDeclConstructs++;} )*
///JAVA            {
///JAVA               c_action_specification_part(numUseStmts,numImportStmts,0,numDeclConstructs);
///JAVA            }
///JAVA    ;


//========================================================================================
/*
 * R205-F08   implicit-part           is [ implicit-part-stmt ] ...
 *                                       implicit-stmt
 */
//
// R205 implicit_part removed from grammar (see ERR_CHK 207)
//----------------------------------------------------------------------------------------


//========================================================================================
/*
 * R206-F08   implicit-part-stmt      is implicit-stmt
 *                                    or parameter-stmt
 *                                    or format-stmt
 *                                    or entry-stmt
 */
//
// R206 implicit_part_stmt removed from grammar (see ERR_CHK 207)
//----------------------------------------------------------------------------------------


//========================================================================================
/* R207-F08 declaration-construct
 *    is  derived-type-def
 *    or  entry-stmt
 *    or  enum-def                      // NEW_NAME_2008 (was enum-alias-def)
 *    or  format-stmt
 *    or  interface-block
 *    or  parameter-stmt
 *    or  procedure-declaration-stmt
 *    or  other-specification-stmt      // NEW_NAME_2008 (was specification-stmt)
 *    or  type-declaration-stmt
 *    or  stmt-function-stmt
 */
//----------------------------------------------------------------------------------------
declaration_construct
@after
{
   c_action_declaration_construct();
}
   :   derived_type_def
   |   entry_stmt
   |   enum_def
   |   format_stmt
   |   interface_block
   |   parameter_stmt
   |   procedure_declaration_stmt
   |   other_specification_stmt
   |   type_declaration_stmt
   |   stmt_function_stmt
   ;


//========================================================================================
/*
 * R208-F08   execution-part      is executable-construct
 *                                    [ execution-part-construct ] ...
 */
//----------------------------------------------------------------------------------------
execution_part
@after
{
   c_action_execution_part();
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
   treeSetListBoundaries (retval.tree, 1);
}
   :   executable_construct
       execution_part_construct *

   ->  ^(OFPExecutablePartConstructList executable_construct execution_part_construct*)
   ;

//========================================================================================
/*
 * R209-F08   execution-part-construct      is executable-construct
 *                                          or format-stmt
 *                                          or entry-stmt
 *                                          or data-stmt
 */
//----------------------------------------------------------------------------------------
execution_part_construct
@after
{
   c_action_execution_part_construct();
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   executable_construct  
   |   format_stmt
   |   entry_stmt
   |   data_stmt
   ;

/*
 * R210-F08 internal-subprogram-part
 *    is  contains-stmt
 *            [ internal-subprogram ] ...  // DIFFERENT_2008 (can have contains only)
 */

////////////
// R210-F08
//
internal_subprogram_part
@init{int count = 0;}
   :   contains_stmt
       ( internal_subprogram {count += 1;} )*
           { c_action_internal_subprogram_part(count); }
   ;

// R211
// modified to factor optional prefix
internal_subprogram
@after {
    c_action_internal_subprogram();
}
   :   ( prefix )? function_subprogram
   |   subroutine_subprogram
   ;

/*
 * R212-F08 other-specification-stmt   // NEW_NAME_2008 (was specification-stmt)
 *    is  access-stmt
 *    or  allocatable-stmt
 *    or  asynchronous-stmt
 *    or  bind-stmt
 *    or  codimension-stmt              // NEW_TO_2008
 *    or  common-stmt
 *    or  data-stmt
 *    or  dimension-stmt
 *    or  equivalence-stmt
 *    or  external-stmt
 *    or  intent-stmt
 *    or  intrinsic-stmt
 *    or  namelist-stmt
 *    or  optional-stmt
 *    or  pointer-stmt
 *    or  protected-stmt
 *    or  save-stmt
 *    or  target-stmt
 *    or  volatile-stmt
 *    or  value-stmt
 */

////////////
// R212-F08
//
other_specification_stmt
@after {c_action_specification_stmt();}
   :   access_stmt
   |   allocatable_stmt
   |   asynchronous_stmt
   |   bind_stmt
   |   codimension_stmt                // NEW_TO_2008
   |   common_stmt
   |   data_stmt
   |   dimension_stmt
   |   equivalence_stmt
   |   external_stmt
   |   intent_stmt
   |   intrinsic_stmt
   |   namelist_stmt
   |   optional_stmt
   |   pointer_stmt
   |   protected_stmt
   |   save_stmt
   |   target_stmt
   |   volatile_stmt
   |   value_stmt
   |   other_spec_stmt_extension
   ;


// language extension point
other_spec_stmt_extension : T_NO_LANGUAGE_EXTENSION ;


////////////
// R213-F03
//
// This rule is overridden in FortranParserExtras grammar
//
///JAVA executable_construct
///JAVA @after {c_action_executable_construct();}
///JAVA    :   action_stmt
///JAVA    |   associate_construct
///JAVA    |   case_construct
///JAVA    |   do_construct
///JAVA    |   forall_construct
///JAVA    |   if_construct
///JAVA    |   select_type_construct
///JAVA    |   where_construct
///JAVA    ;


////////////
// R214-F08
//
// Implemented in "Extras" section
//
//----------------------------------------------------------------------------------------
///JAVA action_stmt
///JAVA @after {
///JAVA     c_action_action_stmt();
///JAVA     checkForInclude();
///JAVA }
///JAVA    :   allocate_stmt
///JAVA    |   assignment_stmt
///JAVA    |   backspace_stmt
///JAVA    |   call_stmt
///JAVA    |   close_stmt
///JAVA    |   continue_stmt
///JAVA    |   cycle_stmt
///JAVA    |   deallocate_stmt
///JAVA    |   endfile_stmt
///JAVA    |   exit_stmt
///JAVA    |   flush_stmt
///JAVA    |   forall_stmt
///JAVA    |   goto_stmt
///JAVA    |   if_stmt
///JAVA    |   inquire_stmt  
///JAVA    |   nullify_stmt
///JAVA    |   open_stmt
///JAVA    |   pointer_assignment_stmt
///JAVA    |   print_stmt
///JAVA    |   read_stmt
///JAVA    |   return_stmt
///JAVA    |   rewind_stmt
///JAVA    |   stop_stmt
///JAVA    |   wait_stmt
///JAVA    |   where_stmt
///JAVA    |   write_stmt
///JAVA    |   arithmetic_if_stmt
///JAVA    |   computed_goto_stmt
///JAVA    |   assign_stmt 
///JAVA    |   assigned_goto_stmt
///JAVA    |   pause_stmt
///JAVA    ;


//========================================================================================
// R215
//----------------------------------------------------------------------------------------
keyword
@after
{
   c_action_keyword();
}
   :   name
   ;


/**
 * Section/Clause 3: Lexical tokens and source form
 */

// R301 character not used

// R302 alphanumeric_character converted to fragment

// R303 underscore inlined

// R304
name
   :   T_IDENT              { c_action_name($T_IDENT); }
   ;

// R305
// ERR_CHK 305 named_constant replaced by T_IDENT 
constant
   :   literal_constant     { c_action_constant(NULL); }
   |   T_IDENT              { c_action_constant($T_IDENT); }
   ;

scalar_constant
@after
{
   c_action_scalar_constant();
}
   :    constant
   ;

// R306
literal_constant
@after
{
   c_action_literal_constant();
}
   :   int_literal_constant
   |   real_literal_constant
   |   complex_literal_constant
   |   logical_literal_constant
   |   char_literal_constant
   |   boz_literal_constant
   |   hollerith_literal_constant  // deleted in F77
   ;

// R307 named_constant was name inlined as T_IDENT

// R308
// C302 R308 int_constant shall be of type integer
// inlined integer portion of constant
int_constant
   :   int_literal_constant    { c_action_int_constant(NULL); }
   |   T_IDENT                 { c_action_int_constant($T_IDENT); }
   ;

// R309
// C303 R309 char_constant shall be of type character
// inlined character portion of constant
char_constant
   :   char_literal_constant   { c_action_int_constant(NULL); }
   |   T_IDENT                 { c_action_int_constant($T_IDENT); }
   ;

// R310
intrinsic_operator
@after
{
   c_action_intrinsic_operator();
}
   :   power_op
   |   mult_op
   |   add_op
   |   concat_op
   |   rel_op
   |   not_op
   |   and_op
   |   or_op
   |   equiv_op
   ;

// R311
// removed defined_unary_op or defined_binary_op ambiguity with T_DEFINED_OP
defined_operator
   :   T_DEFINED_OP            
            { c_action_defined_operator($T_DEFINED_OP, ANTLR3_FALSE); }
   |   extended_intrinsic_op   
            { c_action_defined_operator($extended_intrinsic_op.start, ANTLR3_TRUE); }
   ;

// R312
extended_intrinsic_op
@after
{
   c_action_extended_intrinsic_op();
}
   :   intrinsic_operator
   ;


//========================================================================================
//
/* R312-F08 label
 *   is  digit [digit [digit [digit [digit ]]]]
 */
//
// This should be checked to make sure the label is five characters or less.
//
//----------------------------------------------------------------------------------------
label
   :  T_DIGIT_STRING
          {
             c_action_label($T_DIGIT_STRING);
          }
   ;


opt_label
@after
{
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   label?

    -> ^(OFPLabel label?)
   ;

// c_action_label called here to store label in action class
label_list
@init
{
   int count=0;
   c_action_label_list__begin();
}
   :   lbl=label {count++;}  ( T_COMMA lbl=label {count++;} )*
           {
              c_action_label_list(count);
           }
   ;


/**
 * Section/Clause 4: Types
 */


// R401-F08
// ERR_CHK 402 scalar_int_expr replaced by expr
type_param_value
   :   expr        { c_action_type_param_value(ANTLR3_TRUE, ANTLR3_FALSE, ANTLR3_FALSE); }
   |   T_ASTERISK  { c_action_type_param_value(ANTLR3_FALSE, ANTLR3_TRUE, ANTLR3_FALSE); }
   |   T_COLON     { c_action_type_param_value(ANTLR3_FALSE, ANTLR3_FALSE, ANTLR3_TRUE); }
   ;

// R402-F08
type_spec
@after
{
    c_action_type_spec();
}
   :   intrinsic_type_spec
   |   derived_type_spec
   ;

//========================================================================================
// R403-F08 declaration-type-spec
//
//     is intrinsic-type-spec
//     or TYPE ( intrinsic-type-spec )
//     or TYPE ( derived-type-spec )
//     or CLASS ( derived-type-spec )
//     or CLASS ( * )
//----------------------------------------------------------------------------------------
declaration_type_spec
@after
{
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   intrinsic_type_spec
           {
              c_action_declaration_type_spec(NULL,IActionEnums_ DeclarationTypeSpec_INTRINSIC);
           }
   -> ^(OFPDeclarationTypeSpec intrinsic_type_spec)

   |   T_TYPE T_LPAREN intrinsic_type_spec T_RPAREN
           {
              c_action_declaration_type_spec(NULL,IActionEnums_ DeclarationTypeSpec_INTRINSIC);
           }
   -> ^(OFPDeclarationTypeSpec intrinsic_type_spec)

   |   T_TYPE T_LPAREN derived_type_spec T_RPAREN
           {
              c_action_declaration_type_spec($T_TYPE,IActionEnums_ DeclarationTypeSpec_TYPE);
           }
   -> ^(OFPDeclarationTypeSpec derived_type_spec)

   |   T_CLASS T_LPAREN derived_type_spec T_RPAREN
           {
              c_action_declaration_type_spec($T_CLASS,IActionEnums_ DeclarationTypeSpec_CLASS);
           }
   -> ^(OFPDeclarationTypeSpec derived_type_spec)

   |   T_CLASS T_LPAREN T_ASTERISK T_RPAREN
           {
              c_action_declaration_type_spec($T_CLASS,IActionEnums_ DeclarationTypeSpec_unlimited);
           }
   -> ^(OFPDeclarationTypeSpec T_ASTERISK)

   ;


// inlined scalar_int_expr C101 shall be a scalar

// inlined scalar_expr

//========================================================================================
// R404-F08 intrinsic-type-spec
//
// Nonstandard Extension: source BLAS
//  |   T_DOUBLE T_COMPLEX
//  |   T_DOUBLECOMPLEX
//----------------------------------------------------------------------------------------
intrinsic_type_spec
@init
{
   ANTLR3_BOOLEAN hasKindSelector = ANTLR3_FALSE;
   pANTLR3_COMMON_TOKEN start, stop;
}
@after
{
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
   treeSetTokenBoundaries(retval.tree, start, stop, 0);
}
   :   T_LOGICAL kind=opt_kind_selector
           {
              if (kind.tree->getChildCount(kind.tree) > 0) hasKindSelector = ANTLR3_TRUE;
              c_action_intrinsic_type_spec($T_LOGICAL,NULL,IActionEnums_ IntrinsicTypeSpec_LOGICAL,hasKindSelector);
           }

    -> ^(OFPIntrinsicTypeSpec OFPTypeLogical opt_kind_selector)

   |   T_INTEGER kind=opt_kind_selector
           {
              if (kind.tree->getChildCount(kind.tree) > 0) hasKindSelector = ANTLR3_TRUE;
              c_action_intrinsic_type_spec($T_INTEGER,NULL,IActionEnums_ IntrinsicTypeSpec_INTEGER,hasKindSelector);
           }

    -> ^(OFPIntrinsicTypeSpec OFPTypeInteger opt_kind_selector)

   |   T_REAL kind=opt_kind_selector
           {
              start = stop = $T_REAL;
              if (kind.tree->getChildCount(kind.tree) > 0) hasKindSelector = ANTLR3_TRUE;
              c_action_intrinsic_type_spec($T_REAL,NULL,IActionEnums_ IntrinsicTypeSpec_REAL,hasKindSelector);
           }

    -> ^(OFPIntrinsicTypeSpec OFPTypeReal opt_kind_selector)

   |   T_DOUBLE T_PRECISION
           {
              c_action_intrinsic_type_spec($T_DOUBLE,$T_PRECISION,IActionEnums_ IntrinsicTypeSpec_DOUBLEPRECISION,ANTLR3_FALSE);
           }

    -> ^(OFPIntrinsicTypeSpec OFPTypeDouble OFPKindSelector)

   |   T_DOUBLEPRECISION
           {
              c_action_intrinsic_type_spec($T_DOUBLEPRECISION,NULL,IActionEnums_ IntrinsicTypeSpec_DOUBLEPRECISION,ANTLR3_FALSE);
           }

    -> ^(OFPIntrinsicTypeSpec OFPTypeDouble OFPKindSelector)

   |   T_COMPLEX kind=opt_kind_selector
           {
              if (kind.tree->getChildCount(kind.tree) > 0) hasKindSelector = ANTLR3_TRUE;
              c_action_intrinsic_type_spec($T_COMPLEX,NULL,IActionEnums_ IntrinsicTypeSpec_COMPLEX,hasKindSelector);
           }

    -> ^(OFPIntrinsicTypeSpec OFPTypeComplex opt_kind_selector)

   |   T_DOUBLE T_COMPLEX
           {
              c_action_intrinsic_type_spec($T_DOUBLE,$T_COMPLEX,IActionEnums_ IntrinsicTypeSpec_DOUBLECOMPLEX,ANTLR3_FALSE);
           }

    -> ^(OFPIntrinsicTypeSpec OFPTypeDComplex OFPKindSelector)

   |   T_DOUBLECOMPLEX
           {
              c_action_intrinsic_type_spec($T_DOUBLECOMPLEX,NULL,IActionEnums_ IntrinsicTypeSpec_DOUBLECOMPLEX,ANTLR3_FALSE);
           }

    -> ^(OFPIntrinsicTypeSpec OFPTypeDComplex OFPKindSelector)

   |   T_CHARACTER ckind=opt_char_selector
           {
              if (ckind.tree->getChildCount(ckind.tree) > 0) hasKindSelector = ANTLR3_TRUE;
              c_action_intrinsic_type_spec($T_CHARACTER,NULL,IActionEnums_ IntrinsicTypeSpec_CHARACTER,hasKindSelector);
           }

    -> ^(OFPIntrinsicTypeSpec OFPTypeCharacter opt_char_selector)

   ;


//========================================================================================
// R405-F08 kind-selector
//    is ( [ KIND = ] scalar-int-constant-expr )
//
// ERR_CHK 405 scalar_int_constant_expr replaced by expr
// Nonstandard extension: source common practice
//  | T_ASTERISK T_DIGIT_STRING  // e.g., COMPLEX*16    
// TODO - check to see if second alternative is where it should go
//----------------------------------------------------------------------------------------
kind_selector
@init
{
   pANTLR3_COMMON_TOKEN tk1 = NULL;
   pANTLR3_COMMON_TOKEN tk2 = NULL;
}
   :   T_LPAREN (T_KIND T_EQUALS {tk1=$T_KIND; tk2=$T_EQUALS;})? expr T_RPAREN
           {
              c_action_kind_selector(tk1, tk2, ANTLR3_TRUE);
           }

    -> expr

   |   T_ASTERISK T_DIGIT_STRING
           {
              c_action_kind_selector($T_ASTERISK, $T_DIGIT_STRING, ANTLR3_FALSE);
           }

    -> T_DIGIT_STRING
   ;

opt_kind_selector
   :   kind_selector?  ->  ^(OFPKindSelector kind_selector?)
   ;

// R405
signed_int_literal_constant
@init{pANTLR3_COMMON_TOKEN sign = NULL;} 
   :   (T_PLUS {sign=$T_PLUS;} | T_MINUS {sign=$T_MINUS;})?
       int_literal_constant
            { c_action_signed_int_literal_constant(sign); }
   ;

//========================================================================================
/* R407-F08 int-literal-constant
 *    is digit-string [ _ kind-param ]
 */
//----------------------------------------------------------------------------------------
int_literal_constant
@init
{
   pANTLR3_COMMON_TOKEN kind = NULL;
} 
   :   T_DIGIT_STRING (T_UNDERSCORE kind_param {kind = $kind_param.start;})?
            {c_action_int_literal_constant($T_DIGIT_STRING, kind);}

   -> ^(OFPIntLiteralConstant T_DIGIT_STRING ^(OFPKindParam kind_param?))
   ;

// R407
//========================================================================================
/* R408-F08 kind-param
 *   is  digit-string
 *   of  scalar-int-constant-name
 */
// T_IDENT inlined for scalar_int_constant_name
//----------------------------------------------------------------------------------------
kind_param
   :   T_DIGIT_STRING 
           { c_action_kind_param($T_DIGIT_STRING); }
   |   T_IDENT 
           { c_action_kind_param($T_IDENT); }
   ;

// R408 signed_digit_string inlined

// R409 digit_string converted to fragment

// R410 sign inlined

// R411
boz_literal_constant
   :   BINARY_CONSTANT { c_action_boz_literal_constant($BINARY_CONSTANT); }
   |   OCTAL_CONSTANT  { c_action_boz_literal_constant($OCTAL_CONSTANT); }
   |   HEX_CONSTANT    { c_action_boz_literal_constant($HEX_CONSTANT); }
   ;

// R412 binary-constant converted to terminal

// R413 octal_constant converted to terminal

// R414 hex_constant converted to terminal

// R415 hex_digit inlined

// R416
signed_real_literal_constant
@init{pANTLR3_COMMON_TOKEN sign = NULL;} 
   :   (T_PLUS {sign=$T_PLUS;} | T_MINUS {sign=$T_MINUS;})?
       real_literal_constant
            {c_action_signed_real_literal_constant(sign);}
   ;

// R417 modified to use terminal
// Grammar Modified slightly to prevent problems with input such as: 
// if(1.and.1) then ... 
real_literal_constant
@init{pANTLR3_COMMON_TOKEN kind = NULL;} 
//      WARNING must parse T_REAL_CONSTANT in action (look for D)
   :   T_REAL_CONSTANT (T_UNDERSCORE kind_param {kind = $kind_param.start;})? 
            { c_action_real_literal_constant($T_REAL_CONSTANT, kind); }
        
   ;

// R418 significand converted to fragment

// R419 exponent_letter inlined in new Exponent

// R420 exponent inlined in new Exponent

// R421
complex_literal_constant
@after
{
    c_action_complex_literal_constant();
}
   :   T_LPAREN real_part T_COMMA imag_part T_RPAREN
   ;

// R422
// ERR_CHK 422 named_constant replaced by T_IDENT
real_part
   :   signed_int_literal_constant  
            { c_action_real_part(ANTLR3_TRUE, ANTLR3_FALSE, NULL); }
   |   signed_real_literal_constant 
            { c_action_real_part(ANTLR3_FALSE, ANTLR3_TRUE, NULL); }
   |   T_IDENT                      
            { c_action_real_part(ANTLR3_FALSE, ANTLR3_FALSE, $T_IDENT); }
   ;

// R423
// ERR_CHK 423 named_constant replaced by T_IDENT
imag_part
   :   signed_int_literal_constant     
            { c_action_imag_part(ANTLR3_TRUE, ANTLR3_FALSE, NULL); }
   |   signed_real_literal_constant    
            { c_action_imag_part(ANTLR3_FALSE, ANTLR3_TRUE, NULL); }
   |   T_IDENT                         
            { c_action_imag_part(ANTLR3_FALSE, ANTLR3_FALSE, $T_IDENT); }
   ;

//========================================================================================
// R420-F08 char-selector
//
// ERR_CHK 420a scalar_int_initialization_expr replaced by expr
// ERR_CHK 420b T_KIND, if type_param_value, must be a 
// scalar_int_initialization_expr
// ERR_CHK 420c T_KIND and T_LEN cannot both be specified
//----------------------------------------------------------------------------------------
char_selector
@init {
    int kindOrLen1; kindOrLen1 = IActionEnums_ KindLenParam_none;
    int kindOrLen2; kindOrLen2 = IActionEnums_ KindLenParam_none;
    pANTLR3_COMMON_TOKEN tk = NULL;
    ANTLR3_BOOLEAN hasAsterisk = ANTLR3_FALSE;
}
   // length-selector without type-param-value
   :   T_ASTERISK char_length (T_COMMA)?
          {
            hasAsterisk=ANTLR3_TRUE; 
            c_action_char_selector(NULL, NULL, kindOrLen1, kindOrLen2, hasAsterisk);
          }
   // type-param-value but no LEN=
   |   T_LPAREN type_param_value
          (  T_COMMA (T_KIND T_EQUALS {tk=$T_KIND;})? expr
             {kindOrLen2=IActionEnums_ KindLenParam_kind;}
          )?
       T_RPAREN
          {
            kindOrLen1 = IActionEnums_ KindLenParam_len;
            c_action_char_selector(NULL, tk, kindOrLen1, kindOrLen2, hasAsterisk);
          }
   // type-param-value with LEN=
   |   T_LPAREN T_LEN T_EQUALS type_param_value
          (  T_COMMA T_KIND T_EQUALS expr
             {kindOrLen2=IActionEnums_ KindLenParam_kind; tk=$T_KIND;}
          )?
       T_RPAREN
          {
            kindOrLen1 = IActionEnums_ KindLenParam_len;
            c_action_char_selector($T_LEN, tk, kindOrLen1, kindOrLen2, hasAsterisk);
          }
   // KIND= first
   |   T_LPAREN T_KIND T_EQUALS expr
          (  T_COMMA (T_LEN T_EQUALS {tk=$T_LEN;})? type_param_value
             {kindOrLen2=IActionEnums_ KindLenParam_len;}
          )?
       T_RPAREN
          {
            kindOrLen1 = IActionEnums_ KindLenParam_kind;
            c_action_char_selector($T_KIND, tk, kindOrLen1, kindOrLen2, hasAsterisk);
          }
   ;

opt_char_selector
   :   char_selector?  ->  ^(OFPCharSelector char_selector?)
   ;

// R421-F08
length_selector
@init {pANTLR3_COMMON_TOKEN len = NULL;}
   :   T_LPAREN ( T_LEN { len=$T_LEN; } T_EQUALS )? type_param_value T_RPAREN
          { c_action_length_selector(len, IActionEnums_ KindLenParam_len, ANTLR3_FALSE); }

    -> ^(OFPLengthSelector type_param_value)

   |   T_ASTERISK char_length (T_COMMA)?
          { c_action_length_selector(len, IActionEnums_ KindLenParam_none, ANTLR3_TRUE); }

    -> ^(OFPLengthSelector char_length)

   ; 

// R426
char_length
   :   T_LPAREN type_param_value T_RPAREN   { c_action_char_length(ANTLR3_TRUE); }
   |   scalar_int_literal_constant          { c_action_char_length(ANTLR3_FALSE); }
   ;

scalar_int_literal_constant
@after {c_action_scalar_int_literal_constant();}
   :   int_literal_constant
   ;

// R427
// char_literal_constant
// // options {k=2;}
//   :   T_DIGIT_STRING T_UNDERSCORE T_CHAR_CONSTANT
//         // removed the T_UNDERSCORE because underscores are valid characters 
//         // for identifiers, which means the lexer would match the T_IDENT and 
//         // T_UNDERSCORE as one token (T_IDENT).
//   |   T_IDENT T_CHAR_CONSTANT
//   |   T_CHAR_CONSTANT
//   ;
char_literal_constant
   :   T_DIGIT_STRING T_UNDERSCORE T_CHAR_CONSTANT
          { c_action_char_literal_constant($T_DIGIT_STRING, NULL, $T_CHAR_CONSTANT); }
       // removed the T_UNDERSCORE because underscores are valid characters 
       // for identifiers, which means the lexer would match the T_IDENT and 
       // T_UNDERSCORE as one token (T_IDENT).
   |   T_IDENT T_CHAR_CONSTANT
          { c_action_char_literal_constant(NULL, $T_IDENT, $T_CHAR_CONSTANT); }
   |   T_CHAR_CONSTANT
          { c_action_char_literal_constant(NULL, NULL, $T_CHAR_CONSTANT); }
   ;

//
// Note: Hollerith constants were deleted in F77; Hollerith edit descriptors
// deleted in F95.
//
hollerith_literal_constant
   :   T_HOLLERITH
            { c_action_hollerith_literal_constant($T_HOLLERITH); }
   ;

// R428
logical_literal_constant
@init{pANTLR3_COMMON_TOKEN kind = NULL;} 
   :   T_TRUE ( T_UNDERSCORE kind_param {kind = $kind_param.start;})?
            {c_action_logical_literal_constant($T_TRUE, ANTLR3_TRUE, kind);}
   |   T_FALSE ( T_UNDERSCORE kind_param {kind = $kind_param.start;})?
            {c_action_logical_literal_constant($T_FALSE, ANTLR3_FALSE, kind);}
   ;

// R429
//  ( component_part )? inlined as ( component_def_stmt )*
derived_type_def
@after
{
   c_action_derived_type_def();
}
   :   derived_type_stmt
       // matches T_INTEGER possibilities in component_def_stmt
       type_param_or_comp_def_stmt_list  
       ( private_or_sequence )*
             { /* ERR_CHK 429
                * if private_or_sequence present, component_def_stmt in 
                * type_param_or_comp_def_stmt_list
                * is an error
                */
             }
       ( component_def_stmt )*
       ( type_bound_procedure_part )?
       end_type_stmt
   ;

// Includes:
//    ( type_param_def_stmt)*
//    ( component_def_stmt )* if starts with T_INTEGER (could be a parse error)
// REMOVED T_INTEGER junk (see statement above) with k=1
// TODO this must be tested can we get rid of this????
type_param_or_comp_def_stmt_list
@after {
    c_action_type_param_or_comp_def_stmt_list();
}
///options {k=1;}
//  :   (T_INTEGER) => (kind_selector)? T_COMMA type_param_or_comp_def_stmt
//          type_param_or_comp_def_stmt_list
   :   (kind_selector)?  T_COMMA  type_param_or_comp_def_stmt  type_param_or_comp_def_stmt_list
   |
        { /* ERR_CHK R435
           * type_param_def_stmt(s) must precede component_def_stmt(s)
           */
        }
   ;

type_param_or_comp_def_stmt
   :   type_param_attr_spec T_COLON_COLON type_param_decl_list end_of_stmt 
            // TODO: See if this is reachable now that type_param_attr_spec is 
            // tokenized T_KIND or T_LEN. See R435
            {c_action_type_param_or_comp_def_stmt($end_of_stmt.start,
                IActionEnums_ TypeParamOrCompDef_typeParam);}
   |   component_attr_spec_list T_COLON_COLON component_decl_list end_of_stmt 
            // See R440
            {c_action_type_param_or_comp_def_stmt($end_of_stmt.start,
                IActionEnums_ TypeParamOrCompDef_compDef);}
   ;

// R430
// generic_name_list substituted for type_param_name_list
derived_type_stmt
@init {
    pANTLR3_COMMON_TOKEN lbl=NULL; 
    ANTLR3_BOOLEAN hasTypeAttrSpecList=ANTLR3_FALSE; 
    ANTLR3_BOOLEAN hasGenericNameList=ANTLR3_FALSE;
}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_TYPE
       ( ( T_COMMA type_attr_spec_list {hasTypeAttrSpecList=ANTLR3_TRUE;} )? 
           T_COLON_COLON )? T_IDENT
           ( T_LPAREN generic_name_list T_RPAREN {hasGenericNameList=ANTLR3_TRUE;} )?
           end_of_stmt
              {
                 c_action_derived_type_stmt(lbl,$T_TYPE, $T_IDENT, $end_of_stmt.start,hasTypeAttrSpecList, hasGenericNameList);
              }
   ;

type_attr_spec_list
@init
{
   int count = 0;
   c_action_type_attr_spec_list__begin();
}
   :   type_attr_spec {count++;} ( T_COMMA type_attr_spec {count++;} )*
           {
              c_action_type_attr_spec_list(count);
           }
   ;

generic_name_list
@init
{
   int count = 0;
   c_action_generic_name_list__begin();
}
   :   id=T_IDENT
            {
               count++;
               c_action_generic_name_list_part(id);
            }
       ( T_COMMA id=T_IDENT 
            {
               count++;
               c_action_generic_name_list_part(id);
            }
       )*
            {
               c_action_generic_name_list(count);
            }
    -> ^(OFPList T_IDENT+)
   ;

// R431
// T_IDENT inlined for parent_type_name
type_attr_spec
   :   access_spec
            {c_action_type_attr_spec(NULL, NULL, 
                                   IActionEnums_ TypeAttrSpec_access_spec);}
   |   T_EXTENDS T_LPAREN T_IDENT T_RPAREN
            {c_action_type_attr_spec($T_EXTENDS, $T_IDENT, 
                                   IActionEnums_ TypeAttrSpec_extends);}
   |   T_ABSTRACT
            {c_action_type_attr_spec($T_ABSTRACT, NULL, 
                                   IActionEnums_ TypeAttrSpec_abstract);}
   |   T_BIND T_LPAREN T_IDENT /* 'C' */ T_RPAREN
            {c_action_type_attr_spec($T_BIND, $T_IDENT, 
                                   IActionEnums_ TypeAttrSpec_bind);}
   ;

// R432
private_or_sequence
@after
{
    c_action_private_or_sequence();
}
   :   private_components_stmt
   |   sequence_stmt
   ;

// R433
end_type_stmt
@init
{
   pANTLR3_COMMON_TOKEN lbl = NULL;
   pANTLR3_COMMON_TOKEN id=NULL;
}
@after{
   checkForInclude();
}
   :  (label {lbl=$label.start;})?
      T_END  T_TYPE  ( T_IDENT {id=$T_IDENT;})?  end_of_stmt
         {
            c_action_end_type_stmt(lbl, $T_END, $T_TYPE, id, $end_of_stmt.start);
         }

   |  (label {lbl=$label.start;})?
      T_ENDTYPE      ( T_IDENT {id=$T_IDENT;})?  end_of_stmt
        {
            c_action_end_type_stmt(lbl, $T_ENDTYPE, NULL, id, $end_of_stmt.start);
        }
   ;

// R434
sequence_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;} 
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_SEQUENCE end_of_stmt
            {c_action_sequence_stmt(lbl, $T_SEQUENCE, $end_of_stmt.start);}
   ;

// R435 type_param_def_stmt inlined in type_param_or_comp_def_stmt_list

// R436
// ERR_CHK 436 scalar_int_initialization_expr replaced by expr
// T_IDENT inlined for type_param_name
type_param_decl
@init{ ANTLR3_BOOLEAN hasInit=ANTLR3_FALSE; }
   :    T_IDENT ( T_EQUALS expr {hasInit=ANTLR3_TRUE;})?
            {c_action_type_param_decl($T_IDENT, hasInit);}
   ;

type_param_decl_list
@init{int count=0;}
   :       {c_action_type_param_decl_list__begin();}
        type_param_decl {count++;} ( T_COMMA type_param_decl {count++;} )*
            {c_action_type_param_decl_list(count);}
   ;

/*
 * R437-F08 component-attr-spec
 *    is  access-spec
 *    or  ALLOCATABLE
 *    or  CODIMENSION lbracket coarray-spec rbracket  // NEW_TO_2008
 *    or  CONTIGUOUS                                  // NEW_TO_2008
 *    or  DIMENSION ( component-array-spec )
 *    or  POINTER
 */

////////////
// R437-F08, R441-F03
//
// TODO it appears there is a bug in the standard for a parameterized type,
//      it needs to accept KIND, LEN keywords, see NOTE 4.24 and 4.25
component_attr_spec
   :   access_spec
          {c_action_component_attr_spec(NULL, IActionEnums_ ComponentAttrSpec_access_spec);}
   |   T_ALLOCATABLE
          {c_action_component_attr_spec($T_ALLOCATABLE, IActionEnums_ ComponentAttrSpec_allocatable);}
   |   T_CODIMENSION T_LBRACKET coarray_spec T_RBRACKET          // NEW_TO_2008 
          {c_action_component_attr_spec($T_CODIMENSION, IActionEnums_ ComponentAttrSpec_codimension);}
   |   T_CONTIGUOUS                                              // NEW_TO_2008 
          {c_action_component_attr_spec($T_CONTIGUOUS, IActionEnums_ ComponentAttrSpec_contiguous);}
   |   T_DIMENSION T_LPAREN component_array_spec T_RPAREN
          {c_action_component_attr_spec($T_DIMENSION, IActionEnums_ ComponentAttrSpec_dimension);}
   |   T_POINTER
          {c_action_component_attr_spec($T_POINTER, IActionEnums_ ComponentAttrSpec_pointer);}
   |   component_attr_spec_extension
    // are T_KIND and T_LEN correct?
//   |   T_KIND
//          {c_action_component_attr_spec($T_KIND, 
//                  IActionEnums_ ComponentAttrSpec_kind);}
//   |   T_LEN
//          {c_action_component_attr_spec($T_LEN, 
//                  IActionEnums_ ComponentAttrSpec_len);}
  ;
  
// language extension point
component_attr_spec_extension : T_NO_LANGUAGE_EXTENSION ;

component_attr_spec_list
@init{int count=1;}
   :       {c_action_component_attr_spec_list__begin();}
        component_attr_spec ( T_COMMA component_attr_spec {count++;} )*
            {c_action_component_attr_spec_list(count);}
   ;

// R437
// ADD isKind boolean.
type_param_attr_spec
   :   T_IDENT /* { KIND | LEN } */ 
            { c_action_type_param_attr_spec($T_IDENT); }
   ;

// R438 component_part inlined as ( component_def_stmt )* in R429

// R439
component_def_stmt
@after{checkForInclude();}
   :   data_component_def_stmt
            {c_action_component_def_stmt(IActionEnums_ ComponentDefType_data);}
   |   proc_component_def_stmt
            {c_action_component_def_stmt(IActionEnums_ ComponentDefType_procedure);}
   ;


// R440
data_component_def_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasSpec=ANTLR3_FALSE; }
@after{checkForInclude();}
   :    (label {lbl=$label.start;})? declaration_type_spec 
            ( ( T_COMMA component_attr_spec_list {hasSpec=ANTLR3_TRUE;})? 
            T_COLON_COLON )? component_decl_list end_of_stmt
            {c_action_data_component_def_stmt(lbl, $end_of_stmt.start, hasSpec);}
   ;


/*
 * R438-F08 component-decl
 *    is  component-name [ ( component-array-spec ) ]
 *                       [ lbracket coarray-spec rbracket ]  // NEW_TO_2008
 *                       [ * char-length ] [ component-initialization ]
 */

////////////
// R438-F08, R442-F03
//
// T_IDENT inlined as component_name
component_decl
@init { 
    ANTLR3_BOOLEAN hasComponentArraySpec = ANTLR3_FALSE; 
    ANTLR3_BOOLEAN hasCoarraySpec = ANTLR3_FALSE;
    ANTLR3_BOOLEAN hasCharLength = ANTLR3_FALSE;
    ANTLR3_BOOLEAN hasComponentInitialization = ANTLR3_FALSE;
}
   :   T_IDENT (T_LPAREN component_array_spec T_RPAREN {hasComponentArraySpec=ANTLR3_TRUE;})?
               (T_LBRACKET coarray_spec T_RBRACKET {hasCoarraySpec=ANTLR3_TRUE;})?
               (T_ASTERISK char_length {hasCharLength=ANTLR3_TRUE;})? 
               (component_initialization {hasComponentInitialization =ANTLR3_TRUE;})?
           {c_action_component_decl($T_IDENT, hasComponentArraySpec, 
                                  hasCoarraySpec, hasCharLength,
                                  hasComponentInitialization);}
   ;

component_decl_list
@init
{
   int count=0;
   c_action_component_decl_list__begin();
}
   :   component_decl {count++;} ( T_COMMA component_decl {count++;} )*
          {
             c_action_component_decl_list(count);
          }
  ;

// R443
component_array_spec
   :   explicit_shape_spec_list
            {c_action_component_array_spec(ANTLR3_TRUE);}
   |   deferred_shape_spec_list
            {c_action_component_array_spec(ANTLR3_FALSE);}
   ;

// deferred_shape_spec replaced by T_COLON
deferred_shape_spec_list
@init{int count=0;}
   :       {c_action_deferred_shape_spec_list__begin();}
        T_COLON {count++;} ( T_COMMA T_COLON {count++;} )*
            {c_action_deferred_shape_spec_list(count);}
   ;

// R444
// R447-F2008 can also be => initial_data_target, see NOTE 4.40 in J3/07-007
// ERR_CHK 444 initialization_expr replaced by expr
component_initialization
@after {
    c_action_component_initialization();
}
   :   T_EQUALS expr
   |   T_EQ_GT null_init
   ;

// R445
proc_component_def_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasInterface=ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_PROCEDURE T_LPAREN 
            ( proc_interface {hasInterface=ANTLR3_TRUE;})? T_RPAREN T_COMMA
            proc_component_attr_spec_list T_COLON_COLON proc_decl_list 
            end_of_stmt
                {c_action_proc_component_def_stmt(lbl, $T_PROCEDURE, 
                    $end_of_stmt.start, hasInterface);}
   ;

// R446
// T_IDENT inlined for arg_name
proc_component_attr_spec
@init{ pANTLR3_COMMON_TOKEN id=NULL; }
   :    T_POINTER
            {c_action_proc_component_attr_spec($T_POINTER, id, 
                                             IActionEnums_ ProcComponentAttrSpec_pointer);}
   |    T_PASS ( T_LPAREN T_IDENT T_RPAREN {id=$T_IDENT;} )?
            {c_action_proc_component_attr_spec($T_PASS, id, 
                                             IActionEnums_ ProcComponentAttrSpec_pass);}
   |    T_NOPASS
            {c_action_proc_component_attr_spec($T_NOPASS, id, 
                                             IActionEnums_ ProcComponentAttrSpec_nopass);}
   |    access_spec
            {c_action_proc_component_attr_spec(NULL, id, IActionEnums_ ProcComponentAttrSpec_access_spec);}
   ;

proc_component_attr_spec_list
@init{int count=0;}
   :       {c_action_proc_component_attr_spec_list__begin();}
        proc_component_attr_spec {count++;} 
            ( T_COMMA proc_component_attr_spec {count++;})*
            {c_action_proc_component_attr_spec_list(count);}
   ;

// R447
private_components_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_PRIVATE end_of_stmt
            {c_action_private_components_stmt(lbl, $T_PRIVATE, $end_of_stmt.start);}
   ;

//========================================================================================
//
/* R445-F08 type-bound-procedure-part
 *   is contains-stmt
 *         [ binding-private-stmt ]
 *         [ type-bound-proc-binding ] ...
 */
//
//----------------------------------------------------------------------------------------
type_bound_procedure_part
@init
{
   int count = 1;
   ANTLR3_BOOLEAN hasBindingPrivateStmt = ANTLR3_FALSE;
}
   :   contains_stmt
        ( binding_private_stmt {hasBindingPrivateStmt=ANTLR3_TRUE;} )? 
        type_bound_proc_binding ( type_bound_proc_binding {count++;} )*

             {
                c_action_type_bound_procedure_part(count,hasBindingPrivateStmt);
             }
   ;

//========================================================================================
//
/* R446-F08 binding_private_stmt
 *   is PRIVATE
 */
//
//----------------------------------------------------------------------------------------
binding_private_stmt
@init
{
   pANTLR3_COMMON_TOKEN lbl = NULL;
}
@after
{
   checkForInclude();
}
   :   (label {lbl=$label.start;})?  T_PRIVATE  end_of_stmt
           {
              c_action_binding_private_stmt(lbl,$T_PRIVATE,$end_of_stmt.start);
           }
   ;

//========================================================================================
//
/* R447-F08 type-bound-proc-binding
 *   is  type-bound-procedure-stmt
 *   or  type-bound-generic-stmt
 *   or  final-procedure-stmt
 */
//
//----------------------------------------------------------------------------------------
type_bound_proc_binding
@init
{
   pANTLR3_COMMON_TOKEN lbl = NULL;
}
@after
{
   checkForInclude();
}
   :   ( label  {lbl=$label.start;} )?
       specific_binding end_of_stmt
                {c_action_proc_binding_stmt(lbl,IActionEnums_ BindingStatementType_specific,$end_of_stmt.start);}
   |   ( label  {lbl=$label.start;} )?
       generic_binding end_of_stmt
                {c_action_proc_binding_stmt(lbl,IActionEnums_ BindingStatementType_generic,$end_of_stmt.start);}
   |   ( label  {lbl=$label.start;} )?
       final_binding end_of_stmt
                {c_action_proc_binding_stmt(lbl,IActionEnums_ BindingStatementType_final,$end_of_stmt.start);}
   ;

// R451
// T_IDENT inlined for interface_name, binding_name and procedure_name
specific_binding
@init {
    pANTLR3_COMMON_TOKEN interfaceName=NULL;
    pANTLR3_COMMON_TOKEN bindingName=NULL; 
    pANTLR3_COMMON_TOKEN procedureName=NULL;
    ANTLR3_BOOLEAN hasBindingAttrList=ANTLR3_FALSE;
} 
   :   T_PROCEDURE (T_LPAREN tmpId1=T_IDENT T_RPAREN {interfaceName=tmpId1;})?
            ( ( T_COMMA binding_attr_list {hasBindingAttrList=ANTLR3_TRUE;})? 
                T_COLON_COLON )?
            tmpId2=T_IDENT {bindingName=tmpId2;} 
            ( T_EQ_GT tmpId3=T_IDENT {procedureName=tmpId3;})?
            { c_action_specific_binding($T_PROCEDURE, interfaceName, bindingName,
                                      procedureName, hasBindingAttrList);}
   ;

// R452
// generic_name_list substituted for binding_name_list
generic_binding
@init{ANTLR3_BOOLEAN hasAccessSpec=ANTLR3_FALSE;}
   :    T_GENERIC ( T_COMMA access_spec {hasAccessSpec=ANTLR3_TRUE;})? T_COLON_COLON 
        generic_spec T_EQ_GT generic_name_list
            {c_action_generic_binding($T_GENERIC, hasAccessSpec);}
   ;

// R453
// T_IDENT inlined for arg_name
binding_attr
@init{pANTLR3_COMMON_TOKEN id = NULL;}
   :  T_PASS ( T_LPAREN T_IDENT T_RPAREN {id=$T_IDENT;})?
        { c_action_binding_attr($T_PASS, IActionEnums_ AttrSpec_PASS, id); }
   |  T_NOPASS          
        { c_action_binding_attr($T_NOPASS, IActionEnums_ AttrSpec_NOPASS, id); }
   |  T_NON_OVERRIDABLE 
        { c_action_binding_attr($T_NON_OVERRIDABLE, 
                              IActionEnums_ AttrSpec_NON_OVERRIDABLE, id); }
   |  T_DEFERRED        
        { c_action_binding_attr($T_DEFERRED, IActionEnums_ AttrSpec_DEFERRED, 
                              id); }
   |  access_spec       
        { c_action_binding_attr(NULL, IActionEnums_ AttrSpec_none, id); }
   ;

binding_attr_list
@init
{
   int count=0;
   c_action_binding_attr_list__begin();
}
   :   binding_attr {count++;} ( T_COMMA binding_attr {count++;} )*
          {
             c_action_binding_attr_list(count);
          }
   ;

// R454
// generic_name_list substituted for final_subroutine_name_list
final_binding
   :   T_FINAL ( T_COLON_COLON )? generic_name_list 
            { c_action_final_binding($T_FINAL); }
   ;

// R455
derived_type_spec
@init{ANTLR3_BOOLEAN hasList = ANTLR3_FALSE;}
   : T_IDENT ( T_LPAREN type_param_spec_list {hasList=ANTLR3_TRUE;} T_RPAREN )?
        { c_action_derived_type_spec($T_IDENT, hasList); }
   ;

// R456
type_param_spec
@init{ pANTLR3_COMMON_TOKEN keyWord=NULL; }
   :  ( keyword T_EQUALS {keyWord=$keyword.start;})? type_param_value
            {c_action_type_param_spec(keyWord);}
   ;

type_param_spec_list
@init{int count=0;}
   :       {c_action_type_param_spec_list__begin();} 
        type_param_spec {count++;}( T_COMMA type_param_spec {count++;})*
            {c_action_type_param_spec_list(count);} 
   ;

// R457
// inlined derived_type_spec (R662) to remove ambiguity using backtracking
// ERR_CHK R457 
// If any of the type-param-specs in the list are an '*' or ':', the 
// component-spec-list is required.
// the second alternative to the original rule for structure_constructor is 
// a subset of the first alternative because component_spec_list is a 
// subset of type_param_spec_list.  by combining these two alternatives we can
// remove the backtracking on this rule.
structure_constructor
// options {backtrack=true;}
//    : T_IDENT T_LPAREN type_param_spec_list T_RPAREN
//      T_LPAREN
//      ( component_spec_list )?
//      T_RPAREN
//    | T_IDENT
//      T_LPAREN
//      ( component_spec_list )?
//      T_RPAREN
   : T_IDENT T_LPAREN type_param_spec_list T_RPAREN
        (T_LPAREN
        ( component_spec_list )?
        T_RPAREN)?
        { c_action_structure_constructor($T_IDENT); }
   ;

// R458
component_spec
@init { pANTLR3_COMMON_TOKEN keyWord = NULL; }
   :   ( keyword T_EQUALS { keyWord=$keyword.start; })? component_data_source
            { c_action_component_spec(keyWord); }
   ;

component_spec_list
@init{int count=0;}
   :       {c_action_component_spec_list__begin();} 
        component_spec {count++;}( T_COMMA component_spec {count++;})*
            {c_action_component_spec_list(count);} 
   ;

// R459
// is (expr | data-target | proc-target)
// data_target isa expr so data_target deleted
// proc_target isa expr so proc_target deleted
component_data_source
   :   expr 
            { c_action_component_data_source(); }
   ;

// R460
enum_def
@init{ int numEls=1; }
   :   enum_def_stmt
        enumerator_def_stmt
        ( enumerator_def_stmt {numEls++;})*
        end_enum_stmt
            {c_action_enum_def(numEls);}
   ;

// R461
enum_def_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_ENUM T_COMMA T_BIND T_LPAREN 
            T_IDENT /* 'C' */ T_RPAREN end_of_stmt
            {c_action_enum_def_stmt(lbl, $T_ENUM, $T_BIND, $T_IDENT, 
                $end_of_stmt.start);}
   ;

// R462
enumerator_def_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_ENUMERATOR ( T_COLON_COLON )? 
            enumerator_list end_of_stmt
            {c_action_enumerator_def_stmt(lbl, $T_ENUMERATOR, $end_of_stmt.start);}
   ;

// R463
// ERR_CHK 463 scalar_int_initialization_expr replaced by expr
// ERR_CHK 463 named_constant replaced by T_IDENT
enumerator
@init{ANTLR3_BOOLEAN hasExpr = ANTLR3_FALSE;}
   :   T_IDENT ( T_EQUALS expr { hasExpr = ANTLR3_TRUE; })?
            { c_action_enumerator($T_IDENT, hasExpr); }
   ;

enumerator_list
@init{int count=0;}
   :       {c_action_enumerator_list__begin();} 
        enumerator {count++;}( T_COMMA enumerator {count++;})*
            {c_action_enumerator_list(count);} 
   ;

// R464
end_enum_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_END T_ENUM end_of_stmt 
            { c_action_end_enum_stmt(lbl, $T_END, $T_ENUM, $end_of_stmt.start); }
   |   (label {lbl=$label.start;})? T_ENDENUM end_of_stmt 
            { c_action_end_enum_stmt(lbl, $T_ENDENUM, NULL, $end_of_stmt.start); }
   ;

// R465
array_constructor
   :   T_LPAREN T_SLASH ac_spec T_SLASH T_RPAREN
            { c_action_array_constructor(); }
   |   T_LBRACKET ac_spec T_RBRACKET
            { c_action_array_constructor(); }
   ;

// R466
// refactored to remove optional from lhs
ac_spec
options {backtrack=true;}
@after {
    c_action_ac_spec();
}
   : type_spec T_COLON_COLON (ac_value_list)?
   | ac_value_list
   ;

// R467 left_square_bracket inlined as T_LBRACKET

// R468 right_square_bracket inlined as T_RBRACKET

// R469
ac_value
options {backtrack=true;}
@after {
    c_action_ac_value();
}
   :   expr
   |   ac_implied_do
   ;

ac_value_list
@init{int count=0;}
   :       {c_action_ac_value_list__begin();} 
        ac_value {count++;}( T_COMMA ac_value {count++;})*
            {c_action_ac_value_list(count);} 
   ;

// R470
ac_implied_do
   :   T_LPAREN ac_value_list T_COMMA ac_implied_do_control T_RPAREN
            {c_action_ac_implied_do();}
   ;

// R471
// ERR_CHK 471a scalar_int_expr replaced by expr
// ERR_CHK 471b ac_do_variable replaced by do_variable
ac_implied_do_control
@init{ANTLR3_BOOLEAN hasStride=ANTLR3_FALSE;}
   :    do_variable T_EQUALS expr T_COMMA expr ( T_COMMA expr {hasStride=ANTLR3_TRUE;})?
            {c_action_ac_implied_do_control(hasStride);}
   ;

// R472 inlined ac_do_variable as scalar_int_variable (and finally T_IDENT) 
// in R471
// C493 (R472) ac-do-variable shall be a named variable
scalar_int_variable
   :   variable
            { c_action_scalar_int_variable(); }
   ;


/**
 * Section/Clause 5: Attribute declarations and specifications
 */


////////////
// R501-F08
//
// Implemented in "Extras" section
//
//----------------------------------------------------------------------------------------
///JAVA type_declaration_stmt
///JAVA @init {pANTLR3_COMMON_TOKEN lbl = NULL; int numAttrSpecs = 0;}
///JAVA @after{checkForInclude();}
///JAVA    :   (label {lbl=$label.start;})? declaration_type_spec
///JAVA        ( (T_COMMA attr_spec {numAttrSpecs += 1;})* T_COLON_COLON )?
///JAVA        entity_decl_list end_of_stmt
///JAVA           {
///JAVA              c_action_type_declaration_stmt(lbl, numAttrSpecs, $end_of_stmt.start);
///JAVA           }
///JAVA 
///JAVA    -> ^(SgVariableDeclaration declaration_type_spec entity_decl+ label?)
///JAVA 
///JAVA    ;


/*
 * R502-F08 attr-spec
 *   is  access-spec
 *   or  ALLOCATABLE
 *   or  ASYNCHRONOUS
 *   or  CODIMENSION lbracket coarray-spec rbracket  // NEW_TO_2008
 *   or  CONTIGUOUS                                  // NEW_TO_2008
 *   or  DIMENSION ( array-spec )
 *   or  EXTERNAL
 *   or  INTENT ( intent-spec )
 *   or  INTRINSIC
 *   or  language-binding-spec
 *   or  OPTIONAL
 *   or  PARAMETER
 *   or  POINTER
 *   or  PROTECTED
 *   or  SAVE
 *   or  TARGET
 *   or  VALUE
 *   or  VOLATILE
 */

////////////
// R502-F08, R503-F03
//
attr_spec
   :   access_spec
           {c_action_attr_spec(NULL, IActionEnums_ AttrSpec_access);}
   -> OFPUnimplemented
   |   T_ALLOCATABLE
           {c_action_attr_spec($T_ALLOCATABLE, IActionEnums_ AttrSpec_ALLOCATABLE);}
   -> OFPUnimplemented
   |   T_ASYNCHRONOUS
           {c_action_attr_spec($T_ASYNCHRONOUS, IActionEnums_ AttrSpec_ASYNCHRONOUS);}
   -> OFPUnimplemented
   |   T_CODIMENSION T_LBRACKET coarray_spec T_RBRACKET  // NEW_TO_2008
           {c_action_attr_spec($T_CODIMENSION, IActionEnums_ AttrSpec_CODIMENSION);}
   -> OFPUnimplemented
   |   T_CONTIGUOUS                                      // NEW_TO_2008
           {c_action_attr_spec($T_CONTIGUOUS, IActionEnums_ AttrSpec_CONTIGUOUS);}
   -> OFPUnimplemented
   |   T_DIMENSION T_LPAREN array_spec T_RPAREN
           {c_action_attr_spec($T_DIMENSION, IActionEnums_ AttrSpec_DIMENSION);}
   -> OFPUnimplemented
   |   T_EXTERNAL
           {c_action_attr_spec($T_EXTERNAL, IActionEnums_ AttrSpec_EXTERNAL);}
   -> OFPUnimplemented
   |   T_INTENT T_LPAREN intent_spec T_RPAREN
           {c_action_attr_spec($T_INTENT, IActionEnums_ AttrSpec_INTENT);}
   -> intent_spec
   |   T_INTRINSIC
           {c_action_attr_spec($T_INTRINSIC, IActionEnums_ AttrSpec_INTRINSIC);}
   -> OFPUnimplemented
   |   language_binding_spec        
           {c_action_attr_spec(NULL, IActionEnums_ AttrSpec_language_binding);}
   -> OFPUnimplemented
   |   T_OPTIONAL
           {c_action_attr_spec($T_OPTIONAL, IActionEnums_ AttrSpec_OPTIONAL);}
   -> OFPOptional
   |   T_PARAMETER
           {c_action_attr_spec($T_PARAMETER, IActionEnums_ AttrSpec_PARAMETER);}
   -> OFPUnimplemented
   |   T_POINTER
           {c_action_attr_spec($T_POINTER, IActionEnums_ AttrSpec_POINTER);}
   -> OFPUnimplemented
   |   T_PROTECTED
           {c_action_attr_spec($T_PROTECTED, IActionEnums_ AttrSpec_PROTECTED);}
   -> OFPUnimplemented
   |   T_SAVE
           {c_action_attr_spec($T_SAVE, IActionEnums_ AttrSpec_SAVE);}
   -> OFPUnimplemented
   |   T_TARGET
           {c_action_attr_spec($T_TARGET, IActionEnums_ AttrSpec_TARGET);}
   -> OFPUnimplemented
   |   T_VALUE
           {c_action_attr_spec($T_VALUE, IActionEnums_ AttrSpec_VALUE);}
   -> OFPUnimplemented
   |   T_VOLATILE
           {c_action_attr_spec($T_VOLATILE, IActionEnums_ AttrSpec_VOLATILE);}
// TODO are T_KIND and T_LEN correct?
   -> OFPUnimplemented
   |   T_KIND
           {c_action_attr_spec($T_KIND, IActionEnums_ AttrSpec_KIND);}
   -> OFPUnimplemented
   |   T_LEN
           {c_action_attr_spec($T_LEN, IActionEnums_ AttrSpec_LEN);}
   -> OFPUnimplemented
   |   attr_spec_extension
   -> OFPUnimplemented
   ;
    
// language extension point
attr_spec_extension : T_NO_LANGUAGE_EXTENSION ;


/*
 * R503-F08 entity-decl
 *   is  object-name [( array-spec )]
 *         [ lracket coarray-spec rbracket ]
 *         [ * char-length ] [ initialization ]
 *   or  function-name [ * char-length ]
 */

////////////
// R503-F08, R504-F03
//
// T_IDENT inlined for object_name and function_name
// T_IDENT ( T_ASTERISK char_length )? takes character and function
// TODO Pass more info to c_action_...
entity_decl
@init{
   ANTLR3_BOOLEAN hasArraySpec=ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasCoarraySpec=ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasCharLength=ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasInitialization=ANTLR3_FALSE;
}
@after
{
   treeSetTokenBoundaries(retval.tree, id, id, 0);
}
   :   id=T_IDENT ( T_LPAREN array_spec T_RPAREN {hasArraySpec=ANTLR3_TRUE;} )?
                  ( T_LBRACKET coarray_spec T_RBRACKET {hasCoarraySpec=ANTLR3_TRUE;} )?
                  ( T_ASTERISK char_length {hasCharLength=ANTLR3_TRUE;} )?
                  ( initialization {hasInitialization=ANTLR3_TRUE;} )?
          {
             c_action_entity_decl($T_IDENT, hasArraySpec,
                                hasCoarraySpec, hasCharLength, hasInitialization);
          }
   -> ^(OFPObjectName ^(OFPName T_IDENT))
   ;


entity_decl_list
@init
{
   int count = 0;
   c_action_entity_decl_list__begin();
}
@after
{
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   entity_decl {count += 1;}  ( T_COMMA  entity_decl  {count += 1;} )*
          {
             c_action_entity_decl_list(count);
          }
   -> ^(OFPEntityDeclList entity_decl+)
   ;


/*
 * R505-F03 object-name
 *   is  name
 */

////////////
// R505-F03, R504-F08
//
object_name
   :   T_IDENT
   ;

// R506
// ERR_CHK 506 initialization_expr replaced by expr
initialization
   :   T_EQUALS expr       { c_action_initialization(ANTLR3_TRUE, ANTLR3_FALSE); }
   |   T_EQ_GT null_init   { c_action_initialization(ANTLR3_FALSE, ANTLR3_TRUE); }
   ;

// R507
// C506 The function-reference shall be a reference to the NULL intrinsic 
// function with no arguments.
null_init
   :   T_IDENT /* 'NULL' */ T_LPAREN T_RPAREN
            { c_action_null_init($T_IDENT); }
   ;

/*
 * R509-F08 coarray-spec
 *   is  deferred-coshape-spec-list
 *   or  explicit-coshape-spec
 */

////////////
// R509-F08
//
// deferred-coshape-spec-list and explicit-coshape-spec rules are ambiguous so
// we use the same method as for array-spec.  Enough information is provided so
// that the coarray_spec can be figured out by the actions.  Note, that this
// means the parser can't determine all incorrect syntax as many rules are
// combined into one.  It is the action's responsiblity to enforce correct syntax.
//
coarray_spec
@init{int count=0;}
   :   array_spec_element {count++;} (T_COMMA array_spec_element {count++;})*
           {c_action_coarray_spec(count);}
   ;

// R508
access_spec
   :   T_PUBLIC
            {c_action_access_spec($T_PUBLIC,  IActionEnums_ AttrSpec_PUBLIC);}
   |   T_PRIVATE
            {c_action_access_spec($T_PRIVATE, IActionEnums_ AttrSpec_PRIVATE);}
   ;

// R509
// ERR_CHK 509 scalar_char_initialization_expr replaced by expr
language_binding_spec
@init
{
   ANTLR3_BOOLEAN hasName = ANTLR3_FALSE;
}
   :   T_BIND T_LPAREN T_IDENT /* 'C' */ 
       (T_COMMA name T_EQUALS expr {hasName=ANTLR3_TRUE;})? T_RPAREN
          {
             c_action_language_binding_spec($T_BIND, $T_IDENT, hasName);
          }

   -> ^(OFPBind T_IDENT expr?)
   ;

// R510
array_spec
@init{int count=0;}
   :   array_spec_element {count++;}
        (T_COMMA array_spec_element {count++;})*
            {c_action_array_spec(count);}
   ;

// Array specifications can consist of these beasts. Note that we can't 
// mix/match arbitrarily, so we have to check validity in actions.
// Types:   0 expr (e.g. 3 or m+1)
//          1 expr: (e.g. 3:)
//          2 expr:expr (e.g. 3:5 or 7:(m+1))
//          3 expr:* (e.g. 3:* end of assumed size)
//          4 *  (end of assumed size)
//          5 :  (could be part of assumed or deferred shape)
array_spec_element
@init
{
   int type=IActionEnums_ ArraySpecElement_expr;
}
   :   expr
       ( T_COLON            {type=IActionEnums_ ArraySpecElement_expr_colon;}
          (  expr           {type=IActionEnums_ ArraySpecElement_expr_colon_expr;}
             | T_ASTERISK   {type=IActionEnums_ ArraySpecElement_expr_colon_asterisk;}
          )?
       )?
            {
               c_action_array_spec_element(type);
            }

   |   T_ASTERISK
            {
               c_action_array_spec_element(IActionEnums_ ArraySpecElement_asterisk);
            }

   |   T_COLON
            {
               c_action_array_spec_element(IActionEnums_ ArraySpecElement_colon);
            }
   ;


// R511
// refactored to remove conditional from lhs and inlined lower_bound and 
// upper_bound
explicit_shape_spec
@init{ANTLR3_BOOLEAN hasUpperBound=ANTLR3_FALSE;}
   :   expr (T_COLON expr {hasUpperBound=ANTLR3_TRUE;})?
            {c_action_explicit_shape_spec(hasUpperBound);}
   ;

explicit_shape_spec_list
@init{ int count=0;}
   :       {c_action_explicit_shape_spec_list__begin();}
        explicit_shape_spec {count++;} 
            ( T_COMMA explicit_shape_spec {count++;})*
            {c_action_explicit_shape_spec_list(count);}
   ;

// R512 lower_bound was specification_expr inlined as expr

// R513 upper_bound was specification_expr inlined as expr

// R514 assumed_shape_spec was ( lower_bound )? T_COLON not used in R510 
// array_spec

// R515 deferred_shape_spec inlined as T_COLON in deferred_shape_spec_list

// R516 assumed_size_spec absorbed into array_spec.

// R517
intent_spec
   :   T_IN        { c_action_intent_spec($T_IN, NULL, 
                IActionEnums_ IntentSpec_IN); }
   -> OFPIntentIn
   |   T_OUT       { c_action_intent_spec($T_OUT, NULL, 
                IActionEnums_ IntentSpec_OUT); }
   -> OFPIntentOut
   |   T_IN T_OUT  { c_action_intent_spec($T_IN, $T_OUT, 
                IActionEnums_ IntentSpec_INOUT); }
   -> OFPIntentInOut
   |   T_INOUT     { c_action_intent_spec($T_INOUT, NULL, 
                IActionEnums_ IntentSpec_INOUT); }
   -> OFPIntentInOut
   ;

// R518
access_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;ANTLR3_BOOLEAN hasList=ANTLR3_FALSE;}
@after{checkForInclude();}
   :    (label {lbl=$label.start;})? access_spec ( ( T_COLON_COLON )? 
            access_id_list {hasList=ANTLR3_TRUE;})? end_of_stmt
            { c_action_access_stmt(lbl,$end_of_stmt.start,hasList); }
   ;

// R519
// T_IDENT inlined for use_name
// generic_spec can be T_IDENT so T_IDENT deleted
// TODO - can this only be T_IDENTS?  generic_spec is more than that..
access_id
   :   generic_spec
            { c_action_access_id(); }
   ;

access_id_list
@init{ int count=0;}
   :       {c_action_access_id_list__begin();}
        access_id {count++;} ( T_COMMA access_id {count++;} )*
            {c_action_access_id_list(count);}
   ;

////////////
// R520-F03, R526-F08
//     - form of F08 used with allocatable_decl_list
//
allocatable_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       T_ALLOCATABLE ( T_COLON_COLON )? allocatable_decl_list end_of_stmt
           {c_action_allocatable_stmt(lbl, $T_ALLOCATABLE, $end_of_stmt.start);}
   ;

/*
 * R527-F08 allocatable-decl
 *   is  object-name [ ( array-spec ) ] [ lbracket ( coarray-spec ) ]
 */

////////////
// R527-F08
//
allocatable_decl
@init{pANTLR3_COMMON_TOKEN objName=NULL; ANTLR3_BOOLEAN hasArraySpec=ANTLR3_FALSE; ANTLR3_BOOLEAN hasCoarraySpec=ANTLR3_FALSE;}
   :   object_name {objName=$object_name.start;}
          ( T_LPAREN array_spec T_RPAREN {hasArraySpec=ANTLR3_TRUE;} )?
          ( T_LBRACKET coarray_spec T_RBRACKET {hasCoarraySpec=ANTLR3_TRUE;} )?
              {c_action_allocatable_decl(objName, hasArraySpec, hasCoarraySpec);}
   ;

allocatable_decl_list
@init{int count=0;}
   :       {c_action_allocatable_decl_list__begin();}
       allocatable_decl {count++;} ( T_COMMA allocatable_decl {count++;} )*
           {c_action_allocatable_decl_list(count);}
   ;

// R521
// generic_name_list substituted for object_name_list
asynchronous_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_ASYNCHRONOUS ( T_COLON_COLON )?
        generic_name_list end_of_stmt
            {c_action_asynchronous_stmt(lbl,$T_ASYNCHRONOUS,$end_of_stmt.start);}
   ;

// R522
bind_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? language_binding_spec
        ( T_COLON_COLON )? bind_entity_list end_of_stmt
            { c_action_bind_stmt(lbl, $end_of_stmt.start); }
   ;

// R523
// T_IDENT inlined for entity_name and common_block_name
bind_entity
   :   T_IDENT 
        { c_action_bind_entity($T_IDENT, ANTLR3_FALSE); }// isCommonBlockName=false
   |   T_SLASH T_IDENT T_SLASH 
        { c_action_bind_entity($T_IDENT, ANTLR3_TRUE); }// isCommonBlockname=true
   ;

bind_entity_list
@init{ int count=0;}
   :       {c_action_bind_entity_list__begin();}
        bind_entity {count++;} ( T_COMMA bind_entity {count++;} )*
            {c_action_bind_entity_list(count);}
   ;

// R524
data_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; int count=1;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_DATA data_stmt_set ( ( T_COMMA )? 
            data_stmt_set {count++;})* end_of_stmt
            { c_action_data_stmt(lbl, $T_DATA, $end_of_stmt.start, count); }
   ;

// R525
data_stmt_set
   :   data_stmt_object_list
        T_SLASH
        data_stmt_value_list
        T_SLASH
            { c_action_data_stmt_set(); }
   ;

// R526
data_stmt_object
@after {
    c_action_data_stmt_object();
}
   :   variable
   |   data_implied_do
   ;

data_stmt_object_list
@init{ int count=0;}
   :       {c_action_data_stmt_object_list__begin();}
        data_stmt_object {count++;} ( T_COMMA data_stmt_object {count++;} )*
            {c_action_data_stmt_object_list(count);}
   ;


// R527
// ERR_CHK 527 scalar_int_expr replaced by expr
// data_i_do_variable replaced by T_IDENT
data_implied_do
@init {
    ANTLR3_BOOLEAN hasThirdExpr = ANTLR3_FALSE;
}
   : T_LPAREN data_i_do_object_list T_COMMA T_IDENT T_EQUALS
        expr T_COMMA expr ( T_COMMA expr { hasThirdExpr = ANTLR3_TRUE; })? T_RPAREN
        { c_action_data_implied_do($T_IDENT, hasThirdExpr); }
   ;

// R528
// data_ref inlined for scalar_structure_component and array_element
data_i_do_object
@after {
    c_action_data_i_do_object();
}
   :   data_ref
   |   data_implied_do
   ;

data_i_do_object_list
@init{ int count=0;}
   :       {c_action_data_i_do_object_list__begin();}
        data_i_do_object {count++;} ( T_COMMA data_i_do_object {count++;} )*
            {c_action_data_i_do_object_list(count);}
   ;

// R529 data_i_do_variable was scalar_int_variable inlined as T_IDENT
// C556 (R529) The data-i-do-variable shall be a named variable.

// R530
// ERR_CHK R530 designator is scalar-constant or integer constant when 
// followed by '*'
// data_stmt_repeat inlined from R531
// structure_constructure covers null_init if 'NULL()' so null_init deleted
// TODO - check for other cases of signed_real_literal_constant and 
// real_literal_constant problems
data_stmt_value
options {backtrack=true; k=3;}
@init {pANTLR3_COMMON_TOKEN ast = NULL;}
@after{c_action_data_stmt_value(ast);}
   :   designator (T_ASTERISK data_stmt_constant {ast=$T_ASTERISK;})?
   |   int_literal_constant (T_ASTERISK data_stmt_constant {ast=$T_ASTERISK;})?
   |   signed_real_literal_constant
   |   signed_int_literal_constant
   |   complex_literal_constant
   |   logical_literal_constant
   |   char_literal_constant
   |   boz_literal_constant
   |   structure_constructor       // is null_init if 'NULL()'
   |   hollerith_literal_constant  // deleted in F77
   ;

data_stmt_value_list
@init{ int count=0;}
   :       {c_action_data_stmt_value_list__begin();}
        data_stmt_value {count++;} ( T_COMMA data_stmt_value {count++;} )*
            {c_action_data_stmt_value_list(count);}
   ;

// R531 data_stmt_repeat inlined as (int_literal_constant | designator) in R530
// ERRCHK 531 int_constant shall be a scalar_int_constant
// scalar_int_constant replaced by int_constant replaced by 
// int_literal_constant as T_IDENT covered by designator
// scalar_int_constant_subobject replaced by designator

scalar_int_constant
   :   int_constant
            { c_action_scalar_int_constant(); }
   ;

// R532
// scalar_constant_subobject replaced by designator
// scalar_constant replaced by literal_constant as designator can be T_IDENT
// then literal_constant inlined (except for signed portion)
// structure_constructure covers null_init if 'NULL()' so null_init deleted
// The lookahead in the alternative for signed_real_literal_constant is 
// necessary because ANTLR won't look far enough ahead by itself and when it
// sees a T_DIGIT_STRING, it tries the signed_int_literal_constant.  this isn't
// correct since the new version of the real_literal_constants can start with
// a T_DIGIT_STRING.  
data_stmt_constant
options {backtrack=true; k=3;}
@after {
    c_action_data_stmt_constant();
}
   :   designator
   |   signed_int_literal_constant
   |   signed_real_literal_constant
   |   complex_literal_constant
   |   logical_literal_constant
   |   char_literal_constant
   |   boz_literal_constant
   |   structure_constructor // is null_init if 'NULL()'
   ;


/*
 * R531-F08 codimension-stmt
 *   is  CODIMENSION [ :: ] codimension-decl-list
 */

////////////
// R531-F08
//
codimension_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       T_CODIMENSION ( T_COLON_COLON )? codimension_decl_list end_of_stmt
          { c_action_codimension_stmt(lbl, $T_CODIMENSION, $end_of_stmt.start); }
   ;
   
/*
 * R532-08 codimension-decl
 *   is  coarray-name lbracket coarray-spec rbracket
 */

////////////
// R532-F08
//
codimension_decl
   :   T_IDENT T_LBRACKET coarray_spec T_RBRACKET
           {c_action_codimension_decl($T_IDENT, $T_LBRACKET, $T_RBRACKET);}
   ;

codimension_decl_list
@init{int count=0;}
   :       {c_action_codimension_decl_list__begin();}
       codimension_decl {count++;} ( T_COMMA codimension_decl {count++;} )*
           {c_action_codimension_decl_list(count);}
   ;

// R533 int_constant_subobject was constant_subobject inlined as designator 
// in R531

// R534 constant_subobject inlined as designator in R533
// C566 (R534) constant-subobject shall be a subobject of a constant.

// R535, R543-F2008
// array_name replaced by T_IDENT
dimension_stmt
@init {pANTLR3_COMMON_TOKEN lbl=NULL; int count=1;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_DIMENSION ( T_COLON_COLON )? 
        dimension_decl ( T_COMMA dimension_decl {count++;})* end_of_stmt
            { c_action_dimension_stmt(lbl, $T_DIMENSION, $end_of_stmt.start, count); }
   ;

// R535-subrule
dimension_decl
   :   T_IDENT T_LPAREN array_spec T_RPAREN
           {c_action_dimension_decl($T_IDENT);}
   ;

// R536
// generic_name_list substituted for dummy_arg_name_list
intent_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_INTENT T_LPAREN intent_spec T_RPAREN 
            ( T_COLON_COLON )? generic_name_list end_of_stmt
            {c_action_intent_stmt(lbl,$T_INTENT,$end_of_stmt.start);}
   ;

// R537
// generic_name_list substituted for dummy_arg_name_list
optional_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_OPTIONAL ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
            { c_action_optional_stmt(lbl, $T_OPTIONAL, $end_of_stmt.start); }
        
   ;

// R538
parameter_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_PARAMETER T_LPAREN 
            named_constant_def_list T_RPAREN end_of_stmt
            {c_action_parameter_stmt(lbl,$T_PARAMETER,$end_of_stmt.start);}
   ;

named_constant_def_list
@init{ int count=0;}
   :       {c_action_named_constant_def_list__begin();}
        named_constant_def {count++;} 
            ( T_COMMA named_constant_def {count++;} )*
            {c_action_named_constant_def_list(count);}
   ;

// R539
// ERR_CHK 539 initialization_expr replaced by expr
// ERR_CHK 539 named_constant replaced by T_IDENT
named_constant_def
   :   T_IDENT T_EQUALS expr
            {c_action_named_constant_def($T_IDENT);}
   ;

/*
 * R550-F08
 *   is  POINTER [ :: ] pointer-decl-list
 */

////////////
// R550-F08, R540-F03
//
// Cray pointer extension added 11/17/2010
//
pointer_stmt
@init {pANTLR3_COMMON_TOKEN lbl=NULL; ANTLR3_BOOLEAN isCrayPointer=ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_POINTER
       (
              cray_pointer_assoc_list  {isCrayPointer = ANTLR3_TRUE;}
          |
              ( ( T_COLON_COLON )? pointer_decl_list )
       ) end_of_stmt
              {
                 if (isCrayPointer) {
                    c_action_cray_pointer_stmt(lbl,$T_POINTER,$end_of_stmt.start);
                 } else {
                    c_action_pointer_stmt(lbl,$T_POINTER,$end_of_stmt.start);
                 }
              }
   ;

pointer_decl_list
@init{int count=0;}
   :      {c_action_pointer_decl_list__begin();}
       pointer_decl {count++;} ( T_COMMA pointer_decl {count++;} )*
          {c_action_pointer_decl_list(count);}
   ;

/*
 * R551-F08
 *   is  object-name [ ( deferred-shape-spec-list ) ]
 *   or  proc-entity-name    
 */

////////////
// R551-F08, R541-F03
//
// T_IDENT inlined as object_name and proc_entity_name (removing second alt)
pointer_decl
@init{ANTLR3_BOOLEAN hasSpecList=ANTLR3_FALSE;}
   :    T_IDENT ( T_LPAREN deferred_shape_spec_list T_RPAREN 
            {hasSpecList=ANTLR3_TRUE;})?
            {c_action_pointer_decl($T_IDENT,hasSpecList);}
   ;

cray_pointer_assoc_list
@init{int count=0;}
   :      {c_action_cray_pointer_assoc_list__begin();}
       cray_pointer_assoc {count++;} ( T_COMMA cray_pointer_assoc {count++;} )*
          {c_action_cray_pointer_assoc_list(count);}
   ;

cray_pointer_assoc
   :   T_LPAREN pointer=T_IDENT T_COMMA pointee=T_IDENT T_RPAREN
          {c_action_cray_pointer_assoc(pointer, pointee);}
   ;

// R542
// generic_name_list substituted for entity_name_list
protected_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_PROTECTED ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
            {c_action_protected_stmt(lbl,$T_PROTECTED,$end_of_stmt.start);}
   ;

// R543
save_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasSavedEntityList=ANTLR3_FALSE;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_SAVE ( ( T_COLON_COLON )? 
            saved_entity_list {hasSavedEntityList=ANTLR3_TRUE;})? end_of_stmt
            {c_action_save_stmt(lbl,$T_SAVE,$end_of_stmt.start,hasSavedEntityList);}
   ;

// R544
// T_IDENT inlined for object_name, proc_pointer_name (removing second alt), 
// and common_block_name
saved_entity
   :   id=T_IDENT
            {c_action_saved_entity(id, ANTLR3_FALSE);}
   |   T_SLASH id=T_IDENT T_SLASH
            {c_action_saved_entity(id, ANTLR3_TRUE);}   // is common block name
   ;

saved_entity_list
@init{ int count=0;}
   :       {c_action_saved_entity_list__begin();}
        saved_entity {count++;} ( T_COMMA saved_entity {count++;} )*
            {c_action_saved_entity_list(count);}
   ;


// R545 proc_pointer_name was name inlined as T_IDENT

// R546, R555-F08
// T_IDENT inlined for object_name
target_stmt
@init
{
   pANTLR3_COMMON_TOKEN lbl = NULL;
}
@after
{
   checkForInclude();
}
   :   (label {lbl=$label.start;})?
       T_TARGET ( T_COLON_COLON )? target_decl_list end_of_stmt
            {c_action_target_stmt(lbl,$T_TARGET,$end_of_stmt.start);}
   ;

/*
 * R557-F08 target-decl
 *    is  object-name [ ( array-spec ) ]
 *                    [ lbracket coarray-spec rbracket ]
 */

////////////
// R557-F08
//
target_decl
@init{ANTLR3_BOOLEAN hasArraySpec=ANTLR3_FALSE; ANTLR3_BOOLEAN hasCoarraySpec=ANTLR3_FALSE;}
   :   T_IDENT (T_LPAREN array_spec T_RPAREN {hasArraySpec=ANTLR3_TRUE;} )?
               (T_LBRACKET coarray_spec T_RBRACKET {hasCoarraySpec=ANTLR3_TRUE;} )?
          {c_action_target_decl($T_IDENT,hasArraySpec,hasCoarraySpec);}
   ;

// R557-F08
target_decl_list
@init{ int count=0;}
   :       {c_action_target_decl_list__begin();}
       target_decl {count++;} ( T_COMMA target_decl {count++;} )*
           {c_action_target_decl_list(count);}
   ;

// R547
// generic_name_list substituted for dummy_arg_name_list
value_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_VALUE ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
            {c_action_value_stmt(lbl,$T_VALUE,$end_of_stmt.start);}
   ;

// R548
// generic_name_list substituted for object_name_list
volatile_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_VOLATILE ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
            {c_action_volatile_stmt(lbl,$T_VOLATILE,$end_of_stmt.start);}
   ;

//========================================================================================
// R560-F08 implicit-stmt
//----------------------------------------------------------------------------------------
implicit_stmt
@after
{
   checkForInclude();
}
   :   lbl=label?  T_IMPLICIT  implicit_spec_list  end_of_stmt
          {
             c_action_implicit_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_IMPLICIT,NULL,$end_of_stmt.start,ANTLR3_TRUE);
          }

   -> ^(SgImplicitStatement ^(OFPLabel label?) implicit_spec_list)

   |   lbl=label?  T_IMPLICIT T_NONE               end_of_stmt

          {
             c_action_implicit_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_IMPLICIT,$T_NONE,$end_of_stmt.start,ANTLR3_FALSE);
          }

   -> ^(SgImplicitStatement ^(OFPLabel label?) OFPList)
   ;

// R561-F08
implicit_spec
   :   declaration_type_spec T_LPAREN letter_spec_list T_RPAREN
        { c_action_implicit_spec(); }
   ;

implicit_spec_list
@init
{
   int count=0;
   c_action_implicit_spec_list__begin();
}
   :   implicit_spec {count++;} ( T_COMMA implicit_spec {count++;} )*

          {
             c_action_implicit_spec_list(count);
          }

    -> ^(OFPList implicit_spec+)
   ;


// R562-F08
// TODO: here, we'll accept a T_IDENT, and then we'll have to do error 
// checking on it.  
letter_spec 
   :  id1=T_IDENT ( T_MINUS id2=T_IDENT )? 
         {
            c_action_letter_spec(id1, id2);
         }
   ;

letter_spec_list
@init
{
   int count=0;
   c_action_letter_spec_list__begin();
}
   :   letter_spec {count++;} ( T_COMMA letter_spec {count++;} )*
          {
             c_action_letter_spec_list(count);
          }
   ;

// R552
// T_IDENT inlined for namelist_group_name
namelist_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;int count =1;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_NAMELIST T_SLASH nlName=T_IDENT T_SLASH
            {c_action_namelist_group_name(nlName);}
        namelist_group_object_list
        ( ( T_COMMA )?  T_SLASH nlName=T_IDENT T_SLASH
            {c_action_namelist_group_name(nlName);}
        namelist_group_object_list {count++;})* end_of_stmt
            {c_action_namelist_stmt(lbl,$T_NAMELIST,$end_of_stmt.start,count);}
   ;

// R553 namelist_group_object was variable_name inlined as T_IDENT

// T_IDENT inlined for namelist_group_object
namelist_group_object_list
@init{ int count=0;}
   :       {c_action_namelist_group_object_list__begin();}
        goName=T_IDENT {c_action_namelist_group_object(goName); count++;}
            ( T_COMMA goName=T_IDENT 
            {c_action_namelist_group_object(goName); count++;} )*
            {c_action_namelist_group_object_list(count);}
   ;

// R554
equivalence_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_EQUIVALENCE equivalence_set_list 
            end_of_stmt
            {c_action_equivalence_stmt(lbl, $T_EQUIVALENCE, $end_of_stmt.start);}
   ;

// R555
equivalence_set
   :   T_LPAREN equivalence_object T_COMMA equivalence_object_list T_RPAREN
        { c_action_equivalence_set(); }
   ;


equivalence_set_list
@init{ int count=0;}
   :       {c_action_equivalence_set_list__begin();}
        equivalence_set {count++;} ( T_COMMA equivalence_set {count++;} )*
            {c_action_equivalence_set_list(count);}
   ;

// R556
// T_IDENT inlined for variable_name
// data_ref inlined for array_element
// data_ref isa T_IDENT so T_IDENT deleted (removing first alt)
// substring isa data_ref so data_ref deleted (removing second alt)
equivalence_object
   :   substring { c_action_equivalence_object(); }
   ;

equivalence_object_list
@init{ int count=0;}
   :       {c_action_equivalence_object_list__begin();}
        equivalence_object {count++;} 
            ( T_COMMA equivalence_object {count++;} )*
            {c_action_equivalence_object_list(count);}
   ;

// R557
// c_action_common_block_name must be called here because it needs
//     to be called even if optional '/common_block_name/' is not present
common_stmt
@init {pANTLR3_COMMON_TOKEN lbl=NULL; int numBlocks=1;} 
@after{checkForInclude();}
   : (label {lbl=$label.start;})? 
        T_COMMON ( cb_name=common_block_name )?
            { c_action_common_block_name(cb_name); }
        common_block_object_list
        ( ( T_COMMA )? cb_name=common_block_name
            { c_action_common_block_name(cb_name); }
        common_block_object_list {numBlocks++;} )* end_of_stmt
            {c_action_common_stmt(lbl, $T_COMMON, $end_of_stmt.start, numBlocks);}
   ;

// T_SLASH_SLASH must be a option in case there are no spaces slashes, '//'
common_block_name returns [pANTLR3_COMMON_TOKEN id]
@init
{
   retval.id = NULL;
}
   :   T_SLASH_SLASH
   |   T_SLASH  T_IDENT?  T_SLASH
           {
              retval.id=$T_IDENT;
           }
   ;

// R558
// T_IDENT inlined for variable_name and proc_pointer_name
// T_IDENT covered by first alt so second deleted
common_block_object
@init{ANTLR3_BOOLEAN hasShapeSpecList=ANTLR3_FALSE;}
   : T_IDENT ( T_LPAREN explicit_shape_spec_list T_RPAREN 
            {hasShapeSpecList=ANTLR3_TRUE;})?
            {c_action_common_block_object($T_IDENT,hasShapeSpecList);}
   ;

common_block_object_list
@init{ int count=0;}
   :       {c_action_common_block_object_list__begin();}
        common_block_object {count++;} 
            ( T_COMMA common_block_object {count++;} )*
            {c_action_common_block_object_list(count);}
   ;


/**
 * Section/Clause 6: Use of data objects
 */               

//========================================================================================
/* R601-F08 designator
 *    is object-name
 *    or array-element
 *    or array-section
 *    or coindexed-named-object
 *    or complex-part-designator
 *    or structure-component
 *    or substring
 */
//
//  :   object-name             // T_IDENT (data-ref isa T_IDENT)
//  |   array-element           // R616 is data-ref
//  |   array-section           // R617 is data-ref [ (substring-range) ] 
//  |   structure-component     // R614 is data-ref
//  |   substring
// (substring-range) may be matched in data-ref
// this rule is now identical to substring
//----------------------------------------------------------------------------------------
designator
@init
{
   ANTLR3_BOOLEAN hasSubstringRange = ANTLR3_FALSE;
}
@after
{
   c_action_designator(hasSubstringRange);
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   data_ref ( T_LPAREN substring_range T_RPAREN {hasSubstringRange=ANTLR3_TRUE;} )?

   ->  ^(OFPDesignator data_ref substring_range?)

   |   char_literal_constant T_LPAREN substring_range T_RPAREN {hasSubstringRange=ANTLR3_TRUE;}

   ->  ^(OFPDesignator char_literal_constant substring_range)
   ;

// R603 variable_name was name inlined as T_IDENT

//
// a function_reference is ambiguous with designator, ie, foo(b) could be an 
// array element
//  function_reference : procedure_designator T_LPAREN 
// ( actual_arg_spec_list )? T_RPAREN
//                       procedure_designator isa data_ref
// C1220 (R1217) The procedure-designator shall designate a function.
// data_ref may (or not) match T_LPAREN ( actual_arg_spec_list )? T_RPAREN, 
// so is optional
designator_or_func_ref
@init {
    ANTLR3_BOOLEAN hasSubstringRangeOrArgList = ANTLR3_FALSE;
    ANTLR3_BOOLEAN hasSubstringRange = ANTLR3_FALSE;
}
@after {
    c_action_designator_or_func_ref();
}
   :   data_ref (T_LPAREN substring_range_or_arg_list
                    {
                        hasSubstringRangeOrArgList = ANTLR3_TRUE;
                        hasSubstringRange=
                            $substring_range_or_arg_list.isSubstringRange;
                    }
                  T_RPAREN)?
            {
                if (hasSubstringRangeOrArgList) {
                    if (hasSubstringRange) {
                        c_action_designator(hasSubstringRange);
                    } else {
                        // hasActualArgSpecList=true
                        c_action_function_reference(ANTLR3_TRUE);
                    }
                }
            }
   |   char_literal_constant T_LPAREN substring_range T_RPAREN
            { hasSubstringRange=ANTLR3_TRUE; c_action_substring(hasSubstringRange); }
   ;

substring_range_or_arg_list returns [ANTLR3_BOOLEAN isSubstringRange]
@init
{
   int                   count          = 0;
   ANTLR3_BOOLEAN        hasUpperBound  = ANTLR3_FALSE;
   pANTLR3_COMMON_TOKEN  keyword        = NULL;

   retval.isSubstringRange = ANTLR3_FALSE;
}
@after
{
   c_action_substring_range_or_arg_list();
}
   :   T_COLON (expr {hasUpperBound = ANTLR3_TRUE;})? // substring_range
            {
                // hasLowerBound=false
                c_action_substring_range(ANTLR3_FALSE, hasUpperBound);  
                retval.isSubstringRange=ANTLR3_TRUE;
            }
   |        { 
                /* mimic actual-arg-spec-list */
                c_action_actual_arg_spec_list__begin();  
            }
       expr substr_range_or_arg_list_suffix
            {
                retval.isSubstringRange = $substr_range_or_arg_list_suffix.isSubstringRange;
            }
   |        {
                /* mimic actual-arg-spec-list */
                c_action_actual_arg_spec_list__begin(); 
            }
       T_IDENT T_EQUALS expr
            {
                count++;
                c_action_actual_arg(ANTLR3_TRUE, NULL);
                c_action_actual_arg_spec($T_IDENT);
            }
       ( T_COMMA actual_arg_spec {count++;} )*
            {
                c_action_actual_arg_spec_list(count);
            }
   |        {
                /* mimic actual-arg-spec-list */
                c_action_actual_arg_spec_list__begin(); 
            }
       ( T_IDENT T_EQUALS {keyword=$T_IDENT;} )? T_ASTERISK label
            {
                count++;
                c_action_actual_arg(ANTLR3_FALSE, $label.start);
                c_action_actual_arg_spec(keyword);
            }
        ( T_COMMA actual_arg_spec {count++;} )*
            {
                c_action_actual_arg_spec_list(count);
            }
   ;

substr_range_or_arg_list_suffix returns [ANTLR3_BOOLEAN isSubstringRange]
@init
{
   int             count          = 0;
   ANTLR3_BOOLEAN  hasUpperBound  = ANTLR3_FALSE;

   retval.isSubstringRange = ANTLR3_FALSE;
}
@after
{
   c_action_substr_range_or_arg_list_suffix();
}
   :        {
                // guessed wrong on list creation, inform of error
                c_action_actual_arg_spec_list(-1);  
            }
        T_COLON (expr {hasUpperBound=ANTLR3_TRUE;})? // substring_range
            {
                // hasLowerBound=true
                c_action_substring_range(ANTLR3_TRUE, hasUpperBound);
                retval.isSubstringRange = ANTLR3_TRUE;
            }
   |
            {
                count++;
                c_action_actual_arg(ANTLR3_TRUE, NULL); // hasExpr=true, label=null
                c_action_actual_arg_spec(NULL);         // keyword=null
            }
        ( T_COMMA actual_arg_spec {count++;} )*
            {
                c_action_actual_arg_spec_list(count);
            }  // actual_arg_spec_list
   ;


//========================================================================================
/* R602-F08 variable
 *    is  designator
 *    or  expr
 */
//----------------------------------------------------------------------------------------
variable
@after
{
   c_action_variable();
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   designator  ->  ^(OFPVariable designator)
   ;

// R604
logical_variable
   :   variable
            { c_action_logical_variable(); }
   ;

// R605
default_logical_variable
   :   variable
            { c_action_default_logical_variable(); }
   ;

scalar_default_logical_variable
   :   variable
            { c_action_scalar_default_logical_variable(); }
   ;

// R606
char_variable
   :   variable
            { c_action_char_variable(); }
   ;

// R607
default_char_variable
   :   variable
            { c_action_default_char_variable(); }
   ;

scalar_default_char_variable
   :   variable
            { c_action_scalar_default_char_variable(); }
   ;

// R608
int_variable
   :   variable
            { c_action_int_variable(); }
   ;

// R609
// C608 (R610) parent_string shall be of type character
// fix for ambiguity in data_ref allows it to match T_LPAREN substring_range 
// T_RPAREN, so required T_LPAREN substring_range T_RPAREN made optional
// ERR_CHK 609 ensure final () is (substring-range)
substring
@init{ANTLR3_BOOLEAN hasSubstringRange = ANTLR3_FALSE;}
   :   data_ref (T_LPAREN substring_range {hasSubstringRange=ANTLR3_TRUE;} T_RPAREN)?
            { c_action_substring(hasSubstringRange); }
   |   char_literal_constant T_LPAREN substring_range T_RPAREN
            { c_action_substring(ANTLR3_TRUE); }
   ;

// R610 parent_string inlined in R609 as (data_ref | char_literal_constant)
// T_IDENT inlined for scalar_variable_name
// data_ref inlined for scalar_structure_component and array_element
// data_ref isa T_IDENT so T_IDENT deleted
// scalar_constant replaced by char_literal_constant as data_ref isa T_IDENT 
// and must be character

// R611
// ERR_CHK 611 scalar_int_expr replaced by expr
substring_range
@init{
    ANTLR3_BOOLEAN hasLowerBound = ANTLR3_FALSE;
    ANTLR3_BOOLEAN hasUpperBound = ANTLR3_FALSE;
}
   :   (expr {hasLowerBound = ANTLR3_TRUE;})? T_COLON  (expr {hasUpperBound = ANTLR3_TRUE;})?
            { c_action_substring_range(hasLowerBound, hasUpperBound); }
   ;

//========================================================================================
// R611-F08 data-ref
//----------------------------------------------------------------------------------------
data_ref
@init
{
   int numPartRefs = 1;
}
@after
{
   c_action_data_ref(numPartRefs);
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
   treeSetListBoundaries (retval.tree, 1);
}
   :   part_ref ( T_PERCENT part_ref {numPartRefs += 1;})*

   ->  ^(OFPDataRef ^(OFPPartRefList part_ref+) )
   ;

/**
 * R612-F08 part-ref
 *   is  part-name [ ( section-subscript-list ) ] [ image-selector]
 */

////////////
// R612-F08, R613-F03
//
// Implemented in "Extras" section
//
//----------------------------------------------------------------------------------------
///JAVA part_ref
///JAVA    :   T_IDENT
///JAVA            {SYSTEM_ERR_PRINT("ERROR: part_ref implemented in FortranParserExtras.java\n");}
///JAVA    ;


////////////
// R614 structure_component inlined as data_ref
//

////////////
// R615 type_param_inquiry inlined in R701 then deleted as can be designator
// T_IDENT inlined for type_param_name
//

////////////
// R616 array_element inlined as data_ref
//

////////////
// R617 array_section inlined in R603
//

////////////
// R618 subscript inlined as expr
// ERR_CHK 618 scalar_int_expr replaced by expr
//


////////////
// R620-F08, R619-F03
//
// Implemented in "Extras" section
//


// R620 subscript_triplet inlined in R619
// inlined expr as subscript and stride in subscript_triplet

// R621 stride inlined as expr
// ERR_CHK 621 scalar_int_expr replaced by expr

// R622
// ERR_CHK 622 int_expr replaced by expr
vector_subscript
   :   expr
            { c_action_vector_subscript(); }
   ;

// R622 inlined vector_subscript as expr in R619
// ERR_CHK 622 int_expr replaced by expr

// R623
// modified to remove backtracking by looking for the token inserted during
// the lexical prepass if a :: was found (which required alt1 below).
allocate_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;
       ANTLR3_BOOLEAN hasTypeSpec = ANTLR3_FALSE;
       ANTLR3_BOOLEAN hasAllocOptList = ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_ALLOCATE_STMT_1 T_ALLOCATE T_LPAREN
        type_spec T_COLON_COLON
        allocation_list 
        ( T_COMMA alloc_opt_list {hasAllocOptList=ANTLR3_TRUE;} )? T_RPAREN 
            end_of_stmt
            {
                hasTypeSpec = ANTLR3_TRUE;
                c_action_allocate_stmt(lbl, $T_ALLOCATE, $end_of_stmt.start, 
                                     hasTypeSpec, hasAllocOptList);
            }
   |   (label {lbl=$label.start;})? T_ALLOCATE T_LPAREN
        allocation_list
        ( T_COMMA alloc_opt_list {hasAllocOptList=ANTLR3_TRUE;} )? T_RPAREN 
            end_of_stmt
            {
                c_action_allocate_stmt(lbl, $T_ALLOCATE, $end_of_stmt.start, 
                                     hasTypeSpec, hasAllocOptList);
            }
   ;

// R624
// ERR_CHK 624 source_expr replaced by expr
// stat_variable and errmsg_variable replaced by designator
alloc_opt
   :   T_IDENT T_EQUALS expr
            /* {'STAT','ERRMSG'} are variables {SOURCE'} is expr */
            { c_action_alloc_opt($T_IDENT); }
   ;

alloc_opt_list
@init{ int count=0;}
   :       {c_action_alloc_opt_list__begin();}
        alloc_opt {count++;} ( T_COMMA alloc_opt {count++;} )*
            {c_action_alloc_opt_list(count);}
   ;

// R625 stat_variable was scalar_int_variable inlined in R624 and R636
// R626 errmsg_variable was scalar_default_char_variable inlined in R624 
// and R636
// R627 inlined source_expr was expr


////////////
// R631-F08
//
// Implemented in "Extras" section
//
//----------------------------------------------------------------------------------------
///JAVA allocation
///JAVA    :   T_IDENT
///JAVA            {SYSTEM_ERR_PRINT("ERROR: allocation implemented in FortranParserExtras.java\n");}
///JAVA    ;


allocation_list
@init{ int count=0;}
   :       {c_action_allocation_list__begin();}
       allocation {count++;} ( T_COMMA allocation {count++;} )*
           {c_action_allocation_list(count);}
   ;


////////////
// R636-F08, R629-F03
//
// Implemented in "Extras" section
//
//----------------------------------------------------------------------------------------
///JAVA allocate_object
///JAVA    :   T_IDENT
///JAVA            {SYSTEM_ERR_PRINT("ERROR: allocate_object implemented in FortranParserExtras.java\n");}
///JAVA    ;

allocate_object_list
@init{ int count=0;}
   :       {c_action_allocate_object_list__begin();}
        allocate_object {count++;} ( T_COMMA allocate_object {count++;} )*
            {c_action_allocate_object_list(count);}
   ;

// R630
// ERR_CHK 630a lower_bound_expr replaced by expr
// ERR_CHK 630b upper_bound_expr replaced by expr

// SAD NOTE 1: In ROSE, there is no IR for allocations. That is, there is no place in the AST to hold the
// 'allocate_shape_spec_list' and 'rice_allocate_coarray_spec' if any. The only way to preserve them is
// to encode them in the 'allocate_object' itself, i.e. as part of an expression.

// SAD NOTE 2: In this rule, the 'allocate_shape_spec_list' is never recognized. Its corresponding action
// 'c_action_allocate_shape_spec' is a no-op in ROSE. Shape specs are parsed by the 'allocate_object' rule
// as a section subscript list within a part ref. Sigh! On the other hand, this is just as well because
// there is no other way to represent the shape specs (see Sad Note 1).

allocate_shape_spec
@init{ANTLR3_BOOLEAN hasLowerBound = ANTLR3_FALSE; ANTLR3_BOOLEAN hasUpperBound = ANTLR3_TRUE;}
   :   expr (T_COLON expr)?
            {   // note, allocate-shape-spec always has upper bound
                // grammar was refactored to remove left recursion, 
                // looks deceptive
                c_action_allocate_shape_spec(hasLowerBound, hasUpperBound);
            }
   ;

allocate_shape_spec_list
@init{ int count=0;}
   :       {c_action_allocate_shape_spec_list__begin();}
        allocate_shape_spec {count++;} 
            ( T_COMMA allocate_shape_spec {count++;} )*
            {c_action_allocate_shape_spec_list(count);}
   ;

// R631 inlined lower_bound_expr was scalar_int_expr

// R632 inlined upper_bound_expr was scalar_int_expr


/*
 * R636-F08 allocate-coarray-spec
 *    is  [ allocate-coshape-spec-list , ] [ lower-bound-expr : ] *
 */

////////////
// R636-F08
//
// This rule is implemented in FortranParserExtras grammar


/*
 * R637-F08 allocate-coshape-spec
 *    is  [ lower-bound-expr : ] upper-bound-expr
 */

////////////
// R637-F08
//
allocate_coshape_spec
@init { ANTLR3_BOOLEAN hasExpr = ANTLR3_FALSE; }
   :   expr ( T_COLON expr { hasExpr = ANTLR3_TRUE; })?
           { c_action_allocate_coshape_spec(hasExpr); }
   ;

allocate_coshape_spec_list
@init{ int count=0;}
   :       {c_action_allocate_coshape_spec_list__begin();}
       allocate_coshape_spec {count++;} ( T_COMMA allocate_coshape_spec {count++;} )*
           {c_action_allocate_coshape_spec_list(count);}
   ;


// R633
nullify_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
        T_NULLIFY T_LPAREN pointer_object_list T_RPAREN end_of_stmt
            { c_action_nullify_stmt(lbl, $T_NULLIFY, $end_of_stmt.start); }
   ;

// R634
// T_IDENT inlined for variable_name and proc_pointer_name
// data_ref inlined for structure_component
// data_ref can be a T_IDENT so T_IDENT deleted
pointer_object
   :   data_ref
            { c_action_pointer_object(); }
   ;

pointer_object_list
@init{ int count=0;}
   :       {c_action_pointer_object_list__begin();}
        pointer_object {count++;} ( T_COMMA pointer_object {count++;} )*
            {c_action_pointer_object_list(count);}
   ;

// R635
deallocate_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasDeallocOptList=ANTLR3_FALSE;}
@after{checkForInclude();}
   :    (label {lbl=$label.start;})? T_DEALLOCATE T_LPAREN allocate_object_list 
            ( T_COMMA dealloc_opt_list {hasDeallocOptList=ANTLR3_TRUE;})? 
            T_RPAREN end_of_stmt
            {c_action_deallocate_stmt(lbl, $T_DEALLOCATE, $end_of_stmt.start, 
                hasDeallocOptList);}
   ;

// R636
// stat_variable and errmsg_variable replaced by designator
dealloc_opt
   :   T_IDENT /* {'STAT','ERRMSG'} */ T_EQUALS designator
            { c_action_dealloc_opt($T_IDENT); }
   ;

dealloc_opt_list
@init{ int count=0;}
   :       {c_action_dealloc_opt_list__begin();}
        dealloc_opt {count++;} ( T_COMMA dealloc_opt {count++;} )*
            {c_action_dealloc_opt_list(count);}
   ;

/**
 * Section/Clause 7: Expressions and assignment
 */

// R701
// constant replaced by literal_constant as T_IDENT can be designator
// T_IDENT inlined for type_param_name
// data_ref in designator can be a T_IDENT so T_IDENT deleted
// type_param_inquiry is designator T_PERCENT T_IDENT can be designator so 
// deleted 
// function_reference integrated with designator (was ambiguous) and 
// deleted (to reduce backtracking)
primary
options {backtrack=true;}       // alt 1,4 ambiguous
@after {c_action_primary();}
   :   designator_or_func_ref
   |   literal_constant
   |   array_constructor
   |   structure_constructor
   |   T_LPAREN expr T_RPAREN {c_action_parenthesized_expr();}
   ;

// R702
level_1_expr
@init{pANTLR3_COMMON_TOKEN tk = NULL;}
   : (defined_unary_op {tk = $defined_unary_op.start;})? primary
            {c_action_level_1_expr(tk);}
   ;

// R703
defined_unary_op
   :   T_DEFINED_OP
           {
              c_action_defined_unary_op($T_DEFINED_OP);
           }
   ;

// inserted as R704 functionality
power_operand
@init{ANTLR3_BOOLEAN hasPowerOperand = ANTLR3_FALSE;}
   : level_1_expr (power_op power_operand {hasPowerOperand = ANTLR3_TRUE;})?
            {c_action_power_operand(hasPowerOperand);}
   ;   

// R704
// see power_operand
mult_operand
@init{int numMultOps = 0;}
//    : level_1_expr ( power_op mult_operand )?
//    : power_operand
   : power_operand (mult_op power_operand
            { c_action_mult_operand__mult_op($mult_op.start); numMultOps += 1; })*
            { c_action_mult_operand(numMultOps); }
   ;

// R705-addition
// This rule has been added so the unary plus/minus has the correct
// precedence when actions are fired.
signed_operand
@init{int numAddOps = 0;}
   :   (tk=add_op)? mult_operand 
          {c_action_signed_operand(tk);}
   ;

// R705
// moved leading optionals to mult_operand
add_operand
@init{int numAddOps = 0;}
@after{c_action_add_operand(numAddOps);}
//    : ( add_operand mult_op )? mult_operand
//    : ( mult_operand mult_op )* mult_operand
   :   signed_operand
       ( tk=add_op mult_operand 
            {c_action_add_operand__add_op(tk); numAddOps += 1;}
       )*
   ;

// R706
// moved leading optionals to add_operand
level_2_expr
@init{int numConcatOps = 0;}
//    : ( ( level_2_expr )? add_op )? add_operand
// check notes on how to remove this left recursion  
// (WARNING something like the following)
//    : (add_op)? ( add_operand add_op )* add_operand
   : add_operand ( concat_op add_operand {numConcatOps += 1;})*
            {c_action_level_2_expr(numConcatOps);}
   ;

// R707
power_op
   :   T_POWER      { c_action_power_op($T_POWER); }
   ;

// R708
mult_op
   :   T_ASTERISK   { c_action_mult_op($T_ASTERISK); }
   |   T_SLASH      { c_action_mult_op($T_SLASH); }
   ;

// R709
add_op
   :   T_PLUS       { c_action_add_op($T_PLUS); }
   |   T_MINUS      { c_action_add_op($T_MINUS); }
   ;

// R710
// moved leading optional to level_2_expr
level_3_expr
@init{pANTLR3_COMMON_TOKEN relOp = NULL;}
//    : ( level_3_expr concat_op )? level_2_expr
//    : ( level_2_expr concat_op )* level_2_expr
   : level_2_expr (rel_op level_2_expr {relOp = $rel_op.start;})?
            {c_action_level_3_expr(relOp);}
   ;

// R711
concat_op
   :   T_SLASH_SLASH   { c_action_concat_op($T_SLASH_SLASH); }
   ;

// R712
// moved leading optional to level_3_expr
// inlined level_3_expr for level_4_expr in R714
//level_4_expr
//    : ( level_3_expr rel_op )? level_3_expr
//    : level_3_expr
//    ;

// R713
rel_op
   :   T_EQ                  { c_action_rel_op($T_EQ); }
   |   T_NE                  { c_action_rel_op($T_NE); }
   |   T_LT                  { c_action_rel_op($T_LT); }
   |   T_LE                  { c_action_rel_op($T_LE); }
   |   T_GT                  { c_action_rel_op($T_GT); }
   |   T_GE                  { c_action_rel_op($T_GE); }
   |   T_EQ_EQ               { c_action_rel_op($T_EQ_EQ); }
   |   T_SLASH_EQ            { c_action_rel_op($T_SLASH_EQ); }
   |   T_LESSTHAN            { c_action_rel_op($T_LESSTHAN); }
   |   T_LESSTHAN_EQ         { c_action_rel_op($T_LESSTHAN_EQ); }
   |   T_GREATERTHAN         { c_action_rel_op($T_GREATERTHAN); }
   |   T_GREATERTHAN_EQ      { c_action_rel_op($T_GREATERTHAN_EQ); }
   ;

// R714
// level_4_expr inlined as level_3_expr
and_operand
@init {
    ANTLR3_BOOLEAN hasNotOp0 = ANTLR3_FALSE;
    ANTLR3_BOOLEAN hasNotOp1 = ANTLR3_FALSE;
    int numAndOps = 0;
}
//    :    ( not_op )? level_3_expr
   :   (not_op {hasNotOp0=ANTLR3_TRUE;})?
        level_3_expr
        (and_op {hasNotOp1=ANTLR3_FALSE;} (not_op {hasNotOp1=ANTLR3_TRUE;})? level_3_expr
                {c_action_and_operand__not_op(hasNotOp1); numAndOps += 1;}
        )*
                {c_action_and_operand(hasNotOp0, numAndOps);}
   ;

// R715
// moved leading optional to or_operand
or_operand
@init{int numOrOps = 0;}
//    : ( or_operand and_op )? and_operand
//    : ( and_operand and_op )* and_operand
   : and_operand (or_op and_operand {numOrOps += 1;})*
            { c_action_or_operand(numOrOps); }
   ;

// R716
// moved leading optional to or_operand
// TODO - action for equiv_op token
equiv_operand
@init{int numEquivOps = 0;}
//    : ( equiv_operand or_op )? or_operand
//    : ( or_operand or_op )* or_operand
   : or_operand 
        (equiv_op or_operand
            {c_action_equiv_operand__equiv_op($equiv_op.start); numEquivOps += 1;}
        )*
            {c_action_equiv_operand(numEquivOps);}
   ;

// R717
// moved leading optional to equiv_operand
level_5_expr
@init{int numDefinedBinaryOps = 0;}
//    : ( level_5_expr equiv_op )? equiv_operand
//    : ( equiv_operand equiv_op )* equiv_operand
   : equiv_operand (defined_binary_op equiv_operand
            {c_action_level_5_expr__defined_binary_op($defined_binary_op.start); 
                numDefinedBinaryOps += 1;} )*
            {c_action_level_5_expr(numDefinedBinaryOps);}
   ;

// R718
not_op
   :   T_NOT      { c_action_not_op($T_NOT); } 
   ;

// R719
and_op
   :   T_AND      { c_action_and_op($T_AND); }
   ;

// R720
or_op
   :   T_OR       { c_action_or_op($T_OR); }
   ;

// R721
equiv_op
   :   T_EQV      { c_action_equiv_op($T_EQV); }
   |   T_NEQV     { c_action_equiv_op($T_NEQV); }
   ;

//========================================================================================
/* R722-F08  expr
 *   is [ expr defined-binary-op ] level-5-expr
 */
// moved leading optional to level_5_expr
//----------------------------------------------------------------------------------------
expr
@after
{
   c_action_expr();
}
   : level_5_expr  ->  ^(OFPExpr level_5_expr)
   ;

// R723
defined_binary_op
   :   T_DEFINED_OP   { c_action_defined_binary_op($T_DEFINED_OP); }
   ;

// R724 inlined logical_expr was expr

// R725 inlined char_expr was expr

// R726 inlined default_char_expr

// R727 inlined int_expr

// R728 inlined numeric_expr was expr

// inlined scalar_numeric_expr was expr

// R729 inlined specification_expr was scalar_int_expr

// R730 inlined initialization_expr

// R731 inlined char_initialization_expr was char_expr

// inlined scalar_char_initialization_expr was char_expr

// R732 inlined int_initialization_expr was int_expr

// inlined scalar_int_initialization_expr was int_initialization_expr

// R733 inlined logical_initialization_expr was logical_expr

// inlined scalar_logical_initialization_expr was logical_expr

//========================================================================================
// R732-F08  assignment-stmt  is  variable = expr
//----------------------------------------------------------------------------------------
assignment_stmt
@after
{
   checkForInclude();
   c_action_assignment_stmt((lbl.tree==NULL)?NULL:lbl.start,eos.start);
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   lbl=opt_label T_ASSIGNMENT_STMT variable T_EQUALS expr eos=end_of_stmt

   -> ^(OFPAssignmentStmt opt_label variable expr)
   ;

// R735
// ERR_TEST 735 ensure that part_ref in data_ref doesn't capture the T_LPAREN
// data_pointer_object and proc_pointer_object replaced by designator
// data_target and proc_target replaced by expr
// third alt covered by first alt so proc_pointer_object assignment deleted
// designator (R603), minus the substring part is data_ref, so designator 
// replaced by data_ref,
// see NOTE 6.10 for why array-section does not have pointer attribute
// TODO: alt1 and alt3 require the backtracking.  if find a way to disambiguate
// them, should be able to remove backtracking.
pointer_assignment_stmt
options {backtrack=true;}
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_PTR_ASSIGNMENT_STMT data_ref T_EQ_GT 
            expr end_of_stmt
            {c_action_pointer_assignment_stmt(lbl, $end_of_stmt.start,ANTLR3_FALSE,ANTLR3_FALSE);}
   | (label {lbl=$label.start;})? T_PTR_ASSIGNMENT_STMT data_ref T_LPAREN 
            bounds_spec_list T_RPAREN T_EQ_GT expr end_of_stmt
            {c_action_pointer_assignment_stmt(lbl, $end_of_stmt.start, ANTLR3_TRUE,ANTLR3_FALSE);}
   | (label {lbl=$label.start;})? T_PTR_ASSIGNMENT_STMT data_ref T_LPAREN 
            bounds_remapping_list T_RPAREN T_EQ_GT expr end_of_stmt
            {c_action_pointer_assignment_stmt(lbl, $end_of_stmt.start, ANTLR3_FALSE,ANTLR3_TRUE);}
   ;

// R736
// ERR_CHK 736 ensure ( T_IDENT | designator ending in T_PERCENT T_IDENT)
// T_IDENT inlined for variable_name and data_pointer_component_name
// variable replaced by designator
data_pointer_object
   :   designator
            { c_action_data_pointer_object(); }
   ;

// R737
// ERR_CHK 737 lower_bound_expr replaced by expr
bounds_spec
   :   expr T_COLON
            { c_action_bounds_spec(); }
   ;

bounds_spec_list
@init{ int count=0;}
   :       {c_action_bounds_spec_list__begin();}
        bounds_spec {count++;} ( T_COMMA bounds_spec {count++;} )*
            {c_action_bounds_spec_list(count);}
   ;

// R738
// ERR_CHK 738a lower_bound_expr replaced by expr
// ERR_CHK 738b upper_bound_expr replaced by expr
bounds_remapping
   :   expr T_COLON expr
            { c_action_bounds_remapping(); }
   ;

bounds_remapping_list
@init{ int count=0;}
   :       {c_action_bounds_remapping_list__begin();}
        bounds_remapping {count++;} ( T_COMMA bounds_remapping {count++;} )*
            {c_action_bounds_remapping_list(count);}
   ;

// R739 data_target inlined as expr in R459 and R735
// expr can be designator (via primary) so variable deleted

// R740
// ERR_CHK 740 ensure ( T_IDENT | ends in T_PERCENT T_IDENT )
// T_IDENT inlined for proc_pointer_name
// proc_component_ref replaced by designator T_PERCENT T_IDENT replaced 
// by designator
proc_pointer_object
   :   designator
            { c_action_proc_pointer_object(); }
   ;

// R741 proc_component_ref inlined as designator T_PERCENT T_IDENT in R740, 
// R742, R1219, and R1221
// T_IDENT inlined for procedure_component_name
// designator inlined for variable

// R742 proc_target inlined as expr in R459 and R735
// ERR_CHK 736 ensure ( expr | designator ending in T_PERCENT T_IDENT)
// T_IDENT inlined for procedure_name
// T_IDENT isa expr so T_IDENT deleted
// proc_component_ref is variable T_PERCENT T_IDENT can be designator 
// so deleted

// R743
// ERR_CHK 743 mask_expr replaced by expr
// assignment_stmt inlined for where_assignment_stmt
where_stmt
@init {
    pANTLR3_COMMON_TOKEN lbl = NULL;
    c_action_where_stmt__begin();
}
@after{checkForInclude();}
   :
        (label {lbl=$label.start;})? T_WHERE_STMT T_WHERE
        T_LPAREN expr T_RPAREN assignment_stmt
            {c_action_where_stmt(lbl, $T_WHERE);}
   ;

// R744
where_construct
@init {
    int numConstructs = 0;
    int numMaskedConstructs = 0;     
    ANTLR3_BOOLEAN hasMaskedElsewhere = ANTLR3_FALSE;
    int numElsewhereConstructs = 0;  
    ANTLR3_BOOLEAN hasElsewhere = ANTLR3_FALSE;
}
   :    where_construct_stmt ( where_body_construct {numConstructs += 1;} )*
          ( masked_elsewhere_stmt ( where_body_construct 
                {numMaskedConstructs += 1;} )*
                {hasMaskedElsewhere = ANTLR3_TRUE; 
                c_action_masked_elsewhere_stmt__end(numMaskedConstructs);}
          )*
          ( elsewhere_stmt ( where_body_construct 
                {numElsewhereConstructs += 1;} )*
                {hasElsewhere = ANTLR3_TRUE; 
                c_action_elsewhere_stmt__end(numElsewhereConstructs);}
          )?
         end_where_stmt
                {c_action_where_construct(numConstructs, hasMaskedElsewhere, 
                    hasElsewhere);}
   ;

// R745
// ERR_CHK 745 mask_expr replaced by expr
where_construct_stmt
@init {pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   :   ( T_IDENT T_COLON {id=$T_IDENT;})? T_WHERE_CONSTRUCT_STMT T_WHERE 
            T_LPAREN expr T_RPAREN end_of_stmt
                {c_action_where_construct_stmt(id, $T_WHERE, $end_of_stmt.start);}
   ;

// R746
// assignment_stmt inlined for where_assignment_stmt
where_body_construct
@after {
    c_action_where_body_construct();
}
   :   assignment_stmt
   |   where_stmt
   |   where_construct
   ;

// R747 where_assignment_stmt inlined as assignment_stmt in R743 and R746

// R748 inlined mask_expr was logical_expr

// inlined scalar_mask_expr was scalar_logical_expr

// inlined scalar_logical_expr was logical_expr

// R749
// ERR_CHK 749 mask_expr replaced by expr
masked_elsewhere_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_ELSE T_WHERE T_LPAREN expr T_RPAREN 
            ( T_IDENT {id=$T_IDENT;})? end_of_stmt 
            {c_action_masked_elsewhere_stmt(lbl, $T_ELSE, $T_WHERE, id, 
                $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_ELSEWHERE T_LPAREN expr T_RPAREN 
            ( T_IDENT {id=$T_IDENT;})? end_of_stmt 
            {c_action_masked_elsewhere_stmt(lbl, $T_ELSEWHERE, NULL,id,
                $end_of_stmt.start);}
   ;

// R750
elsewhere_stmt
@init { pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;} 
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_ELSE T_WHERE 
            (T_IDENT {id=$T_IDENT;})? end_of_stmt
            {c_action_elsewhere_stmt(lbl, $T_ELSE, $T_WHERE, id, 
                $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_ELSEWHERE (T_IDENT {id=$T_IDENT;})? 
            end_of_stmt 
            {c_action_elsewhere_stmt(lbl, $T_ELSEWHERE, NULL, id, 
                $end_of_stmt.start);}
   ;

// R751
end_where_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_END T_WHERE ( T_IDENT {id=$T_IDENT;} )? 
        end_of_stmt
        {c_action_end_where_stmt(lbl, $T_END, $T_WHERE, id, $end_of_stmt.start);}
   | (label {lbl=$label.start;})? T_ENDWHERE ( T_IDENT {id=$T_IDENT;} )? 
        end_of_stmt
        {c_action_end_where_stmt(lbl, $T_ENDWHERE, NULL, id, $end_of_stmt.start);}
   ;

// R752
forall_construct
@after {
    c_action_forall_construct(); 
}
   :   forall_construct_stmt
        ( forall_body_construct )*
        end_forall_stmt
   ;

// R753
forall_construct_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id = NULL;} 
@after{checkForInclude();}
   :    (label {lbl=$label.start;})? ( T_IDENT T_COLON {id=$T_IDENT;})? 
            T_FORALL_CONSTRUCT_STMT T_FORALL 
            forall_header end_of_stmt
                {c_action_forall_construct_stmt(lbl, id, $T_FORALL, 
                    $end_of_stmt.start);}
   ;

// R754
// ERR_CHK 754 scalar_mask_expr replaced by expr
forall_header
@after {
    c_action_forall_header();
}
   : T_LPAREN forall_triplet_spec_list ( T_COMMA expr )? T_RPAREN
   ;

// R755
// T_IDENT inlined for index_name
// expr inlined for subscript and stride
forall_triplet_spec
@init{ANTLR3_BOOLEAN hasStride=ANTLR3_FALSE;}
   : T_IDENT T_EQUALS expr T_COLON expr ( T_COLON expr {hasStride=ANTLR3_TRUE;})?
            {c_action_forall_triplet_spec($T_IDENT,hasStride);}
   ;


forall_triplet_spec_list
@init{ int count=0;}
   :       {c_action_forall_triplet_spec_list__begin();}
        forall_triplet_spec {count++;} 
            ( T_COMMA forall_triplet_spec {count++;} )*
            {c_action_forall_triplet_spec_list(count);}
   ;

// R756
forall_body_construct
@after {
    c_action_forall_body_construct();
}
   :   forall_assignment_stmt
   |   where_stmt
   |   where_construct
   |   forall_construct
   |   forall_stmt
   ;

// R757
forall_assignment_stmt
@after{checkForInclude();}
   :   assignment_stmt
            {c_action_forall_assignment_stmt(ANTLR3_FALSE);}
   |   pointer_assignment_stmt
            {c_action_forall_assignment_stmt(ANTLR3_TRUE);}
   ;

// R758
end_forall_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_END T_FORALL ( T_IDENT {id=$T_IDENT;})? 
        end_of_stmt
        {c_action_end_forall_stmt(lbl, $T_END, $T_FORALL, id, $end_of_stmt.start);}
   | (label {lbl=$label.start;})? T_ENDFORALL ( T_IDENT {id=$T_IDENT;})? 
        end_of_stmt
        {c_action_end_forall_stmt(lbl, $T_ENDFORALL, NULL, id, $end_of_stmt.start);}
   ;

// R759
// T_FORALL_STMT token is inserted by scanner to remove need for backtracking
forall_stmt
@init {
    pANTLR3_COMMON_TOKEN lbl = NULL;
    c_action_forall_stmt__begin();
}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_FORALL_STMT T_FORALL
        forall_header
        forall_assignment_stmt
            {c_action_forall_stmt(lbl, $T_FORALL);}
   ;


/**
 * Section/Clause 8: Execution control
 */


// R801
block
@after {
    c_action_block();
}
   :   execution_part_construct *
   ;

// R802
if_construct
@after {
    c_action_if_construct();
}
   :   if_then_stmt block ( else_if_stmt block )* ( else_stmt block )? 
            end_if_stmt
   ;

// R803
// ERR_CHK 803 scalar_logical_expr replaced by expr
if_then_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? ( T_IDENT T_COLON {id=$T_IDENT;} )? T_IF 
            T_LPAREN expr T_RPAREN T_THEN end_of_stmt
            {c_action_if_then_stmt(lbl, id, $T_IF, $T_THEN, $end_of_stmt.start);}
   ;

// R804
// ERR_CHK 804 scalar_logical_expr replaced by expr
else_if_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_ELSE T_IF
        T_LPAREN expr T_RPAREN T_THEN ( T_IDENT {id=$T_IDENT;} )? end_of_stmt
            {c_action_else_if_stmt(lbl, $T_ELSE, $T_IF, $T_THEN, id, 
                $end_of_stmt.start);}
   | (label {lbl=$label.start;})? T_ELSEIF
        T_LPAREN expr T_RPAREN T_THEN ( T_IDENT {id=$T_IDENT;} )? end_of_stmt
            {c_action_else_if_stmt(lbl, $T_ELSEIF, NULL, $T_THEN, id, 
                $end_of_stmt.start);}
   ;

// R805
else_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_ELSE ( T_IDENT {id=$T_IDENT;} )? 
            end_of_stmt
            {c_action_else_stmt(lbl, $T_ELSE, id, $end_of_stmt.start);}
   ;

// R806
end_if_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_END T_IF ( T_IDENT {id=$T_IDENT;} )? 
        end_of_stmt
            {c_action_end_if_stmt(lbl, $T_END, $T_IF, id, $end_of_stmt.start);}
   | (label {lbl=$label.start;})? T_ENDIF    ( T_IDENT {id=$T_IDENT;} )? 
            end_of_stmt
            {c_action_end_if_stmt(lbl, $T_ENDIF, NULL, id, $end_of_stmt.start);}
   ;

// R807
// ERR_CHK 807 scalar_logical_expr replaced by expr
// T_IF_STMT inserted by scanner to remove need for backtracking
if_stmt
@init {
    pANTLR3_COMMON_TOKEN lbl = NULL;
    c_action_if_stmt__begin();
}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_IF_STMT T_IF T_LPAREN expr T_RPAREN 
            action_stmt
                {c_action_if_stmt(lbl, $T_IF);}
   ;

/*
 * R807-F08 block-construct
 *   is  block-stmt
 *       [ specification-part ]
 *       block
 *       end-block-stmt
 *
 * C806-F08 (R807-F08) The specification-part of a BLOCK construct shall not contain a
 * COMMON, EQUIVALENCE, IMPLICIT, INTENT, NAMELIST, OPTIONAL, statement function, or
 * VALUE statement.
 *
 * C806-F08 means that the implicit-part in specification-part can be removed
 */

////////////
// R807-F08
//
block_construct
@after{c_action_block_construct();}
   :   block_stmt
         specification_part_and_block
       end_block_stmt
   ;

specification_part_and_block
@init{int numUseStmts=0; int numImportStmts=0; gCount1=0;}
   :   ( use_stmt {numUseStmts++;} )*
       ( import_stmt {numImportStmts++;} )*
       declaration_construct_and_block
           {c_action_specification_part_and_block(numUseStmts, numImportStmts, gCount1);}
   ;

declaration_construct_and_block
@init{gCount1++;}
   :   ((label)? T_ENTRY)      => entry_stmt       declaration_construct_and_block
   |   ((label)? T_ENUM)       => enum_def         declaration_construct_and_block
   |   ((label)? T_FORMAT)     => format_stmt      declaration_construct_and_block
   |   ((label)? T_INTERFACE)  => interface_block  declaration_construct_and_block
   |   ((label)? T_PARAMETER)  => parameter_stmt   declaration_construct_and_block
   |   ((label)? T_PROCEDURE)  => procedure_declaration_stmt
                                                   declaration_construct_and_block
   |   (derived_type_stmt)     => derived_type_def declaration_construct_and_block
   |   (type_declaration_stmt) => type_declaration_stmt declaration_construct_and_block

   // the following are from other_specification_stmt

   |   ((label)? access_spec)    => access_stmt       declaration_construct_and_block
   |   ((label)? T_ALLOCATABLE)  => allocatable_stmt  declaration_construct_and_block
   |   ((label)? T_ASYNCHRONOUS) => asynchronous_stmt declaration_construct_and_block
   |   ((label)? T_BIND)         => bind_stmt         declaration_construct_and_block
   |   ((label)? T_CODIMENSION)  => codimension_stmt  declaration_construct_and_block
   |   ((label)? T_DATA)         => data_stmt         declaration_construct_and_block
   |   ((label)? T_DIMENSION)    => dimension_stmt    declaration_construct_and_block
   |   ((label)? T_EXTERNAL)     => external_stmt     declaration_construct_and_block
   |   ((label)? T_INTRINSIC)    => intrinsic_stmt    declaration_construct_and_block
   |   ((label)? T_POINTER)      => pointer_stmt      declaration_construct_and_block
   |   ((label)? T_PROTECTED)    => protected_stmt    declaration_construct_and_block
   |   ((label)? T_SAVE)         => save_stmt         declaration_construct_and_block
   |   ((label)? T_TARGET)       => target_stmt       declaration_construct_and_block
   |   ((label)? T_VOLATILE)     => volatile_stmt     declaration_construct_and_block
   |   block {gCount1--; /* decrement extra count as this isn't a declConstruct */}
   ;

/*
 * R808-F08 block-stmt
 *   is  [ block-construct-name : ] BLOCK
 */

////////////
// R808-F08
//
block_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN name = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       (T_IDENT T_COLON {name=$T_IDENT;})?
       T_BLOCK end_of_stmt
           {c_action_block_stmt(lbl, name, $T_BLOCK, $end_of_stmt.start);}
   ;

/*
 * R809-F08 end-block-stmt
 *   is  END BLOCK [ block-construct-name ]
 */

////////////
// R809-F08
//
end_block_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN name = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       T_END T_BLOCK (T_IDENT {name=$T_IDENT;})? end_of_stmt
           {c_action_end_block_stmt(lbl, name, $T_END, $T_BLOCK, $end_of_stmt.start);}
   |   (label {lbl=$label.start;})?
       T_ENDBLOCK (T_IDENT {name=$T_IDENT;})? end_of_stmt
           {c_action_end_block_stmt(lbl, name, $T_ENDBLOCK, NULL, $end_of_stmt.start);}
   ;

/*
 * R810-F08 critical-construct
 *   is  critical-stmt
 *          block
 *       end-critical-stmt
 */

////////////
// R810-F08
//
critical_construct
   :   critical_stmt block end_critical_stmt
           {c_action_critical_construct();}
   ;

/*
 * R811-F08 critical-stmt
 *   is  [ critical-construct-name : ] CRITICAL
 */

////////////
// R811-F08
//
critical_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN name = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       (T_IDENT T_COLON {name=$T_IDENT;})?
       T_CRITICAL end_of_stmt
           {c_action_critical_stmt(lbl, name, $T_CRITICAL, $end_of_stmt.start);}
   ;

/*
 * R812-F08 end-critical-stmt
 *   is  END CRITICAL [ critical-construct-name ]
 */

////////////
// R812-F08
//
end_critical_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN name = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       T_END T_CRITICAL (T_IDENT {name=$T_IDENT;})? end_of_stmt
           {c_action_end_critical_stmt(lbl, name, $T_END, $T_CRITICAL, $end_of_stmt.start);}
   ;

// R808
case_construct
@after {
    c_action_case_construct();
}
   :    select_case_stmt ( case_stmt block )* end_select_stmt
   ;

// R809
// ERR_CHK 809 case_expr replaced by expr
select_case_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL; pANTLR3_COMMON_TOKEN tk1 = NULL; pANTLR3_COMMON_TOKEN tk2 = NULL;}
@after{checkForInclude();}
   :    (label {lbl=$label.start;})? ( T_IDENT T_COLON {id=$T_IDENT;})?
        (T_SELECT T_CASE {tk1=$T_SELECT; tk2=$T_CASE;} 
            | T_SELECTCASE {tk1=$T_SELECTCASE; tk2=NULL;} )
            T_LPAREN expr T_RPAREN end_of_stmt
            {c_action_select_case_stmt(lbl, id, tk1, tk2, $end_of_stmt.start);}
   ;

// R810
case_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_CASE case_selector
            ( T_IDENT {id=$T_IDENT;})? end_of_stmt
            { c_action_case_stmt(lbl, $T_CASE, id, $end_of_stmt.start);}
   ;

// R811
end_select_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_END T_SELECT (T_IDENT {id=$T_IDENT;})? 
        end_of_stmt
            {c_action_end_select_stmt(lbl, $T_END, $T_SELECT, id, 
                $end_of_stmt.start);}
   | (label {lbl=$label.start;})? T_ENDSELECT    (T_IDENT {id=$T_IDENT;})? 
        end_of_stmt
            {c_action_end_select_stmt(lbl, $T_ENDSELECT, NULL, id, 
                $end_of_stmt.start);}
   ;

// R812 inlined case_expr with expr was either scalar_int_expr 
// scalar_char_expr scalar_logical_expr

// inlined scalar_char_expr with expr was char_expr

// R813
case_selector
   :   T_LPAREN
        case_value_range_list
        T_RPAREN
            { c_action_case_selector(NULL); }
   |   T_DEFAULT
            { c_action_case_selector($T_DEFAULT); }
   ;

// R814
case_value_range
@after {
    c_action_case_value_range();
}
   :   T_COLON case_value
   |   case_value case_value_range_suffix
   ;

case_value_range_suffix
@after {
    c_action_case_value_range_suffix();
}
   :   T_COLON ( case_value )?
   |   { /* empty */ }
   ;

case_value_range_list
@init{ int count=0;}
   :       {c_action_case_value_range_list__begin();}
        case_value_range {count++;} ( T_COMMA case_value_range {count++;} )*
            {c_action_case_value_range_list(count);}
   ;

// R815
// ERR_CHK 815 expr either scalar_int_initialization_expr 
// scalar_char_initialization_expr scalar_logical_initialization_expr
case_value
   :   expr
            { c_action_case_value(); }
   ;

// R816
associate_construct
   :   associate_stmt
        block
        end_associate_stmt
            { c_action_associate_construct(); }
   ;

// R817
associate_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? ( T_IDENT T_COLON {id=$T_IDENT;})? 
            T_ASSOCIATE T_LPAREN association_list T_RPAREN end_of_stmt
            {c_action_associate_stmt(lbl, id, $T_ASSOCIATE, $end_of_stmt.start);}
   ;

association_list
@init{ int count=0;}
   :       {c_action_association_list__begin();}
        association {count++;} ( T_COMMA association {count++;} )*
            {c_action_association_list(count);}
   ;

/*
 * R818-08 loop-control
 *   is  [ , ] do-variable = scalar-int-expr , scalar-int-expr [ , scalar-int-expr ]
 *   or  [ , ] WHILE ( scalar-logical-expr )
 *   or  [ , ] CONCURRENT forall-header
 */

////////////
// R818-F08, R830-F03
//
// ERR_CHK 818 scalar_int_expr replaced by expr
// ERR_CHK 818 scalar_logical_expr replaced by expr
loop_control
@init {ANTLR3_BOOLEAN hasOptExpr = ANTLR3_FALSE;}
   :   ( T_COMMA )? do_variable T_EQUALS expr T_COMMA expr
       ( T_COMMA expr {hasOptExpr=ANTLR3_TRUE;})?
           {c_action_loop_control(NULL, IActionEnums_ DoConstruct_variable, hasOptExpr);}
   |   ( T_COMMA )? T_WHILE T_LPAREN expr T_RPAREN 
           {c_action_loop_control($T_WHILE, IActionEnums_ DoConstruct_while, hasOptExpr);}
   |   ( T_COMMA )? T_CONCURRENT forall_header
           {c_action_loop_control($T_CONCURRENT,
                                IActionEnums_ DoConstruct_concurrent, hasOptExpr);}
   ;

// R818
// T_IDENT inlined for associate_name
association
   :   T_IDENT T_EQ_GT selector
            { c_action_association($T_IDENT); }
   ;

// R819
// expr can be designator (via primary) so variable deleted
selector
   :   expr
            { c_action_selector(); }
   ;

// R820
end_associate_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_END T_ASSOCIATE 
            (T_IDENT {id=$T_IDENT;})? end_of_stmt
            {c_action_end_associate_stmt(lbl, $T_END, $T_ASSOCIATE, id, 
                $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_ENDASSOCIATE  
            (T_IDENT {id=$T_IDENT;})? end_of_stmt
            {c_action_end_associate_stmt(lbl, $T_ENDASSOCIATE, NULL, id, 
                                       $end_of_stmt.start);}
   ;

// R821
select_type_construct
   :   select_type_stmt ( type_guard_stmt block )* end_select_type_stmt
            { c_action_select_type_construct(); }
   ;

// R822
// T_IDENT inlined for select_construct_name and associate_name
select_type_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN selectConstructName=NULL; 
       pANTLR3_COMMON_TOKEN associateName=NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})?
        ( idTmp=T_IDENT T_COLON {selectConstructName=idTmp;})? select_type
        T_LPAREN ( idTmpx=T_IDENT T_EQ_GT {associateName=idTmpx;} )?
        selector T_RPAREN end_of_stmt
            {c_action_select_type_stmt(lbl, selectConstructName, associateName, 
                                     $end_of_stmt.start);}
   ;

select_type
   : T_SELECT T_TYPE { c_action_select_type($T_SELECT, $T_TYPE); }
   | T_SELECTTYPE { c_action_select_type($T_SELECTTYPE, NULL); }
   ;

// R823
// T_IDENT inlined for select_construct_name
// TODO - FIXME - have to remove T_TYPE_IS and T_CLASS_IS because the 
// lexer never matches the sequences.  lexer now matches a T_IDENT for 
// the 'IS'.  this rule should be fixed (see test_select_stmts.f03)
// TODO - The temporary token seems convoluted, but I couldn't figure out 
// how to prevent ambiguous use of T_IDENT otherwise. -BMR
type_guard_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN selectConstructName=NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_TYPE id1=T_IDENT 
            T_LPAREN type_spec T_RPAREN
            ( idTmp=T_IDENT {selectConstructName=idTmp;})? end_of_stmt
            {c_action_type_guard_stmt(lbl, $T_TYPE, id1, selectConstructName, 
                                    $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_CLASS id1=T_IDENT 
            T_LPAREN type_spec T_RPAREN
            ( idTmp=T_IDENT {selectConstructName=idTmp;})? end_of_stmt
            {c_action_type_guard_stmt(lbl, $T_CLASS, id1, selectConstructName, 
                                    $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_CLASS    T_DEFAULT
        ( idTmp=T_IDENT {selectConstructName=idTmp;})? end_of_stmt
            {c_action_type_guard_stmt(lbl, $T_CLASS, $T_DEFAULT, 
                                    selectConstructName, $end_of_stmt.start);}
   ;

// R824
// T_IDENT inlined for select_construct_name
end_select_type_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_END T_SELECT 
            ( T_IDENT {id=$T_IDENT;})? end_of_stmt
            {c_action_end_select_type_stmt(lbl, $T_END, $T_SELECT, id, 
                $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_ENDSELECT    
            ( T_IDENT {id=$T_IDENT;})? end_of_stmt
            {c_action_end_select_type_stmt(lbl, $T_ENDSELECT, NULL, id, 
                $end_of_stmt.start);}
   ;

// R825
// deleted second alternative, nonblock_do_construct, to reduce backtracking, see comments for R835 on how
// termination of nested loops must be handled.
do_construct
   :   block_do_construct
            { c_action_do_construct(); }
   ;

// R826
// do_block replaced by block
block_do_construct
   :   do_stmt
       block
       end_do
           {
              c_action_block_do_construct();
           }
   ;

// R827
// label_do_stmt and nonlabel_do_stmt inlined
do_stmt
@init {pANTLR3_COMMON_TOKEN lbl=NULL; 
       pANTLR3_COMMON_TOKEN id=NULL;
       pANTLR3_COMMON_TOKEN digitString=NULL;
       ANTLR3_BOOLEAN hasLoopControl=ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? ( T_IDENT T_COLON {id=$T_IDENT;})? T_DO 
            ( T_DIGIT_STRING {digitString=$T_DIGIT_STRING;})? 
            ( loop_control {hasLoopControl=ANTLR3_TRUE;})? end_of_stmt
                {c_action_do_stmt(lbl, id, $T_DO, digitString, $end_of_stmt.start, 
                                hasLoopControl);}
   ;

// R828
// T_IDENT inlined for do_construct_name
// T_DIGIT_STRING inlined for label
label_do_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL; ANTLR3_BOOLEAN hasLoopControl=ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? ( T_IDENT T_COLON {id=$T_IDENT;} )? 
            T_DO T_DIGIT_STRING ( loop_control {hasLoopControl=ANTLR3_TRUE;})? 
            end_of_stmt
            {c_action_label_do_stmt(lbl, id, $T_DO, $T_DIGIT_STRING, 
                                  $end_of_stmt.start, hasLoopControl);}
   ;

// R829 inlined in R827
// T_IDENT inlined for do_construct_name

// R831
// do_variable is scalar-int-variable-name
do_variable
   :   T_IDENT
            { c_action_do_variable($T_IDENT); }
   ;

// R832 do_block was block inlined in R826

// R833
// TODO continue-stmt is ambiguous with same in action statement, check 
// there for label and if
// label matches do-stmt label, then match end-do
// do_term_action_stmt added to allow block_do_construct to cover 
// nonblock_do_construct as well
end_do
@after {
    c_action_end_do();
}
   :   end_do_stmt
   |   do_term_action_stmt
   ;

// R834
// T_IDENT inlined for do_construct_name
end_do_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_END T_DO ( T_IDENT {id=$T_IDENT;})? 
            end_of_stmt
            {c_action_end_do_stmt(lbl, $T_END, $T_DO, id, $end_of_stmt.start);}
   | (label {lbl=$label.start;})? T_ENDDO    ( T_IDENT {id=$T_IDENT;})? 
            end_of_stmt
            {c_action_end_do_stmt(lbl, $T_ENDDO, NULL, id, $end_of_stmt.start);}
   ;

// R835 nonblock_do_construct deleted as it was combined with 
// block_do_construct to reduce backtracking
// Second alternative, outer_shared_do_construct (nested loops sharing a 
// termination label) is ambiguous
// with do_construct in do_body, so deleted.  Loop termination is coordinated with
// the scanner to unwind nested loops sharing a common termination statement 
// (see do_term_action_stmt).

// R836 action_term_do_construct deleted because nonblock_do_construct 
// combined with block_do_construct to reduce backtracking

// R837 do_body deleted because nonblock_do_construct combined with 
// block_do_construct to reduce backtracking

// R838
// C826 (R842) A do-term-shared-stmt shall not be a goto-stmt, a return-stmt, 
// a stop-stmt, an exit-stmt, a cyle-stmt, an end-function-stmt, an 
// end-subroutine-stmt, an end-program-stmt, or an arithmetic-if-stmt.
do_term_action_stmt
@init {pANTLR3_COMMON_TOKEN endToken = NULL; pANTLR3_COMMON_TOKEN doToken = NULL; pANTLR3_COMMON_TOKEN id=NULL;}
@after{checkForInclude();}
    // for a labeled statement which closes a DO, we insert a T_LABEL_DO_TERMINAL during the Sale's prepass.
   :   label T_LABEL_DO_TERMINAL 
        (action_stmt
         | ( (T_END T_DO {endToken=$T_END; doToken=$T_DO;} | T_ENDDO {endToken=$T_ENDDO; doToken=NULL;}) 
                (T_IDENT {id=$T_IDENT;})?)
                end_of_stmt
        )
            {c_action_do_term_action_stmt($label.start, endToken, doToken, id, $end_of_stmt.start, ANTLR3_FALSE);}
                                        
    // for an outer shared DO closed implicitly, we insert a T_LABEL_DO_TERMINAL_INSERTED during the Sale's prepass.
    // the inserted token's text is the closing statement's label.
   | T_LABEL_DO_TERMINAL_INSERTED
            {c_action_do_term_action_stmt($T_LABEL_DO_TERMINAL_INSERTED, NULL, NULL, NULL, NULL, ANTLR3_TRUE);}
   ;

// R839 outer_shared_do_construct removed because it caused ambiguity in 
// R835 (see comment in R835)

// R840 shared_term_do_construct deleted (see comments for R839 and R835)

// R841 inner_shared_do_construct deleted (see comments for R839 and R835)

// R842 do_term_shared_stmt deleted (see comments for R839 and R835)

// R843
// T_IDENT inlined for do_construct_name
cycle_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id = NULL;} 
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_CYCLE (T_IDENT {id=$T_IDENT;})? end_of_stmt
            { c_action_cycle_stmt(lbl, $T_CYCLE, id, $end_of_stmt.start); }
   ;

// R844
// T_IDENT inlined for do_construct_name
exit_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_EXIT (T_IDENT {id=$T_IDENT;})? end_of_stmt
            { c_action_exit_stmt(lbl, $T_EXIT, id, $end_of_stmt.start); }
   ;

// R845
goto_stmt
@init {pANTLR3_COMMON_TOKEN lbl=NULL;
       pANTLR3_COMMON_TOKEN goto_target=NULL;
       pANTLR3_COMMON_TOKEN goKeyword=NULL;
       pANTLR3_COMMON_TOKEN toKeyword=NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       (   T_GO T_TO { goKeyword=$T_GO; toKeyword=$T_TO;} 
        |  T_GOTO    { goKeyword=$T_GOTO; toKeyword=NULL;}
       )
       T_DIGIT_STRING {goto_target=$T_DIGIT_STRING;} end_of_stmt
          { c_action_goto_stmt(lbl, goKeyword, toKeyword, goto_target, $end_of_stmt.start); }
   ;

// R846
// ERR_CHK 846 scalar_int_expr replaced by expr
computed_goto_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN goKeyword=NULL; pANTLR3_COMMON_TOKEN toKeyword=NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
        (T_GO T_TO {goKeyword=$T_GO; toKeyword=$T_TO;} 
         | T_GOTO {goKeyword=$T_GOTO; toKeyword=NULL;}) 
            T_LPAREN label_list T_RPAREN ( T_COMMA )? expr end_of_stmt
            { c_action_computed_goto_stmt(lbl, goKeyword, toKeyword, 
                $end_of_stmt.start); }
   ;

// The ASSIGN statement is a deleted feature.
assign_stmt 
@after{checkForInclude();}
   :   (lbl1=label)? T_ASSIGN lbl2=label T_TO name end_of_stmt 
            { c_action_assign_stmt(lbl1, $T_ASSIGN, lbl2, $T_TO, $name.start, 
                                 $end_of_stmt.start); }
   ;

// The assigned GOTO statement is a deleted feature.
assigned_goto_stmt
@init {pANTLR3_COMMON_TOKEN goKeyword=NULL; pANTLR3_COMMON_TOKEN toKeyword=NULL;}
@after{checkForInclude();}
   :   (label)? ( T_GOTO {goKeyword=$T_GOTO; toKeyword=NULL;}
                   | T_GO T_TO {goKeyword=$T_GO; toKeyword=$T_TO;} ) 
            name (T_COMMA stmt_label_list)? end_of_stmt
            { c_action_assigned_goto_stmt($label.start, goKeyword, toKeyword, 
                                        $name.start, $end_of_stmt.start); }
   ;

// Used with assigned_goto_stmt (deleted feature)
stmt_label_list
   :   T_LPAREN label ( T_COMMA label )* T_RPAREN 
            { c_action_stmt_label_list(); }
   ;

// The PAUSE statement is a deleted feature.
pause_stmt
@after
{
   checkForInclude();
}
   :   (lbl=label)?
       T_PAUSE  (tk=label | char_literal_constant {tk.start=NULL;})?  end_of_stmt 

           {
              c_action_pause_stmt(lbl.start,$T_PAUSE,tk.start,$end_of_stmt.start);
           }
   ;

// R847
// ERR_CHK 847 scalar_numeric_expr replaced by expr
arithmetic_if_stmt
@after{checkForInclude();}
   :   (lbl=label)? T_ARITHMETIC_IF_STMT T_IF
        T_LPAREN expr T_RPAREN label1=label
        T_COMMA label2=label
        T_COMMA label3=label end_of_stmt
            { c_action_arithmetic_if_stmt(lbl, $T_IF, label1, label2, label3, 
                                        $end_of_stmt.start); }
   ;

// R848 continue_stmt
continue_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_CONTINUE end_of_stmt
            { c_action_continue_stmt(lbl, $T_CONTINUE, $end_of_stmt.start); } 
   ;

// R849
stop_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasStopCode = ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_STOP (stop_code {hasStopCode=ANTLR3_TRUE;})? 
            end_of_stmt
            { c_action_stop_stmt(lbl, $T_STOP, $end_of_stmt.start, hasStopCode); }
   ;

// R850
// ERR_CHK 850 T_DIGIT_STRING must be 5 digits or less
stop_code
   : scalar_char_constant
        { c_action_stop_code(NULL); }
//     | Digit ( Digit ( Digit ( Digit ( Digit )? )? )? )?
   | T_DIGIT_STRING
        { c_action_stop_code($T_DIGIT_STRING); } 
   ;

/*
 * R856-F08 errorstop-stmt
 *   is  ERROR STOP [ stop-code ]
 */

////////////
// R856-F08
//
errorstop_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasStopCode = ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_ERROR T_STOP (stop_code {hasStopCode=ANTLR3_TRUE;})? 
       end_of_stmt
          { c_action_errorstop_stmt(lbl, $T_ERROR, $T_STOP, $end_of_stmt.start, hasStopCode); }
   ;

/*
 * R858-F08 sync-all-stmt
 *   is  SYNC ALL [([ sync-stat-list ])]
 */
 
////////////
// R858-F08
//
sync_all_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasSyncStatList = ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_SYNC T_ALL
       (T_LPAREN T_RPAREN)? end_of_stmt
             { c_action_sync_all_stmt(lbl, $T_SYNC, $T_ALL, $end_of_stmt.start, hasSyncStatList); }
   |   (label {lbl=$label.start;})? T_SYNC T_ALL
       T_LPAREN sync_stat_list T_RPAREN end_of_stmt
             { c_action_sync_all_stmt(lbl, $T_SYNC, $T_ALL, $end_of_stmt.start, ANTLR3_TRUE); }
   ;


/*
 * R859-F08 sync-stat
 *   is  STAT = stat-variable
 *   or  ERRMSG = errmsg-variable
 */
 
////////////
// R859-F08
//
sync_stat
   :    T_IDENT T_EQUALS expr    // expr is a stat-variable or an errmsg-variable
             /* {'STAT','ERRMSG'} exprs are variables */
             { c_action_sync_stat($T_IDENT); }
   ;

sync_stat_list
@init{int count=0;}
   :       {c_action_sync_stat_list__begin();}
       sync_stat {count++;} ( T_COMMA sync_stat {count++;} )*
           {c_action_sync_stat_list(count);}
   ;


/*
 * R860-F08 sync-images-stmt
 *   is  SYNC IMAGES ( image-set [, sync-stat-list ] )
 */
 
////////////
// R860-F08
//
sync_images_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasSyncStatList = ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_SYNC T_IMAGES
       T_LPAREN image_set (T_COMMA sync_stat_list {hasSyncStatList=ANTLR3_TRUE;})? T_RPAREN
       end_of_stmt
             { c_action_sync_images_stmt(lbl, $T_SYNC, $T_IMAGES, $end_of_stmt.start, hasSyncStatList); }
   ;


/*
 * R861-F08 image-set
 *   is  int-expr
 *   or  *
 */
 
////////////
// R861-F08
//
image_set
@init {pANTLR3_COMMON_TOKEN asterisk = NULL; ANTLR3_BOOLEAN hasIntExpr = ANTLR3_FALSE;}
   :   expr 
             { hasIntExpr = ANTLR3_TRUE; c_action_image_set(asterisk, hasIntExpr); }
   |   T_ASTERISK
             { asterisk = $T_ASTERISK; c_action_image_set(asterisk, hasIntExpr); }
   ;


/*
 * R862-F08 sync-memory-stmt
 *   is  SYNC MEMORY [([ sync-stat-list ])]
 */
 
////////////
// R862-F08
//
sync_memory_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasSyncStatList = ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_SYNC T_MEMORY
       (T_LPAREN T_RPAREN)? end_of_stmt
             { c_action_sync_memory_stmt(lbl, $T_SYNC, $T_MEMORY, $end_of_stmt.start, hasSyncStatList); }
   |   (label {lbl=$label.start;})? T_SYNC T_MEMORY
       T_LPAREN sync_stat_list T_RPAREN end_of_stmt
             { c_action_sync_memory_stmt(lbl, $T_SYNC, $T_MEMORY, $end_of_stmt.start, ANTLR3_TRUE); }
   ;


/*
 * R863-F08 lock-stmt
 *   is  LOCK ( lock-variable [, lock-stat-list ] )
 */
 
////////////
// R863-F08
//
// ERR_CHK 863 lock_variable replaced by variable
lock_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasLockStatList = ANTLR3_FALSE;}
@after{checkForInclude();}
   :    (label {lbl=$label.start;})? T_LOCK T_LPAREN variable
             (T_COMMA lock_stat_list {hasLockStatList=ANTLR3_TRUE;})? T_RPAREN
             end_of_stmt
             { c_action_lock_stmt(lbl, $T_LOCK, $end_of_stmt.start, hasLockStatList); }
   ;

/*
 * R864-F08 lock-stat
 *   is  ACQUIRED_LOCK = scalar-logical-variable
 *   or  sync-stat
 */
 
////////////
// R864-F08
//
// TODO - replace expr with scalar_logical_variable
lock_stat 
   :   T_ACQUIRED_LOCK T_EQUALS expr    // expr is a scalar-logical-variable
          { c_action_lock_stat($T_ACQUIRED_LOCK); }
   |   sync_stat
   ;

lock_stat_list
@init{int count=0;}
   :       {c_action_lock_stat_list__begin();}
        lock_stat {count++;} ( T_COMMA lock_stat {count++;} )*
            {c_action_lock_stat_list(count);}
   ;

/*
 * R865-F08 unlock-stmt
 *   is  UNLOCK ( lock-variable [, lock-stat-list ] )
 */
 
////////////
// R865-F08
//
// ERR_CHK 865 lock_variable replaced by expr
unlock_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasSyncStatList = ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       T_UNLOCK T_LPAREN variable (T_COMMA sync_stat_list {hasSyncStatList=ANTLR3_TRUE;})?
                T_RPAREN end_of_stmt
           {c_action_unlock_stmt(lbl, $T_UNLOCK, $end_of_stmt.start, hasSyncStatList);}
   ;

scalar_char_constant
   :    char_constant
                { c_action_scalar_char_constant(); }
   ;

/**
 * Section/Clause 9: Input/output statements
 */

// R901
// file_unit_number replaced by expr
// internal_file_variable isa expr so internal_file_variable deleted
io_unit
@after {
    c_action_io_unit();
}
   :   expr
   |   T_ASTERISK
   ;

// R902
// ERR_CHK 902 scalar_int_expr replaced by expr
file_unit_number
@after {
    c_action_file_unit_number();
}
   :   expr
   ;

// R903 internal_file_variable was char_variable inlined (and then deleted) 
// in R901

// R904
open_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_OPEN T_LPAREN connect_spec_list 
            T_RPAREN end_of_stmt
            {c_action_open_stmt(lbl, $T_OPEN, $end_of_stmt.start);}
   ;

// R905
// ERR_CHK 905 check expr type with identifier
connect_spec
   : expr
            { c_action_connect_spec(NULL); }
   | T_IDENT
        /* {'UNIT','ACCESS','ACTION','ASYNCHRONOUS','BLANK','DECIMAL', */
        /* 'DELIM','ENCODING'} are expr */
        /* {'ERR'} is T_DIGIT_STRING */
        /* {'FILE','FORM'} are expr */
        /* {'IOMSG','IOSTAT'} are variables */
        /* {'PAD','POSITION','RECL','ROUND','SIGN','STATUS'} are expr */
      T_EQUALS expr
            { c_action_connect_spec($T_IDENT); }
   ;

connect_spec_list
@init{ int count=0;}
   :       {c_action_connect_spec_list__begin();}
        connect_spec {count++;} ( T_COMMA connect_spec {count++;} )*
            {c_action_connect_spec_list(count);}
   ;

// inlined scalar_default_char_expr

// R906 inlined file_name_expr with expr was scalar_default_char_expr

// R907 iomsg_variable inlined as scalar_default_char_variable in 
// R905,R909,R913,R922,R926,R928

// R908
close_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_CLOSE T_LPAREN close_spec_list 
            T_RPAREN end_of_stmt
            {c_action_close_stmt(lbl, $T_CLOSE, $end_of_stmt.start);}
   ;

// R909
// file_unit_number, scalar_int_variable, iomsg_variable, label replaced 
// by expr
close_spec
   :   expr
            { c_action_close_spec(NULL); }
   |   T_IDENT /* {'UNIT','IOSTAT','IOMSG','ERR','STATUS'} */ T_EQUALS expr
            { c_action_close_spec($T_IDENT); }
   ;

close_spec_list
@init{ int count=0;}
   :       {c_action_close_spec_list__begin();}
        close_spec {count++;} ( T_COMMA close_spec {count++;} )*
            {c_action_close_spec_list(count);}
   ;

// R910
read_stmt
options {k=3;}
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasInputItemList=ANTLR3_FALSE;}
@after{checkForInclude();}
   :    ((label)? T_READ T_LPAREN) => 
            (label {lbl=$label.start;})? T_READ T_LPAREN io_control_spec_list 
            T_RPAREN ( input_item_list {hasInputItemList=ANTLR3_TRUE;})? end_of_stmt
            {c_action_read_stmt(lbl, $T_READ, $end_of_stmt.start, 
                hasInputItemList);}
   |    ((label)? T_READ) => 
            (label {lbl=$label.start;})? T_READ format 
            ( T_COMMA input_item_list {hasInputItemList=ANTLR3_TRUE;})? end_of_stmt
            {c_action_read_stmt(lbl, $T_READ, $end_of_stmt.start, 
                hasInputItemList);}
   ;

// R911
write_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasOutputItemList=ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_WRITE T_LPAREN io_control_spec_list 
            T_RPAREN ( output_item_list {hasOutputItemList=ANTLR3_TRUE;})? end_of_stmt
            { c_action_write_stmt(lbl, $T_WRITE, $end_of_stmt.start, 
                hasOutputItemList); }
   ;

// R912
print_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasOutputItemList=ANTLR3_FALSE;}
@after{checkForInclude();}
   :    (label {lbl=$label.start;})? T_PRINT format 
            ( T_COMMA output_item_list {hasOutputItemList=ANTLR3_TRUE;})? end_of_stmt
            { c_action_print_stmt(lbl, $T_PRINT, $end_of_stmt.start, 
                hasOutputItemList); }
   ;


// R913
// ERR_CHK 913 check expr type with identifier
// io_unit and format are both (expr|'*') so combined
io_control_spec
   :   expr
            {
               // hasExpression=true
               c_action_io_control_spec(ANTLR3_TRUE, NULL, ANTLR3_FALSE);
            }

   |   T_ASTERISK
            {
               // hasAsterisk=true
               c_action_io_control_spec(ANTLR3_FALSE, NULL, ANTLR3_TRUE);
            }

   |   T_IDENT /* {'UNIT','FMT'} */ T_EQUALS T_ASTERISK
            {
               // hasAsterisk=true
               c_action_io_control_spec(ANTLR3_FALSE, $T_IDENT, ANTLR3_TRUE);
            }

   |   T_IDENT
            /* {'UNIT','FMT'} are expr 'NML' is T_IDENT} */
            /* {'ADVANCE','ASYNCHRONOUS','BLANK','DECIMAL','DELIM'} are expr */
            /* {'END','EOR','ERR'} are labels */
            /* {'ID','IOMSG',IOSTAT','SIZE'} are variables */
            /* {'PAD','POS','REC','ROUND','SIGN'} are expr */
       T_EQUALS expr
            {
               // hasExpression=true
               c_action_io_control_spec(ANTLR3_TRUE, $T_IDENT, ANTLR3_FALSE);
            }
   ;


io_control_spec_list
@init{ int count=0;}
   :       {c_action_io_control_spec_list__begin();}
        io_control_spec {count++;} ( T_COMMA io_control_spec {count++;} )*
            {c_action_io_control_spec_list(count);}
   ;

// R914
// ERR_CHK 914 default_char_expr replaced by expr
// label replaced by T_DIGIT_STRING is expr so deleted
format
@after {
    c_action_format();
}
   :   expr
   |   T_ASTERISK
   ;

// R915
input_item
@after {
    c_action_input_item();
}
   :   variable
   |   io_implied_do
   ;

input_item_list
@init{ int count=0;}
   :       {c_action_input_item_list__begin();}
        input_item {count++;} ( T_COMMA input_item {count++;} )*
            {c_action_input_item_list(count);}
   ;

// R916
output_item
options {backtrack=true;}
@after {
    c_action_output_item();
}
   :   expr
   |   io_implied_do
   ;


output_item_list
@init{ int count=0;}
   :       {c_action_output_item_list__begin();}
        output_item {count++;} ( T_COMMA output_item {count++;} )*
            {c_action_output_item_list(count);}
   ;

// R917
io_implied_do
   :   T_LPAREN io_implied_do_object io_implied_do_suffix T_RPAREN
            { c_action_io_implied_do(); }
   ;

// R918
// expr in output_item can be variable in input_item so input_item deleted
io_implied_do_object
   :   output_item
            { c_action_io_implied_do_object(); }
   ;

io_implied_do_suffix
options {backtrack=true;}
   :   T_COMMA io_implied_do_object io_implied_do_suffix
   |   T_COMMA io_implied_do_control
   ;

// R919
// ERR_CHK 919 scalar_int_expr replaced by expr
io_implied_do_control
@init{ANTLR3_BOOLEAN hasStride=ANTLR3_FALSE;}
   : do_variable T_EQUALS expr T_COMMA expr ( T_COMMA expr {hasStride=ANTLR3_TRUE;})?
            { c_action_io_implied_do_control(hasStride); }
   ;

// R920
// TODO: remove this?  it is never called.
dtv_type_spec
   :   T_TYPE
        T_LPAREN
        derived_type_spec
        T_RPAREN
            { c_action_dtv_type_spec($T_TYPE); }
   |   T_CLASS
        T_LPAREN
        derived_type_spec
        T_RPAREN
            { c_action_dtv_type_spec($T_CLASS); }
   ;

// R921
wait_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_WAIT T_LPAREN wait_spec_list T_RPAREN 
            end_of_stmt
            {c_action_wait_stmt(lbl, $T_WAIT, $end_of_stmt.start);}
   ;

// R922
// file_unit_number, scalar_int_variable, iomsg_variable, label replaced 
// by expr
wait_spec
   :   expr
            { c_action_wait_spec(NULL); }
   |   T_IDENT /* {'UNIT','END','EOR','ERR','ID','IOMSG','IOSTAT'} */ 
            T_EQUALS expr
            { c_action_wait_spec($T_IDENT); }
   ;


wait_spec_list
@init{ int count=0;}
   :       {c_action_wait_spec_list__begin();}
        wait_spec {count++;} ( T_COMMA wait_spec {count++;} )*
            {c_action_wait_spec_list(count);}
   ;

// R923
backspace_stmt
options {k=3;}
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   ((label)? T_BACKSPACE T_LPAREN) => 
            (label {lbl=$label.start;})? T_BACKSPACE T_LPAREN position_spec_list 
            T_RPAREN end_of_stmt
            {c_action_backspace_stmt(lbl, $T_BACKSPACE, $end_of_stmt.start, ANTLR3_TRUE);}
   |   ((label)? T_BACKSPACE) => 
            (label {lbl=$label.start;})? T_BACKSPACE file_unit_number end_of_stmt
            {c_action_backspace_stmt(lbl, $T_BACKSPACE, $end_of_stmt.start, ANTLR3_FALSE);}
   ;

// R924
endfile_stmt
options {k=3;}
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   ((label)? T_END T_FILE T_LPAREN) => 
            (label {lbl=$label.start;})? T_END T_FILE T_LPAREN position_spec_list 
            T_RPAREN end_of_stmt
            {c_action_endfile_stmt(lbl, $T_END, $T_FILE, $end_of_stmt.start, ANTLR3_TRUE);}
   |   ((label)? T_ENDFILE T_LPAREN) => 
            (label {lbl=$label.start;})? T_ENDFILE T_LPAREN position_spec_list 
            T_RPAREN end_of_stmt
            {c_action_endfile_stmt(lbl, $T_ENDFILE, NULL, $end_of_stmt.start, 
                ANTLR3_TRUE);}
   |   ((label)? T_END T_FILE) => 
            (label {lbl=$label.start;})? T_END T_FILE file_unit_number end_of_stmt
            {c_action_endfile_stmt(lbl, $T_END, $T_FILE, $end_of_stmt.start, 
                ANTLR3_FALSE);}
   |   ((label)? T_ENDFILE) => 
            (label {lbl=$label.start;})? T_ENDFILE file_unit_number end_of_stmt
            {c_action_endfile_stmt(lbl, $T_ENDFILE, NULL, $end_of_stmt.start, 
                ANTLR3_FALSE);}
   ;

// R925
rewind_stmt
options {k=3;}
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   ((label)? T_REWIND T_LPAREN) => 
            (label {lbl=$label.start;})? T_REWIND T_LPAREN position_spec_list 
            T_RPAREN end_of_stmt
            {c_action_rewind_stmt(lbl, $T_REWIND, $end_of_stmt.start, ANTLR3_TRUE);}
   |   ((label)? T_REWIND) => 
            (label {lbl=$label.start;})? T_REWIND file_unit_number end_of_stmt
            {c_action_rewind_stmt(lbl, $T_REWIND, $end_of_stmt.start, ANTLR3_FALSE);}
   ;

// R926
// file_unit_number, scalar_int_variable, iomsg_variable, label replaced 
// by expr
position_spec
   :   expr
            { c_action_position_spec(NULL); }
   |   T_IDENT /* {'UNIT','IOSTAT','IOMSG','ERR'} */ T_EQUALS expr
            { c_action_position_spec($T_IDENT); }
   ;

position_spec_list
@init{ int count=0;}
   :       {c_action_position_spec_list__begin();}
        position_spec {count++;} ( T_COMMA position_spec {count++;} )*
            {c_action_position_spec_list(count);}
   ;

// R927
flush_stmt
options {k=3;}
@init {pANTLR3_COMMON_TOKEN lbl = NULL;} 
@after{checkForInclude();}
   :   ((label)? T_FLUSH T_LPAREN) => 
            (label {lbl=$label.start;})? T_FLUSH T_LPAREN flush_spec_list 
            T_RPAREN end_of_stmt
            {c_action_flush_stmt(lbl, $T_FLUSH, $end_of_stmt.start, ANTLR3_TRUE);}
   |   ((label)? T_FLUSH) => 
            (label {lbl=$label.start;})? T_FLUSH file_unit_number end_of_stmt
            {c_action_flush_stmt(lbl, $T_FLUSH, $end_of_stmt.start, ANTLR3_FALSE);}
   ;

// R928
// file_unit_number, scalar_int_variable, iomsg_variable, label replaced 
// by expr
flush_spec
   :   expr
            { c_action_flush_spec(NULL); }
   |   T_IDENT /* {'UNIT','IOSTAT','IOMSG','ERR'} */ T_EQUALS expr
            { c_action_flush_spec($T_IDENT); }
   ;

flush_spec_list
@init{ int count=0;}
   :       {c_action_flush_spec_list__begin();}
        flush_spec {count++;} ( T_COMMA flush_spec {count++;} )*
            {c_action_flush_spec_list(count);}
   ;

// R929
inquire_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_INQUIRE T_LPAREN inquire_spec_list 
            T_RPAREN end_of_stmt
            {c_action_inquire_stmt(lbl, $T_INQUIRE, NULL, $end_of_stmt.start, 
                ANTLR3_FALSE);}
   |   (label {lbl=$label.start;})? T_INQUIRE_STMT_2 
            T_INQUIRE T_LPAREN T_IDENT /* 'IOLENGTH' */ T_EQUALS 
            scalar_int_variable T_RPAREN output_item_list end_of_stmt
                {c_action_inquire_stmt(lbl, $T_INQUIRE, $T_IDENT, 
                    $end_of_stmt.start, ANTLR3_TRUE);}
   ;


// R930
// ERR_CHK 930 file_name_expr replaced by expr
// file_unit_number replaced by expr
// scalar_default_char_variable replaced by designator
inquire_spec
   :   expr
            { c_action_inquire_spec(NULL); }
   |   T_IDENT 
        /* {'UNIT','FILE'} '=' expr portion, '=' designator portion below 
           {'ACCESS','ACTION','ASYNCHRONOUS','BLANK','DECIMAL',DELIM','DIRECT'}
           {'ENCODING','ERR','EXIST','FORM','FORMATTED','ID','IOMSG','IOSTAT'}
           {'NAME','NAMED','NEXTREC','NUMBER',OPENED','PAD','PENDING','POS'} 
           {'POSITION','READ','READWRITE','RECL','ROUND','SEQUENTIAL','SIGN'} 
           {'SIZE','STREAM','UNFORMATTED','WRITE'}  */
        T_EQUALS expr
             { c_action_inquire_spec($T_IDENT); }
   ;

inquire_spec_list
@init{ int count=0;}
   :       {c_action_inquire_spec_list__begin();}
        inquire_spec {count++;} ( T_COMMA inquire_spec {count++;} )*
            {c_action_inquire_spec_list(count);}
   ;

/**
 * Section/Clause 10: Input/output editing
 */

// R1001
// TODO: error checking: label is required.  accept as optional so we can
// report the error to the user.
format_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_FORMAT format_specification end_of_stmt
            {c_action_format_stmt(lbl, $T_FORMAT, $end_of_stmt.start);}
   ;

// R1002
format_specification
@init{ ANTLR3_BOOLEAN hasFormatItemList=ANTLR3_FALSE; }
   :   T_LPAREN ( format_item_list {hasFormatItemList=ANTLR3_TRUE;})? T_RPAREN
            {c_action_format_specification(hasFormatItemList);}
   ;

// R1003
// r replaced by int_literal_constant replaced by char_literal_constant 
// replaced by T_CHAR_CONSTANT
// char_string_edit_desc replaced by T_CHAR_CONSTANT
format_item
@init{ pANTLR3_COMMON_TOKEN descOrDigit=NULL; ANTLR3_BOOLEAN hasFormatItemList=ANTLR3_FALSE; }
   :   T_DATA_EDIT_DESC 
            {c_action_format_item($T_DATA_EDIT_DESC,hasFormatItemList);}
   |   T_CONTROL_EDIT_DESC
            {c_action_format_item($T_CONTROL_EDIT_DESC,hasFormatItemList);}
   |   T_CHAR_STRING_EDIT_DESC
            {c_action_format_item($T_CHAR_STRING_EDIT_DESC,hasFormatItemList);}
   |   (T_DIGIT_STRING {descOrDigit=$T_DIGIT_STRING;} )? T_LPAREN 
            format_item_list T_RPAREN
            {c_action_format_item(descOrDigit,hasFormatItemList);}
   ;

// the comma is not always required.  see J3/04-007, pg. 221, lines
// 17-22
// ERR_CHK
format_item_list
@init{ int count=1;}
   :       {c_action_format_item_list__begin();}
        format_item ( (T_COMMA)? format_item {count++;} )*
            {c_action_format_item_list(count);}
   ;


// the following rules, from here to the v_list, are the originals.  modifying 
// to try and simplify and make match up with the standard.
// original rules. 02.01.07
// // R1003
// // r replaced by int_literal_constant replaced by char_literal_constant replaced by T_CHAR_CONSTANT
// // char_string_edit_desc replaced by T_CHAR_CONSTANT
// format_item
//  :   T_DIGIT_STRING data_edit_desc
//  |   data_plus_control_edit_desc
//  |   T_CHAR_CONSTANT
//  |   (T_DIGIT_STRING)? T_LPAREN format_item_list T_RPAREN
//  ;

// format_item_list
//    :    format_item ( T_COMMA format_item )*
//    ;

// // R1004 r inlined in R1003 and R1011 as int_literal_constant (then as DIGIT_STRING)
// // C1004 (R1004) r shall not have a kind parameter associated with it

// // R1005
// // w,m,d,e replaced by int_literal_constant replaced by T_DIGIT_STRING
// // char_literal_constant replaced by T_CHAR_CONSTANT
// // ERR_CHK 1005 matching T_ID_OR_OTHER with alternatives will have to be done here
// data_edit_desc
//    : T_ID_OR_OTHER /* {'I','B','O','Z','F','E','EN','ES','G','L','A','D'} */ 
//       T_DIGIT_STRING ( T_PERIOD T_DIGIT_STRING )?
//       ( T_ID_OR_OTHER /* is 'E' */ T_DIGIT_STRING )?
//    | T_ID_OR_OTHER /* is 'DT' */ T_CHAR_CONSTANT ( T_LPAREN v_list T_RPAREN )?
//    | T_ID_OR_OTHER /* {'A','DT'},{'X','P' from control_edit_desc} */
//    ;

// data_plus_control_edit_desc
//  :   T_ID_OR_OTHER /* {'I','B','O','Z','F','E','EN','ES','G','L','A','D'},{T','TL','TR'} */ 
//          T_DIGIT_STRING ( T_PERIOD T_DIGIT_STRING )?
//          ( T_ID_OR_OTHER /* is 'E' */ T_DIGIT_STRING )?
//  |   T_ID_OR_OTHER /* is 'DT' */ T_CHAR_CONSTANT ( T_LPAREN v_list T_RPAREN )?
//  |   T_ID_OR_OTHER /* {'A','DT'},{'BN','BZ','RU','RD','RZ','RN','RC','RP','DC','DP'} */
// // following only from control_edit_desc
//  |   ( T_DIGIT_STRING )? T_SLASH
//  |   T_COLON
//  |   (T_PLUS|T_MINUS) T_DIGIT_STRING T_ID_OR_OTHER /* is 'P' */
//  ;

// R1006 w inlined in R1005 as int_literal_constant replaced by T_DIGIT_STRING

// R1007 m inlined in R1005 as int_literal_constant replaced by T_DIGIT_STRING

// R1008 d inlined in R1005 as int_literal_constant replaced by T_DIGIT_STRING

// R1009 e inlined in R1005 as int_literal_constant replaced by T_DIGIT_STRING

// R1010 v inlined as signed_int_literal_constant in v_list replaced by (T_PLUS or T_MINUS) T_DIGIT_STRING

v_list
@init{int count=0;}
   :       {c_action_v_list__begin();}
        (pm=T_PLUS|T_MINUS)? ds=T_DIGIT_STRING
            {
                count++;
                c_action_v_list_part(pm, ds);
            }
        ( T_COMMA (pm=T_PLUS|T_MINUS)? ds=T_DIGIT_STRING
            {
                count++;
                c_action_v_list_part(pm, ds);
            }
        )*
            {c_action_v_list(count);}
   ;

// R1011 control_edit_desc inlined/combined in R1005 and data_plus_control_edit_desc
// r replaced by int_literal_constant replaced by T_DIGIT_STRING
// k replaced by signed_int_literal_constant replaced by (T_PLUS|T_MINUS)? T_DIGIT_STRING
// position_edit_desc inlined
// sign_edit_desc replaced by T_ID_OR_OTHER was {'SS','SP','S'}
// blank_interp_edit_desc replaced by T_ID_OR_OTHER was {'BN','BZ'}
// round_edit_desc replaced by T_ID_OR_OTHER was {'RU','RD','RZ','RN','RC','RP'}
// decimal_edit_desc replaced by T_ID_OR_OTHER was {'DC','DP'}
// leading T_ID_OR_OTHER alternates combined with data_edit_desc in data_plus_control_edit_desc

// R1012 k inlined in R1011 as signed_int_literal_constant
// C1009 (R1012) k shall not have a kind parameter specified for it

// R1013 position_edit_desc inlined in R1011
// n in R1013 was replaced by int_literal_constant replaced by T_DIGIT_STRING

// R1014 n inlined in R1013 as int_literal_constant (is T_DIGIT_STRING, see C1010)
// C1010 (R1014) n shall not have a kind parameter specified for it

// R1015 sign_edit_desc inlined in R1011 as T_ID_OR_OTHER was {'SS','SP','S'}

// R1016 blank_interp_edit_desc inlined in R1011 as T_ID_OR_OTHER was {'BN','BZ'}

// R1017 round_edit_desc inlined in R1011 as T_ID_OR_OTHER was {'RU','RD','RZ','RN','RC','RP'}

// R1018 decimal_edit_desc inlined in R1011 as T_ID_OR_OTHER was {'DC','DP'}

// R1019 char_string_edit_desc was char_literal_constant inlined in R1003 as T_CHAR_CONSTANT


/**
 * Section/Clause 11: Program units
 */

//========================================================================================
//
/* R1101-F08 main-program
 *   is  [ program-stmt ]
 *          [ specification-part ]
 *          [ execution-part ]
 *          [ internal-subprogram-part ]
 *          end-program-stmt
 */
//
//
// This is one of the entry points to the parser.
//
// specification_part made non-optional to remove END ambiguity (as it can be empty)
//
//----------------------------------------------------------------------------------------
main_program
@init
{
   ANTLR3_BOOLEAN  hasExecutionPart            = ANTLR3_FALSE;
   ANTLR3_BOOLEAN  hasInternalSubprogramPart   = ANTLR3_FALSE;
   c_action_main_program__begin();
}
@after
{
   ANTLR3_BOOLEAN hasProgramStmt = hasPayload(ps.tree);
   c_action_main_program(hasProgramStmt, hasExecutionPart, hasInternalSubprogramPart);
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   ps=opt_program_stmt

           specification_part
           ( execution_part {hasExecutionPart = ANTLR3_TRUE;} )?
           ( internal_subprogram_part {hasInternalSubprogramPart = ANTLR3_TRUE;} )?

       end_program_stmt

   -> ^(OFPMainProgram
           opt_program_stmt
             specification_part
             ^(OFPExecutionPart           execution_part?           )
             ^(OFPInternalSubprogramPart  internal_subprogram_part? )
           end_program_stmt
       )
   ;


//========================================================================================
//
// added rule so could have one rule for main() to call for attempting
// to match a function subprogram.  the original rule, 
// external_subprogram, has (prefix)? for a function_subprogram.
//
//----------------------------------------------------------------------------------------
ext_function_subprogram
@init
{
   ANTLR3_BOOLEAN hasPrefix=ANTLR3_FALSE;
}
   :   (prefix {hasPrefix=ANTLR3_TRUE;})? function_subprogram
           {
              c_action_ext_function_subprogram(hasPrefix);
           }
   ;


//========================================================================================
//
/* R1102-F08 program-stmt
 *   is  PROGRAM [ program-name ]
 */
//
// T_IDENT inlined for program_name
//
//----------------------------------------------------------------------------------------
program_stmt
@after
{
   checkForInclude();
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
   treeSetTokenBoundaries(retval.tree, id, id, 1);
}
   :   lbl=opt_label  T_PROGRAM  id=T_IDENT  end_of_stmt

          {
             c_action_program_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_PROGRAM,$T_IDENT,$end_of_stmt.start);
          }

   -> ^(opt_label) ^(OFPProgramName T_IDENT)
   ;

opt_program_stmt
@after
{
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   program_stmt?
   -> ^(OFPProgramStmt program_stmt?)
   ;


//========================================================================================
//
/* R1103-F08 end-program-stmt
 *   is  END [ PROGRAM [ program-name ] ]
 */
//
// T_IDENT inlined for program_name
//
//----------------------------------------------------------------------------------------
end_program_stmt
@after
{
   checkForInclude();
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
   treeSetTokenBoundaries(retval.tree, id, id, 1);
}
   :   lbl=opt_label  T_END  T_PROGRAM  id=T_IDENT?  end_of_stmt

          {
             c_action_end_program_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_END,$T_PROGRAM,id,$end_of_stmt.start);
          }

   -> ^(OFPEndProgramStmt opt_label ^(OFPProgramName T_IDENT?))

   |   lbl=opt_label  T_ENDPROGRAM     id=T_IDENT?  end_of_stmt

          {
             c_action_end_program_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_ENDPROGRAM,NULL,id,$end_of_stmt.start);
          }

   -> ^(OFPEndProgramStmt opt_label ^(OFPProgramName T_IDENT?))

   |   lbl=opt_label  T_END                         end_of_stmt

          {
             c_action_end_program_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_END,NULL,NULL,$end_of_stmt.start);
          }

   -> ^(OFPEndProgramStmt opt_label ^(OFPProgramName))

   ;


//========================================================================================
//
/* R1104-F08 module
 *   is  module-stmt
 *          [ specification-part ]
 *          [ module-subprogram-part ]
 *          end-module-stmt
 */
//
// specification_part made non-optional to remove END ambiguity (as it can be empty)
//
//----------------------------------------------------------------------------------------
module
@after
{
   c_action_module();
}
   :   module_stmt
       specification_part
       module_subprogram_part?
       end_module_stmt

   -> ^(OFPModule module_stmt
          ^(SgBasicBlock
              specification_part
          // TODO - ( module_subprogram_part )?
           )
           end_module_stmt
       )
   ;

//========================================================================================
//
/* R1105-F08 module-stmt
 *   is  MODULE module-name
 */
//
//----------------------------------------------------------------------------------------
module_stmt
@init
{
   c_action_module_stmt__begin();
}
@after
{
   checkForInclude();
}
   :   lbl=label?  T_MODULE  id=T_IDENT  end_of_stmt

           {
              c_action_module_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_MODULE,id,$end_of_stmt.start);
           }

   -> ^(OFPModuleStmt  ^(OFPLabel label?)  ^(OFPModuleName T_IDENT) )
   ;


//========================================================================================
//
/* R1106-F08 end-module-stmt
 *   is  END [ MODULE [ module-name ] ]
 */
//
//----------------------------------------------------------------------------------------
end_module_stmt
@after
{
   checkForInclude();
}
   :   lbl=label?  T_END  T_MODULE  id=T_IDENT?  end_of_stmt

           {
              c_action_end_module_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_END,$T_MODULE,id,$end_of_stmt.start);
           }

   -> ^(OFPEndModuleStmt ^(OFPLabel label?) ^(OFPModuleName T_IDENT?) )

   |   lbl=label?  T_ENDMODULE      id=T_IDENT?  end_of_stmt

           {
              c_action_end_module_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_ENDMODULE,NULL,id,$end_of_stmt.start);
           }

   -> ^(OFPEndModuleStmt ^(OFPLabel label?) ^(OFPModuleName T_IDENT?) )

   |   lbl=label?  T_END                         end_of_stmt

           {
              c_action_end_module_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_END,NULL,id,$end_of_stmt.start);
           }

   -> ^(OFPEndModuleStmt ^(OFPLabel label?) ^(OFPModuleName) )

   ;


/*
 * R1107-F08 module-subprogram-part
 *     is  contains-stmt
 *         [ module-subprogram ] ...
 */

////////////
// R1107-F08
//
module_subprogram_part
@init {int count = 0;}
   :   contains_stmt
       ( module_subprogram {count += 1;} )*
           { c_action_module_subprogram_part(count); }
   ;


/*
 * R1108-F08 module-subprogram
 *     is  function-subprogram
 *     or  subroutine-subprogram
 *     or  separate-module-subprogram   // NEW_TO_F2008
 */

////////////
// R1108-F08
//
// modified to factor optional prefix
//
module_subprogram
@init {ANTLR3_BOOLEAN hasPrefix = ANTLR3_FALSE;}
@after{c_action_module_subprogram(hasPrefix);}
   :   (prefix {hasPrefix=ANTLR3_TRUE;})? function_subprogram
   |   subroutine_subprogram
   |   separate_module_subprogram
   ;


// R1109
use_stmt
@init
{
    ANTLR3_BOOLEAN hasModuleNature=ANTLR3_FALSE; 
    ANTLR3_BOOLEAN hasRenameList=ANTLR3_FALSE;
}
@after
{
   checkForInclude();
}
   :   lbl=label?
       T_USE   ( (T_COMMA module_nature {hasModuleNature=ANTLR3_TRUE;})? T_COLON_COLON )?
       T_IDENT (  T_COMMA rename_list   {hasRenameList=ANTLR3_TRUE;})?   end_of_stmt

            {
               c_action_use_stmt(lbl,$T_USE,$T_IDENT,NULL,$end_of_stmt.start,hasModuleNature,hasRenameList,ANTLR3_FALSE);
            }

   -> ^(OFPUseStmt ^(OFPLabel label?) ^(SgInitializedName T_IDENT)
           ^(OFPModuleNature module_nature?)
           ^(OFPRenameList   rename_list  ?)
             OFPOnlyList
       )

   |   lbl=label?
       T_USE   ( ( T_COMMA module_nature {hasModuleNature=ANTLR3_TRUE;})? T_COLON_COLON )?
       T_IDENT     T_COMMA T_ONLY T_COLON  only_list?                     end_of_stmt

            {
               c_action_use_stmt(lbl,$T_USE,$T_IDENT,$T_ONLY,$end_of_stmt.start,hasModuleNature,hasRenameList,ANTLR3_TRUE);
            }

   -> ^(OFPUseStmt ^(OFPLabel label?) ^(SgInitializedName T_IDENT)
           ^(OFPModuleNature module_nature?)
             OFPRenameList
           ^(OFPOnlyList     only_list    ?)
       )

   ;

// R1110
module_nature
   :   T_INTRINSIC
            { c_action_module_nature($T_INTRINSIC); }
   |   T_NON_INTRINSIC
            { c_action_module_nature($T_NON_INTRINSIC); }
   ;

//========================================================================================
//
/* R1111-F08 rename
 *   is  local-name  =>  use-name
 *   or  OPERATOR  (local-defined-operator )  =>  OPERATOR (use-defined-operator)
 */
//
// Renamed to fortran_rename to avoid collision with rename from stdio.h
//
// T_DEFINED_OP inlined for local_defined_operator and use_defined_operator
// T_IDENT inlined for local_name and use_name
//
//----------------------------------------------------------------------------------------
fortran_rename
   :   id1=T_IDENT T_EQ_GT id2=T_IDENT
           { c_action_rename(id1, id2, NULL, NULL, NULL, NULL); }
   |   op1=T_OPERATOR T_LPAREN defOp1=T_DEFINED_OP T_RPAREN T_EQ_GT
       op2=T_OPERATOR T_LPAREN defOp2=T_DEFINED_OP T_RPAREN
           { c_action_rename(NULL, NULL, op1, defOp1, op2, defOp2); } 
   ;

rename_list
@init
{
   int count = 1;
   c_action_rename_list__begin();
}
@after
{
   c_action_rename_list(count);
}
   :
       fortran_rename  ( T_COMMA fortran_rename {count++;} )*
   ;

// R1112
// T_IDENT inlined for only_use_name
// generic_spec can be T_IDENT so T_IDENT deleted
only
@init
{
   ANTLR3_BOOLEAN hasGenericSpec=ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasRename=ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasOnlyUseName=ANTLR3_FALSE;
}
@after
{
   c_action_only(hasGenericSpec, hasRename, hasOnlyUseName);
}
   :   generic_spec        {hasGenericSpec=ANTLR3_TRUE;}
   |   fortran_rename      {hasRename=ANTLR3_TRUE;}
   ;

only_list
@init
{
   int count=0;
   c_action_only_list__begin();
}
   :   only {count++;} ( T_COMMA only {count++;} )*
            {c_action_only_list(count);}

   -> only+
   ;

// R1113 only_use_name was use_name inlined as T_IDENT

// R1114 inlined local_defined_operator in R1111 as T_DEFINED_OP

// R1115 inlined use_defined_operator in R1111 as T_DEFINED_OP

/*
 * R1116-F08 submodule
 *   is  submodule-stmt
 *          [ specification-part ]
 *          [ module-subprogram-part ]
 *       end-submodule-stmt
 */

////////////
// R1116-F08
//
submodule
@init {ANTLR3_BOOLEAN hasModuleSubprogramPart = ANTLR3_FALSE;}
@after{c_action_submodule(hasModuleSubprogramPart);}
   :   submodule_stmt
       specification_part  // non-optional as can be empty
       ( module_subprogram_part {hasModuleSubprogramPart=ANTLR3_TRUE;} )?
       end_submodule_stmt
   ;

/*
 * R1117-F08 submodule-stmt
 *   is  SUBMODULE ( parent-identifier ) submodule-name
 */

////////////
// R1117-F08
//
submodule_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN t_subname = NULL;}
@after{checkForInclude();}
   :       {c_action_submodule_stmt__begin();}
       (label {lbl=$label.start;})?
       T_SUBMODULE T_LPAREN parent_identifier T_RPAREN
       name {t_subname=$name.start;} end_of_stmt
           {c_action_submodule_stmt(lbl, $T_SUBMODULE, t_subname, $end_of_stmt.start);}
   ;


/*
 * R1118-F08 parent-identifier
 *   is  ancestor-module-name [ : parent-submodule-name ]
 */

////////////
// R1118-F08
//
parent_identifier
@init {pANTLR3_COMMON_TOKEN ancestor = NULL; pANTLR3_COMMON_TOKEN parent = NULL;}
   :   name {ancestor=$name.start;}
       ( : T_IDENT {parent=$T_IDENT;} )?
           {c_action_parent_identifier(ancestor, parent);}
   ;


/*
 * R1119-F08 end-submodule-stmt
 *   is  END [ SUBMODULE [ submodule-name ] ]
 */

////////////
// R1119-F08
//
end_submodule_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN t_submod = NULL; pANTLR3_COMMON_TOKEN t_name = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       T_END (T_SUBMODULE (name {t_name=$name.start;})? {t_submod=$T_SUBMODULE;})?
       end_of_stmt
           {c_action_end_submodule_stmt(lbl, $T_END, t_submod, t_name, $end_of_stmt.start);}
   ;

// R1116
// specification_part made non-optional to remove END ambiguity (as can 
// be empty).
block_data
@after {
    c_action_block_data();
}
   :   block_data_stmt
        specification_part
        end_block_data_stmt
   ;

// R1117
block_data_stmt
@init
    {
        pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id = NULL;
        c_action_block_data_stmt__begin();
    }
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       T_BLOCK T_DATA (T_IDENT {id=$T_IDENT;})? end_of_stmt
           {c_action_block_data_stmt(lbl, $T_BLOCK, $T_DATA, id, $end_of_stmt.start);}
   |   (label {lbl=$label.start;})?
       T_BLOCKDATA  (T_IDENT {id=$T_IDENT;})? end_of_stmt
           {c_action_block_data_stmt(lbl, $T_BLOCKDATA, NULL, id, $end_of_stmt.start);}
   ;

// R1118
end_block_data_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_END T_BLOCK T_DATA 
            ( T_IDENT {id=$T_IDENT;})? end_of_stmt
            {c_action_end_block_data_stmt(lbl, $T_END, $T_BLOCK, $T_DATA, id, 
                                        $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_ENDBLOCK T_DATA    
            ( T_IDENT {id=$T_IDENT;})? end_of_stmt
            {c_action_end_block_data_stmt(lbl, $T_ENDBLOCK, NULL, $T_DATA, id, 
                                        $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_END T_BLOCKDATA    
            ( T_IDENT {id=$T_IDENT;})? end_of_stmt
            {c_action_end_block_data_stmt(lbl, $T_END, $T_BLOCKDATA, NULL, id, 
                                        $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_ENDBLOCKDATA       
            ( T_IDENT {id=$T_IDENT;})? end_of_stmt
            {c_action_end_block_data_stmt(lbl, $T_ENDBLOCKDATA, NULL, NULL, id, 
                                        $end_of_stmt.start);}
   |   (label {lbl=$label.start;})? T_END end_of_stmt
            {c_action_end_block_data_stmt(lbl, $T_END, NULL, NULL, id, 
                                        $end_of_stmt.start);}
   ;

/**
 * Section/Clause 12: Procedures
 */

// R1201
interface_block
@after {
    c_action_interface_block();
}
   :   interface_stmt
        ( interface_specification )*
        end_interface_stmt
   ;

// R1202
interface_specification
@after {
    c_action_interface_specification();
}
   :   interface_body
   |   procedure_stmt
   ;

//========================================================================================
//
/* R1203-F08 interface-stmt
 *   is  INTERFACE [ generic-spec ]
 */
//
//----------------------------------------------------------------------------------------
interface_stmt
@init
{
   c_action_interface_stmt__begin();
   ANTLR3_BOOLEAN hasGenericSpec = ANTLR3_FALSE;
}
@after
{
   checkForInclude();
}
   :   lbl=label?
       T_INTERFACE ( generic_spec {hasGenericSpec=ANTLR3_TRUE;} )?  end_of_stmt

           {
              c_action_interface_stmt(lbl,NULL,$T_INTERFACE,$end_of_stmt.start,hasGenericSpec);
           }

   -> ^(OFPInterfaceStmt ^(OFPLabel label?) ^(OFPGenericSpec generic_spec?))

   |   lbl=label?
       T_ABSTRACT T_INTERFACE                                       end_of_stmt
           {
              c_action_interface_stmt(lbl,$T_ABSTRACT,$T_INTERFACE,$end_of_stmt.start,hasGenericSpec);
           }

   -> ^(OFPInterfaceStmt ^(OFPLabel label?)   OFPGenericSpec )

   ;

//========================================================================================
//
/* R1204-F08 end-interface-stmt
 *   is  END INTERFACE [ generic-spec ]
 */
//
//----------------------------------------------------------------------------------------
end_interface_stmt
@init
{
   ANTLR3_BOOLEAN hasGenericSpec=ANTLR3_FALSE;
}
@after
{
   checkForInclude();
}
   :   lbl=label?
       T_END T_INTERFACE ( generic_spec {hasGenericSpec=ANTLR3_TRUE;} )?  end_of_stmt

           {
              c_action_end_interface_stmt(lbl,$T_END,$T_INTERFACE,$end_of_stmt.start,hasGenericSpec);
           }

   -> ^(OFPEndInterfaceStmt ^(OFPLabel label?) ^(OFPGenericSpec generic_spec?))

   |   lbl=label?
       T_ENDINTERFACE    ( generic_spec {hasGenericSpec=ANTLR3_TRUE;} )?  end_of_stmt

           {
              c_action_end_interface_stmt(lbl,$T_ENDINTERFACE,NULL,$end_of_stmt.start,hasGenericSpec);
           }

   -> ^(OFPEndInterfaceStmt ^(OFPLabel label?) ^(OFPGenericSpec generic_spec?))

   ;

// R1205
// specification_part made non-optional to remove END ambiguity (as can 
// be empty)
interface_body
   :   prefix? function_stmt specification_part end_function_stmt
            { c_action_interface_body(ANTLR3_TRUE); /* true for hasPrefix */ }

   -> OFPUnimplemented

   |   subroutine_stmt specification_part end_subroutine_stmt
            { c_action_interface_body(ANTLR3_FALSE); /* false for hasPrefix */ }

   -> ^(SgFunctionDeclaration subroutine_stmt end_subroutine_stmt specification_part)

   ;

// R1206
// generic_name_list substituted for procedure_name_list
procedure_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN module=NULL;} 
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? ( T_MODULE {module=$T_MODULE;})? 
            T_PROCEDURE generic_name_list end_of_stmt
            {c_action_procedure_stmt(lbl, module, $T_PROCEDURE, 
                $end_of_stmt.start);}
   ;

// R1207
// T_IDENT inlined for generic_name
generic_spec
   :   T_IDENT

           {
              c_action_generic_spec(NULL,$T_IDENT,IActionEnums_ GenericSpec_generic_name);
           }

   -> ^(SgInitializedName T_IDENT)

   |   T_OPERATOR T_LPAREN defined_operator T_RPAREN

           {
              c_action_generic_spec($T_OPERATOR,NULL,IActionEnums_ GenericSpec_OPERATOR);
           }

   -> OFPUnimplemented

   |   T_ASSIGNMENT T_LPAREN T_EQUALS T_RPAREN

           {
              c_action_generic_spec($T_ASSIGNMENT,NULL,IActionEnums_ GenericSpec_ASSIGNMENT);
           }

   -> OFPUnimplemented

   |   defined_io_generic_spec

           {
              c_action_generic_spec(NULL,NULL,IActionEnums_ GenericSpec_dtio_generic_spec);
           }

   -> OFPUnimplemented

   ;

// R1208
// TODO - the name has been changed from dtio_generic_spec to defined_io_generic_spec
// change the actions and enums as well
defined_io_generic_spec
   :   T_READ T_LPAREN T_FORMATTED T_RPAREN
        {c_action_dtio_generic_spec($T_READ, $T_FORMATTED, 
                                  IActionEnums_ DTIOGenericSpec_READ_FORMATTED);}
   |   T_READ T_LPAREN T_UNFORMATTED T_RPAREN
        {c_action_dtio_generic_spec($T_READ, $T_UNFORMATTED, 
                                  IActionEnums_ DTIOGenericSpec_READ_UNFORMATTED);}
   |   T_WRITE T_LPAREN T_FORMATTED T_RPAREN
        {c_action_dtio_generic_spec($T_WRITE, $T_FORMATTED, 
                                  IActionEnums_ DTIOGenericSpec_WRITE_FORMATTED);}
   |   T_WRITE T_LPAREN T_UNFORMATTED T_RPAREN
        {c_action_dtio_generic_spec($T_WRITE, $T_UNFORMATTED, 
                                  IActionEnums_ DTIOGenericSpec_WRITE_UNFORMATTED);}
   ;

// R1209
// generic_name_list substituted for import_name_list
import_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasGenericNameList=ANTLR3_FALSE;}
@after{checkForInclude();}
   :    (label {lbl=$label.start;})? T_IMPORT ( ( T_COLON_COLON )? 
            generic_name_list {hasGenericNameList=ANTLR3_TRUE;})? end_of_stmt
            {c_action_import_stmt(lbl, $T_IMPORT, $end_of_stmt.start, 
                hasGenericNameList);}
   ;

// R1210
// generic_name_list substituted for external_name_list
external_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_EXTERNAL ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
            {c_action_external_stmt(lbl, $T_EXTERNAL, $end_of_stmt.start);}
   ;

// R1211
procedure_declaration_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasProcInterface=ANTLR3_FALSE; int count=0;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_PROCEDURE T_LPAREN
        ( proc_interface {hasProcInterface=ANTLR3_TRUE;})? T_RPAREN
        ( ( T_COMMA proc_attr_spec {count++;})* T_COLON_COLON )?
        proc_decl_list end_of_stmt
            {c_action_procedure_declaration_stmt(lbl, $T_PROCEDURE, 
                $end_of_stmt.start, hasProcInterface, count);}
   ;

// R1212
// T_IDENT inlined for interface_name
proc_interface
   :   T_IDENT                 { c_action_proc_interface($T_IDENT); }
   |   declaration_type_spec   { c_action_proc_interface(NULL); }
   ;

// R1213
proc_attr_spec
   :   access_spec
            { c_action_proc_attr_spec(NULL, NULL, IActionEnums_ AttrSpec_none); }
   |   proc_language_binding_spec
            { c_action_proc_attr_spec(NULL, NULL, IActionEnums_ AttrSpec_none); }
   |   T_INTENT T_LPAREN intent_spec T_RPAREN
            { c_action_proc_attr_spec($T_INTENT, NULL, 
                IActionEnums_ AttrSpec_INTENT); }
   |   T_OPTIONAL  
            { c_action_proc_attr_spec($T_OPTIONAL, NULL, 
                IActionEnums_ AttrSpec_OPTIONAL); }
   |   T_POINTER   
            { c_action_proc_attr_spec($T_POINTER, NULL, 
                IActionEnums_ AttrSpec_POINTER); }
   |   T_SAVE      
            { c_action_proc_attr_spec($T_SAVE, NULL, 
                IActionEnums_ AttrSpec_SAVE); }
// TODO: are T_PASS, T_NOPASS, and T_DEFERRED correct?
// From R453 binding-attr
   |   T_PASS ( T_LPAREN T_IDENT T_RPAREN)?
            { c_action_proc_attr_spec($T_PASS, $T_IDENT, 
                IActionEnums_ AttrSpec_PASS); }
   |   T_NOPASS
            { c_action_proc_attr_spec($T_NOPASS, NULL, 
                IActionEnums_ AttrSpec_NOPASS); }
   |   T_DEFERRED
            { c_action_proc_attr_spec($T_DEFERRED, NULL, 
                IActionEnums_ AttrSpec_DEFERRED); }
   |   proc_attr_spec_extension
   ;
  
// language extension point
proc_attr_spec_extension : T_NO_LANGUAGE_EXTENSION ;

// R1214
// T_IDENT inlined for procedure_entity_name
proc_decl
@init{ANTLR3_BOOLEAN hasNullInit = ANTLR3_FALSE;}
   :   T_IDENT ( T_EQ_GT null_init {hasNullInit=ANTLR3_TRUE;} )?
            { c_action_proc_decl($T_IDENT, hasNullInit); }
   ;

proc_decl_list
@init{ int count=0;}
   :       {c_action_proc_decl_list__begin();}
        proc_decl {count++;} ( T_COMMA proc_decl {count++;} )*
            {c_action_proc_decl_list(count);}
   ;

// R1215 interface_name was name inlined as T_IDENT

// R1216
// generic_name_list substituted for intrinsic_procedure_name_list
intrinsic_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_INTRINSIC
        ( T_COLON_COLON )?
        generic_name_list end_of_stmt
            {c_action_intrinsic_stmt(lbl, $T_INTRINSIC, $end_of_stmt.start);}
   ;

// R1217 function_reference replaced by designator_or_func_ref to reduce 
// backtracking

// R1218
// C1222 (R1218) The procedure-designator shall designate a subroutine.
call_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasActualArgSpecList = ANTLR3_FALSE;} 
@after{checkForInclude();}
   :    (label {lbl=$label.start;})? T_CALL procedure_designator
            ( T_LPAREN (actual_arg_spec_list {hasActualArgSpecList=ANTLR3_TRUE;})? 
            T_RPAREN )? end_of_stmt
            { c_action_call_stmt(lbl, $T_CALL, $end_of_stmt.start, 
                hasActualArgSpecList); }
   ;

// R1219
// ERR_CHK 1219 must be (T_IDENT | designator T_PERCENT T_IDENT)
// T_IDENT inlined for procedure_name and binding_name
// proc_component_ref is variable T_PERCENT T_IDENT (variable is designator)
// data_ref subset of designator so data_ref T_PERCENT T_IDENT deleted
// designator (R603), minus the substring part is data_ref, so designator 
// replaced by data_ref
//R1219 procedure-designator            is procedure-name
//                                      or proc-component-ref
//                                      or data-ref % binding-name
procedure_designator
   :   data_ref
            { c_action_procedure_designator(); }
   ;

// R1220
actual_arg_spec
@init{pANTLR3_COMMON_TOKEN keyword = NULL;}
   :   (T_IDENT T_EQUALS {keyword=$T_IDENT;})? actual_arg
            { c_action_actual_arg_spec(keyword); }
   ;

// TODO - delete greedy?
actual_arg_spec_list
options{greedy=false;}
@init{int count = 0;}
   :       { c_action_actual_arg_spec_list__begin(); }
        actual_arg_spec {count++;} ( T_COMMA actual_arg_spec {count++;} )*
            { c_action_actual_arg_spec_list(count); }
   ;

// R1221
// ERR_CHK 1221 ensure ( expr | designator ending in T_PERCENT T_IDENT)
// T_IDENT inlined for procedure_name
// expr isa designator (via primary) so variable deleted
// designator isa T_IDENT so T_IDENT deleted
// proc_component_ref is variable T_PERCENT T_IDENT can be designator so 
// deleted
actual_arg
@init{ANTLR3_BOOLEAN hasExpr = ANTLR3_FALSE;}
   :   expr                
            { hasExpr=ANTLR3_TRUE; c_action_actual_arg(hasExpr, NULL); }
   |   T_ASTERISK label    
            { c_action_actual_arg(hasExpr, $label.start); }
   ;

// R1222 alt_return_spec inlined as T_ASTERISK label in R1221

// R1223
// 1. left factored optional prefix in function_stmt from function_subprogram
// 2. specification_part made non-optional to remove END ambiguity (as can 
// be empty)
function_subprogram
@init {
    ANTLR3_BOOLEAN hasExePart = ANTLR3_FALSE;
    ANTLR3_BOOLEAN hasIntSubProg = ANTLR3_FALSE;
}
   :   function_stmt
        specification_part
        ( execution_part { hasExePart=ANTLR3_TRUE; })?
        ( internal_subprogram_part { hasIntSubProg=ANTLR3_TRUE; })?
        end_function_stmt
            { c_action_function_subprogram(hasExePart, hasIntSubProg); }
   ;

// R1224
// left factored optional prefix from function_stmt
// generic_name_list substituted for dummy_arg_name_list
function_stmt
@init {
    pANTLR3_COMMON_TOKEN lbl = NULL; 
    ANTLR3_BOOLEAN hasGenericNameList=ANTLR3_FALSE;
    ANTLR3_BOOLEAN hasSuffix=ANTLR3_FALSE;
}
@after{checkForInclude();}
   :       {c_action_function_stmt__begin();} 
        (label {lbl=$label.start;})? T_FUNCTION T_IDENT
            T_LPAREN ( generic_name_list {hasGenericNameList=ANTLR3_TRUE;})? T_RPAREN 
            ( suffix {hasSuffix=ANTLR3_TRUE;})? end_of_stmt
            {c_action_function_stmt(lbl, $T_FUNCTION, $T_IDENT, $end_of_stmt.start, 
                                  hasGenericNameList,hasSuffix);}
   ;

// R1225
proc_language_binding_spec
   :   language_binding_spec
            { c_action_proc_language_binding_spec(); }
   ;

// R1226 dummy_arg_name was name inlined as T_IDENT

// R1227
// C1240 (R1227) A prefix shall contain at most one of each prefix-spec
// C1241 (R1227) A prefix shall not specify both ELEMENTAL AND RECURSIVE
prefix
@init
{
   int specCount = 1;
}
   :   ( prefix_spec {specCount++;} )+
           {
              c_action_prefix(specCount);
           }
   ;

t_prefix
@init
{
   int specCount = 1;
}
   :   ( t_prefix_spec {specCount++;} )+
           {
              c_action_t_prefix(specCount);
           }
   ;

// R1226-F08
prefix_spec
   :  declaration_type_spec
          {c_action_prefix_spec(ANTLR3_TRUE);}
   |  t_prefix_spec
          {c_action_prefix_spec(ANTLR3_FALSE);}
   ;

t_prefix_spec
   :  T_ELEMENTAL  {c_action_t_prefix_spec($T_ELEMENTAL);}
   |  T_IMPURE     {c_action_t_prefix_spec($T_IMPURE);}
   |  T_MODULE     {c_action_t_prefix_spec($T_MODULE);}
   |  T_PURE       {c_action_t_prefix_spec($T_PURE);}
   |  T_RECURSIVE  {c_action_t_prefix_spec($T_RECURSIVE);}
   |  prefix_spec_extension
   ;

// language extension point
prefix_spec_extension : T_NO_LANGUAGE_EXTENSION ;

// R1229
suffix
@init {
    pANTLR3_COMMON_TOKEN result = NULL;
    ANTLR3_BOOLEAN hasProcLangBindSpec = ANTLR3_FALSE;
}
   :   proc_language_binding_spec ( T_RESULT T_LPAREN result_name 
            T_RPAREN { result=$T_RESULT; })?
            { c_action_suffix(result, ANTLR3_TRUE); }
   |   T_RESULT T_LPAREN result_name T_RPAREN 
            ( proc_language_binding_spec { hasProcLangBindSpec = ANTLR3_TRUE; })?
            { c_action_suffix($T_RESULT, hasProcLangBindSpec); }
   ;

result_name
   :    name
            { c_action_result_name(); }
   ;

// R1230
end_function_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; pANTLR3_COMMON_TOKEN id = NULL;}
@after{checkForInclude();}
   : (label {lbl=$label.start;})? T_END T_FUNCTION ( T_IDENT {id=$T_IDENT;})? 
        end_of_stmt
        {c_action_end_function_stmt(lbl, $T_END, $T_FUNCTION, id, 
                                  $end_of_stmt.start);}
   | (label {lbl=$label.start;})? T_ENDFUNCTION    ( T_IDENT {id=$T_IDENT;})? 
        end_of_stmt
        {c_action_end_function_stmt(lbl, $T_ENDFUNCTION, NULL, id, 
                                  $end_of_stmt.start);}
   | (label {lbl=$label.start;})? T_END end_of_stmt
        {c_action_end_function_stmt(lbl, $T_END, NULL, id, $end_of_stmt.start);}
   ;

// R1231
// specification_part made non-optional to remove END ambiguity (as can 
// be empty)
subroutine_subprogram
   :   subroutine_stmt
       specification_part
       execution_part ?
       internal_subprogram_part ?
       end_subroutine_stmt

   -> ^(SgProcedureHeaderStatement subroutine_stmt end_subroutine_stmt
          ^(SgFunctionDefinition 
              ^(SgBasicBlock specification_part
               )
           )
       )
   ;

//========================================================================================
// R1234-F08 subroutine-stmt
//----------------------------------------------------------------------------------------
subroutine_stmt
@init
{
   ANTLR3_BOOLEAN hasPrefix       = ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasDummyArgList = ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasBindingSpec  = ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasArgSpecifier = ANTLR3_FALSE;
   c_action_subroutine_stmt__begin();
}
@after{checkForInclude();}
   :   lbl=label?
       ( t_prefix {hasPrefix=ANTLR3_TRUE;} )?
       T_SUBROUTINE T_IDENT
       ( T_LPAREN
            (
               dummy_arg_list             {hasDummyArgList=ANTLR3_TRUE;}
            )? 
         T_RPAREN
            (
               proc_language_binding_spec {hasBindingSpec=ANTLR3_TRUE;}
            )?
                                          {hasArgSpecifier=ANTLR3_TRUE;}
       )?
       end_of_stmt

            {
               c_action_subroutine_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_SUBROUTINE,$T_IDENT,$end_of_stmt.start,hasPrefix, hasDummyArgList,hasBindingSpec,hasArgSpecifier);
            }

   -> ^(OFPBeginStmt  ^(OFPLabel label?)  T_IDENT                      )
      ^(SgInitializedName                 T_IDENT                      )
      ^(SgFunctionParameterList           dummy_arg_list *             )
      ^(OFPPrefixList                     t_prefix ?                   )
      ^(OFPSuffix                         proc_language_binding_spec ? )
   ;

// R1233
// T_IDENT inlined for dummy_arg_name
dummy_arg
options{greedy=false; memoize=false;}
   :   T_IDENT     { c_action_dummy_arg($T_IDENT); }
   |   T_ASTERISK  { c_action_dummy_arg($T_ASTERISK); }
   ;

dummy_arg_list
@init
{
   int count = 0;
   c_action_dummy_arg_list__begin();
}
   :   dummy_arg {count++;} ( T_COMMA dummy_arg {count++;} )*
          {
             c_action_dummy_arg_list(count);
          }

   -> dummy_arg +
   ;

//========================================================================================
// R1236-F08 end-subroutine-stmt
//----------------------------------------------------------------------------------------
end_subroutine_stmt
@after
{
   checkForInclude();
}
   :   lbl=label?  T_END T_SUBROUTINE  id=T_IDENT?  end_of_stmt
          {
             c_action_end_subroutine_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_END,$T_SUBROUTINE,id,$end_of_stmt.start);
          }

   -> ^(OFPEndStmt ^(OFPLabel label?) T_IDENT?)

   |   lbl=label?  T_ENDSUBROUTINE     id=T_IDENT?  end_of_stmt
          {
             c_action_end_subroutine_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_ENDSUBROUTINE,NULL,id,$end_of_stmt.start);
          }

   -> ^(OFPEndStmt ^(OFPLabel label?) T_IDENT?)

   |   lbl=label?  T_END                            end_of_stmt
          {
             c_action_end_subroutine_stmt((lbl.tree==NULL)?NULL:lbl.start,$T_END,NULL,id,$end_of_stmt.start);
          }

   -> ^(OFPEndStmt ^(OFPLabel label?))

   ;

// R1235
// T_INDENT inlined for entry_name
entry_stmt
@init {
    pANTLR3_COMMON_TOKEN lbl = NULL; 
    ANTLR3_BOOLEAN hasDummyArgList=ANTLR3_FALSE; 
    ANTLR3_BOOLEAN hasSuffix=ANTLR3_FALSE;
}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_ENTRY T_IDENT
            ( T_LPAREN ( dummy_arg_list {hasDummyArgList=ANTLR3_TRUE;} )? T_RPAREN 
            ( suffix {hasSuffix=ANTLR3_TRUE;})? )? end_of_stmt
            {c_action_entry_stmt(lbl, $T_ENTRY, $T_IDENT, $end_of_stmt.start, 
                               hasDummyArgList, hasSuffix);}
   ;

// R1236
// ERR_CHK 1236 scalar_int_expr replaced by expr
return_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasScalarIntExpr=ANTLR3_FALSE;} 
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_RETURN ( expr {hasScalarIntExpr=ANTLR3_TRUE;})? 
            end_of_stmt
            {c_action_return_stmt(lbl, $T_RETURN, $end_of_stmt.start, 
                hasScalarIntExpr);} 
   ;


/*
 * R1237-F08 separate-module-subprogram
 *   is  mp-subprogram-stmt          // NEW_TO_F2008
 *           [ specification-part ]
 *           [ execution-part ]
 *           [ internal-subprogram-part ]
 *       end-mp-subprogram
 */

////////////
// R1237-F08
//
separate_module_subprogram
@init{
   ANTLR3_BOOLEAN hasExecutionPart = ANTLR3_FALSE; ANTLR3_BOOLEAN hasInternalSubprogramPart = ANTLR3_FALSE;
   c_action_separate_module_subprogram__begin();
}
@after{c_action_separate_module_subprogram(hasExecutionPart, hasInternalSubprogramPart);}
   :   mp_subprogram_stmt
          specification_part  // non-optional as can be empty
          ( execution_part {hasExecutionPart=ANTLR3_TRUE;} )?
          ( internal_subprogram_part {hasInternalSubprogramPart=ANTLR3_TRUE;} )?
       end_mp_subprogram_stmt
   ;


/*
 * R1238-F08 mp-subprogram-stmt
 *   is  MODULE PROCEDURE procedure-name
 */

////////////
// R1238-F08
//
mp_subprogram_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_MODULE T_PROCEDURE name end_of_stmt
          {
             c_action_mp_subprogram_stmt(lbl, $T_MODULE, $T_PROCEDURE, $name.start, $end_of_stmt.start);
          }
   ;


/*
 * R1239-F08 end-mp-subprogram-stmt
 *   is  END [ PROCEDURE [ procedure-name ] ]
 */

////////////
// R1239-F08
//
end_mp_subprogram_stmt
@init
{
   pANTLR3_COMMON_TOKEN lbl = NULL;
   pANTLR3_COMMON_TOKEN t_proc = NULL;
   pANTLR3_COMMON_TOKEN t_name = NULL;
}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})?
       T_END (T_PROCEDURE (name {t_name=$name.start;})? {t_proc=$T_PROCEDURE;})?
       end_of_stmt
           {c_action_end_mp_subprogram_stmt(lbl, $T_END, t_proc, t_name, $end_of_stmt.start);}
   |   (label {lbl=$label.start;})?
       T_ENDPROCEDURE (name {t_name=$name.start;})?
       end_of_stmt
           {
              c_action_end_mp_subprogram_stmt(lbl, $T_ENDPROCEDURE, NULL, t_name, $end_of_stmt.start);
           }
   ;


// R1237
contains_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_CONTAINS end_of_stmt
            {c_action_contains_stmt(lbl, $T_CONTAINS, $end_of_stmt.start);} 
   ;


// R1238
// ERR_CHK 1239 scalar_expr replaced by expr
// generic_name_list substituted for dummy_arg_name_list
// TODO Hopefully scanner and parser can help work together here to work 
// around ambiguity.
// why can't this be accepted as an assignment statement and then the parser
// look up the symbol for the T_IDENT to see if it is a function??
//      Need scanner to send special token if it sees what?
// TODO - won't do a(b==3,c) = 2
stmt_function_stmt
@init {pANTLR3_COMMON_TOKEN lbl = NULL; ANTLR3_BOOLEAN hasGenericNameList=ANTLR3_FALSE;}
@after{checkForInclude();}
   :   (label {lbl=$label.start;})? T_STMT_FUNCTION T_IDENT T_LPAREN 
            ( generic_name_list {hasGenericNameList=ANTLR3_TRUE;})? T_RPAREN 
            T_EQUALS expr end_of_stmt
            {c_action_stmt_function_stmt(lbl, $T_IDENT, $end_of_stmt.start, hasGenericNameList);}
   ;


//========================================================================================
// This rule added to allow matching of T_EOS or EOF combination.
//----------------------------------------------------------------------------------------
end_of_stmt
   :  T_EOS
          {
             c_action_end_of_stmt($T_EOS);
          }
    -> T_EOS
   |  T_EOF
          {
            c_action_end_of_stmt($T_EOF);
          }
    -> T_EOS
   ;


//========================================================================================
//========================================================================================
// The "Extra" section of the Fortran 2008 grammar follows.  It is necessary to split
// the grammar for the java parser.
//========================================================================================
//========================================================================================

/**
 * FortranParserExtras.g - this file is needed because adding more rules to FortranParser08
 * currently will cause javac to fail with a "Code too large" error.  Removing some of
 * the rules to an inherited grammar is a workaround to the problem.
 */

/*
 * Section/Clause 2: Fortran concepts
 */

/*
 * R204 specification-part
 *    is [ use-stmt ] ... 
 *       [ import-stmt ] ... 
 *       [ implicit-part ] 
 *       [ declaration-construct ] ... 
 */

/*
 * C201-F08   (R208) An execution-part shall not contain an end-function-stmt,
 *  end-mp-subprogram-stmt, end-program-stmt, or end-subroutine-stmt.
 */


//========================================================================================
//
/* R204-F08 specification-part
 *   is [ use-stmt ] ...
 *          [ import-stmt ] ...
 *          [ implicit-part ]
 *          [ declaration-construct ] ...
 */
//
// ERR_CHK 204 see ERR_CHK 207, implicit_part? removed (was after import_stmt*)
//
//----------------------------------------------------------------------------------------
specification_part
@init
{
   int numUseStmts=0;
   int numImportStmts=0;
   gCount1=0;
   gCount2=0;
}
@after
{
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
   treeSetListBoundaries (retval.tree, 1);
   treeSetListBoundaries (retval.tree, 2);
   treeSetListBoundaries (retval.tree, 3);  // TODO - why not 4, what about implicit_part?
                                            // maybe because implicit_part_recursion can be empty
}
   :   ( use_stmt               {numUseStmts++;}    )*
       ( import_stmt            {numImportStmts++;} )*
         implicit_part_recursion             // making nonoptional with predicates fixes ambiguity
       ( declaration_construct  {gCount2++;}        )*
           {
              c_action_specification_part(numUseStmts,numImportStmts,gCount1,gCount2);
           }

   ->  ^(OFPSpecificationPart
           ^(OFPUseStmtList               use_stmt*               )
           ^(OFPImportStmtList            import_stmt*            )
           ^(OFPImplicitPart              )//TODO PUTBACK implicit_part_recursion )
           ^(OFPDeclarationConstructList  declaration_construct*  )
        )
   ;

////////////
// R205-F08
// R206-F08 combined
//
implicit_part_recursion
   :   ((label)? T_IMPLICIT)  => implicit_stmt  {gCount1++;} implicit_part_recursion
   |   ((label)? T_PARAMETER) => parameter_stmt {gCount2++;} implicit_part_recursion
   |   ((label)? T_FORMAT)    => format_stmt    {gCount2++;} implicit_part_recursion
   |   ((label)? T_ENTRY)     => entry_stmt     {gCount2++;} implicit_part_recursion
   |   // empty
   ;

//========================================================================================
//
/*
 * R213-F08 executable-construct
 *    is action-stmt
 *    or associate-construct
 *    or block-construct               // NEW_TO_2008
 *    or case-construct
 *    or critical-construct            // NEW_TO_2008
 *    or do-construct
 *    or forall-construct
 *    or if-construct
 *    or select-type-construct
 *    or where-construct
 */
//
//----------------------------------------------------------------------------------------
executable_construct
@after
{
   c_action_executable_construct();
}
   :   action_stmt
//TODO PUTBACK
//   |   associate_construct
//   |   block_construct                 // NEW_TO_2008
//   |   case_construct
//   |   critical_construct              // NEW_TO_2008
//   |   do_construct
//   |   forall_construct
//   |   if_construct
//   |   select_type_construct
//   |   where_construct
   ;


//========================================================================================
//
/* R214-F08 action-stmt
 *    is allocate-stmt
 *    or assignment-stmt
 *    or backspace-stmt
 *    or call-stmt
 *    or close-stmt
 *    or continue-stmt
 *    or cycle-stmt
 *    or deallocate-stmt
 *    or end-function-stmt
 *    or end-mp-subprogram-stmt        // NEW_TO_2008
 *    or end-program-stmt
 *    or end-subroutine-stmt
 *    or endfile-stmt
 *    or errorstop-stmt                // NEW_TO_2008
 *    or exit-stmt
 *    or flush-stmt
 *    or forall-stmt
 *    or goto-stmt
 *    or if-stmt
 *    or inquire-stmt
 *    or lock-stmt                     // NEW_TO_2008
 *    or nullify-stmt
 *    or open-stmt
 *    or pointer-assignment-stmt
 *    or print-stmt
 *    or read-stmt
 *    or return-stmt
 *    or rewind-stmt
 *    or stop-stmt
 *    or sync-all-stmt                 // NEW_TO_2008
 *    or sync-images-stmt              // NEW_TO_2008
 *    or sync-memory-stmt              // NEW_TO_2008
 *    or unlock-stmt                   // NEW_TO_2008
 *    or wait-stmt
 *    or where-stmt
 *    or write-stmt
 *    or arithmetic-if-stmt
 *    or computed-goto-stmt
 */
//
//
// C201-F08   (R208) An execution-part shall not contain an end-function-stmt,
//  end-mp-subprogram-stmt, end-program-stmt, or end-subroutine-stmt.
//
//     (But they can be in a branch target statement, which is not in the grammar,
//      so the end-xxx-stmts deleted.)
// TODO continue-stmt is ambiguous with same in end-do, check for label and if
// label matches do-stmt label, then match end-do there
// the original generated rules do not allow the label, so add (label)?
//
//----------------------------------------------------------------------------------------
action_stmt
@after
{
   c_action_action_stmt();
}
// Removed backtracking by inserting extra tokens in the stream by the prepass
// that signals whether we have an assignment-stmt, a pointer-assignment-stmt,
// or an arithmetic if.  This approach may work for other parts of backtracking
// also.  However, need to see if there is a way to define tokens w/o defining
// them in the lexer so that the lexer doesn't have to add them to it's parsing.
//  02.05.07
//TODO PUTBACK
//   :   allocate_stmt
   :   assignment_stmt
//TODO PUTBACK
//   |   backspace_stmt
//   |   call_stmt
//   |   close_stmt
//   |   continue_stmt
//   |   cycle_stmt
//   |   deallocate_stmt
//////////
// These end functions are not needed because the initiating constructs are called
// explicitly to avoid ambiguities.
//   |   end_function_stmt
//   |   end_mp_subprogram_stmt        // NEW_TO_2008
//   |   end_program_stmt
//   |   end_subroutine_stmt
//TODO PUTBACK
//   |   endfile_stmt
//   |   errorstop_stmt                // NEW_TO_2008
//   |   exit_stmt
//   |   flush_stmt
//   |   forall_stmt
//   |   goto_stmt
//   |   if_stmt
//   |   inquire_stmt  
//   |   lock_stmt                     // NEW_TO_2008
//   |   nullify_stmt
//   |   open_stmt
//   |   pointer_assignment_stmt
//   |   print_stmt
//   |   read_stmt
//   |   return_stmt
//   |   rewind_stmt
//   |   stop_stmt
//   |   sync_all_stmt                 // NEW_TO_2008
//   |   sync_images_stmt              // NEW_TO_2008
//   |   sync_memory_stmt              // NEW_TO_2008
//   |   unlock_stmt                   // NEW_TO_2008
//   |   wait_stmt
//   |   where_stmt
//   |   write_stmt
//   |   arithmetic_if_stmt
//   |   computed_goto_stmt
//   |   assign_stmt                   // deleted feature
//   |   assigned_goto_stmt            // deleted feature
//   |   pause_stmt                    // deleted feature
   ;


/**
 * Section/Clause 3: Lexical tokens and source form
 */


/*
 * Section/Clause 4: Types
 */


/*
 * Section/Clause 5: Attribute declarations and specifications
 */

//========================================================================================
// R501-F08 type-declaration-stmt
//-------------------------------
//    is declaration-type-spec [[, attr-spec ]... :: ] entity-decl-list
//----------------------------------------------------------------------------------------
type_declaration_stmt
@init
{
   int numAttrSpecs = 0;
}
@after
{
   checkForInclude();
   treeSetTokenBoundaries(retval.tree, retval.start, retval.stop, -1);
}
   :   lbl=opt_label
       declaration_type_spec
       ( (T_COMMA attr_spec {numAttrSpecs += 1;})* T_COLON_COLON )?
       entity_decl_list  end_of_stmt
          {
             c_action_type_declaration_stmt((lbl.tree==NULL)?NULL:lbl.start,numAttrSpecs,$end_of_stmt.start);
          }

   -> ^(OFPTypeDeclarationStmt opt_label
          declaration_type_spec
          ^(OFPAttrSpec attr_spec*  )
          entity_decl_list
       )

   ;

/*
 * R510-F08 deferred-coshape-spec
 *    is :
 */

////////////
// R510-F08
//
// deferred_coshape_spec is replaced by array_spec (see R509-F08)
//

/*
 * R511-08 explicit-coshape-spec
 *    is [ [ lower-cobound : ] upper-cobound, ]...
 *           [ lower-cobound : ] *
 */

////////////
// R511-F08
//
// explicit_coshape_spec is replaced by array_spec (see R509-F08)
//


/**
 * Section/Clause 6: Use of data objects
 */               


//========================================================================================
/*
 * R612-F08 part-ref
 *    is part-name [ ( section-subscript-list ) ] [ image-selector]
 */
//
// T_IDENT inlined for part_name
// with k=2, this path is chosen over T_LPAREN substring_range T_RPAREN
// TODO error: if a function call, should match id rather than 
// (section_subscript_list)
// a = foo(b) is ambiguous YUK...
//
//----------------------------------------------------------------------------------------
part_ref
options {k=2;}
@init
{
   ANTLR3_BOOLEAN hasSSL = ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasImageSelector = ANTLR3_FALSE;
}
@after
{
   c_action_part_ref(id, hasSSL, hasImageSelector);
}
   :   (T_IDENT T_LPAREN)   => id=T_IDENT T_LPAREN section_subscript_list T_RPAREN {hasSSL=ANTLR3_TRUE;}
                                  (image_selector {hasImageSelector=ANTLR3_TRUE;})?

   ->  ^(OFPPartRef T_IDENT section_subscript_list image_selector?)

   |   (T_IDENT T_LBRACKET) => id=T_IDENT image_selector {hasImageSelector=ANTLR3_TRUE;}

   ->  ^(OFPPartRef T_IDENT image_selector)

   |   id=T_IDENT

   ->  ^(OFPPartRef T_IDENT)
   ;


part_ref_no_image_selector
options{k=2;}
@init{ANTLR3_BOOLEAN hasSSL = ANTLR3_FALSE; ANTLR3_BOOLEAN hasImageSelector = ANTLR3_FALSE;}
   :   (T_IDENT T_LPAREN) => T_IDENT T_LPAREN section_subscript_list T_RPAREN
           {hasSSL=ANTLR3_TRUE; c_action_part_ref($T_IDENT, hasSSL, hasImageSelector);}
   |   T_IDENT
           {c_action_part_ref($T_IDENT, hasSSL, hasImageSelector);}
   ;



//========================================================================================
/* R620-F08 section-subscript
 *    is subscript
 *    or subscript-triplet
 *    or vector-subscript
 */
//
// expr inlined for subscript, vector_subscript, and stride (thus deleted option 3)
// refactored first optional expr from subscript_triplet modified to also match
// actual_arg_spec_list to reduce ambiguities and need for backtracking
//
//----------------------------------------------------------------------------------------
section_subscript returns [ANTLR3_BOOLEAN isEmpty]
@init
{
   ANTLR3_BOOLEAN hasLowerBounds = ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasUpperBounds = ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasStride = ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasExpr = ANTLR3_FALSE;
   retval.isEmpty = ANTLR3_FALSE;
}
   :   expr section_subscript_ambiguous

   |   T_COLON (expr {hasUpperBounds=ANTLR3_TRUE;})? (T_COLON expr {hasStride=ANTLR3_TRUE;})?
           {
              c_action_section_subscript(hasLowerBounds, hasUpperBounds, hasStride, ANTLR3_FALSE);
           }

   |   T_COLON_COLON expr
           {
              hasStride=ANTLR3_TRUE;
              c_action_section_subscript(hasLowerBounds, hasUpperBounds, hasStride, ANTLR3_FALSE);
           }

   |   T_IDENT T_EQUALS expr    // could be an actual-arg, see R1220
           {
              hasExpr=ANTLR3_TRUE;
              c_action_actual_arg(hasExpr, NULL); 
              c_action_actual_arg_spec($T_IDENT);
           }

   |   T_IDENT T_EQUALS T_ASTERISK label // could be an actual-arg, see R1220
           {
              c_action_actual_arg(hasExpr, $label.start);
              c_action_actual_arg_spec($T_IDENT);
           }

   |   T_ASTERISK label /* could be an actual-arg, see R1220 */
           {
              c_action_actual_arg(hasExpr, $label.start); c_action_actual_arg_spec(NULL);
           }

   |       
           {
              retval.isEmpty = ANTLR3_TRUE; /* empty could be an actual-arg, see R1220 */
           }
   ;

section_subscript_ambiguous
@init {
   ANTLR3_BOOLEAN hasLowerBound = ANTLR3_TRUE;
   ANTLR3_BOOLEAN hasUpperBound = ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasStride = ANTLR3_FALSE;
   ANTLR3_BOOLEAN isAmbiguous = ANTLR3_FALSE; 
}
   :   T_COLON (expr {hasUpperBound=ANTLR3_TRUE;})? (T_COLON expr {hasStride=ANTLR3_TRUE;})?
           { c_action_section_subscript(hasLowerBound, hasUpperBound, hasStride, isAmbiguous);}
       // this alternative is necessary because if alt1 above has no expr
       // following the first : and there is the optional second : with no 
       // WS between the two, the lexer will make a T_COLON_COLON token 
       // instead of two T_COLON tokens.  in this case, the second expr is
       // required.  for an example, see J3/04-007, Note 7.44.
   |  T_COLON_COLON expr
           { hasStride=ANTLR3_TRUE; 
             c_action_section_subscript(hasLowerBound, hasUpperBound, hasStride, isAmbiguous);}
   |       { /* empty, could be an actual-arg, see R1220 */
             isAmbiguous=ANTLR3_TRUE; 
             c_action_section_subscript(hasLowerBound, hasUpperBound, hasStride, isAmbiguous);
           }
   ;


//========================================================================================
/* R620-F08 section-subscript
 *    is subscript
 *    or subscript-triplet
 *    or vector-subscript
 */
//
// This rule must be kept here with part-ref, otherwise parsing errors will occur.
// It is unknown why this happens.
//
//----------------------------------------------------------------------------------------
section_subscript_list
@init
{
   int count = 0;
   c_action_section_subscript_list__begin();
}
   :   isEmpty=section_subscript
           {
              if (isEmpty.start == ANTLR3_FALSE) count += 1;
           }
       (T_COMMA section_subscript {count += 1;})*
           {
              c_action_section_subscript_list(count);
           }
   ;


/*
 * R624-F08 image-selector
 *    is lbracket cosubscript-list rbracket
 */

////////////
// R624-F08
//
image_selector
   :   T_LBRACKET cosubscript_list T_RBRACKET
           {c_action_image_selector($T_LBRACKET, $T_RBRACKET);}
   ;

/*
 * R625-F08 cosubscript
 *    is scalar-int-expr
 */

////////////
// R625-F08
//
cosubscript
   :   scalar_int_expr
   ;

cosubscript_list
@init{int count=0;}
   :       {c_action_cosubscript_list__begin();}
       cosubscript {count++;} ( T_COMMA cosubscript {count++;} )*
           {c_action_cosubscript_list(count, NULL);}
   ;


//========================================================================================
//
/*
 * R631-08 allocation
 *    is allocate-object [ ( allocate-shape-spec-list ) ]
 *                       [ lbracket allocate-coarray-spec rbracket ]  // NEW_TO_2008
 */
//
//
// SAD NOTE 1: In ROSE, there is no IR for allocations. That is, there is no place in the AST to hold the
// 'allocate_shape_spec_list' and 'allocate_coarray_spec' if any. The only way to preserve them is
// to encode them in the 'allocate_object' itself, i.e. as part of an expression.
//
// SAD NOTE 2: In this rule, an 'allocate_shape_spec_list' would never be recognized. Its corresponding action
// 'action.allocate_shape_spec' is a no-op in ROSE. Shape specs are parsed by the 'allocate_object' rule
// as a section subscript list within a part ref. Sigh! On the other hand, this is just as well because
// there is no other way to represent the shape specs (see Sad Note 1).
//
//----------------------------------------------------------------------------------------
allocation
@init
{
   ANTLR3_BOOLEAN hasAllocateShapeSpecList = ANTLR3_FALSE;
   ANTLR3_BOOLEAN hasAllocateCoarraySpec = ANTLR3_FALSE;
}
   :   (allocate_object T_LBRACKET)
          => allocate_object T_LBRACKET allocate_coarray_spec T_RBRACKET
                 {
                    hasAllocateCoarraySpec=ANTLR3_TRUE;
                    c_action_allocation(hasAllocateShapeSpecList, hasAllocateCoarraySpec);
                 }
// This option (with allocate_shape_spec_list) is caught by the allocate object.  If so,
// the section-subscript-list must be changed into a allocate-shape-spec-list)
//
//   |   (allocate_object T_LPAREN)
//          => allocate_object T_LPAREN allocate_shape_spec_list {hasAllocateShapeSpecList=ANTLR3_TRUE;}
//                             T_RPAREN
//                             T_LBRACKET allocate_coarray_spec {hasAllocateCoarraySpec=ANTLR3_TRUE;}
//                             T_RBRACKET
//                 {c_action_allocation(hasAllocateShapeSpecList, hasAllocateCoarraySpec);}
   |   (allocate_object)
          => allocate_object
                 {
                    c_action_allocation(hasAllocateShapeSpecList, hasAllocateCoarraySpec);
                 }
   ;


//========================================================================================
//
/* R632-F08 allocate-object
 *    is variable-name
 *    structure-component
 */
//
// C644 (R632) An allocate-object shall not be a coindexed object.
//
// T_IDENT inlined for variable_name
// data_ref inlined for structure_component
// data_ref isa T_IDENT so T_IDENT deleted
// data_ref inlined and part_ref_no_image_selector called directly
//
//----------------------------------------------------------------------------------------
allocate_object
@init
{
   int numPartRefs = 0;
}
   :   part_ref_no_image_selector {numPartRefs += 1;}
       (T_PERCENT part_ref_no_image_selector {numPartRefs += 1;})*
           {
              c_action_data_ref(numPartRefs); c_action_allocate_object();
           }
   ;


/*
 * R636-F08 allocate-coarray-spec
 *    is   [ allocate-coshape-spec-list , ] [ lower-bound-expr : ] *
 */

////////////
// R636-F08
//
allocate_coarray_spec
options{k=3;}
@after {c_action_allocate_coarray_spec();}
   :   (T_ASTERISK)              => T_ASTERISK
   |   (expr T_COLON T_ASTERISK) => expr T_COLON T_ASTERISK
   ;


/**
 * Section/Clause 7: Expressions and assignment
 */

/*
 * R724-F08 logical-expr
 *    is expr
 */

////////////
// R724-F08, R724-F03
//
logical_expr
   :   expr
   ;

scalar_logical_expr
   :   expr
   ;


/*
 * R726-08 int-expr
 *    is   expr
 */

////////////
// R726-F08, R727-F03
//
int_expr
   :   expr
   ;

scalar_int_expr
   :   expr
   ;


//----------------------------------------------------------------------------
// additional rules following standard and useful for error checking
//----------------------------------------------------------------------------

scalar_variable
   :   expr
   ;


/**
 * Section/Clause 8: Execution control
 */


/*
 * R866-F08 lock-variable
 *    is scalar-variable
 */
 
////////////
// R866-F08
//
lock_variable
   :   scalar_variable
          { c_action_lock_variable(); }
   ;
