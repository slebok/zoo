/*
  Author: Christian Wulf
  E-Mail: chwchw@gmx.de

  Preprocessor semantics:
  - Chapter 9.5.1: "An implication of this is that #define and #undef directives in one
    source file have no effect on other source files in the same program."
*/

lexer grammar CSharp4PreProcessor;

options {
  language = Java;
}

import CSharp4Lexer;

@lexer::header {
package lang.csharp;

import java.util.Deque;
import java.util.LinkedList;
import java.util.Set;
import java.util.HashSet;
import java.util.Queue;
import java.util.regex.Pattern;
}

@lexer::members {
// if-then-else hierarchy controlling
protected Deque<Boolean> ifStack = new LinkedList<Boolean>();

// return value is only used for debugging purposes
protected boolean push(boolean expr) {
  /* if we are already within a block that should not be parsed due to current macro defs,
      do not parse the child if-section */
  if (!ifStack.peek()) {
    ifStack.push(false);
    return false;
  } else {
    ifStack.push(expr);
    return expr;
  }
  
  //boolean newTopValue = expr && ifStack.peek();
  //ifStack.push(newTopValue);
  //return newTopValue;
}

protected boolean pop() {
  return ifStack.pop();
}

// static and dynamic macro definition controlling
protected Set<String> definedMacros = new HashSet<String>();

protected void define(final String conditionSymbol) {
  definedMacros.add(conditionSymbol);
}
  
protected void undefine(final String conditionSymbol) {
  definedMacros.remove(conditionSymbol);
}
  
protected boolean isDefined(final String conditionSymbol) {
  return definedMacros.contains(conditionSymbol);
}

// the following methods are only used for debug purposes
private List<String> errors = new LinkedList<String>();

@Override
public void displayRecognitionError(String[] tokenNames, RecognitionException e) {
    super.displayRecognitionError(tokenNames, e);
    String hdr = getErrorHeader(e);
    String msg = getErrorMessage(e, tokenNames);
    errors.add(hdr + " " + msg);
}

public List<String> getErrors() {
    return errors;
}

private void next(int n) {
  System.err.print("next: ");
  for (int i=1; i<=n; i++) {
    System.err.print(" | " + input.LA(i));
  }
  System.err.println();
}

}

//B.1.10 Pre_processing Directives
Pp_directive
  : (Pp_declaration
  | Pp_conditional
  | Pp_line
  | Pp_diagnostic
  | Pp_region
  | Pp_pragma
  ) {$channel=HIDDEN; }
  ;
fragment Pp_expression[Expression exprObj]
@init { Expression expr = new Expression(); }
  : WHITESPACE? Pp_or_expression[exprObj] WHITESPACE?
  ;
fragment Pp_or_expression[Expression exprObj]
@init { Expression expr = new Expression(); }
  : Pp_and_expression[expr] {exprObj.set(expr); } WHITESPACE?
    ('||' WHITESPACE? Pp_and_expression[expr] {exprObj.or(exprObj, expr);} )*
  ;
fragment Pp_and_expression[Expression exprObj]
@init { Expression expr = new Expression(); }
  : Pp_equality_expression[expr] {exprObj.set(expr);} WHITESPACE? 
    ('&&' WHITESPACE? Pp_equality_expression[expr] WHITESPACE? {exprObj.and(exprObj, expr);} )*
  ;
fragment Pp_equality_expression[Expression exprObj]
@init { Expression expr = new Expression(); }
  : Pp_unary_expression[expr] {exprObj.set(expr);} WHITESPACE?
    ( '==' WHITESPACE? Pp_unary_expression[expr] WHITESPACE? {exprObj.equal(exprObj, expr);}
    | '!=' WHITESPACE? Pp_unary_expression[expr] WHITESPACE? {exprObj.unequal(exprObj, expr);}
    )*
  ;
fragment Pp_unary_expression[Expression exprObj]
@init { Expression expr = new Expression(); }
  : Pp_primary_expression[expr] {exprObj.set(expr);}
  | '!' WHITESPACE? Pp_unary_expression[expr] {exprObj.not(expr);}
  ;
fragment Pp_primary_expression[Expression exprObj]
  : (TRUE) => TRUE {exprObj.set(true);}
  | (FALSE) => FALSE {exprObj.set(false);}
  | Conditional_symbol {exprObj.set(isDefined($Conditional_symbol.text)); }
  | '(' Pp_expression[exprObj] ')'
  ;
fragment Pp_declaration
  : WHITESPACE? SHARP WHITESPACE? 'define' WHITESPACE Conditional_symbol Pp_new_line
    {define($Conditional_symbol.text); }
  | WHITESPACE? SHARP WHITESPACE? 'undef' WHITESPACE Conditional_symbol Pp_new_line
    {undefine($Conditional_symbol.text); }
  ;
fragment Pp_new_line
  : WHITESPACE? SINGLE_LINE_COMMENT? NEW_LINE
  ;
// changed by chw
fragment Pp_conditional
  : Pp_if_section
  | Pp_elif_section
  | Pp_else_section
  | Pp_endif
  ;
fragment Pp_if_section
@init {Expression exprObj = new Expression();}
  : WHITESPACE? SHARP WHITESPACE? 'if' WHITESPACE e=Pp_expression[exprObj] Pp_new_line
      {boolean p=push(exprObj.isExpression());
        /*System.err.println("#if "+$e.text+" -> "+exprObj.isExpression());*/ }
  ;
fragment Pp_elif_section
@init {Expression exprObj = new Expression();}
  : WHITESPACE? SHARP WHITESPACE? 'elif' WHITESPACE Pp_expression[exprObj] Pp_new_line
  // if the if/elif-sections before has not been processed and expr is true
      {push(!pop() && exprObj.isExpression()); }
  ;
fragment Pp_else_section
  : WHITESPACE? SHARP WHITESPACE? 'else' Pp_new_line
  // if the if/elif-sections before has not been processed
      {push(!pop()); }
  ;
fragment Pp_endif
  : WHITESPACE? SHARP WHITESPACE? 'endif' Pp_new_line
      {boolean p=pop(); /*System.err.println("endif: "+p); System.err.println("head: "+ifStack.peek());*/ }
  ;
//'<Any Identifier_or_keyword Except True Or False>'
// WARNING: ignores exclusion
fragment Conditional_symbol
  : Identifier_or_keyword
  ;
fragment Pp_diagnostic
  : WHITESPACE? SHARP WHITESPACE? 'error' Pp_message
  | WHITESPACE? SHARP WHITESPACE? 'warning' Pp_message
  ;
fragment Pp_message
  : NEW_LINE
  | WHITESPACE Input_character* NEW_LINE
  ;
// changed by chw
fragment Pp_region
  : Pp_start_region
  | Pp_end_region
  ;
fragment Pp_start_region
  : WHITESPACE? SHARP WHITESPACE? 'region' Pp_message
  ;
fragment Pp_end_region
  : WHITESPACE? SHARP WHITESPACE? 'endregion' Pp_message?
  ;
fragment Pp_line
  : WHITESPACE? SHARP WHITESPACE? 'line' WHITESPACE Line_indicator Pp_new_line
  ;
fragment Line_indicator
  : Decimal_digits (WHITESPACE File_name)?
  | 'default'
  | 'hidden'
  ;
fragment File_name
  : DOUBLE_QUOTE File_name_characters DOUBLE_QUOTE
  ;
fragment File_name_characters
  : File_name_character+
  ;
//'<Any input_character Except ">'
fragment File_name_character
  : ~( NEW_LINE_CHARACTER | DOUBLE_QUOTE )
  ;
// We use a more flexible pragma expression that also supports C# versions below 4.0
fragment Pp_pragma
  : WHITESPACE? SHARP WHITESPACE? 'pragma' Pp_pragma_text
  ;
fragment Pp_pragma_text
  : NEW_LINE?
  | WHITESPACE Input_characters? NEW_LINE?
  ;

// -----------------------------------------------------------------------------------------------------

// the following preprocessor rules are only invoked by the extended Lexer class
// Hint: tokens need not to be skipped because they are matched within fragment rules
//   who in turn do not produce tokens by themselves
fragment SkiPped_section_part
  : WHITESPACE? SkiPped_characters? NEW_LINE
  | Pp_directive
  ;
fragment SkiPped_characters
  : Not_number_sign Input_character*
  ;
//'<Any Input_character Except #>'
// added Whitespace_character to solve warning in SkiPped_characters
fragment Not_number_sign
  : ~( Whitespace_character | NEW_LINE_CHARACTER | SHARP )
  ;

  