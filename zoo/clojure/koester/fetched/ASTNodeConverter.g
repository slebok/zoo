tree grammar ASTNodeConverter;

options {
  language = Java;
  tokenVocab = Clojure;
  ASTLabelType = CommonTree;
}

@header {
package org.anachronos.clojure.core.parser.antlr;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.dltk.ast.ASTNode;
import org.eclipse.dltk.ast.declarations.Argument;
import org.eclipse.dltk.ast.declarations.Declaration;
import org.eclipse.dltk.ast.declarations.MethodDeclaration;
import org.eclipse.dltk.ast.declarations.ModuleDeclaration;
import org.eclipse.dltk.ast.statements.Statement;
}

@members {
  private final ASTNodeFactory factory = new ASTNodeFactory();
  private final ModuleDeclaration moduleDeclaration = factory.createFile();
}

file returns [ModuleDeclaration file] 
@init { file = moduleDeclaration; }:  
    (
      d=form { if (d != null) moduleDeclaration.addStatement(d); }
    )*;
  
form returns [Statement stmt]: 
    literal |
    ( s=def | s=defn | s=fn | s=lambda | 
      s=call | s=list | s=map | s=set | s=vector
    ) { stmt = s; }; 
    // | var | let |
  
//  require | refer | use | in_ns | import__ | ns |
  
//  reader_macro;

def returns [Statement stmt]:
  ^(d=DEF name=SYMBOL initial=form?)
  { 
    if (initial instanceof MethodDeclaration) {
      MethodDeclaration fn = (MethodDeclaration) initial; 
      fn.setName(name.getText());
      stmt = fn; 
    } else
      stmt = factory.createDef(d, name); 
  };
  
defn returns [Statement stmt]:
  ^(d=DEFN 
      name=SYMBOL doc=STRING? 
      args=params 
      statements=stmt_list
   ) 
  { 
    MethodDeclaration defn = factory.createDefn(d, name, doc); 
    defn.acceptArguments(args);
    defn.acceptBody(factory.createBody(d, statements));
    stmt = defn;
  };

fn returns [Statement stmt]:
  ^(f=FN 
      args=params 
      statements=stmt_list
   ) 
  { 
    MethodDeclaration fn = factory.createFn(f); 
    fn.acceptArguments(args); 
    fn.acceptBody(factory.createBody(f, statements));
    stmt = fn;
  };


lambda returns [Statement stmt]
scope {
  int paramCount;
}:
  ^(f=LAMBDA 
      statements=stmt_list
   ) 
  { 
    MethodDeclaration fn = factory.createFn(f); 
    fn.acceptBody(factory.createBody(f, statements));
    fn.acceptArguments(factory.createLambdaArguments($lambda::paramCount));
    stmt = fn;
  };

params returns [List<Argument> args]
@init{ args = new ArrayList<Argument>(); }:
  ^(PARAMS 
      (name=SYMBOL { args.add(factory.createArgument(name)); })* 
      var_arg[args]?
   );

var_arg[List<Argument> args]:
  ^(VAR_ARG name=SYMBOL) { args.add(factory.createVarArg(name)); };
  
call returns [Statement list]:
  ^(c=CALL form*);
  
list returns [Statement list]:
  ^(l=LIST statements=stmt_list ) 
  { list = factory.createBody(l, statements); };

set returns [Statement set]:
  ^(s=SET statements=stmt_list) 
  { set = factory.createBody(s, statements); };

map returns [Statement map]:
  ^(m=MAP statements=stmt_list) 
  { map = factory.createBody(m, statements); };

vector returns [Statement vector]:
  ^(v=VECTOR statements=stmt_list) 
  { vector = factory.createBody(v, statements); };

stmt_list returns [List<Statement> statements]
@init { statements = new ArrayList<Statement>(); }:
  (stmt=form { if (stmt != null) statements.add(stmt); })*;
  
literal:
  NUMBER | SYMBOL | 
  p=PARAM_NAME 
  { 
    String s = p.getText(); 
    int pNum = s.length() != 1 ? Integer.valueOf(s.substring(1)) : 1;
    $lambda::paramCount = Math.max($lambda::paramCount, pNum); 
  };

