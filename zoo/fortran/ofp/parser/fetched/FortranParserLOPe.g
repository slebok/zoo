///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//  FortranParserOFP.g - grammar extensions for the OFP research effort in   //
//  programming models for Fortran.                                          //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

parser grammar FortranParserLOPe;

options {
    language=Java;
    superClass=FortranParser;
    tokenVocab=FortranLexer;
}

import FortranParser08;

@header {
  package fortran.ofp.parser.java;
  import fortran.ofp.parser.java.IActionEnums;
}

@members {
   int gCount1;
   int gCount2;

   public void initialize(String[] args, String kind, String filename, String path) {
      action = FortranParserActionFactory.newAction(args, this, kind, filename);

      initialize(this, action, filename, path);
      gFortranParser08.initialize(this, action, filename, path);

      action.start_of_file(filename, path);
   }

   public void eofAction() {
      gFortranParser08.eofAction();
   }

   public boolean isTPrefixSpec(int token) {
      if (token == FortranLexer.T_CONCURRENT) return true;
      else return super.isTPrefixSpec(token);
   }

} // end members


/**
 * Section/Clause 1: Overview
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


////////////
// R204-F08
//
specification_part
@init{int numUseStmts=0; int numImportStmts=0; gCount1=0; gCount2=0;}
   :   ( use_stmt {numUseStmts++;} )*
       ( import_stmt {numImportStmts++;} )*
       implicit_part_recursion // making nonoptional with predicates fixes ambiguity
       ( declaration_construct {gCount2++;} )*
           {action.specification_part(numUseStmts, numImportStmts, gCount1, gCount2);}
   ;

/*
 * R205-F08   implicit-part           is [ implicit-part-stmt ] ...
 *                                       implicit-stmt
 */

/*
 * R206-F08   implicit-part-stmt      is implicit-stmt
 *                                    or parameter-stmt
 *                                    or format-stmt
 *                                    or entry-stmt
 */

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

////////////
// R213-F08
//
executable_construct
@after {action.executable_construct();}
   :   action_stmt
   |   associate_construct
   |   block_construct                 // NEW_TO_2008
   |   case_construct
   |   critical_construct              // NEW_TO_2008
   |   do_construct
   |   forall_construct
   |   if_construct
   |   select_type_construct
   |   where_construct
   ;

/*
 * R214-F08 action-stmt
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

////////////
// R214-F08
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
action_stmt
@after {action.action_stmt();}
// Removed backtracking by inserting extra tokens in the stream by the prepass
// that signals whether we have an assignment-stmt, a pointer-assignment-stmt,
// or an arithmetic if.  This approach may work for other parts of backtracking
// also.  However, need to see if there is a way to define tokens w/o defining
// them in the lexer so that the lexer doesn't have to add them to it's parsing.
//  02.05.07
   :   allocate_stmt
   |   assignment_stmt
   |   backspace_stmt
   |   call_stmt
   |   close_stmt
   |   continue_stmt
   |   cycle_stmt
   |   deallocate_stmt
//////////
// These end functions are not needed because the initiating constructs are called
// explicitly to avoid ambiguities.
//   |   end_function_stmt
//   |   end_mp_subprogram_stmt        // NEW_TO_2008
//   |   end_program_stmt
//   |   end_subroutine_stmt
   |   endfile_stmt
   |   errorstop_stmt                // NEW_TO_2008
   |   exit_stmt
   |   flush_stmt
   |   forall_stmt
   |   goto_stmt
   |   if_stmt
   |   inquire_stmt  
   |   lock_stmt                     // NEW_TO_2008
   |   nullify_stmt
   |   open_stmt
   |   pointer_assignment_stmt
   |   print_stmt
   |   read_stmt
   |   return_stmt
   |   rewind_stmt
   |   stop_stmt
   |   sync_all_stmt                 // NEW_TO_2008
   |   sync_images_stmt              // NEW_TO_2008
   |   sync_memory_stmt              // NEW_TO_2008
   |   unlock_stmt                   // NEW_TO_2008
   |   wait_stmt
   |   where_stmt
   |   write_stmt
   |   arithmetic_if_stmt
   |   computed_goto_stmt
   |   assign_stmt                   // ADDED?
   |   assigned_goto_stmt            // ADDED?
   |   pause_stmt                    // ADDED?
   |   exchange_halo_stmt            // LOPe extension
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

// R501
type_declaration_stmt
@init {Token lbl = null; int numAttrSpecs = 0;}
@after{checkForInclude();}
    :   (label {lbl=$label.tk;})? declaration_type_spec
        ( (T_COMMA attr_spec {numAttrSpecs += 1;})* T_COLON_COLON )?
        entity_decl_list end_of_stmt
            { action.type_declaration_stmt(lbl, numAttrSpecs, $end_of_stmt.tk); }
    ;

// language extension point
//
other_spec_stmt_extension
@init {
   Token lbl=null;
   boolean hbs = false;
   boolean hcf = false;
   int count=1;
}
@after{checkForInclude();}
   :   (label {lbl=$label.tk;})?
       T_HALO
       (
         (  (T_COMMA T_BOUNDARY T_LPAREN halo_boundary_spec T_RPAREN {hbs=true;})?
            (T_COMMA                     halo_copy_fn                {hcf=true;})?
         )
         T_COLON_COLON
       )?
       halo_decl ( T_COMMA halo_decl {count++;})* end_of_stmt
           { action.lope_halo_stmt(lbl, $T_HALO, hbs, hcf, $end_of_stmt.tk, count); }
   ;

exchange_halo_stmt
@init {Token lbl=null;}
@after{checkForInclude();}
   :   //(label {lbl=$label.tk;})?
       T_EXCHANGE_HALO T_LPAREN expr T_RPAREN end_of_stmt
           { action.lope_exchange_halo_stmt(lbl, $T_EXCHANGE_HALO, $end_of_stmt.tk); }
   ;

halo_copy_fn
@init{int count=0;}
   :   T_COPY_FN T_EQUALS T_IDENT
           {action.lope_halo_copy_fn($T_IDENT);}
   ;

halo_boundary_spec
@init{int count=0;}
   :   halo_boundary_spec_element {count++;}
       (T_COMMA halo_boundary_spec_element {count++;})*
           {action.lope_halo_boundary_spec(count);}
   ;

halo_boundary_spec_element
@init{int type=IActionEnums.HaloSpecElement_expr_colon_asterisk_colon_expr;}
   :   expr T_COLON
            T_ASTERISK
            T_COLON
       expr
            {
                type = IActionEnums.HaloBoundarySpecElement_expr_colon_asterisk_colon_expr;
                action.lope_halo_boundary_spec_element(type);
            }
   |   T_CYCLIC
            {
                type = IActionEnums.HaloBoundarySpecElement_cyclic;
                action.lope_halo_boundary_spec_element(type);
            }
   ;

halo_decl
@init{boolean hasHaloSpec=false;}
   :   T_IDENT ( T_LPAREN halo_spec T_RPAREN {hasHaloSpec=true;})?
           {action.lope_halo_decl($T_IDENT,hasHaloSpec);}
   ;

// Extension for the HALO attribute for dummy argument type declarations
// in CONCURRENT procedures.  From R502-F08, R503-F03.
//
attr_spec_extension
    :  T_HALO T_LPAREN halo_spec T_RPAREN
           {action.attr_spec($T_HALO, IActionEnums.AttrSpec_HALO);}
    ;

halo_spec
@init{int count=0;}
   :   halo_spec_element {count++;}
       (T_COMMA halo_spec_element {count++;})*
           {action.lope_halo_spec(count);}
   ;

// A halo specification is simple compared to an array spec
// Types: 	0 expr:*:expr (e.g. 1:*:1)
// 			1 expr (perhaps, expr value would be for both sides of halo)?
halo_spec_element
@init{int type=IActionEnums.HaloSpecElement_expr_colon_asterisk_colon_expr;}
   :   expr T_COLON
            T_ASTERISK
            T_COLON
       expr
               { action.lope_halo_spec_element(type); }
   |   T_COLON
               { action.lope_halo_spec_element(IActionEnums.HaloSpecElement_colon); }
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

/*
 * R612-F08 part-ref
 *    is part-name [ ( section-subscript-list ) ] [ image-selector]
 */

////////////
// R612-F08, R613-F03
//
// This rule is implemented in FortranParserExtras grammar
//
// T_IDENT inlined for part_name
// with k=2, this path is chosen over T_LPAREN substring_range T_RPAREN
// TODO error: if a function call, should match id rather than 
// (section_subscript_list)
// a = foo(b) is ambiguous YUK...
part_ref
options {k=2;}
@init{boolean hasSSL = false; boolean hasImageSelector = false;}
   :   (T_IDENT T_LPAREN) => T_IDENT T_LPAREN section_subscript_list T_RPAREN
                             (image_selector {hasImageSelector=true;})?
           {hasSSL=true; action.part_ref($T_IDENT, hasSSL, hasImageSelector);}
   |   (T_IDENT T_LBRACKET) => T_IDENT image_selector
           {hasImageSelector=true; action.part_ref($T_IDENT, hasSSL, hasImageSelector);}
   |   T_IDENT
           {action.part_ref($T_IDENT, hasSSL, hasImageSelector);}
   ;

part_ref_no_image_selector
options{k=2;}
@init{boolean hasSSL = false; boolean hasImageSelector = false;}
   :   (T_IDENT T_LPAREN) => T_IDENT T_LPAREN section_subscript_list T_RPAREN
           {hasSSL=true; action.part_ref($T_IDENT, hasSSL, hasImageSelector);}
   |   T_IDENT
           {action.part_ref($T_IDENT, hasSSL, hasImageSelector);}
   ;


/**
 * R620-F08 section-subscript
 *    is subscript
 *    or subscript-triplet
 *    or vector-subscript
 */

////////////
// R620-F08, R619-F03
//
// expr inlined for subscript, vector_subscript, and stride (thus deleted option 3)
// refactored first optional expr from subscript_triplet modified to also match
// actual_arg_spec_list to reduce ambiguities and need for backtracking
section_subscript returns [boolean isEmpty]
@init {
   boolean hasLowerBounds = false;
   boolean hasUpperBounds = false;
   boolean hasStride = false;
   boolean hasExpr = false;
}
   :   expr section_subscript_ambiguous
   |   T_COLON (expr {hasUpperBounds=true;})? (T_COLON expr {hasStride=true;})?
           { action.section_subscript(hasLowerBounds, hasUpperBounds, hasStride, false); }
   |   T_COLON_COLON expr
           { hasStride=true;
             action.section_subscript(hasLowerBounds, hasUpperBounds, hasStride, false);}
   |   T_IDENT T_EQUALS expr	// could be an actual-arg, see R1220
           { hasExpr=true; action.actual_arg(hasExpr, null); 
             action.actual_arg_spec($T_IDENT); }
   |   T_IDENT T_EQUALS T_ASTERISK label // could be an actual-arg, see R1220
           { action.actual_arg(hasExpr, $label.tk); action.actual_arg_spec($T_IDENT); }
   |   T_ASTERISK label /* could be an actual-arg, see R1220 */
           { action.actual_arg(hasExpr, $label.tk); action.actual_arg_spec(null); }
   |       { isEmpty = true; /* empty could be an actual-arg, see R1220 */ }
   ;

section_subscript_ambiguous
@init {
   boolean hasLowerBound = true;
   boolean hasUpperBound = false;
   boolean hasStride = false;
   boolean isAmbiguous = false; 
}
   :   T_COLON (expr {hasUpperBound=true;})? (T_COLON expr {hasStride=true;})?
           { action.section_subscript(hasLowerBound, hasUpperBound, hasStride, isAmbiguous);}
       // this alternative is necessary because if alt1 above has no expr
       // following the first : and there is the optional second : with no 
       // WS between the two, the lexer will make a T_COLON_COLON token 
       // instead of two T_COLON tokens.  in this case, the second expr is
       // required.  for an example, see J3/04-007, Note 7.44.
   |  T_COLON_COLON expr
           { hasStride=true; 
             action.section_subscript(hasLowerBound, hasUpperBound, hasStride, isAmbiguous);}
   |       { /* empty, could be an actual-arg, see R1220 */
             isAmbiguous=true; 
             action.section_subscript(hasLowerBound, hasUpperBound, hasStride, isAmbiguous);
           }
   ;


/**
 * R620-F08 section-subscript
 *    is subscript
 *    or subscript-triplet
 *    or vector-subscript
 */

////////////
// R620-F08 list
//
// This rule must be kept here with part-ref, otherwise parsing errors will occur.
// It is unknown why this happens.
//
section_subscript_list
@init{int count = 0;}
   :       { action.section_subscript_list__begin(); }
       isEmpty=section_subscript
           {
               if (isEmpty == false) count += 1;
           }
       (T_COMMA section_subscript {count += 1;})*
           { action.section_subscript_list(count); }
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
           {action.image_selector($T_LBRACKET, $T_RBRACKET);}
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
   :       {action.cosubscript_list__begin();}
       cosubscript {count++;} ( T_COMMA cosubscript {count++;} )*
           {action.cosubscript_list(count, null);}
   ;

/*
 * R631-08 allocation
 *    is allocate-object [ ( allocate-shape-spec-list ) ]
 *                       [ lbracket allocate-coarray-spec rbracket ]  // NEW_TO_2008
 */

////////////
// R631-F08, R628-F03
//
// C644 (R632) An allocate-object shall not be a coindexed object.
//

// SAD NOTE 1: In ROSE, there is no IR for allocations. That is, there is no place in the AST to hold the
// 'allocate_shape_spec_list' and 'allocate_coarray_spec' if any. The only way to preserve them is
// to encode them in the 'allocate_object' itself, i.e. as part of an expression.

// SAD NOTE 2: In this rule, an 'allocate_shape_spec_list' would never be recognized. Its corresponding action
// 'action.allocate_shape_spec' is a no-op in ROSE. Shape specs are parsed by the 'allocate_object' rule
// as a section subscript list within a part ref. Sigh! On the other hand, this is just as well because
// there is no other way to represent the shape specs (see Sad Note 1).

allocation
@init{boolean hasAllocateShapeSpecList = false; boolean hasAllocateCoarraySpec = false;}
   :   (allocate_object T_LBRACKET)
          => allocate_object T_LBRACKET allocate_coarray_spec T_RBRACKET
                 {hasAllocateCoarraySpec=true;}
                 {action.allocation(hasAllocateShapeSpecList, hasAllocateCoarraySpec);}
// This option (with allocate_shape_spec_list) is caught by the allocate object.  If so,
// the section-subscript-list must be changed into a allocate-shape-spec-list)
//
//   |   (allocate_object T_LPAREN)
//          => allocate_object T_LPAREN allocate_shape_spec_list {hasAllocateShapeSpecList=true;}
//                             T_RPAREN
//                             T_LBRACKET allocate_coarray_spec {hasAllocateCoarraySpec=true;}
//                             T_RBRACKET
//                 {action.allocation(hasAllocateShapeSpecList, hasAllocateCoarraySpec);}
   |   (allocate_object)
          => allocate_object
                 {action.allocation(hasAllocateShapeSpecList, hasAllocateCoarraySpec);}
   ;


/**
 * R632-F08 allocate-object
 *    is variable-name
 *    structure-component
 */

////////////
// R636-F08, R629-F03
//
// C644 (R632) An allocate-object shall not be a coindexed object.
//
// T_IDENT inlined for variable_name
// data_ref inlined for structure_component
// data_ref isa T_IDENT so T_IDENT deleted
// data_ref inlined and part_ref_no_image_selector called directly
//
allocate_object
@init{int numPartRefs = 0;}
   :   part_ref_no_image_selector {numPartRefs += 1;}
       (T_PERCENT part_ref_no_image_selector {numPartRefs += 1;})*
           {action.data_ref(numPartRefs); action.allocate_object();}
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
@after {action.allocate_coarray_spec();}
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


/**
 * Section/Clause 12: Procedures
 */

// Extension allowing CONCURRENT as a prefix-spec enabling syntax
// for CONCURRENT procedures.  Extending R1226-F2008.
//
prefix_spec_extension
   :  T_CONCURRENT
          {action.t_prefix_spec($T_CONCURRENT);}
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
          { action.lock_variable(); }
   ;

