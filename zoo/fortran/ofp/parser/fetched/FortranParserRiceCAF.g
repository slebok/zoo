///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//  FortranParserRiceCAF.g - grammar extensions for the CAF 2.0 translator   //
//                                                                           //
//  Copyright ((c)) 2008-2011, Rice University.                              //
//  All rights reserved. See the file "LICENSE" for details.                 //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////


parser grammar FortranParserRiceCAF;

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
   |   rice_with_team_construct
   |   rice_finish_construct
   |   rice_spawn_stmt
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
    :	(label {lbl=$label.tk;})? rice_declaration_type_spec
		( (T_COMMA attr_spec {numAttrSpecs += 1;})* T_COLON_COLON )?
		entity_decl_list end_of_stmt
    		{ action.type_declaration_stmt(lbl, numAttrSpecs, $end_of_stmt.tk); }
    ;

// Copointer extensions to rules R503(F03)/R502(F08), R441(F03)/R437(F08), R1213(F080)
// Note that in F08 the 'TARGET' attribute can only appear in 'attr-spec's,
// so we make the same decision for our new 'COTARGET' attribute.
attr_spec_extension
    :  T_COPOINTER
           {action.attr_spec($T_COPOINTER, IActionEnums.AttrSpec_COPOINTER);}
    |  T_COTARGET
           {action.attr_spec($T_COTARGET, IActionEnums.AttrSpec_COTARGET);}
    ;
component_attr_spec_extension
    :  T_COPOINTER
           {action.attr_spec($T_COPOINTER, IActionEnums.AttrSpec_COPOINTER);}
    ;
proc_attr_spec_extension
    :  T_COPOINTER
           {action.attr_spec($T_COPOINTER, IActionEnums.AttrSpec_COPOINTER);}
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


////////////
// Rice extension for copointer dereferencing
////////////

// This rule is written so that the 'part_ref' action's signature doesn't change between F08 and CAF2.
// and so the action sequence is not quite natural when a co-deref-op is present.
part_ref
@init{boolean hasSSL = false; boolean hasImageSelector = false;}
   :  (T_IDENT T_LPAREN) =>
           T_IDENT T_LPAREN section_subscript_list T_RPAREN
           (image_selector {hasImageSelector=true;})?
               {hasSSL=true; action.part_ref($T_IDENT, hasSSL, hasImageSelector);}
   |  (T_IDENT T_LBRACKET T_RBRACKET ) =>
           T_IDENT T_LBRACKET T_RBRACKET
           ( (T_LPAREN) => T_LPAREN section_subscript_list T_RPAREN  {hasSSL=true;} )?
           (image_selector {hasImageSelector=true;})?
               {action.part_ref($T_IDENT, hasSSL, hasImageSelector); action.rice_co_dereference_op($T_LBRACKET, $T_RBRACKET);}
   |  (T_IDENT T_LBRACKET) =>
           T_IDENT image_selector
               {hasImageSelector=true; action.part_ref($T_IDENT, hasSSL, hasImageSelector);}
   |       T_IDENT
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


/* alternate syntax for co-dereferencing

part_ref
@init{boolean hasCoDeref = false; }
   :  part_ref (rice_co_dereference_op {hasCoDeref=true;})?
          {action.part_ref(hasCoDeref);}
   ;
   
rice_co_dereference_op
   :   T_LBRACKET T_RBRACKET
           {action.rice_co_dereference_op($T_LBRACKET, $T_RBRACKET);}
   ;
*/


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
 * R631-08 allocation
 *    is allocate-object [ ( allocate-shape-spec-list ) ]
 *                       [ lbracket allocate-coarray-spec rbracket ]  // NEW_TO_2008
 */

////////////
// R631-F08, R628-F03
//

// SAD NOTE 1: In ROSE, there is no IR for allocations. That is, there is no place in the AST to hold the
// 'allocate_shape_spec_list' and 'rice_allocate_coarray_spec' if any. The only way to preserve them is
// to encode them in the 'allocate_object' itself, i.e. as part of an expression.

// SAD NOTE 2: In this rule, the 'allocate_shape_spec_list' is never recognized. Its corresponding action
// 'action.allocate_shape_spec' is a no-op in ROSE. Shape specs are parsed by the 'allocate_object' rule
// as a section subscript list within a part ref. Sigh! On the other hand, this is just as well because
// there is no other way to represent the shape specs (see Sad Note 1).

// SAD NOTE 3: In this rule, the 'rice_allocate_coarray_spec' *is* in fact parsed. Coshape specs do not
// get parsed by 'allocate_object' because it looks for a 'partref_no_image_selector' instead of a part ref.
// However, there is still no good place to represent the coshape specs (see Sad Note 1), so instead the
// action 'action.rice_allocate_coarray_spec' builds a coarray reference node containing them. Sigh!

allocation
@init{boolean hasAllocateShapeSpecList = false; boolean hasAllocateCoarraySpec = false;}
   :   allocate_object
     ( T_LPAREN allocate_shape_spec_list {hasAllocateShapeSpecList=true;} T_RPAREN )?
     ( T_LBRACKET rice_allocate_coarray_spec {hasAllocateCoarraySpec=true;} T_RBRACKET )?
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
//       part_ref {numPartRefs += 1;}
//       (T_PERCENT part_ref {numPartRefs += 1;})*
           {action.data_ref(numPartRefs); action.allocate_object();}
   ;


/*
 * R636-F08 allocate-coarray-spec
 *    is   [ allocate-coshape-spec-list , ] [ lower-bound-expr : ] *
 */

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


/*
 * Section/Clause 11: Program units
 */



//----------------------------------------------------------------------------
// RICE CO-ARRAY FORTRAN RULES
//----------------------------------------------------------------------------

rice_allocate_coarray_spec
@init{Token id = null;}
  :
    (T_ASTERISK) => T_ASTERISK
        { action.rice_allocate_coarray_spec(0, null); }
  |
//  (expr T_COLON T_ASTERISK) => expr T_COLON T_ASTERISK
//|
    T_AT (T_IDENT {id=$T_IDENT;})?
        { action.rice_allocate_coarray_spec(1, id); }
  |
    // TEMPORARY: accept old empty version for legacy code's allocate-stmts
    /* empty */
        { action.rice_allocate_coarray_spec(1, null); }
  ;

rice_with_team_construct
	: rice_with_team_stmt block rice_end_with_team_stmt
	;
	
rice_with_team_stmt
@init{Token lbl = null;}
	:	
	  (label {lbl=$label.tk;})?
	  (T_WITHTEAM | T_WITH T_TEAM) T_IDENT
	  end_of_stmt
	      { action.rice_co_with_team_stmt(lbl, $T_IDENT); }
	;
	
rice_end_with_team_stmt
@init{Token lbl = null; Token id = null;}
	 : 
	   (label {lbl=$label.tk;})?
	   T_END (T_WITHTEAM | T_WITH T_TEAM) (T_IDENT {id=$T_IDENT;})?
	   end_of_stmt
	      {action.rice_end_with_team_stmt(lbl, id, $end_of_stmt.tk);}
	;

// R403 (rice version)
rice_intrinsic_type_spec
	:	
		       T_LOCKSET {action.intrinsic_type_spec($T_LOCKSET, null,
                                        IActionEnums.IntrinsicTypeSpec_LOCKSET,
                                        false);}
        |       T_LOCK {action.intrinsic_type_spec($T_LOCK, null,
                                        IActionEnums.IntrinsicTypeSpec_LOCK,
                                        false);}
        |       T_TEAM {action.intrinsic_type_spec($T_TEAM, null,
                                        IActionEnums.IntrinsicTypeSpec_TEAM,
                                        false);}
        |       T_TOPOLOGY {action.intrinsic_type_spec($T_TOPOLOGY, null,
                                        IActionEnums.IntrinsicTypeSpec_TOPOLOGY,
                                        false);}
        |       T_EVENT {action.intrinsic_type_spec($T_EVENT, null,
                                        IActionEnums.IntrinsicTypeSpec_EVENT,
                                        false);}
	;


// R502 (rice version)
rice_declaration_type_spec
	:	// original F03 rule
		declaration_type_spec 	
	|   // rice CAF 2.0 rules
		rice_intrinsic_type_spec
			{ action.declaration_type_spec(null, 
                IActionEnums.DeclarationTypeSpec_INTRINSIC); }
	;


/*
 * R625-F08 cosubscript
 *    is scalar-int-expr
 */

////////////
// R625-F08
//
/*** TODO: sadly, this accepts some allocate-coarray-specs:
 in 'allocate( a[@t] )', and in 'allocate( a[*] )'
  -- see SAD NOTE at rule for 'allocation' ***/
cosubscript
     :   expr
   ;

cosubscript_list
@init{
 int count=0;
 Token idTeam=null;
 }
  :  {action.cosubscript_list__begin();}
     ( cosubscript {count++;} ( T_COMMA cosubscript {count++;} )* )?
     (T_AT T_IDENT {idTeam=$T_IDENT;})?
     {
       action.cosubscript_list(count, idTeam);
     }
  ;


rice_finish_construct
  : rice_finish_stmt block rice_end_finish_stmt
  ;
  
  
rice_finish_stmt
@init{Token lbl = null; Token idTeam = null;}
  : 
  (label {lbl=$label.tk;})?
  T_FINISH ( T_IDENT {idTeam=$T_IDENT;} )?
  end_of_stmt
  {
    action.rice_finish_stmt(lbl, idTeam, $end_of_stmt.tk);
  }
  ;
  

rice_end_finish_stmt
@init{Token lbl = null;}
  : 
  (label {lbl=$label.tk;})?
  T_END T_FINISH
  end_of_stmt
  {
    action.rice_end_finish_stmt(lbl, $end_of_stmt.tk);
  }
  ;


rice_spawn_stmt
@init {Token lbl = null; boolean hasEvent = false;} 
@after{checkForInclude();}
  :
  (label {lbl=$label.tk;})?
  T_SPAWN ( T_LPAREN expr T_RPAREN {hasEvent=true;})?
  procedure_designator // includes actual parameter list and cosubscript, sigh
  // T_LBRACKET expr (T_AT T_IDENT)? T_RBRACKET
  end_of_stmt
  {
    action.rice_spawn_stmt(lbl, $T_SPAWN, $end_of_stmt.tk, hasEvent);
  }
  ;


///////////////////////////////////////////////////////////////////////////////
// THESE RULES ARE COPIED FROM FORTRAN-PARSER-EXTRAS ONLY BECAUSE WE ARE     //
// CURRENTLY IMPORTING FORTRAAN-PARSER-08 INSTEAD. FIX THIS.                 //
///////////////////////////////////////////////////////////////////////////////


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



