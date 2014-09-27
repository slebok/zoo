tree grammar FTreeWalker;

options {
   language       = C;
   tokenVocab     = CFortranParser;
   output         = AST;
   ASTLabelType   = pANTLR3_BASE_TREE;
}

@members {

#include  "OFP_Type.h"

//static      pANTLR3_VECTOR      tlist;
//static      ANTLR3_MARKER       next_token;

      pANTLR3_VECTOR      tlist;
      ANTLR3_MARKER       next_token;


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

} // end members



/*
 * Section/Clause 1: Overview
 */


/*
 * Section/Clause 2: Fortran concepts
 */

//========================================================================================
// R204-F08 specification-part
//----------------------------------------------------------------------------------------
specification_part
   :  ^(OFPSpecificationPart
          ^(OFPUseStmtList               use_stmt*                 )
                                         import_stmt*
                                         implicit_part_recursion
          ^(OFPDeclarationConstructList  declaration_construct*    )
       )
   ;

////////////
// R205-F08
// R206-F08 combined
//
implicit_part_recursion
   :   (SgImplicitStatement)  => implicit_stmt   implicit_part_recursion
   |   ((label)? T_PARAMETER) => parameter_stmt  implicit_part_recursion
   |   ((label)? T_FORMAT)    => format_stmt     implicit_part_recursion
   |   ((label)? T_ENTRY)     => entry_stmt      implicit_part_recursion
   |   // empty
   ;

////////////
// R207-F08
//
declaration_construct
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

// R208
execution_part
   :   executable_construct
       execution_part_construct *
   ;

// R209
execution_part_construct
   :   executable_construct  
   |   format_stmt
   |   entry_stmt
   |   data_stmt
   ;

////////////
// R210-F08
//
internal_subprogram_part
   :   contains_stmt
       ( internal_subprogram  )*
   ;

// R211
internal_subprogram
   :   ( prefix )? function_subprogram
   |   subroutine_subprogram
   ;

////////////
// R212-F08
//
other_specification_stmt
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
executable_construct
   :   action_stmt
   |   associate_construct
   |   case_construct
   |   do_construct
   |   forall_construct
   |   if_construct
   |   select_type_construct
   |   where_construct
   ;


////////////
// R214-F08 action-stmt
//
action_stmt
   :   allocate_stmt
   |   assignment_stmt
   |   backspace_stmt
   |   call_stmt
   |   close_stmt
   |   continue_stmt
   |   cycle_stmt
   |   deallocate_stmt
   |   endfile_stmt
   |   exit_stmt
   |   flush_stmt
   |   forall_stmt
   |   goto_stmt
   |   if_stmt
   |   inquire_stmt  
   |   nullify_stmt
   |   open_stmt
   |   pointer_assignment_stmt
   |   print_stmt
   |   read_stmt
   |   return_stmt
   |   rewind_stmt
   |   stop_stmt
   |   wait_stmt
   |   where_stmt
   |   write_stmt
   |   arithmetic_if_stmt
   |   computed_goto_stmt
   |   assign_stmt 
   |   assigned_goto_stmt
   |   pause_stmt
   ;

//========================================================================================
// R215
//----------------------------------------------------------------------------------------
keyword
   :   name
   ;


/**
 * Section/Clause 3: Lexical tokens and source form
 */

// R304
name
   :   T_IDENT
   ;

// R305
constant
   :   literal_constant
   |   T_IDENT
   ;

scalar_constant
   :    constant
   ;

// R306
literal_constant
   :   int_literal_constant
   |   real_literal_constant
   |   complex_literal_constant
   |   logical_literal_constant
   |   char_literal_constant
   |   boz_literal_constant
   |   hollerith_literal_constant  // deleted in F77
   ;

// R308
int_constant
   :   int_literal_constant
   |   T_IDENT
   ;

// R309
char_constant
   :   char_literal_constant
   |   T_IDENT
   ;

// R310
intrinsic_operator
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
defined_operator
   :   T_DEFINED_OP            
   |   extended_intrinsic_op   
   ;

// R312
extended_intrinsic_op
   :   intrinsic_operator
   ;


//========================================================================================
// R312-F08 label
//----------------------------------------------------------------------------------------
label
   :  T_DIGIT_STRING
   ;


/**
 * Section/Clause 4: Types
 */


// R401
type_spec
   :   intrinsic_type_spec
   |   derived_type_spec
   ;

// R402
type_param_value
   :   expr
   |   T_ASTERISK
   |   T_COLON
   ;

//========================================================================================
// R404-F08 intrinsic-type-spec
//----------------------------------------------------------------------------------------
intrinsic_type_spec
@after
{
   pOFP_TYPE_TABLE ttable = ofpGetTypeTable();
   ttable->putIntrinsic(ttable, retval.tree);
}
   :   ^( SgTypeInt       kind_selector? )
   |   ^( SgTypeFloat     kind_selector? )
   |      SgTypeDouble
   |   ^( SgTypeComplex   kind_selector? )
   |      SgTypeDComplex                      // TODO - what is the real SgType?
   |   ^( SgTypeChar      char_selector? )
   |   ^( SgTypeBool      kind_selector? )
   ;

// R404
kind_selector
   :   ^(OFPKindSelector expr)
   ;

// R405
signed_int_literal_constant
   :   (T_PLUS  | T_MINUS )?
        int_literal_constant
   ;

// R406
int_literal_constant
   :   T_DIGIT_STRING (T_UNDERSCORE kind_param )?
   ;

// R407
kind_param
   :   T_DIGIT_STRING 
   |   T_IDENT 
   ;

// R411
boz_literal_constant
   :   BINARY_CONSTANT
   |   OCTAL_CONSTANT
   |   HEX_CONSTANT
   ;

// R416
signed_real_literal_constant
   :   ( T_PLUS | T_MINUS )?  real_literal_constant
   ;

// R417 modified to use terminal
real_literal_constant
   :   T_REAL_CONSTANT ( T_UNDERSCORE kind_param )? 
   ;

// R421
complex_literal_constant
   :   T_LPAREN real_part T_COMMA imag_part T_RPAREN
   ;

// R422
real_part
   :   signed_int_literal_constant  
   |   signed_real_literal_constant 
   |   T_IDENT                      
   ;

// R423
imag_part
   :   signed_int_literal_constant     
   |   signed_real_literal_constant    
   |   T_IDENT                         
   ;

// R420-F08
char_selector
   :   ^(OFPCharSelector ^(OFPKindSelector expr?) ^(OFPLengthSelector type_param_value?))
   ;

// R421-F08
length_selector
   :   ^(OFPLengthSelector type_param_value)
   ; 

// R426
char_length
   :   T_LPAREN type_param_value T_RPAREN
   |   scalar_int_literal_constant
   ;

scalar_int_literal_constant
   :   int_literal_constant
   ;

// R427
char_literal_constant
   :   T_DIGIT_STRING T_UNDERSCORE T_CHAR_CONSTANT
   |   T_IDENT T_CHAR_CONSTANT
   |   T_CHAR_CONSTANT
   ;

hollerith_literal_constant
   :   T_HOLLERITH
   ;

// R428
logical_literal_constant
   :   T_TRUE  ( T_UNDERSCORE kind_param )?
   |   T_FALSE ( T_UNDERSCORE kind_param )?
   ;

// R429
derived_type_def
   :   derived_type_stmt
        // matches T_INTEGER possibilities in component_def_stmt
        type_param_or_comp_def_stmt_list  
        ( private_or_sequence )*
        ( component_def_stmt )*
        ( type_bound_procedure_part )?
        end_type_stmt
   ;

type_param_or_comp_def_stmt_list
   :   (kind_selector)? T_COMMA type_param_or_comp_def_stmt
            type_param_or_comp_def_stmt_list
   |
   ;

type_param_or_comp_def_stmt
   :   type_param_attr_spec T_COLON_COLON type_param_decl_list end_of_stmt 
   |   component_attr_spec_list T_COLON_COLON component_decl_list end_of_stmt 
   ;

// R430
derived_type_stmt
   :   label? T_TYPE
        ( ( T_COMMA type_attr_spec_list )? 
            T_COLON_COLON )? T_IDENT
            ( T_LPAREN generic_name_list T_RPAREN )?
            end_of_stmt
   ;

type_attr_spec_list
   :   type_attr_spec ( T_COMMA type_attr_spec )*
   ;

generic_name_list
   :   ^(OFPList T_IDENT+)
   ;

// R431
type_attr_spec
   :   access_spec
   |   T_EXTENDS T_LPAREN T_IDENT T_RPAREN
   |   T_ABSTRACT
   |   T_BIND T_LPAREN T_IDENT /* 'C' */ T_RPAREN
   ;

// R432
private_or_sequence
   :   private_components_stmt
   |   sequence_stmt
   ;

// R433
end_type_stmt
   :   label? T_END T_TYPE T_IDENT? 
           end_of_stmt
   |   label? T_ENDTYPE T_IDENT?
           end_of_stmt
   ;

// R434
sequence_stmt
   :   label? T_SEQUENCE end_of_stmt
   ;

// R436
type_param_decl
   :    T_IDENT ( T_EQUALS expr )?
   ;

type_param_decl_list
   :   type_param_decl ( T_COMMA type_param_decl )*
   ;

////////////
// R437-F08, R441-F03
//
component_attr_spec
   :   access_spec
   |   T_ALLOCATABLE
   |   T_CODIMENSION T_LBRACKET coarray_spec T_RBRACKET          // NEW_TO_2008 
   |   T_CONTIGUOUS                                              // NEW_TO_2008 
   |   T_DIMENSION T_LPAREN component_array_spec T_RPAREN
   |   T_POINTER
   |   component_attr_spec_extension
   ;
  
// language extension point
component_attr_spec_extension : T_NO_LANGUAGE_EXTENSION ;

component_attr_spec_list
   :   component_attr_spec ( T_COMMA component_attr_spec )*
   ;

// R437
type_param_attr_spec
   :   T_IDENT /* { KIND | LEN } */ 
   ;

// R439
component_def_stmt
   :   data_component_def_stmt
   |   proc_component_def_stmt
   ;


// R440
data_component_def_stmt
   :    label? declaration_type_spec 
            ( ( T_COMMA component_attr_spec_list )? 
            T_COLON_COLON )? component_decl_list end_of_stmt
   ;

////////////
// R438-F08, R442-F03
//
component_decl
   :   T_IDENT ( T_LPAREN   component_array_spec T_RPAREN   )?
               ( T_LBRACKET coarray_spec         T_RBRACKET )?
               ( T_ASTERISK char_length                     )? 
               ( component_initialization                   )?
   ;

component_decl_list
   :   component_decl ( T_COMMA component_decl )*
   ;

// R443
component_array_spec
   :   explicit_shape_spec_list
   |   deferred_shape_spec_list
   ;

// deferred_shape_spec replaced by T_COLON
deferred_shape_spec_list
   :   T_COLON ( T_COMMA T_COLON )*
   ;

// R444
component_initialization
   :   T_EQUALS expr
   |   T_EQ_GT null_init
   ;

// R445
proc_component_def_stmt
   :   label? T_PROCEDURE T_LPAREN 
            ( proc_interface )? T_RPAREN T_COMMA
            proc_component_attr_spec_list T_COLON_COLON proc_decl_list 
            end_of_stmt
   ;

// R446
proc_component_attr_spec
   :    T_POINTER
   |    T_PASS ( T_LPAREN T_IDENT T_RPAREN  )?
   |    T_NOPASS
   |    access_spec
   ;

proc_component_attr_spec_list
   :   proc_component_attr_spec  ( T_COMMA proc_component_attr_spec )*
   ;

// R447
private_components_stmt
   :   label? T_PRIVATE end_of_stmt
   ;

//========================================================================================
// R445-F08 type-bound-procedure-part
//----------------------------------------------------------------------------------------
type_bound_procedure_part
   :   contains_stmt
        ( binding_private_stmt )? 
        type_bound_proc_binding ( type_bound_proc_binding )*
   ;

//========================================================================================
// R446-F08 binding_private_stmt
//----------------------------------------------------------------------------------------
binding_private_stmt
   :   label?  T_PRIVATE  end_of_stmt
   ;

//========================================================================================
// R447-F08 type-bound-proc-binding
//----------------------------------------------------------------------------------------
type_bound_proc_binding
   :   label?
       specific_binding end_of_stmt
   |   label?
       generic_binding end_of_stmt
   |   label?
       final_binding end_of_stmt
   ;

// R451
specific_binding
   :   T_PROCEDURE (T_LPAREN T_IDENT T_RPAREN)?
            ( ( T_COMMA binding_attr_list )? 
                T_COLON_COLON )?
            T_IDENT
            ( T_EQ_GT T_IDENT )?
   ;

// R452
generic_binding
   :    T_GENERIC ( T_COMMA access_spec )? T_COLON_COLON 
            generic_spec T_EQ_GT generic_name_list
   ;

// R453
binding_attr
   :   T_PASS ( T_LPAREN T_IDENT T_RPAREN )?
   |   T_NOPASS         
   |   T_NON_OVERRIDABLE    
   |   T_DEFERRED       
   |   access_spec      
   ;

binding_attr_list
   :   binding_attr  ( T_COMMA binding_attr )*
   ;

// R454
// generic_name_list substituted for final_subroutine_name_list
final_binding
   :   T_FINAL ( T_COLON_COLON )? generic_name_list 
   ;

// R455
derived_type_spec
   :   T_IDENT ( T_LPAREN type_param_spec_list  T_RPAREN )?
   ;

// R456
type_param_spec
   :   ( keyword T_EQUALS )? type_param_value
   ;

type_param_spec_list
   :   type_param_spec ( T_COMMA type_param_spec )*
   ;

// R457
structure_constructor
   :   T_IDENT T_LPAREN type_param_spec_list T_RPAREN
        (T_LPAREN
        ( component_spec_list )?
        T_RPAREN)?
   ;

// R458
component_spec
   :   ( keyword T_EQUALS )? component_data_source
   ;

component_spec_list
   :   component_spec ( T_COMMA component_spec )*
   ;

// R459
component_data_source
   :   expr 
   ;

// R460
enum_def
   :   enum_def_stmt
       enumerator_def_stmt
       ( enumerator_def_stmt )*
       end_enum_stmt
   ;

// R461
enum_def_stmt
   :   label? T_ENUM T_COMMA T_BIND T_LPAREN 
               T_IDENT /* 'C' */ T_RPAREN      end_of_stmt
   ;

// R462
enumerator_def_stmt
   :   label? T_ENUMERATOR ( T_COLON_COLON )? 
            enumerator_list end_of_stmt
   ;

// R463
enumerator
   :   T_IDENT ( T_EQUALS expr )?
   ;

enumerator_list
   :   enumerator ( T_COMMA enumerator )*
   ;

// R464
end_enum_stmt
   :   label? T_END T_ENUM end_of_stmt 
   |   label? T_ENDENUM end_of_stmt 
   ;

// R465
array_constructor
   :   T_LPAREN T_SLASH ac_spec T_SLASH T_RPAREN
   |   T_LBRACKET ac_spec T_RBRACKET
   ;

// R466
ac_spec
options {backtrack=true;}
   :   type_spec  T_COLON_COLON  ac_value_list?
   |   ac_value_list
   ;

// R469
ac_value
options {backtrack=true;}
   :   expr
   |   ac_implied_do
   ;

ac_value_list
   :   ac_value ( T_COMMA ac_value )*
   ;

// R470
ac_implied_do
   :   T_LPAREN ac_value_list T_COMMA ac_implied_do_control T_RPAREN
   ;

// R471
ac_implied_do_control
   :    do_variable T_EQUALS expr T_COMMA expr ( T_COMMA expr )?
   ;

// R472
scalar_int_variable
   :   variable
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
   ;

// R502
declaration_type_spec
   :   intrinsic_type_spec
{
//   printf("intrinsic_type_spec: create an intrinsic SgType here\n");
}
   |   T_TYPE T_LPAREN derived_type_spec T_RPAREN
   |   T_CLASS T_LPAREN derived_type_spec T_RPAREN
   |   T_CLASS T_LPAREN T_ASTERISK T_RPAREN
   ;

////////////
// R502-F08, R503-F03
//
attr_spec
   :   intent_spec
   |   OFPOptional
   |   OFPUnimplemented
   ;
    
// language extension point
attr_spec_extension : T_NO_LANGUAGE_EXTENSION ;


//========================================================================================
// R503-F08 entity-decl
//----------------------------------------------------------------------------------------
entity_decl
//   :   T_IDENT ( T_LPAREN array_spec T_RPAREN  )?
//               ( T_LBRACKET coarray_spec T_RBRACKET  )?
//               ( T_ASTERISK char_length  )?
//               ( initialization  )?

   :  ^(SgInitializedName T_IDENT array_spec?)
   ;


////////////
// R505-F03, R504-F08
//
object_name
   :   T_IDENT
   ;

// R506
initialization
   :   T_EQUALS expr
   |   T_EQ_GT null_init
   ;

// R507
null_init
   :   T_IDENT /* 'NULL' */ T_LPAREN T_RPAREN
   ;

////////////
// R509-F08
//
coarray_spec
   :   array_spec_element  (T_COMMA array_spec_element )*
           
   ;

// R508
access_spec
   :   T_PUBLIC
   |   T_PRIVATE
   ;

// R509
language_binding_spec
   :   ^(OFPBind T_IDENT expr?)
   ;

// R510
array_spec
   :   array_spec_element (T_COMMA array_spec_element )*
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
   :   expr ( T_COLON ( expr | T_ASTERISK )? )?
   |   T_ASTERISK
   |   T_COLON
   ;

// R511
// refactored to remove conditional from lhs and inlined lower_bound and 
// upper_bound
explicit_shape_spec
   :   expr (T_COLON expr )?
   ;

explicit_shape_spec_list
   :   explicit_shape_spec ( T_COMMA explicit_shape_spec )*
   ;

// R517
intent_spec
   :   OFPIntentIn
   |   OFPIntentOut
   |   OFPIntentInOut
   ;

// R518
access_stmt
   :    label? access_spec ( ( T_COLON_COLON )? 
            access_id_list )? end_of_stmt
   ;

// R519
access_id
   :   generic_spec
   ;

access_id_list
   :   access_id  ( T_COMMA access_id  )*
   ;

////////////
// R526-F08
//
allocatable_stmt
   :   label?
       T_ALLOCATABLE ( T_COLON_COLON )? allocatable_decl_list end_of_stmt
   ;

////////////
// R527-F08
//
allocatable_decl
   :   object_name 
          ( T_LPAREN array_spec T_RPAREN  )?
          ( T_LBRACKET coarray_spec T_RBRACKET  )?
   ;

allocatable_decl_list
   :   allocatable_decl  ( T_COMMA allocatable_decl  )*
   ;

// R521
asynchronous_stmt
   :   label? T_ASYNCHRONOUS ( T_COLON_COLON )?
        generic_name_list end_of_stmt
   ;

// R522
bind_stmt
   :   label? language_binding_spec
        ( T_COLON_COLON )? bind_entity_list end_of_stmt
   ;

// R523
bind_entity
   :   T_IDENT 
        // isCommonBlockName=false
   |   T_SLASH T_IDENT T_SLASH 
        // isCommonBlockname=true
   ;

bind_entity_list
   :   bind_entity  ( T_COMMA bind_entity  )*
   ;

// R524
data_stmt
   :   label? T_DATA data_stmt_set ( ( T_COMMA )? 
            data_stmt_set )* end_of_stmt
   ;

// R525
data_stmt_set
   :   data_stmt_object_list
        T_SLASH
        data_stmt_value_list
        T_SLASH
   ;

// R526
data_stmt_object
   :   variable
   |   data_implied_do
   ;

data_stmt_object_list
   :   data_stmt_object  ( T_COMMA data_stmt_object  )*
   ;


// R527
data_implied_do
   :   T_LPAREN data_i_do_object_list T_COMMA T_IDENT T_EQUALS
        expr T_COMMA expr ( T_COMMA expr )? T_RPAREN
   ;

// R528
data_i_do_object
   :   data_ref
   |   data_implied_do
   ;

data_i_do_object_list
   :   data_i_do_object  ( T_COMMA data_i_do_object  )*
   ;

// R530
data_stmt_value
options {backtrack=true; k=3;}
   :   designator (T_ASTERISK data_stmt_constant )?
   |   int_literal_constant (T_ASTERISK data_stmt_constant )?
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
   :   data_stmt_value  ( T_COMMA data_stmt_value  )*
   ;

scalar_int_constant
   :   int_constant
   ;

// R532
data_stmt_constant
options {backtrack=true; k=3;}
   :   designator
   |   signed_int_literal_constant
   |   signed_real_literal_constant
   |   complex_literal_constant
   |   logical_literal_constant
   |   char_literal_constant
   |   boz_literal_constant
   |   structure_constructor // is null_init if 'NULL()'
   ;

////////////
// R531-F08
//
codimension_stmt
   :   label?
       T_CODIMENSION ( T_COLON_COLON )? codimension_decl_list end_of_stmt
   ;
   
////////////
// R532-F08
//
codimension_decl
   :   T_IDENT T_LBRACKET coarray_spec T_RBRACKET
   ;

codimension_decl_list
   :   codimension_decl  ( T_COMMA codimension_decl  )*
   ;

// R535, R543-F2008
dimension_stmt
   :   label? T_DIMENSION ( T_COLON_COLON )? 
        dimension_decl ( T_COMMA dimension_decl )* end_of_stmt
   ;

// R535-subrule
dimension_decl
   :   T_IDENT T_LPAREN array_spec T_RPAREN
   ;

// R536
intent_stmt
   :   label? T_INTENT T_LPAREN intent_spec T_RPAREN 
            ( T_COLON_COLON )? generic_name_list end_of_stmt
   ;

// R537
optional_stmt
   :   label? T_OPTIONAL ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
   ;

// R538
parameter_stmt
   :   label? T_PARAMETER T_LPAREN 
            named_constant_def_list T_RPAREN end_of_stmt
   ;

named_constant_def_list
   :   named_constant_def  ( T_COMMA named_constant_def  )*
   ;

// R539
named_constant_def
   :   T_IDENT T_EQUALS expr
   ;

////////////
// R550-F08, R540-F03
//
pointer_stmt
   :   label? T_POINTER
       (cray_pointer_assoc_list | ( ( T_COLON_COLON )? pointer_decl_list )
       ) end_of_stmt
   ;

pointer_decl_list
   :   pointer_decl  ( T_COMMA pointer_decl  )*
   ;

////////////
// R551-F08, R541-F03
//
pointer_decl
   :   T_IDENT ( T_LPAREN deferred_shape_spec_list T_RPAREN )?
   ;

cray_pointer_assoc_list
   :   cray_pointer_assoc  ( T_COMMA cray_pointer_assoc  )*
   ;

cray_pointer_assoc
   :   T_LPAREN T_IDENT T_COMMA T_IDENT T_RPAREN
   ;

// R542
protected_stmt
   :   label? T_PROTECTED ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
   ;

// R543
save_stmt
   : label? T_SAVE ( ( T_COLON_COLON )? 
            saved_entity_list )? end_of_stmt
   ;

// R544
saved_entity
   :   T_IDENT
   |   T_SLASH T_IDENT T_SLASH      // is common block name
   ;

saved_entity_list
   :   saved_entity  ( T_COMMA saved_entity  )*
   ;


// R546, R555-F08
target_stmt
   :   label?
       T_TARGET ( T_COLON_COLON )? target_decl_list end_of_stmt
   ;

////////////
// R557-F08
//
target_decl
   :   T_IDENT (T_LPAREN array_spec T_RPAREN  )?
               (T_LBRACKET coarray_spec T_RBRACKET  )?
   ;

// R557-F08
target_decl_list
   :   target_decl  ( T_COMMA target_decl  )*
   ;

// R547
// generic_name_list substituted for dummy_arg_name_list
value_stmt
   :   label? T_VALUE ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
   ;

// R548
// generic_name_list substituted for object_name_list
volatile_stmt
   :   label? T_VOLATILE ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
   ;

//========================================================================================
// R560-F08 implicit-stmt
//----------------------------------------------------------------------------------------
implicit_stmt
   :   // implicit none if OFPList is empty
       ^(SgImplicitStatement ^(OFPLabel label?) ^(OFPList implicit_spec*))
   ;

// R561-F08
implicit_spec
   :   declaration_type_spec T_LPAREN letter_spec_list T_RPAREN
   ;

// R562-F08
letter_spec 
   :  T_IDENT ( T_MINUS T_IDENT )? 
   ;

letter_spec_list
   :   letter_spec  ( T_COMMA letter_spec  )*
   ;

// R552
namelist_stmt
   :   label? T_NAMELIST T_SLASH T_IDENT T_SLASH
        namelist_group_object_list
        ( ( T_COMMA )?  T_SLASH T_IDENT T_SLASH
        namelist_group_object_list )* end_of_stmt
   ;

namelist_group_object_list
   :  T_IDENT ( T_COMMA T_IDENT )*
   ;

// R554
equivalence_stmt
   :   label? T_EQUIVALENCE equivalence_set_list 
            end_of_stmt
   ;

// R555
equivalence_set
   :   T_LPAREN equivalence_object T_COMMA equivalence_object_list T_RPAREN
   ;


equivalence_set_list
   :   equivalence_set  ( T_COMMA equivalence_set  )*
   ;

// R556
equivalence_object
   :   substring 
   ;

equivalence_object_list
   :   equivalence_object  ( T_COMMA equivalence_object  )*
   ;

// R557
common_stmt
   : label? 
        T_COMMON ( common_block_name )?
        common_block_object_list
        ( ( T_COMMA )? common_block_name
        common_block_object_list  )* end_of_stmt
   ;

common_block_name returns [pANTLR3_COMMON_TOKEN id]
   :   T_SLASH_SLASH
   |   T_SLASH  T_IDENT?  T_SLASH
   ;

// R558
common_block_object
   : T_IDENT ( T_LPAREN explicit_shape_spec_list T_RPAREN 
            )?
   ;

common_block_object_list
   :   common_block_object ( T_COMMA common_block_object  )*
   ;

/**
 * Section/Clause 6: Use of data objects
 */               


// R601
variable
   :   designator 
   ;

// R603
designator
   :   data_ref (T_LPAREN substring_range  T_RPAREN)?
   |   char_literal_constant T_LPAREN substring_range T_RPAREN
   ;

designator_or_func_ref
   :   data_ref (T_LPAREN substring_range_or_arg_list
                  T_RPAREN)?
   |   char_literal_constant T_LPAREN substring_range T_RPAREN
   ;

substring_range_or_arg_list returns [ANTLR3_BOOLEAN isSubstringRange]
   :   T_COLON (expr )? // substring_range
   |   expr substr_range_or_arg_list_suffix
   |   T_IDENT T_EQUALS expr
       ( T_COMMA actual_arg_spec  )*
   |   ( T_IDENT T_EQUALS  )? T_ASTERISK label ( T_COMMA actual_arg_spec )*
   ;

substr_range_or_arg_list_suffix returns [ANTLR3_BOOLEAN isSubstringRange]
   :        
        T_COLON (expr )? // substring_range
   |
        ( T_COMMA actual_arg_spec  )*
              // actual_arg_spec_list
   ;

// R604
logical_variable
   :   variable
   ;

// R605
default_logical_variable
   :   variable
   ;

scalar_default_logical_variable
   :   variable
   ;

// R606
char_variable
   :   variable
   ;

// R607
default_char_variable
   :   variable
   ;

scalar_default_char_variable
   :   variable
   ;

// R608
int_variable
   :   variable
   ;

// R609
// C608 (R610) parent_string shall be of type character
// fix for ambiguity in data_ref allows it to match T_LPAREN substring_range 
// T_RPAREN, so required T_LPAREN substring_range T_RPAREN made optional
// ERR_CHK 609 ensure final () is (substring-range)
substring
   :   data_ref (T_LPAREN substring_range  T_RPAREN)?
   |   char_literal_constant T_LPAREN substring_range T_RPAREN
   ;

// R611
substring_range
   :   (expr )? T_COLON  (expr )?
   ;

// R612
data_ref
   :   part_ref  ( T_PERCENT part_ref )*
   ;

////////////
// R612-F08, R613-F03
//
part_ref
   :   T_IDENT
   ;

vector_subscript
   :   expr
   ;

// R623
allocate_stmt
   :   label? T_ALLOCATE_STMT_1 T_ALLOCATE T_LPAREN
        type_spec T_COLON_COLON
        allocation_list 
        ( T_COMMA alloc_opt_list  )? T_RPAREN 
            end_of_stmt
   |   label? T_ALLOCATE T_LPAREN
        allocation_list
        ( T_COMMA alloc_opt_list  )? T_RPAREN 
            end_of_stmt
   ;

// R624
alloc_opt
   :   T_IDENT T_EQUALS expr
   ;

alloc_opt_list
   :   alloc_opt  ( T_COMMA alloc_opt  )*
   ;

////////////
// R631-F08, R628-F03
//
allocation
   :   T_IDENT
   ;

allocation_list
   :   allocation  ( T_COMMA allocation  )*
   ;

////////////
// R636-F08, R629-F03
//
allocate_object
   :   T_IDENT
   ;

allocate_object_list
   :       
        allocate_object  ( T_COMMA allocate_object  )*
   ;

allocate_shape_spec
   :   expr (T_COLON expr)?
   ;

allocate_shape_spec_list
   :   allocate_shape_spec ( T_COMMA allocate_shape_spec  )*
   ;

////////////
// R637-F08
//
allocate_coshape_spec
   :   expr ( T_COLON expr )?
   ;

allocate_coshape_spec_list
   :   allocate_coshape_spec  ( T_COMMA allocate_coshape_spec  )*
   ;


// R633
nullify_stmt
   :   label?
        T_NULLIFY T_LPAREN pointer_object_list T_RPAREN end_of_stmt
   ;

// R634
pointer_object
   :   data_ref
   ;

pointer_object_list
   :   pointer_object  ( T_COMMA pointer_object  )*
   ;

// R635
deallocate_stmt
   :    label? T_DEALLOCATE T_LPAREN allocate_object_list 
            ( T_COMMA dealloc_opt_list )? 
            T_RPAREN end_of_stmt
   ;

// R636
// stat_variable and errmsg_variable replaced by designator
dealloc_opt
   :   T_IDENT /*  */ T_EQUALS designator
   ;

dealloc_opt_list
   :       
        dealloc_opt  ( T_COMMA dealloc_opt  )*
   ;

/**
 * Section/Clause 7: Expressions and assignment
 */

// R701
primary
options {backtrack=true;}       // alt 1,4 ambiguous
   :   designator_or_func_ref
   |   literal_constant
   |   array_constructor
   |   structure_constructor
   |   T_LPAREN expr T_RPAREN 
   ;

// R702
level_1_expr
   : (defined_unary_op )? primary
   ;

// R703
defined_unary_op
   :   T_DEFINED_OP
   ;

// inserted as R704 functionality
power_operand
   : level_1_expr (power_op power_operand )?
   ;   

// R704
mult_operand
   : power_operand ( mult_op power_operand )*
   ;

// R705-addition
signed_operand
   :   add_op? mult_operand 
   ;

// R705
add_operand
   :   signed_operand
       ( add_op mult_operand 
       )*
   ;

// R706
level_2_expr
   : add_operand ( concat_op add_operand )*
   ;

// R707
power_op
   :   T_POWER      
   ;

// R708
mult_op
   :   T_ASTERISK   
   |   T_SLASH      
   ;

// R709
add_op
   :   T_PLUS       
   |   T_MINUS      
   ;

// R710
level_3_expr
   : level_2_expr (rel_op level_2_expr )?
   ;

// R711
concat_op
   :   T_SLASH_SLASH   
   ;

// R713
rel_op
   :   T_EQ                  
   |   T_NE                  
   |   T_LT                  
   |   T_LE                  
   |   T_GT                  
   |   T_GE                  
   |   T_EQ_EQ               
   |   T_SLASH_EQ            
   |   T_LESSTHAN            
   |   T_LESSTHAN_EQ         
   |   T_GREATERTHAN         
   |   T_GREATERTHAN_EQ      
   ;

// R714
and_operand
   :   (not_op )?
        level_3_expr
        (and_op  (not_op )? level_3_expr
        )*
   ;

// R715
or_operand
   : and_operand (or_op and_operand )*
   ;

// R716
equiv_operand
   : or_operand 
        (equiv_op or_operand
        )*
   ;

// R717
level_5_expr
   : equiv_operand (defined_binary_op equiv_operand
             )*
   ;

// R718
not_op
   :   T_NOT       
   ;

// R719
and_op
   :   T_AND      
   ;

// R720
or_op
   :   T_OR       
   ;

// R721
equiv_op
   :   T_EQV      
   |   T_NEQV     
   ;

// R722
expr
   : level_5_expr
   ;

// R723
defined_binary_op
   :   T_DEFINED_OP   
   ;

// R734
assignment_stmt
   :   label? T_ASSIGNMENT_STMT variable
        T_EQUALS expr end_of_stmt
   ;

// R735
pointer_assignment_stmt
options {backtrack=true;}
   : label? T_PTR_ASSIGNMENT_STMT data_ref T_EQ_GT 
            expr end_of_stmt
   | label? T_PTR_ASSIGNMENT_STMT data_ref T_LPAREN 
            bounds_spec_list T_RPAREN T_EQ_GT expr end_of_stmt
   | label? T_PTR_ASSIGNMENT_STMT data_ref T_LPAREN 
            bounds_remapping_list T_RPAREN T_EQ_GT expr end_of_stmt
   ;

// R736
data_pointer_object
   :   designator
   ;

// R737
bounds_spec
   :   expr T_COLON
   ;

bounds_spec_list
   :   bounds_spec  ( T_COMMA bounds_spec  )*
   ;

// R738
bounds_remapping
   :   expr T_COLON expr
   ;

bounds_remapping_list
   :   bounds_remapping  ( T_COMMA bounds_remapping  )*
   ;

// R740
proc_pointer_object
   :   designator
   ;

where_stmt
   :
        label? T_WHERE_STMT T_WHERE
        T_LPAREN expr T_RPAREN assignment_stmt
   ;

// R744
where_construct
   :    where_construct_stmt ( where_body_construct  )*
          ( masked_elsewhere_stmt ( where_body_construct 
                 )*
          )*
          ( elsewhere_stmt ( where_body_construct 
                 )*
          )?
         end_where_stmt
   ;

// R745
where_construct_stmt
   :   ( T_IDENT T_COLON )? T_WHERE_CONSTRUCT_STMT T_WHERE 
            T_LPAREN expr T_RPAREN end_of_stmt
   ;

// R746
where_body_construct
   :   assignment_stmt
   |   where_stmt
   |   where_construct
   ;

// R749
masked_elsewhere_stmt
   :   label? T_ELSE T_WHERE T_LPAREN expr T_RPAREN 
            ( T_IDENT )? end_of_stmt 
   |   label? T_ELSEWHERE T_LPAREN expr T_RPAREN 
            ( T_IDENT )? end_of_stmt 
   ;

// R750
elsewhere_stmt
   :   label? T_ELSE T_WHERE 
            (T_IDENT )? end_of_stmt
   |   label? T_ELSEWHERE (T_IDENT )? 
            end_of_stmt 
   ;

// R751
end_where_stmt
   : label? T_END T_WHERE ( T_IDENT  )? 
        end_of_stmt
   | label? T_ENDWHERE ( T_IDENT  )? 
        end_of_stmt
   ;

// R752
forall_construct
   :   forall_construct_stmt
        ( forall_body_construct )*
        end_forall_stmt
   ;

// R753
forall_construct_stmt
   :    label? ( T_IDENT T_COLON )? 
            T_FORALL_CONSTRUCT_STMT T_FORALL 
            forall_header end_of_stmt
   ;

// R754
forall_header
   : T_LPAREN forall_triplet_spec_list ( T_COMMA expr )? T_RPAREN
   ;

// R755
forall_triplet_spec
   : T_IDENT T_EQUALS expr T_COLON expr ( T_COLON expr )?
   ;

forall_triplet_spec_list
   :       
        forall_triplet_spec  
            ( T_COMMA forall_triplet_spec  )*
   ;

// R756
forall_body_construct
   :   forall_assignment_stmt
   |   where_stmt
   |   where_construct
   |   forall_construct
   |   forall_stmt
   ;

// R757
forall_assignment_stmt
   :   assignment_stmt
   |   pointer_assignment_stmt
   ;

// R758
end_forall_stmt
   : label? T_END T_FORALL ( T_IDENT )? 
        end_of_stmt
   | label? T_ENDFORALL ( T_IDENT )? 
        end_of_stmt
   ;

// R759
// T_FORALL_STMT token is inserted by scanner to remove need for backtracking
forall_stmt
   :   label? T_FORALL_STMT T_FORALL
        forall_header
        forall_assignment_stmt
   ;


/**
 * Section/Clause 8: Execution control
 */


// R801
block
   :   ( execution_part_construct )*
   ;

// R802
if_construct
   :   if_then_stmt block ( else_if_stmt block )* ( else_stmt block )? 
            end_if_stmt
   ;

// R803
if_then_stmt
   : label? ( T_IDENT T_COLON  )? T_IF 
            T_LPAREN expr T_RPAREN T_THEN end_of_stmt
   ;

// R804
else_if_stmt
   : label? T_ELSE T_IF
        T_LPAREN expr T_RPAREN T_THEN ( T_IDENT  )? end_of_stmt
   | label? T_ELSEIF
        T_LPAREN expr T_RPAREN T_THEN ( T_IDENT  )? end_of_stmt
   ;

// R805
else_stmt
   :   label? T_ELSE ( T_IDENT  )? 
            end_of_stmt
   ;

// R806
end_if_stmt
   : label? T_END T_IF ( T_IDENT  )? 
        end_of_stmt
   | label? T_ENDIF    ( T_IDENT  )? 
            end_of_stmt
   ;

// R807
if_stmt
   :   label? T_IF_STMT T_IF T_LPAREN expr T_RPAREN 
            action_stmt
   ;

////////////
// R807-F08
//
block_construct
   :   block_stmt
         specification_part_and_block
       end_block_stmt
   ;

specification_part_and_block
   :   ( use_stmt  )*
       ( import_stmt  )*
       declaration_construct_and_block
   ;

declaration_construct_and_block
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
   |   block 
   ;

////////////
// R808-F08
//
block_stmt
   :   label?
       (T_IDENT T_COLON )?
       T_BLOCK end_of_stmt
   ;

////////////
// R809-F08
//
end_block_stmt
   :   label?
       T_END T_BLOCK (T_IDENT )? end_of_stmt
   |   label?
       T_ENDBLOCK (T_IDENT )? end_of_stmt
   ;

////////////
// R810-F08
//
critical_construct
   :   critical_stmt block end_critical_stmt
   ;

////////////
// R811-F08
//
critical_stmt
   :   label?
       (T_IDENT T_COLON )?
       T_CRITICAL end_of_stmt
   ;

////////////
// R812-F08
//
end_critical_stmt
   :   label?
       T_END T_CRITICAL (T_IDENT )? end_of_stmt
           
   ;

// R808
case_construct
   :    select_case_stmt ( case_stmt block )* end_select_stmt
   ;

// R809
select_case_stmt
   :    label? ( T_IDENT T_COLON )?
        (T_SELECT T_CASE  
           | T_SELECTCASE  )
            T_LPAREN expr T_RPAREN end_of_stmt
   ;

// R810
case_stmt
   :   label? T_CASE case_selector
            ( T_IDENT )? end_of_stmt
   ;

// R811
end_select_stmt
   : label? T_END T_SELECT (T_IDENT )? 
        end_of_stmt
   | label? T_ENDSELECT    (T_IDENT )? 
        end_of_stmt
   ;

// R813
case_selector
   :   T_LPAREN
        case_value_range_list
        T_RPAREN
   |   T_DEFAULT
   ;

// R814
case_value_range
   :   T_COLON case_value
   |   case_value case_value_range_suffix
   ;

case_value_range_suffix
   :   T_COLON ( case_value )?
   |   
   ;

case_value_range_list
   :   case_value_range  ( T_COMMA case_value_range  )*
   ;

// R815
case_value
   :   expr
   ;

// R816
associate_construct
   :   associate_stmt
        block
        end_associate_stmt
   ;

// R817
associate_stmt
   :   label? ( T_IDENT T_COLON )? 
            T_ASSOCIATE T_LPAREN association_list T_RPAREN end_of_stmt
   ;

association_list
   :   association  ( T_COMMA association  )*
   ;

////////////
// R818-F08, R830-F03
//
loop_control
   :   ( T_COMMA )? do_variable T_EQUALS expr T_COMMA expr
       ( T_COMMA expr )?
   |   ( T_COMMA )? T_WHILE T_LPAREN expr T_RPAREN 
   |   ( T_COMMA )? T_CONCURRENT forall_header
   ;

// R818
association
   :   T_IDENT T_EQ_GT selector
   ;

// R819
selector
   :   expr
   ;

// R820
end_associate_stmt
   :   label? T_END T_ASSOCIATE 
            (T_IDENT )? end_of_stmt
   |   label? T_ENDASSOCIATE  
            (T_IDENT )? end_of_stmt
   ;

// R821
select_type_construct
   :   select_type_stmt ( type_guard_stmt block )* end_select_type_stmt
   ;

// R822
// T_IDENT inlined for select_construct_name and associate_name
select_type_stmt
   : label?
        ( T_IDENT T_COLON )? select_type
        T_LPAREN ( T_IDENT T_EQ_GT  )?
        selector T_RPAREN end_of_stmt
   ;

select_type
   : T_SELECT T_TYPE 
   | T_SELECTTYPE 
   ;

// R823
type_guard_stmt
   :   label? T_TYPE T_IDENT 
            T_LPAREN type_spec T_RPAREN
            ( T_IDENT )? end_of_stmt
   |   label? T_CLASS T_IDENT 
            T_LPAREN type_spec T_RPAREN
            ( T_IDENT )? end_of_stmt
   |   label? T_CLASS    T_DEFAULT
        ( T_IDENT )? end_of_stmt
   ;

// R824
end_select_type_stmt
   :   label? T_END T_SELECT 
            ( T_IDENT )? end_of_stmt
   |   label? T_ENDSELECT    
            ( T_IDENT )? end_of_stmt
   ;

// R825
do_construct
   :   block_do_construct
   ;

// R826
block_do_construct
   :   do_stmt
        block
        end_do
   ;

// R827
do_stmt
   :   label? ( T_IDENT T_COLON )? T_DO 
            ( T_DIGIT_STRING )? 
            ( loop_control )? end_of_stmt
   ;

// R828
label_do_stmt
   :   label? ( T_IDENT T_COLON  )? 
            T_DO T_DIGIT_STRING ( loop_control )? 
            end_of_stmt
   ;

// R831
do_variable
   :   T_IDENT
   ;

end_do
   :   end_do_stmt
   |   do_term_action_stmt
   ;

// R834
end_do_stmt
   : label? T_END T_DO ( T_IDENT )? 
            end_of_stmt
   | label? T_ENDDO    ( T_IDENT )? 
            end_of_stmt
   ;

do_term_action_stmt
   :   label T_LABEL_DO_TERMINAL 
        (action_stmt
        | ( (T_END T_DO  | T_ENDDO ) 
                (T_IDENT )?)
                end_of_stmt
        )
   | T_LABEL_DO_TERMINAL_INSERTED
   ;

// R843
cycle_stmt
   :   label? T_CYCLE (T_IDENT )? end_of_stmt
   ;

// R844
exit_stmt
   :   label? T_EXIT (T_IDENT )? end_of_stmt
   ;

// R845
goto_stmt
   :   label?
       (   T_GO T_TO  
       |  T_GOTO    
       )
       T_DIGIT_STRING  end_of_stmt
   ;

// R846
computed_goto_stmt
   :   label?
        (T_GO T_TO  
        | T_GOTO ) 
            T_LPAREN label+ T_RPAREN ( T_COMMA )? expr end_of_stmt
   ;

// The ASSIGN statement is a deleted feature.
assign_stmt 
   :   label? T_ASSIGN label T_TO name end_of_stmt 
   ;

// The assigned GOTO statement is a deleted feature.
assigned_goto_stmt
   :   label? ( T_GOTO 
                  | T_GO T_TO  ) 
            name (T_COMMA stmt_label_list)? end_of_stmt
   ;

// Used with assigned_goto_stmt (deleted feature)
stmt_label_list
   :   T_LPAREN label ( T_COMMA label )* T_RPAREN 
   ;

// The PAUSE statement is a deleted feature.
pause_stmt
   :   label?
       T_PAUSE  (label | char_literal_constant )?  end_of_stmt 
   ;

// R847
arithmetic_if_stmt
   :   label? T_ARITHMETIC_IF_STMT T_IF
        T_LPAREN expr T_RPAREN label
        T_COMMA label
        T_COMMA label end_of_stmt
   ;

// R848 continue_stmt
continue_stmt
   :   label? T_CONTINUE end_of_stmt
   ;

// R849
stop_stmt
   :   label? T_STOP (stop_code )? 
            end_of_stmt
   ;

// R850
stop_code
   : scalar_char_constant
   | T_DIGIT_STRING
   ;

////////////
// R856-F08
//
errorstop_stmt
   :   label? T_ERROR T_STOP (stop_code )? 
       end_of_stmt
   ;

////////////
// R858-F08
//
sync_all_stmt
   :   label? T_SYNC T_ALL
       (T_LPAREN T_RPAREN)? end_of_stmt
   |   label? T_SYNC T_ALL
       T_LPAREN sync_stat_list T_RPAREN end_of_stmt
   ;

////////////
// R859-F08
//
sync_stat
   :   T_IDENT T_EQUALS expr    // expr is a stat-variable or an errmsg-variable
             /*  exprs are variables */
   ;

sync_stat_list
   :   sync_stat  ( T_COMMA sync_stat  )*
   ;

////////////
// R860-F08
//
sync_images_stmt
   :   label? T_SYNC T_IMAGES
       T_LPAREN image_set (T_COMMA sync_stat_list )? T_RPAREN
       end_of_stmt
   ;

////////////
// R861-F08
//
image_set
   :   expr 
   |   T_ASTERISK
   ;

////////////
// R862-F08
//
sync_memory_stmt
   :   label? T_SYNC T_MEMORY
       (T_LPAREN T_RPAREN)? end_of_stmt
   |   label? T_SYNC T_MEMORY
       T_LPAREN sync_stat_list T_RPAREN end_of_stmt
   ;

////////////
// R863-F08
//
lock_stmt
   :    label? T_LOCK T_LPAREN variable
             (T_COMMA lock_stat+ )? T_RPAREN
             end_of_stmt
   ;

////////////
// R864-F08
//
lock_stat 
   :   T_ACQUIRED_LOCK T_EQUALS expr    // expr is a scalar-logical-variable
   |   sync_stat
   ;

////////////
// R865-F08
//
unlock_stmt
   :   label?
       T_UNLOCK T_LPAREN variable (T_COMMA sync_stat_list )?
                T_RPAREN end_of_stmt
   ;

scalar_char_constant
   :    char_constant
   ;


/**
 * Section/Clause 9: Input/output statements
 */


// R901
io_unit
   :   expr
   |   T_ASTERISK
   ;

// R902
file_unit_number
   :   expr
   ;

// R904
open_stmt
   :   label? T_OPEN T_LPAREN connect_spec_list 
            T_RPAREN end_of_stmt
   ;

// R905
connect_spec
   : expr
   | T_IDENT
        /*  are expr */
        /*  is T_DIGIT_STRING */
        /*  are expr */
        /*  are variables */
        /*  are expr */
      T_EQUALS expr
   ;

connect_spec_list
   :   connect_spec  ( T_COMMA connect_spec  )*
   ;

// R908
close_stmt
   :   label? T_CLOSE T_LPAREN close_spec_list 
            T_RPAREN end_of_stmt
   ;

// R909
close_spec
   :   expr
   |   T_IDENT /*  */ T_EQUALS expr
   ;

close_spec_list
   :   close_spec  ( T_COMMA close_spec  )*
   ;

// R910
read_stmt
   :    ((label)? T_READ T_LPAREN) => 
            label? T_READ T_LPAREN io_control_spec_list 
            T_RPAREN ( input_item_list )? end_of_stmt
   |    ((label)? T_READ) => 
            label? T_READ format 
            ( T_COMMA input_item_list )? end_of_stmt
   ;

// R911
write_stmt
   :   label? T_WRITE T_LPAREN io_control_spec_list 
            T_RPAREN ( output_item_list )? end_of_stmt
   ;

// R912
print_stmt
   :    label? T_PRINT format 
            ( T_COMMA output_item_list )? end_of_stmt
   ;

// R913
io_control_spec
       :   expr
                // hasExpression=true
       |   T_ASTERISK
                // hasAsterisk=true
       |   T_IDENT /*  */ T_EQUALS T_ASTERISK
                // hasAsterisk=true
       |   T_IDENT
            /*  are expr 'NML' is T_IDENT} */
            /*  are expr */
            /*  are labels */
            /*  are variables */
            /*  are expr */
        T_EQUALS expr
                // hasExpression=true
   ;

io_control_spec_list
   :   io_control_spec  ( T_COMMA io_control_spec  )*
   ;

// R914
format
   :   expr
   |   T_ASTERISK
   ;

// R915
input_item
   :   variable
   |   io_implied_do
   ;

input_item_list
   :   input_item  ( T_COMMA input_item )*
   ;

// R916
output_item
options {backtrack=true;}
   :   expr
   |   io_implied_do
   ;

output_item_list
   :   output_item  ( T_COMMA output_item )*
   ;

// R917
io_implied_do
   :   T_LPAREN io_implied_do_object io_implied_do_suffix T_RPAREN
   ;

// R918
io_implied_do_object
   :   output_item
   ;

io_implied_do_suffix
   :   T_COMMA io_implied_do_object io_implied_do_suffix
   |   T_COMMA io_implied_do_control
   ;

// R919
io_implied_do_control
   : do_variable T_EQUALS expr T_COMMA expr ( T_COMMA expr )?
   ;

// R920
dtv_type_spec
   :   T_TYPE
        T_LPAREN
        derived_type_spec
        T_RPAREN
   |   T_CLASS
        T_LPAREN
        derived_type_spec
        T_RPAREN
   ;

// R921
wait_stmt
   :   label? T_WAIT T_LPAREN wait_spec_list T_RPAREN 
            end_of_stmt
   ;

// R922
wait_spec
   :   expr
   |   T_IDENT /*  */ 
            T_EQUALS expr
   ;


wait_spec_list
   :   wait_spec  ( T_COMMA wait_spec  )*
   ;

// R923
backspace_stmt
   :   ((label)? T_BACKSPACE T_LPAREN) => 
            label? T_BACKSPACE T_LPAREN position_spec_list 
            T_RPAREN end_of_stmt
   |   ((label)? T_BACKSPACE) => 
            label? T_BACKSPACE file_unit_number end_of_stmt
   ;

// R924
endfile_stmt
   :   ((label)? T_END T_FILE T_LPAREN) => 
            label? T_END T_FILE T_LPAREN position_spec_list 
            T_RPAREN end_of_stmt
   |   ((label)? T_ENDFILE T_LPAREN) => 
            label? T_ENDFILE T_LPAREN position_spec_list 
            T_RPAREN end_of_stmt
   |   ((label)? T_END T_FILE) => 
            label? T_END T_FILE file_unit_number end_of_stmt
   |   ((label)? T_ENDFILE) => 
            label? T_ENDFILE file_unit_number end_of_stmt
   ;

// R925
rewind_stmt
   :   ((label)? T_REWIND T_LPAREN) => 
            label? T_REWIND T_LPAREN position_spec_list 
            T_RPAREN end_of_stmt
   |   ((label)? T_REWIND) => 
            label? T_REWIND file_unit_number end_of_stmt
   ;

// R926
position_spec
   :   expr
   |   T_IDENT /*  */ T_EQUALS expr
   ;

position_spec_list
   :   position_spec  ( T_COMMA position_spec  )*
   ;

// R927
flush_stmt
   :   ((label)? T_FLUSH T_LPAREN) => 
            label? T_FLUSH T_LPAREN flush_spec_list 
            T_RPAREN end_of_stmt
   |   ((label)? T_FLUSH) => 
            label? T_FLUSH file_unit_number end_of_stmt
   ;

// R928
flush_spec
   :   expr
   |   T_IDENT /*  */ T_EQUALS expr
   ;

flush_spec_list
   :   flush_spec  ( T_COMMA flush_spec  )*
   ;

// R929
inquire_stmt
   :   label? T_INQUIRE T_LPAREN inquire_spec_list 
            T_RPAREN end_of_stmt
   |   label? T_INQUIRE_STMT_2 
            T_INQUIRE T_LPAREN T_IDENT /* 'IOLENGTH' */ T_EQUALS 
            scalar_int_variable T_RPAREN output_item_list end_of_stmt
   ;


// R930
inquire_spec
   :   expr
   |   T_IDENT 
        /*  '=' expr portion, '=' designator portion below  */
        T_EQUALS expr
   ;

inquire_spec_list
   :       
        inquire_spec  ( T_COMMA inquire_spec  )*
   ;


/**
 * Section/Clause 10: Input/output editing
 */


// R1001
format_stmt
   :   label? T_FORMAT format_specification end_of_stmt
   ;

// R1002
format_specification
   :   T_LPAREN ( format_item_list )? T_RPAREN
   ;

// R1003
format_item
   :   T_DATA_EDIT_DESC 
   |   T_CONTROL_EDIT_DESC
   |   T_CHAR_STRING_EDIT_DESC
   |   (T_DIGIT_STRING  )? T_LPAREN 
            format_item_list T_RPAREN
   ;

format_item_list
   :   format_item ( (T_COMMA)? format_item  )*
   ;

v_list
   :   (T_PLUS|T_MINUS)? T_DIGIT_STRING
        ( T_COMMA (T_PLUS|T_MINUS)? T_DIGIT_STRING )*
   ;


/**
 * Section/Clause 11: Program units
 */

// R201-F08 program
program
@after
{
   int next = LA(1);
   if (next != ANTLR3_TOKEN_EOF) {
      printf("ERROR return from program: LA(1)==\%d\n", next);
   }
}
   :  program_unit+
   ;

program_unit
   :   main_program
   |   module
   |   subroutine_subprogram
   |   ext_function_subprogram
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
        )
   ;


ext_function_subprogram
   :   (prefix )? function_subprogram
   ;


//========================================================================================
// R1102-F08 program-stmt
//----------------------------------------------------------------------------------------
program_stmt
   :  ^(OFPBeginStmt ^(OFPLabel label?) T_IDENT ^(OFPCommentList OFPComment*))
   ;


//========================================================================================
// R1103-F08 end-program-stmt
//----------------------------------------------------------------------------------------
end_program_stmt
   :  ^(OFPEndStmt ^(OFPLabel label?) T_IDENT?)
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
   ;


//========================================================================================
// R1106-F08 end-program-stmt
//----------------------------------------------------------------------------------------
end_module_stmt
   :   ^(OFPEndStmt ^(OFPLabel label?) T_IDENT? )
   ;


////////////
// R1107-F08
//
module_subprogram_part
   :   contains_stmt
       ( module_subprogram  )*
   ;


////////////
// R1108-F08
//
module_subprogram
   :   (prefix )? function_subprogram
   |   subroutine_subprogram
   |   separate_module_subprogram
   ;


// R1109
use_stmt
   : ^(OFPUseStmt ^(OFPLabel label?) ^(SgInitializedName T_IDENT)
          ^(OFPModuleNature module_nature  ?)
          ^(OFPRenameList   fortran_rename *)
          ^(OFPOnlyList     only           *)
      )
   ;
   

// R1110
module_nature
   :   T_INTRINSIC
   |   T_NON_INTRINSIC
   ;

//========================================================================================
// R1111-F08 rename
//----------------------------------------------------------------------------------------
fortran_rename
   :   T_IDENT T_EQ_GT T_IDENT
   |   T_OPERATOR T_LPAREN T_DEFINED_OP T_RPAREN T_EQ_GT
       T_OPERATOR T_LPAREN T_DEFINED_OP T_RPAREN
   ;

// R1112
only
   :   generic_spec        
   |   fortran_rename      
   ;

////////////
// R1116-F08
//
submodule
   :   submodule_stmt
       specification_part  // non-optional as can be empty
       ( module_subprogram_part  )?
       end_submodule_stmt
   ;

////////////
// R1117-F08
//
submodule_stmt
   :       
       label?
       T_SUBMODULE T_LPAREN parent_identifier T_RPAREN
       name  end_of_stmt
   ;


////////////
// R1118-F08
//
parent_identifier
   :   name 
       ( : T_IDENT  )?
   ;

////////////
// R1119-F08
//
end_submodule_stmt
   :   label?
       T_END (T_SUBMODULE (name )? )?
       end_of_stmt
   ;

// R1116
block_data
   :   block_data_stmt
        specification_part
        end_block_data_stmt
   ;

// R1117
block_data_stmt
   :   label?
       T_BLOCK T_DATA (T_IDENT )? end_of_stmt
   |   label?
       T_BLOCKDATA  (T_IDENT )? end_of_stmt
   ;

// R1118
end_block_data_stmt
   :   label? T_END T_BLOCK T_DATA 
            ( T_IDENT )? end_of_stmt
   |   label? T_ENDBLOCK T_DATA    
            ( T_IDENT )? end_of_stmt
   |   label? T_END T_BLOCKDATA    
            ( T_IDENT )? end_of_stmt
   |   label? T_ENDBLOCKDATA       
            ( T_IDENT )? end_of_stmt
   |   label? T_END end_of_stmt
   ;

/**
 * Section/Clause 12: Procedures
 */

// R1201
interface_block
   :   interface_stmt
        ( interface_specification )*
        end_interface_stmt
   ;

// R1202
interface_specification
   :   interface_body
   |   procedure_stmt
   ;

//========================================================================================
// R1203-F08 interface-stmt
//----------------------------------------------------------------------------------------
interface_stmt
   :   ^(OFPInterfaceStmt ^(OFPLabel label?) ^(OFPGenericSpec generic_spec?))
   ;

//========================================================================================
// R1204-F08 end-interface-stmt
//----------------------------------------------------------------------------------------
end_interface_stmt
   :   ^(OFPEndInterfaceStmt ^(OFPLabel label?) ^(OFPGenericSpec generic_spec?))
   ;

// R1205
interface_body
   :   ^(SgFunctionDeclaration subroutine_stmt end_subroutine_stmt specification_part)
   |     OFPUnimplemented
   ;

// R1206
procedure_stmt
   :   label? ( T_MODULE )? 
            T_PROCEDURE generic_name_list end_of_stmt
   ;

//========================================================================================
// R1207-F08 generic_spec
//----------------------------------------------------------------------------------------
generic_spec
   :   ^(SgInitializedName T_IDENT)
   |     OFPUnimplemented
   ;

// R1208
defined_io_generic_spec
   :   T_READ T_LPAREN T_FORMATTED T_RPAREN
   |   T_READ T_LPAREN T_UNFORMATTED T_RPAREN
   |   T_WRITE T_LPAREN T_FORMATTED T_RPAREN
   |   T_WRITE T_LPAREN T_UNFORMATTED T_RPAREN
   ;

// R1209
import_stmt
   :    label? T_IMPORT ( ( T_COLON_COLON )? 
            generic_name_list )? end_of_stmt
   ;

// R1210
external_stmt
   :   label? T_EXTERNAL ( T_COLON_COLON )? 
            generic_name_list end_of_stmt
   ;

// R1211
procedure_declaration_stmt
   : label? T_PROCEDURE T_LPAREN
        ( proc_interface )? T_RPAREN
        ( ( T_COMMA proc_attr_spec )* T_COLON_COLON )?
        proc_decl_list end_of_stmt
   ;

// R1212
proc_interface
   :   T_IDENT                 
   |   declaration_type_spec   
   ;

// R1213
proc_attr_spec
   :   access_spec
   |   proc_language_binding_spec
   |   T_INTENT T_LPAREN intent_spec T_RPAREN
   |   T_OPTIONAL  
   |   T_POINTER   
   |   T_SAVE      
   |   T_PASS ( T_LPAREN T_IDENT T_RPAREN)?
   |   T_NOPASS
   |   T_DEFERRED
   |   proc_attr_spec_extension
   ;
  
// language extension point
proc_attr_spec_extension : T_NO_LANGUAGE_EXTENSION ;

// R1214
proc_decl
   :   T_IDENT ( T_EQ_GT null_init  )?
   ;

proc_decl_list
   :   proc_decl  ( T_COMMA proc_decl  )*
   ;

// R1216
intrinsic_stmt
   :   label? T_INTRINSIC
        ( T_COLON_COLON )?
        generic_name_list end_of_stmt
   ;

// R1218
call_stmt
   :    label? T_CALL procedure_designator
            ( T_LPAREN (actual_arg_spec_list )? 
            T_RPAREN )? end_of_stmt
   ;

// R1219
procedure_designator
   :   data_ref
   ;

// R1220
actual_arg_spec
   :   (T_IDENT T_EQUALS )? actual_arg
   ;

actual_arg_spec_list
   :   actual_arg_spec  ( T_COMMA actual_arg_spec  )*
   ;

// R1221
actual_arg
   :   expr                
   |   T_ASTERISK label    
   ;

// R1223
function_subprogram
   :   function_stmt
        specification_part
        execution_part ?
        internal_subprogram_part ?
        end_function_stmt
   ;

// R1224
function_stmt
   :   label? T_FUNCTION T_IDENT
            T_LPAREN ( generic_name_list )? T_RPAREN 
            ( suffix )? end_of_stmt
   ;

// R1225
proc_language_binding_spec
   :   language_binding_spec
   ;

// R1227
prefix
   :   prefix_spec +
   ;

t_prefix
   :   t_prefix_spec +
   ;

// R1226-F08
prefix_spec
   :  declaration_type_spec
   |  t_prefix_spec
   ;

t_prefix_spec
   :  T_ELEMENTAL  
   |  T_IMPURE     
   |  T_MODULE     
   |  T_PURE       
   |  T_RECURSIVE  
   |  prefix_spec_extension
   ;

// language extension point
prefix_spec_extension : T_NO_LANGUAGE_EXTENSION ;

// R1229
suffix
   :   proc_language_binding_spec ( T_RESULT T_LPAREN result_name 
            T_RPAREN )?
   |   T_RESULT T_LPAREN result_name T_RPAREN 
            ( proc_language_binding_spec )?
   ;

result_name
   :    name
   ;

// R1230
end_function_stmt
   : label? T_END T_FUNCTION ( T_IDENT )? 
        end_of_stmt
   | label? T_ENDFUNCTION    ( T_IDENT )? 
        end_of_stmt
   | label? T_END end_of_stmt
   ;

// R1231
subroutine_subprogram
   :   ^(SgProcedureHeaderStatement subroutine_stmt end_subroutine_stmt
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
   :   ^(OFPBeginStmt  ^(OFPLabel label?)  T_IDENT                      )
       ^(SgInitializedName                 T_IDENT                      )
       ^(SgFunctionParameterList           dummy_arg *                  )
       ^(OFPPrefixList                     t_prefix ?                   )
       ^(OFPSuffix                         proc_language_binding_spec ? )
   ;

// R1233
dummy_arg
   :   T_IDENT     
   |   T_ASTERISK  
   ;

//========================================================================================
// R1236-F08 end-subroutine-stmt
//----------------------------------------------------------------------------------------
end_subroutine_stmt
   :   ^(OFPEndStmt ^(OFPLabel label?) T_IDENT?)
   ;

// R1235
entry_stmt
   :   label? T_ENTRY T_IDENT
            ( T_LPAREN ( dummy_arg+  )? T_RPAREN 
            ( suffix )? )? end_of_stmt
   ;

// R1236
return_stmt
   :   label? T_RETURN ( expr )? 
            end_of_stmt
   ;


////////////
// R1237-F08
//
separate_module_subprogram
   :   mp_subprogram_stmt
          specification_part  // non-optional as can be empty
          ( execution_part  )?
          ( internal_subprogram_part  )?
       end_mp_subprogram_stmt
   ;

////////////
// R1238-F08
//
mp_subprogram_stmt
   :   label? T_MODULE T_PROCEDURE name end_of_stmt
          
   ;

////////////
// R1239-F08
//
end_mp_subprogram_stmt
   :   label?  T_END  (T_PROCEDURE (name )? )?       end_of_stmt
   |   label?  T_ENDPROCEDURE      (name )?          end_of_stmt
   ;


// R1237
contains_stmt
   :   label?  T_CONTAINS  end_of_stmt
   ;


// R1238
stmt_function_stmt
   :   label? T_STMT_FUNCTION T_IDENT T_LPAREN 
            ( generic_name_list )? T_RPAREN 
            T_EQUALS expr end_of_stmt
   ;


//========================================================================================
// This rule added to allow matching of T_EOS or EOF combination.
//----------------------------------------------------------------------------------------
end_of_stmt
   :  T_EOS
   ;
