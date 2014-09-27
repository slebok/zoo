///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//  ImplicitNone.g - grammar extensions to warn of absence of IMPLICIT NONE  //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

tree grammar ImplicitNone;

options {
   language       = C;
   tokenVocab     = CFortranParser;
   output         = AST;
   ASTLabelType   = pANTLR3_BASE_TREE;
}

import FTreeWalker;

@members
{
#  include "support.h"
   ANTLR3_BOOLEAN gHasImplicitNone = ANTLR3_FALSE;
}

// R1101-F08
main_program
@after
{
   if (ANTLR3_FALSE == gHasImplicitNone) {
      printf("ERROR:ImplicitNone:: IMPLICIT NONE statement not found in main-program beginning at line \%d\n", START_LINE);
   }
   gHasImplicitNone = ANTLR3_FALSE;
}
   :   ^(SgProgramHeaderStatement program_stmt? end_program_stmt
           ^(SgFunctionDefinition 
               ^(SgBasicBlock specification_part)
            )
        )
   ;

// R1231
subroutine_subprogram
@after
{
   if (ANTLR3_FALSE == gHasImplicitNone) {
      printf("ERROR:ImplicitNone:: IMPLICIT NONE statement not found in subroutine-subprogram beginning at line \%d\n", START_LINE);
   }
   gHasImplicitNone = ANTLR3_FALSE;
}
   :   subroutine_stmt
       specification_part
       ( execution_part )?
       ( internal_subprogram_part )?
       end_subroutine_stmt
   ;

// R1223
function_subprogram
@after
{
   if (ANTLR3_FALSE == gHasImplicitNone) {
      printf("ERROR:ImplicitNone:: IMPLICIT NONE statement not found in function-subprogram beginning at line \%d\n", START_LINE);
   }
   gHasImplicitNone = ANTLR3_FALSE;
}
   :   function_stmt
        specification_part
        ( execution_part )?
        ( internal_subprogram_part )?
        end_function_stmt
   ;

// R560-F08
implicit_stmt
   :   // implicit none if OFPList is empty
       ^(SgImplicitStatement ^(OFPList implicit_spec+) label?)
   |   ^(SgImplicitStatement   OFPList                 label?)
           {
              gHasImplicitNone = ANTLR3_TRUE;
           }
   ;
