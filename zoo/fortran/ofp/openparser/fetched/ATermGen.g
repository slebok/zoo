///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//  ATermGen.g - grammar extensions for unparsing                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

tree grammar ATermGen;

options {
   language       = C;
   tokenVocab     = FortranParser;
   output         = AST;
   ASTLabelType   = pANTLR3_BASE_TREE;
}

import FTreeWalker;

@header {
#include <aterm2.h>
#include "ofpbase.h"
#include "traversal.h"
}

@members {

FILE * out;

extern      pANTLR3_VECTOR      tlist;
extern      ANTLR3_MARKER       next_token;


void
ofpATermGen_setOutStream(FILE * fp)
{
   out = fp;
}

static int
ofplist_count(pANTLR3_BASE_TREE ofpList)
{
   return ofpList->getChildCount(ofpList);
}

static void
print_token_text(pANTLR3_COMMON_TOKEN tok)
   {
      if (tok->getType(tok) == T_EOS) {
         printf("\n");
      }
      else {
         printf("\%s", tok->getText(tok)->chars);
      }
   }

static ATerm
ofp_annotate_start_stop(ATerm term, pANTLR3_BASE_TREE tree)
{
   pOFP_BASE_RTN pos = (pOFP_BASE_RTN) tree->u;
   if (pos != NULL && pos->start != NULL && pos->stop != NULL) {
      ATerm start = ATmake("start");
      ATerm stop  = ATmake("stop");
      term = ATsetAnnotation(term, stop,  ATmake("<int>", pos->stop ->index));
      term = ATsetAnnotation(term, start, ATmake("<int>", pos->start->index));
   }
   return term;
}

static ATerm
aterm_opt_str(pANTLR3_BASE_TREE tree, const char * term_name)
{
   int len = strlen(term_name) + strlen("(<str>)");
   char * pattern = (char *) malloc(1+len);

   ATerm aterm;
   if (tree->getChildCount(tree) > 0) {
      pANTLR3_BASE_TREE tname = tree->getChild(tree,0);
      sprintf(pattern, "\%s(<str>)", term_name);
      aterm = ATmake(pattern, tname->getText(tname)->chars);
      aterm = ofp_annotate_start_stop(aterm, tree);
   }
   else {
      sprintf(pattern, "\%s()", term_name);
      aterm = ATmake(pattern);
   }
   free(pattern);

   return aterm;
}

static ATerm
aterm_opt_term(pANTLR3_BASE_TREE tree, const char * term_name)
{
   int len = strlen(term_name) + strlen("(<term>)");
   char * pattern = (char *) malloc(1+len);

   ATerm aterm;
   if (tree->getChildCount(tree) > 0) {
      /* WARNING, this is a hack, assumes all tree types are a main_program 
       * Assumes all tree types return an ATerm as first return parameter.
       */
      ATermGen_main_program_return * t = tree->getChild(tree,0);
      sprintf(pattern, "\%s(<term>)", term_name);
      aterm = ATmake(pattern, t->aterm);
   }
   else {
      sprintf(pattern, "\%s()", term_name);
      aterm = ATmake(pattern);
   }
   free(pattern);

   return aterm;
}

static ANTLR3_MARKER
unparseTokens(ANTLR3_MARKER start, ANTLR3_MARKER stop)
   {
      int i;

      stop = (stop < tlist->count) ? stop : tlist->count - 1;

      for (i = start; i <= stop; i++) {
         print_token_text((pANTLR3_COMMON_TOKEN) tlist->get(tlist, i));
      }
      return (stop + 1);
   }

static ANTLR3_MARKER
unparse(pANTLR3_BASE_TREE btn, ANTLR3_MARKER next)
   {
      pANTLR3_COMMON_TREE  ctn;
      pANTLR3_STRING       str;

      if (btn->isNilNode(btn)) {
         printf("unparse: node is nil\n");
         return;
      }
      if (btn->getType(btn) == ANTLR3_TOKEN_DOWN || btn->getType(btn) == ANTLR3_TOKEN_UP) {
         printf("unparse: transition node type \%d found\n", btn->getType(btn));
         return;
      }

      ctn = (pANTLR3_COMMON_TREE) btn->super;
      str = btn->toString(btn);

      // unparse any preceeding whitespace
      //
      if (next < ctn->startIndex) {
         unparseTokens(next, ctn->startIndex - 1);
      }
      return unparseTokens(ctn->startIndex, ctn->stopIndex);
   }

static void
unparse_label(FILE * fp, pANTLR3_BASE_TREE ofpLabel)
{
   ATerm t;
   if (ofpLabel->getChildCount(ofpLabel) > 0) {
      pANTLR3_BASE_TREE label = ofpLabel->getChild(ofpLabel, 0);
      fprintf(fp, "label = OFPLabel(\%s)\n", label->getText(label)->chars);
      t = ATmake("label(<int>)", atoi(label->getText(label)->chars));
      ATprintf("\%t\n", t);
   }
   else {
      t = ATmake("label()");
      fprintf(fp, "label = OFPLabel(None)\n");
   }
}

static void
unparse_OFPName(FILE * fp, pANTLR3_BASE_TREE ofpname, const char * sep)
{
   if (ofpname->getChildCount(ofpname) > 0) {
      pANTLR3_BASE_TREE   name = ofpname->getChild(ofpname, 0);
      fprintf(fp, "\%s\%s", name->getText(name)->chars, sep);
   }
}

static void
unparse_entity_decl_list(FILE * fp, pANTLR3_BASE_TREE ofpList)
{
// entity_decl
//   :   T_IDENT ( T_LPAREN array_spec T_RPAREN  )?
//               ( T_LBRACKET coarray_spec T_RBRACKET  )?
//               ( T_ASTERISK char_length  )?
//               ( initialization  )?
//
//   :   ^(SgInitializedName T_IDENT array_spec?)

   int i, count;

   count = ofplist_count(ofpList);
   for (i = 0; i < count; i++) {
      pANTLR3_BASE_TREE   sgname = ofpList->getChild(ofpList, i);
      if (i < count-1) {
         unparse_OFPName(out, sgname, ", ");
      }
      else {
         unparse_OFPName(out, sgname, "");
      }
   }
}

ATerm
match_OFPObjectName(pANTLR3_BASE_TREE obj_name)
{
   ATerm aterm = ATmake("OFPObjectName");
   if (obj_name->getChildCount(obj_name) > 0) {
      pANTLR3_BASE_TREE name = obj_name->getChild(obj_name, 0);
      if (name->getChildCount(name) > 0) {
         name = name->getChild(name, 0);
         aterm = ATmake("<str>", name->getText(name)->chars);
         aterm = ofp_annotate_start_stop(aterm, obj_name);
         aterm = ATmake("object-name(name(<term>))", aterm);
      }
   }
   return aterm;
}

ATerm
match_entity_decl_list(pANTLR3_BASE_TREE ofpList)
{
// entity_decl
//   :   object-name ( T_LPAREN array_spec T_RPAREN  )?
//               ( T_LBRACKET coarray_spec T_RBRACKET  )?
//               ( T_ASTERISK char_length  )?
//               ( initialization  )?
//
//   :   ^(SgInitializedName T_IDENT array_spec?)

   int i, count;

   ATermList edlist = ATmakeList0();

   count = ofplist_count(ofpList);
   for (i = count-1; i >= 0; i--) {
      pANTLR3_BASE_TREE obj_name = ofpList->getChild(ofpList, i);
      ATerm term = match_OFPObjectName(obj_name);
      edlist = ATinsert(edlist, term);
   }
   return ATmake("entity-decl-list(<term>)", edlist);
}


static void
unparse_token(FILE * fp, pANTLR3_BASE_TREE tree)
{
   if (tree == NULL) return;

   pANTLR3_COMMON_TOKEN tok = tree->getToken(tree);
   if (tok->getType(tok) == T_EOS) {
      fprintf(fp, "\n");
   }
   else {
      fprintf(fp, "\%s", tok->getText(tok)->chars);
   }
}

static void
unparse_name(FILE * fp, pANTLR3_BASE_TREE tree, const char * node_name, const char * node_type)
{
   char * name = "None";

   if (tree != NULL && tree->getChildCount(tree) > 0) {
      pANTLR3_BASE_TREE tname = tree->getChild(tree, 0);
      name = tname->getText(tname)->chars;
   }

   fprintf(fp, "\%s = \%s(\"\%s\")\n", node_name, node_type, name);
}

/**
 * unparse_comments
 */
static void
unparse_comments(FILE * fp, pANTLR3_BASE_TREE tree)
{
   int i;

   fprintf(fp, "comments = []\n");

   for (i = 0; i < tree->getChildCount(tree); i++) {
      pANTLR3_BASE_TREE text = tree->getChild(tree, i);
      fprintf(fp, "comments.append(\%s)\n", text->getText(text)->chars);
   }
}

/**
 * unparse_begin_stmt -> ^(OFPBeginStmt ^(OFPLable label?) name?)
 */
static void
unparse_begin_stmt(FILE * fp, pANTLR3_BASE_TREE tree, const char * text)
{
   unparse_label(fp, tree->getChild(tree,0));
   fprintf(fp, "\%s ", text);

   if (tree->getChildCount(tree) > 1) {
      pANTLR3_BASE_TREE   name = tree->getChild(tree, 1);
      fprintf(fp, "\%s", name->getText(name)->chars);
   }
   fprintf(fp, "\n");
}

/**
 * unparse_end_stmt -> ^(OFPEndStmt ^(OFPLable label?) name?)
 */
static void
unparse_end_stmt(FILE * fp, pANTLR3_BASE_TREE tree, const char * text)
{
   pANTLR3_BASE_TREE name = tree->getChild(tree,1);
   unparse_label(fp, tree->getChild(tree,0));
   fprintf(fp, "End \%s \%s\n", text, name->getText(name)->chars);
}

} // end members

opt_label returns [ATerm aterm]
   :  ^(OFPLabel lbl=T_DIGIT_STRING?)
           {
              if ($OFPLabel->getChildCount($OFPLabel) > 0) {
                 retval.aterm = ATmake("label(<int>)", atoi(lbl->getText(lbl)->chars));
              } else {
                 retval.aterm = ATmake("label()");
              }
              retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPLabel);
           }
;


/*
 * Section/Clause 1: Overview
 */


/*
 * Section/Clause 2: Fortran concepts
 */


//========================================================================================
// R204-F08 specification-part
//----------------------------------------------------------------------------------------
specification_part returns [ATerm aterm]
@init
{
   ATermList dclist = ATmakeList0();
}
   :  ^(OFPSpecificationPart
          ^(OFPUseStmtList               use_stmt*               )
          ^(OFPImportStmtList            import_stmt*            )
          ^(OFPImplicitPart              implicit_part_recursion )
          ^(OFPDeclarationConstructList  
              (dc=declaration_construct {dclist = ATappend(dclist, dc.aterm);})*
           )
       )

       {
          retval.aterm = ATmake("declaration-construct-list(<list>)", dclist);
          retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPDeclarationConstructList);
          retval.aterm = ATmake("specification-part(<term>)", retval.aterm);
          retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPSpecificationPart);
       }
   ;

//========================================================================================
// R207-F08 declaration-construct
//----------------------------------------------------------------------------------------
declaration_construct returns [ATerm aterm]
   //   t=derived_type_def
   //   t=entry_stmt
   //   t=enum_def
   //   t=format_stmt
   //   t=interface_block
   //   t=parameter_stmt
   //   t=procedure_declaration_stmt
   //   t=other_specification_stmt
   :   term=type_declaration_stmt
          {
             retval.aterm = ATmake("declaration-construct(<term>)", term.aterm);
             retval.aterm = ofp_annotate_start_stop(retval.aterm, term.tree);
          }
   //   t=stmt_function_stmt
   ;

//========================================================================================
// R208-F08 execution-part
//----------------------------------------------------------------------------------------
execution_part returns [ATerm aterm]
@init
{
   ATermList list = ATmakeList0();
}
   :  OFPExecutionPart
          {
             retval.aterm = ATmake("executable-part");
             retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPExecutionPart);
          }

   |  ^(OFPExecutionPart
         ^(OFPExecutablePartConstructList
             ( execution_part_construct {list = ATappend(list, $execution_part_construct.aterm);} )+
          )
       )
          {
             retval.aterm = ATmake("executable-part-construct-list(<list>)", list);
             retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPExecutablePartConstructList);
             retval.aterm = ATmake("executable-part(<term>)", retval.aterm);
             retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPExecutionPart);
          }
   ;

//========================================================================================
// R209-F08 execution-part-construct
//----------------------------------------------------------------------------------------
execution_part_construct returns [ATerm aterm]
   :   executable_construct           {retval.aterm = $executable_construct.aterm;}
//TODO PUTBACK   |   format_stmt
//TODO PUTBACK   |   entry_stmt
//TODO PUTBACK   |   data_stmt
   ;

//========================================================================================
// R213-F08 executable-construct
//----------------------------------------------------------------------------------------
executable_construct returns [ATerm aterm]
   :   action_stmt           {retval.aterm = $action_stmt.aterm;}
//TODO PUTBACK   |   associate_construct
//TODO PUTBACK   |   block_construct                 // NEW_TO_2008
//TODO PUTBACK   |   case_construct
//TODO PUTBACK   |   critical_construct              // NEW_TO_2008
//TODO PUTBACK   |   do_construct
//TODO PUTBACK   |   forall_construct
//TODO PUTBACK   |   if_construct
//TODO PUTBACK   |   select_type_construct
//TODO PUTBACK   |   where_construct
   ;

//========================================================================================
// R214-F08 action-stmt
//----------------------------------------------------------------------------------------
action_stmt returns [ATerm aterm]
//TODO PUTBACK   :   allocate_stmt
   :   assignment_stmt           {retval.aterm = $assignment_stmt.aterm;}
//TODO PUTBACK   |   backspace_stmt
//TODO PUTBACK   |   call_stmt
//TODO PUTBACK   |   close_stmt
//TODO PUTBACK   |   continue_stmt
//TODO PUTBACK   |   cycle_stmt
//TODO PUTBACK   |   deallocate_stmt
//////////
// These end functions are not needed because the initiating constructs are called
// explicitly to avoid ambiguities.
//   |   end_function_stmt
//   |   end_mp_subprogram_stmt        // NEW_TO_2008
//   |   end_program_stmt
//   |   end_subroutine_stmt
//TODO PUTBACK   |   endfile_stmt
//TODO PUTBACK   |   errorstop_stmt                // NEW_TO_2008
//TODO PUTBACK   |   exit_stmt
//TODO PUTBACK   |   flush_stmt
//TODO PUTBACK   |   forall_stmt
//TODO PUTBACK   |   goto_stmt
//TODO PUTBACK   |   if_stmt
//TODO PUTBACK   |   inquire_stmt  
//TODO PUTBACK   |   lock_stmt                     // NEW_TO_2008
//TODO PUTBACK   |   nullify_stmt
//TODO PUTBACK   |   open_stmt
//TODO PUTBACK   |   pointer_assignment_stmt
//TODO PUTBACK   |   print_stmt
//TODO PUTBACK   |   read_stmt
//TODO PUTBACK   |   return_stmt
//TODO PUTBACK   |   rewind_stmt
//TODO PUTBACK   |   stop_stmt
//TODO PUTBACK   |   sync_all_stmt                 // NEW_TO_2008
//TODO PUTBACK   |   sync_images_stmt              // NEW_TO_2008
//TODO PUTBACK   |   sync_memory_stmt              // NEW_TO_2008
//TODO PUTBACK   |   unlock_stmt                   // NEW_TO_2008
//TODO PUTBACK   |   wait_stmt
//TODO PUTBACK   |   where_stmt
//TODO PUTBACK   |   write_stmt
//TODO PUTBACK   |   arithmetic_if_stmt
//TODO PUTBACK   |   computed_goto_stmt
//TODO PUTBACK   |   assign_stmt                   // deleted feature
//TODO PUTBACK   |   assigned_goto_stmt            // deleted feature
//TODO PUTBACK   |   pause_stmt                    // deleted feature
   ;

/**
 * Section/Clause 4: Types
 */

//========================================================================================
// R403-F08 declaration-type-spec
//----------------------------------------------------------------------------------------
declaration_type_spec returns [ATerm aterm]
   :  ^(OFPDeclarationTypeSpec intrinsic_type_spec)
          {
             retval.aterm = ATmake("declaration-type-spec(<term>)", $intrinsic_type_spec.aterm);
             retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPDeclarationTypeSpec);
          }
   |  ^(OFPDeclarationTypeSpec derived_type_spec)
   |  ^(OFPDeclarationTypeSpec T_ASTERISK)
   
;

//========================================================================================
// R404-F08 intrinsic-type-spec
//----------------------------------------------------------------------------------------
intrinsic_type_spec returns [ATerm aterm]
@init
{
   ATerm type, kind;
}
@after
{
   type = ofp_annotate_start_stop(type, t);
   retval.aterm = ATmake("intrinsic-type-spec(<term>,<term>)", type, kind);
   retval.aterm = ofp_annotate_start_stop(retval.aterm, r);
}
   :   ^( r=OFPIntrinsicTypeSpec
             (    t=OFPTypeLogical   {type=ATmake("LOGICAL"  );}  k=opt_kind_selector {kind = k.aterm;}
               |  t=OFPTypeInteger   {type=ATmake("INTEGER"  );}  k=opt_kind_selector {kind = k.aterm;}
               |  t=OFPTypeReal      {type=ATmake("REAL"     );}  k=opt_kind_selector {kind = k.aterm;}
               |  t=OFPTypeDouble    {type=ATmake("DOUBLE"   );}  k=opt_kind_selector {kind = k.aterm;}
               |  t=OFPTypeComplex   {type=ATmake("COMPLEX"  );}  k=opt_kind_selector {kind = k.aterm;}
               |  t=OFPTypeDComplex  {type=ATmake("DCOMPLEX" );}  k=opt_kind_selector {kind = k.aterm;}
               |  t=OFPTypeCharacter {type=ATmake("CHARACTER");}  c=opt_char_selector {kind = c.aterm;}
             )
        )
   ;

//========================================================================================
// R405-F08 kind-selector
//----------------------------------------------------------------------------------------
opt_kind_selector returns [ATerm aterm]
   :   ^(OFPKindSelector kind_selector?)
           {
              retval.aterm = ATmake("kind-selector");
           }
   ;

//========================================================================================
// R407-F08 int-literal-constant
//----------------------------------------------------------------------------------------
int_literal_constant returns [ATerm aterm]
@after
{
  if (kp.tree)
       retval.aterm = ATmake("int-literal-constant(<int>,<term>)",atoi(ds->getText(ds)->chars),kp);
  else retval.aterm = ATmake("int-literal-constant(<int>)",       atoi(ds->getText(ds)->chars));
}
   :  ^(OFPIntLiteralConstant ds=T_DIGIT_STRING ^(OFPKindParam kp=kind_param?))
   ;

//========================================================================================
// R408-F08 kind-param
//----------------------------------------------------------------------------------------
kind_param returns [ATerm aterm]
   :   ds=T_DIGIT_STRING  {retval.aterm = ATmake("kind-param(<int>)", atoi(ds->getText(ds)->chars));}
   |   id=T_IDENT         {retval.aterm = ATmake("kind-param(<str>)", id->getText(id)->chars);}
   ;

//========================================================================================
// R420-F08 char-selector
//----------------------------------------------------------------------------------------
opt_char_selector returns [ATerm aterm]
   :   ^(OFPCharSelector char_selector?)
           {
              retval.aterm = ATmake("char-selector");
           }
   ;


/**
 * Section/Clause 5: Attribute declarations and specifications
 */


//========================================================================================
// R501-F08 type-declaration-stmt
//----------------------------------------------------------------------------------------
type_declaration_stmt returns [ATerm aterm]
   :   ^(OFPTypeDeclarationStmt opt_label
          declaration_type_spec
          ^(OFPAttrSpec attr_spec*)
          entity_decl_list
        )
           {
              retval.aterm = ATmake("type-declaration-stmt(<term>,<term>,<term>)",
                                    $opt_label.aterm,
                                    $declaration_type_spec.aterm,
                                    $entity_decl_list.aterm
                                   );
              retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPTypeDeclarationStmt);
           }
   ;

//========================================================================================
// R503-F08 entity-decl
//----------------------------------------------------------------------------------------
entity_decl returns [ATerm aterm]
//   :   T_IDENT ( T_LPAREN array_spec T_RPAREN  )?
//               ( T_LBRACKET coarray_spec T_RBRACKET  )?
//               ( T_ASTERISK char_length  )?
//               ( initialization  )?
   :   ^(OFPObjectName ^(OFPName id=T_IDENT))
           {
              retval.aterm = ATmake("name(<str>)", id->getText(id)->chars);
              retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPName);
              retval.aterm = ATmake("object-name(<term>)", retval.aterm);
           }
   ;

entity_decl_list returns [ATerm aterm]
@init
{
   ATermList list = ATmakeList0();
}
@after
{
   retval.aterm = ATmake("entity-decl-list(<term>)", list);
   retval.aterm = ofp_annotate_start_stop(retval.aterm, retval.tree);
}
   :   ^(OFPEntityDeclList
           (
              entity_decl  {list = ATappend(list, $entity_decl.aterm);}
           )+
        )
   ;

//========================================================================================
// R560-F08 implicit-stmt
//----------------------------------------------------------------------------------------
implicit_stmt
   :   // implicit none if OFPList is empty
       ^(SgImplicitStatement ofplabel ^(OFPList implicit_spec*))
           {
              fprintf(out, "Implicit None");
              fprintf(out, "\n");
           }
   ;


/**
 * Section/Clause 6: Use of data objects
 */               

//========================================================================================
// R601-F08 designator
//----------------------------------------------------------------------------------------
designator returns [ATerm aterm]
@after
{
   retval.aterm = ofp_annotate_start_stop(retval.aterm, retval.tree);
}
   :  ^(OFPDesignator  data_ref               substring_range? )
          {
            //TODO - add substring range
            retval.aterm = ATmake("designator(<term>)", $data_ref.aterm);
          }

//TODO - add this option
//   |  ^(OFPDesignator  char_literal_constant  substring_range  )
//          {
//            retval.aterm = ATmake("designator(<term>)", $char_literal_constant);
//          }
   ;

//========================================================================================
// R602-F08 variable
//----------------------------------------------------------------------------------------
variable returns [ATerm aterm]
@after
{
   retval.aterm = ATmake("variable(<term>)", d.aterm);
   retval.aterm = ofp_annotate_start_stop(retval.aterm, retval.tree);
}
   :   ^(OFPVariable d=designator)
   ;

//========================================================================================
// R611-F08 data-ref
//----------------------------------------------------------------------------------------
data_ref returns [ATerm aterm]
@init
{
   ATermList list = ATmakeList0();
}
@after
{
   retval.aterm = ATmake("data-ref(<term>)", list);
   retval.aterm = ofp_annotate_start_stop(retval.aterm, retval.tree);
}
   :  ^(OFPDataRef ^(OFPPartRefList (part_ref {list=ATappend(list, $part_ref.aterm);})+ ))
   ;

//========================================================================================
// R612-F08 part-ref
//----------------------------------------------------------------------------------------
part_ref returns [ATerm aterm]
@after
{
   retval.aterm = ATmake("part-ref(<str>)", id->getText(id)->chars);
   retval.aterm = ofp_annotate_start_stop(retval.aterm, retval.tree);
}
   :  ^(OFPPartRef id=T_IDENT)
      //TODO - add section-subscript-list and image-selector
   ;

/**
 * Section/Clause 7: Expressions and assignment
 */

//========================================================================================
// R722-F08  expr
//----------------------------------------------------------------------------------------
expr returns [ATerm aterm]
   :  ^(OFPExpr int_literal_constant)    // TODO FIXME
          {
             retval.aterm = ATmake("expr(<term>)", $int_literal_constant.aterm);
//TODO - PUTBACK             retval.aterm = ofp_annotate_start_stop(retval.aterm, retval.tree);
          }
   ;

//========================================================================================
// R732-F08  assignment-stmt
//----------------------------------------------------------------------------------------
assignment_stmt returns [ATerm aterm]
   :  ^(OFPAssignmentStmt opt_label variable expr)

       {
          retval.aterm = ATmake("assignment-stmt(<term>,<term>,<term>)",
                                $opt_label.aterm,
                                $variable.aterm,
                                $expr.aterm);
          retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPAssignmentStmt);
       }
   ;


/**
 * Section/Clause 11: Program units
 */

//========================================================================================
// R1101-F08 main-program
//----------------------------------------------------------------------------------------
main_program returns [ATerm aterm]
   :   ^(OFPMainProgram
           program_stmt
              specification_part
              execution_part
              ^(OFPInternalSubprogramPart  internal_subprogram_part? )
           end_program_stmt
        )

        {
           retval.aterm = ATmake("main-program(<term>,<term>,<term>,<term>,<term>)",
                                  $program_stmt.aterm,
                                  $specification_part.aterm,
                                  $execution_part.aterm,
                                  ATmake("internal-subprogram-part"),
                                  $end_program_stmt.aterm);
           retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPMainProgram);
           ATprintf("\%t\n\n", retval.aterm);

           ofp_traverse_main_program(retval.aterm);
           printf("\n");
        }
   ;


//========================================================================================
// R1102-F08 program-stmt
//----------------------------------------------------------------------------------------
program_stmt returns [ATerm aterm]
   :  OFPProgramStmt
       {
          retval.aterm = ATmake("program-stmt");
       }

   |  ^(OFPProgramStmt opt_label
          ^(OFPProgramName T_IDENT)
       )

       {
          ATerm name = aterm_opt_str($OFPProgramName, "program-name");
          retval.aterm = ATmake("program-stmt(<term>,<term>)", $opt_label.aterm, name);
          retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPProgramStmt);
       }
   ;


//========================================================================================
// R1103-F08 end-program-stmt
//----------------------------------------------------------------------------------------
end_program_stmt returns [ATerm aterm]
   :  ^(OFPEndProgramStmt opt_label
          ^(OFPProgramName T_IDENT?)
       )

       {
          ATerm name = aterm_opt_str($OFPProgramName, "program-name");
          retval.aterm = ATmake("end-program-stmt(<term>,<term>)", $opt_label.aterm, name);
          retval.aterm = ofp_annotate_start_stop(retval.aterm, $OFPEndProgramStmt);
       }
   ;


//========================================================================================
// R1104-F08 module
//----------------------------------------------------------------------------------------
module
   :  ^(OFPModule module_stmt
          ^(SgBasicBlock
              specification_part
          // TODO - ( module_subprogram_part )?
           )
           end_module_stmt
       )
          {
             fprintf(out, "module = ast.module(module_stmt, end_module_stmt)\n");
          }
   ;

//========================================================================================
// R1105-F08 module-stmt
//----------------------------------------------------------------------------------------
module_stmt
   :  ^(OFPModuleStmt  ofplabel  ^(OFPModuleName T_IDENT) )
          {
             fprintf(out, "module_stmt = ast.module_stmt(label, module_name)\n");
          }
   ;


//========================================================================================
// R1106-F08 end-program-stmt
//----------------------------------------------------------------------------------------
end_module_stmt
   :  ^(OFPEndModuleStmt  ^(OFPLabel label?)  ^(OFPModuleName T_IDENT?) )
          {
             fprintf(out, "end_module_stmt = ast.end_module_stmt(label, module_name)\n");
          }
   ;


//========================================================================================
// R1234-F08 subroutine-stmt
//----------------------------------------------------------------------------------------
subroutine_stmt
   :   ^(OFPBeginStmt ofplabel        T_IDENT                      )
       ^(SgInitializedName            subroutine_name              )
       ^(SgFunctionParameterList      dummy_arg *                  )
       ^(OFPPrefixList                t_prefix ?                   )
       ^(OFPSuffix                    proc_language_binding_spec ? )

          {
             fprintf(out, "Subroutine ");
             unparse_OFPName(out, $SgInitializedName, " ");
             fprintf(out, "\n");
          }
   ;

subroutine_name
   :   T_IDENT
   ;

//========================================================================================
// R1236-F08 end-subroutine-stmt
//----------------------------------------------------------------------------------------
end_subroutine_stmt
   :   ^(OFPEndStmt ofplabel T_IDENT?)
          {
             fprintf(out, "End Subroutine ");
             unparse_token(out, $T_IDENT);
             fprintf(out, "\n");
          }
   ;
