grammar FL;

@header {
import types.*;
import java.util.LinkedList;
}

program returns [Program program] : 
        { LinkedList<Function> functions = new LinkedList<Function>(); }
        ( f=function { functions.add($f.function); } )+
        { $program = new Program(functions); }
        ;
    
function returns [Function function] :
        { LinkedList<String> args = new LinkedList<String>(); }
        n=ID
        ( a=ID { args.add($a.text); } )+
        '='
        e=expr NEWLINE+
        { $function = new Function($n.text,args,$e.expr); }
        ;

expr returns [Expr expr] :
	  b=binary { $expr = $b.expr; }
	| a=apply { $expr = $a.expr; }
	| i=ifThenElse { $expr = $i.expr; }
      ;

binary returns [Expr expr] :
        l=atom { $expr = $l.expr; } 
        ( o=ops r=atom { $expr = new Binary($o.symbol,$expr,$r.expr); } )*
        ;

apply returns [Apply expr] :
        { LinkedList<Expr> args = new LinkedList<Expr>(); }
        i=ID
        ( a=atom { args.add($a.expr); } )+
        { $expr = new Apply($i.text,args); } 
        ;

ifThenElse returns [IfThenElse expr] :
        'if' c=expr 'then' e1=expr 'else' e2=expr
        { $expr = new IfThenElse($c.expr,$e1.expr,$e2.expr); }
        ;

atom returns [Expr expr] :
	  ID { $expr = new Argument($ID.text); }
	| INT { $expr = new Literal(Integer.parseInt($INT.text)); }
	| '(' e=expr ')' { $expr = $e.expr; }
 	;

ops returns [Ops symbol] :
	  '==' { $symbol = Ops.Equal; }
	| '+' { $symbol = Ops.Plus; }
	| '-' { $symbol = Ops.Minus; }
        ;

ID  	: ('a'..'z')+ ;
INT 	: '-'?'0'..'9'+ ;
NEWLINE	: '\r'? '\n' ;
WS  	: (' '|'\t')+ {skip();} ;
