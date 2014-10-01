grammar Clojure;

options {
  language = Java;
  output = AST;
}

tokens {
  CALL;
  
  DEREF = '@';
  DEF = 'def';
  DEFN = 'defn';
  
  FN = 'fn';
  
  IMPORT = 'import';
  IN_NS = 'in-ns';
  
  LAMBDA = '#(';
  LET = 'let';
  LIST;
  
  MAP;
  META = '^';
  META_DATA;
  
  NS = 'ns';
  
  QUOTE = '\'';
  
  PARAMS;
  
  REGEX;
  REQUIRE = 'require';
  REFER = 'refer';
  
  SET;
  SYNTAX_QUOTE = '`';
  
  USE = 'use';
  UNQUOTE = '~';
  UNQUOTE_SPLICING = '~@';
  
  VAR = 'var';
  VAR_QUOTE;
  VAR_ARG = '&';
  VECTOR;
    
  LPAREN = '(';
  RPAREN = ')';
  
  LBRACKET = '[';
  RBRACKET = ']';
  
  LCURLY = '{';
  RCURLY = '}';  
}

@header {
package org.anachronos.clojure.core.parser.antlr;

import java.util.Map;
import java.util.HashMap;
}
  
@lexer::header {
package org.anachronos.clojure.core.parser.antlr;

import java.util.HashSet;
import java.util.Set;  
}

@members {
  private boolean paramNamesAllowed = false;
  
  private Scope globalScope = new Scope();
  
  private Scope scope;
  
  public Scope getGlobalScope() {
    return globalScope;
  }
  
  private final Map<RecognitionException, String> errorToMessage = 
    new HashMap<RecognitionException, String>();
  
  public void displayRecognitionError(final String[] tokenNames,
     final RecognitionException e) {
     
     final String msg = getErrorHeader(e) + " " + getErrorMessage(e, tokenNames);
     errorToMessage.put(e, msg);
  }
  
  public boolean hasErrors() {
    return !errorToMessage.isEmpty();
  }
  
  public Map<RecognitionException, String> getErrorToMessage() {
    return errorToMessage;
  }
}

file
@init { scope = globalScope; }: 
  form*;
  
form: 
  literal |
  
  def | defn | fn | var | let |
  
  require | refer | use | in_ns | import__ | ns |
  
  call | list | map | set | vector |
  
  reader_macro;
  
// Definitions

def:
  '(' DEF name=SYMBOL form? ')' 
  { globalScope.addVariableDef($name.text); }
  -> ^(DEF $name form?);
  
defn
@init  { scope = scope.newScope(); }
@after { scope = scope.endScope(); }:
  '(' DEFN name=SYMBOL STRING? map? 
    p=params { scope.addFunctionDef($name.text, $p.paramCount, !$p.varArg); } // hack to allow recursive calls
    form* 
  ')'
  { globalScope.addFunctionDef($name.text, $p.paramCount, !$p.varArg); } 
  -> ^(DEFN SYMBOL STRING? map? params form*);
   
params returns [int paramCount, boolean varArg]:
  '[' 
    (n=SYMBOL { scope.addVariableDef($n.text); $paramCount++; })* 
    v=var_arg? 
  ']'
  { $varArg = v != null; }
  -> ^(PARAMS SYMBOL* var_arg?);
   
var_arg:
  '&' SYMBOL
  -> ^(VAR_ARG SYMBOL);
  
fn:
  '(' FN params form* ')'
  -> ^(FN params form*);

lambda
@init  { paramNamesAllowed = true;  }
@after { paramNamesAllowed = false; }:
  LAMBDA form* ')' 
  -> ^(LAMBDA form*);
  
let:
  '(' LET bindings=vector body+=form* ')'
  -> ^(LET $bindings $body);

// References 
  
var:
  '(' VAR symbol=SYMBOL ')' |
  '#\'' symbol=SYMBOL
  -> ^(VAR $symbol);
  

// Module\Namespace handling

require:
  '(' REQUIRE namespace=quoted_namespace_symbol ')'
  -> ^(REQUIRE $namespace);

refer:
  '(' REFER namespace=quoted_namespace_symbol ')'
  -> ^(REFER $namespace);
  
use:
  '(' USE ':reload-all'? namespace=quoted_namespace_symbol ')'
  -> ^(USE $namespace);
  
in_ns:
  '(' IN_NS namespace=quoted_namespace_symbol ')'
  -> ^(IN_NS $namespace);
  
import__:
  '(' IMPORT pkg_import__+ ')'
  -> ^(IMPORT pkg_import__+);
  
ns:
  '(' NS name=SYMBOL namespace_references+=namespace_reference+ ')'
  -> ^(NS $name $namespace_references+);
  
namespace_reference:
  '(' ':use' packages+=SYMBOL+ ')' 
  |
  '(' ':import' pkg_import__+ ')'
  -> ^(IMPORT pkg_import__+);
  
pkg_import__:
  '(' pkg=SYMBOL classes += SYMBOL+ ')'
  -> ^($pkg $classes+);
  
quoted_namespace_symbol:
  QUOTE namespace=SYMBOL
  -> ^($namespace);
 
// Data types

call
@init { $args = new ArrayList(); }:
  { scope.isFunction(input.LT(2).getText()) }? 
  '(' f=SYMBOL 
    (
      { !scope.exceedsArityUpperBound($f.text, $args.size()) }? args += form)*  
  { scope.isDefinedArity($f.text, $args.size()) }? ')'
  -> ^(CALL form*);   
  
list:
  '(' form* ')' 
  -> ^(LIST form*);

set:
  '#{' form* '}' 
  -> ^(SET form*);
    
map:
  '{' (form form)* '}' 
  -> ^(MAP (form form)*);
  
vector:
  '[' form* ']' 
  -> ^(VECTOR form*);

special_form:
  ('\'' | '`' | '~' | '~@' | '^' | '@') form;
  
  
meta_data:
  '#^' map form 
  -> ^(META_DATA map form);
  
var_quote:
  '\'#' SYMBOL 
  -> ^(VAR_QUOTE SYMBOL);
  
regex:
  '#' STRING 
  -> ^(REGEX STRING);
  
reader_macro:
  lambda |
  meta_data |
  special_form |
  regex |
  var_quote; 
    
literal:
  STRING |
  NUMBER |   
  CHARACTER |
  NIL |
  BOOLEAN |
  KEYWORD |
  s=SYMBOL { scope.isDefined($s.text) }? |
  {paramNamesAllowed}? PARAM_NAME;   
  
STRING: 
  '"' ( ~'"' | ('\\' '"') )* '"';
  
NUMBER: 
  '-'? '0'..'9'+ ('.' '0'..'9'+)? (('e'|'E') '-'? '0'..'9'+)?;

CHARACTER:
  '\\' .;

NIL:
  'nil';
  
BOOLEAN:
  'true' | 'false';

KEYWORD:
  ':' SYMBOL;

SYMBOL: 
  '.' | 
  '/' |   
  NAME ('/' NAME)?;

PARAM_NAME:
  '%' (('1'..'9')('0'..'9')*)?;
  
fragment
NAME:   
  SYMBOL_HEAD SYMBOL_REST* (':' SYMBOL_REST+)*;

fragment
SYMBOL_HEAD:   
  'a'..'z' | 'A'..'Z' | '*' | '+' | '!' | '-' | '_' | '?' | '>' | '<' | '=' | '$';
    
fragment
SYMBOL_REST:
  SYMBOL_HEAD |   
  '0'..'9' | 
  '.';  
  
WS:
  (' '|'\n'|'\t'|'\r'|',') { $channel = HIDDEN; };

COMMENT:
  ';' ~('\n')* ('\n'|EOF) { $channel = HIDDEN; };
