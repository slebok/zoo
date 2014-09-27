///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//  PyASTGen.g - grammar extensions for unparsing                            //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

tree grammar PyASTGen;

options {
   language       = C;
   tokenVocab     = FortranParser;
   output         = AST;
   ASTLabelType   = pANTLR3_BASE_TREE;
}

import FTreeWalker;

@members {
  FILE * out;

extern      pANTLR3_VECTOR      tlist;
extern      ANTLR3_MARKER       next_token;


void
ofpPyASTGen_setOutStream(FILE * fp)
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
unparse_label(FILE * fp, pANTLR3_BASE_TREE ofpLabel)
{
   if (ofpLabel->getChildCount(ofpLabel) > 0) {
      pANTLR3_BASE_TREE   label = ofpLabel->getChild(ofpLabel, 0);
      fprintf(fp, "label = OFPLabel(\%s)\n", label->getText(label)->chars);
   }
   else {
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


ofplabel
   :  ^(OFPLabel T_DIGIT_STRING?)
           {
              //pANTLR3_BASE_TREE ofpLabel = $OFPLabel;
              pANTLR3_BASE_TREE ofpLabel = $T_DIGIT_STRING;
//              fprintf(out, "label = \%p\n", ofpLabel);
//              if (ofpLabel->getChildCount(ofpLabel) > 0) {
//                 pANTLR3_BASE_TREE   label = ofpLabel->getChild(ofpLabel, 0);
//                 fprintf(out, "\%s\%s", label->getText(label)->chars, " ");
//              } else {
                 fprintf(out, "label = ast.label(None)\n");
//              }
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
       ^(SgImplicitStatement ofplabel ^(OFPList implicit_spec*))
           {
              fprintf(out, "Implicit None");
              fprintf(out, "\n");
           }
   ;

//========================================================================================
// R1101-F08 main-program
//----------------------------------------------------------------------------------------
main_program
@init
{
   fprintf(out, "program_stmt = None\n");
   fprintf(out, "specification_part = None\n");
   fprintf(out, "execution_part = None\n");
   fprintf(out, "internal_subprogram_part = None\n\n");
}
   :   ^(OFPMainProgram
           program_stmt?
           specification_part?
           execution_part?
           internal_subprogram_part?
           end_program_stmt
        )

        {
           fprintf(out, "main_program = ofp.MainProgram(program_stmt, specification_part, execution_part, internal_subprotram_part, end_program_stmt)\n\n");
        }
   ;


//========================================================================================
// R1102-F08 program-stmt
//----------------------------------------------------------------------------------------
program_stmt
   :  ^(OFPProgramStmt
          ^(OFPLabel label?)
          ^(OFPProgramName T_IDENT)
          ^(OFPCommentList OFPComment*)
       )

       {
          unparse_label    (out, $OFPLabel);
          unparse_name     (out, $OFPProgramName, "program_name", "OFPProgramName");
          unparse_comments (out, $OFPCommentList);

          fprintf(out, "program_stmt = ofp.ProgramStmt(label, name, comments)\n\n");

       }
   ;


//========================================================================================
// R1103-F08 end-program-stmt
//----------------------------------------------------------------------------------------
end_program_stmt
   :  ^(OFPEndProgramStmt
          ^(OFPLabel label?)
          ^(OFPProgramName T_IDENT?)
          ^(OFPCommentList OFPComment*)
       )

       {
          unparse_label (out, $OFPLabel);
          unparse_name  (out, $OFPProgramName,    "end_program_name", "OFPProgramName");
          unparse_comments (out, $OFPCommentList);

          fprintf(out, "end_program_stmt = OFPEndProgramStmt(label, name, comments)\n\n");
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
