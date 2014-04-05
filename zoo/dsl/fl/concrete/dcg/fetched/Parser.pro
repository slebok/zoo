:- ['ParserLib.pro','Scanner.pro'].
% :- set_prolog_flag(double_quotes,atom).
:- set_prolog_flag(double_quotes,codes).
% :- set_prolog_flag(double_quotes,string.


% Programs as lists of function definitions

program(Fs) --> +(function,Fs).


% Function definitions

function((N,Ns,E)) -->
       name(N),
       +(name,Ns),
       @("="),
       expr(E),
       +(newline).


% Top-level layer of expression forms

expr(E) --> lassoc(ops,atom,binary,E).

expr(apply(N,Es)) -->
       name(N),
       +(atom,Es).

expr(ifThenElse(E1,E2,E3)) -->
       reserved("if"),
       expr(E1),
       reserved("then"),
       expr(E2),
       reserved("else"),
       expr(E3).


% Final layer of expression forms

atom(literal(I)) --> int(I).
atom(argument(N)) --> name(N).
atom(E) --> @("("), expr(E), @(")").


% Operation symbols

ops(equal) --> @("==").
ops(plus) --> @("+").
ops(minus) --> @("-").
