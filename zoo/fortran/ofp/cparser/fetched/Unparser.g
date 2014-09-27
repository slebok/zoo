///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//  Unparser.g - grammar extensions for unparsing                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

tree grammar Unparser;

options {
   language       = C;
   tokenVocab     = CFortranParser;
   output         = AST;
   ASTLabelType   = pANTLR3_BASE_TREE;
}

import FTreeWalker;

@members {
  FILE * out;

extern      pANTLR3_VECTOR      tlist;
extern      ANTLR3_MARKER       next_token;


void
ofpUnparser_setOutStream(FILE * fp)
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
unparse_label(FILE * fp, pANTLR3_BASE_TREE ofpLabel, const char * sep)
{
   if (ofpLabel->getChildCount(ofpLabel) > 0) {
      pANTLR3_BASE_TREE   label = ofpLabel->getChild(ofpLabel, 0);
      fprintf(fp, "\%s\%s", label->getText(label)->chars, sep);
   }
}

static void
unparse_SgInitializedName(FILE * fp, pANTLR3_BASE_TREE sgname, const char * sep)
{
   if (sgname->getChildCount(sgname) > 0) {
      pANTLR3_BASE_TREE   name = sgname->getChild(sgname, 0);
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
         unparse_SgInitializedName(out, sgname, ", ");
      }
      else {
         unparse_SgInitializedName(out, sgname, "");
      }
   }
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

/**
 * unparse_begin_stmt -> ^(OFPBeginStmt ^(OFPLable label?) name?)
 */
static void
unparse_begin_stmt(FILE * fp, pANTLR3_BASE_TREE tree, const char * text)
{
   unparse_label(fp, tree->getChild(tree,0), " ");
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
   unparse_label(fp, tree->getChild(tree,0), " ");
   fprintf(fp, "End \%s \%s\n", text, name->getText(name)->chars);
}

} // end members


/**
 * Rules to simplify unparsing
 */

ofpLabel
   :   ^(OFPLabel label ?)
           {
             unparse_label(out, $OFPLabel, " ");
           }
   ;

/**
 * Section/Clause 4: Types
 */


//========================================================================================
// R404-F08 intrinsic-type-spec
//----------------------------------------------------------------------------------------
intrinsic_type_spec
   :   ^( SgTypeInt    {fprintf(out,"Integer");}   kind_selector? )  {fprintf(out, " :: ");}
   |   ^( SgTypeFloat  {fprintf(out,"Real"   );}   kind_selector? )  {fprintf(out, " :: ");}
   |      SgTypeDouble
   |   ^( SgTypeComplex   kind_selector? )
   |      SgTypeDComplex                      // TODO - what is the real SgType?
   |   ^( SgTypeChar      char_selector? )
   |   ^( SgTypeBool      kind_selector? )
   ;


/**
 * Section/Clause 5: Attribute declarations and specifications
 */


//========================================================================================
// R501-F08 type-declaration-stmt
//----------------------------------------------------------------------------------------
type_declaration_stmt
   :   ^(SgVariableDeclaration ^(OFPLabel label?)
          declaration_type_spec
          ^(OFPAttrSpec attr_spec*  )
          ^(OFPList entity_decl+)
        )
           {
              unparse_entity_decl_list(out, $OFPList);
              fprintf(out, "\n");
           }
   ;

//========================================================================================
// R560-F08 implicit-stmt
//----------------------------------------------------------------------------------------
implicit_stmt
   :   // implicit none if OFPList is empty
       ^(SgImplicitStatement ofpLabel ^(OFPList implicit_spec*))
           {
              fprintf(out, "Implicit None");
              fprintf(out, "\n");
           }
   ;

//========================================================================================
// R1101-F08 main-program
//----------------------------------------------------------------------------------------
main_program
   :   ^(SgProgramHeaderStatement program_stmt? end_program_stmt
          ^(SgFunctionDefinition 
               ^(SgBasicBlock
                  ^(OFPSpecificationPart       specification_part          )
                )
            )
                    {
                       unparse_end_stmt(out, $end_program_stmt.tree, "Program");
                    }
        )
   ;


//========================================================================================
// R1102-F08 program-stmt
//----------------------------------------------------------------------------------------
program_stmt
   :  ^(OFPBeginStmt ofpLabel T_IDENT ^(OFPCommentList OFPComment*))

          {
             next_token = unparse($OFPBeginStmt, next_token);
             unparse_begin_stmt(out, $OFPBeginStmt, "Program");
          }
   ;


//========================================================================================
// R1103-F08 end-program-stmt
//----------------------------------------------------------------------------------------
end_program_stmt
   :  ^(OFPEndStmt ofpLabel T_IDENT?)
   ;


//========================================================================================
// R1104-F08 module
//----------------------------------------------------------------------------------------
module
   :  ^(SgModuleStatement module_stmt end_module_stmt
          ^(SgBasicBlock
              specification_part
          // TODO - ( module_subprogram_part )?
           )
       )
   ;

//========================================================================================
// R1105-F08 module-stmt
//----------------------------------------------------------------------------------------
module_stmt
   :  ^(OFPBeginStmt  ^(OFPLabel label?)  T_IDENT )
      ^(SgInitializedName                 T_IDENT )
          {
             fprintf(out, "Module ");
             unparse_SgInitializedName(out, $SgInitializedName, " ");
             fprintf(out, "\n");
          }
   ;


//========================================================================================
// R1106-F08 end-program-stmt
//----------------------------------------------------------------------------------------
end_module_stmt
   :   ^(OFPEndStmt ^(OFPLabel label?) T_IDENT? )
          {
             fprintf(out, "End Module ");
             unparse_token(out, $T_IDENT);
             fprintf(out, "\n");
          }
   ;


//========================================================================================
// R1234-F08 subroutine-stmt
//----------------------------------------------------------------------------------------
subroutine_stmt
   :   ^(OFPBeginStmt ofpLabel        T_IDENT                      )
       ^(SgInitializedName            subroutine_name              )
       ^(SgFunctionParameterList      dummy_arg *                  )
       ^(OFPPrefixList                t_prefix ?                   )
       ^(OFPSuffix                    proc_language_binding_spec ? )

          {
             fprintf(out, "Subroutine ");
             unparse_SgInitializedName(out, $SgInitializedName, " ");
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
   :   ^(OFPEndStmt ofpLabel T_IDENT?)
          {
             fprintf(out, "End Subroutine ");
             unparse_token(out, $T_IDENT);
             fprintf(out, "\n");
          }
   ;
