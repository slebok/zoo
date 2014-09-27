tree grammar FTreeUnparser;

options {
   language       = C;
   tokenVocab     = CFortranParser;
   ASTLabelType   = pANTLR3_BASE_TREE;
}

@members {

static      pANTLR3_VECTOR      tlist;
static      ANTLR3_MARKER       next_token;

void FTreeWalker_set_tokens(pANTLR3_VECTOR lexer_tlist)
   {
      tlist       = lexer_tlist;
      next_token  = 0;
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
      if (btn->getType(btn) == ANTLR3_TOKEN_DOWN || btn->getType(btn) == ANTLR3_TOKEN_DOWN) {
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

} // end members


main_program
@init    {printf("\n");}
@after   {printf("\n");}
   :   ^(SgProgramHeaderStatement program_stmt? end_program_stmt)

         {
            //pANTLR3_BASE_TREE   node  = $program_stmt.start;
            //pANTLR3_BASE_TREE   name  = node->getFirstChildWithType(node, T_IDENT);
            //pANTLR3_BASE_TREE   label = node->getFirstChildWithType(node, T_DIGIT_STRING);

            next_token = unparse ($program_stmt.start,      next_token);
            next_token = unparse ($end_program_stmt.start,  next_token);

            // unparse trailing comments
            //
            next_token = unparseTokens(next_token, tlist->count-1);
         }
   ;

program_stmt
   :  ^(LabelNameStmt T_IDENT label?)
   ;

end_program_stmt
   :  ^(LabelNameStmt T_IDENT? label?)
   ;

label
   :  T_DIGIT_STRING
   ;
