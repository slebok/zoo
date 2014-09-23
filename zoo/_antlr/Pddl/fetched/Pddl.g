/**
 * PDDL grammar for ANTLR v3
 * Zeyn Saigol
 * School of Computer Science
 * University of Birmingham
 *
 * $Id: Pddl.g 120 2008-10-02 14:59:50Z zas $
 */
grammar Pddl;
options {
    output=AST;
    backtrack=true;
    //k=4;
}

tokens {
    DOMAIN;
    DOMAIN_NAME;
    REQUIREMENTS;
    TYPES;
    EITHER_TYPE;
    CONSTANTS;
    FUNCTIONS;
    PREDICATES;
    ACTION;
    DURATIVE_ACTION;
    PROBLEM;
    PROBLEM_NAME;
    PROBLEM_DOMAIN;
    OBJECTS;
    INIT;
    FUNC_HEAD;
    PRECONDITION;
    EFFECT;
    AND_GD;
    OR_GD;
	NOT_GD;
	IMPLY_GD;
	EXISTS_GD;
	FORALL_GD;
	COMPARISON_GD;
	AND_EFFECT;
	FORALL_EFFECT;
	WHEN_EFFECT;
	ASSIGN_EFFECT;
	NOT_EFFECT;
	PRED_HEAD;
	GOAL;
	BINARY_OP;
	UNARY_MINUS;
	INIT_EQ;
	INIT_AT;
	NOT_PRED_INIT;
	PRED_INST;
	PROBLEM_CONSTRAINT;
	PROBLEM_METRIC;
}

@parser::header {package uk.ac.bham.cs.zas.pddl.antlr;}

@parser::members {
private boolean wasError = false;
public void reportError(RecognitionException e) {
	wasError = true;
	super.reportError(e);
}
public boolean invalidGrammar() {
	return wasError;
}
}
// Standard way of disabling the default error handler, and throwing Exceptions instead:
//@rulecatch { }
//@members {
// // raise exception, rather than recovering, on mismatched token within alt
// protected void mismatch(IntStream input, int ttype, BitSet follow)
//   throws RecognitionException
// {
//   throw new MismatchedTokenException(ttype, input);
// }
//}

@lexer::header {package uk.ac.bham.cs.zas.pddl.antlr;}


/************* Start of grammar *******************/

pddlDoc : domain | problem;

/************* DOMAINS ****************************/

domain
    : '(' 'define' domainName
      requireDef?
      typesDef?
      constantsDef?
      predicatesDef?
      functionsDef?
      constraints?
      structureDef*
      ')'
      -> ^(DOMAIN domainName requireDef? typesDef?
                constantsDef? predicatesDef? functionsDef?
                constraints? structureDef*)
    ;

domainName
    : '(' 'domain' NAME ')'
    	-> ^(DOMAIN_NAME NAME)
    ;

requireDef
	: '(' ':requirements' REQUIRE_KEY+ ')'
	-> ^(REQUIREMENTS REQUIRE_KEY+)
	;

typesDef
	: '(' ':types' typedNameList ')'
	  -> ^(TYPES typedNameList)
	;

// If have any typed names, they must come FIRST!
typedNameList
    : (NAME* | singleTypeNameList+ NAME*)
    ;

singleTypeNameList
    : (NAME+ '-' t=type)
	  -> ^(NAME $t)+
	;

type
	: ( '(' 'either' primType+ ')' )
	  -> ^(EITHER_TYPE primType+)
	| primType
	;

primType : NAME ;

functionsDef
	: '(' ':functions' functionList ')'
	-> ^(FUNCTIONS functionList)
	;

functionList
	: (atomicFunctionSkeleton+ ('-' functionType)? )*
	;

atomicFunctionSkeleton
	: '('! functionSymbol^ typedVariableList ')'!
	;

functionSymbol : NAME ;

functionType : 'number' ; // Currently in PDDL only numeric functions are allowed

constantsDef
	: '(' ':constants' typedNameList ')'
	-> ^(CONSTANTS typedNameList)
	;

predicatesDef
	: '(' ':predicates' atomicFormulaSkeleton+ ')'
	-> ^(PREDICATES atomicFormulaSkeleton+)
	;

atomicFormulaSkeleton
	: '('! predicate^ typedVariableList ')'!
	;

predicate : NAME ;

// If have any typed variables, they must come FIRST!
typedVariableList
    : (VARIABLE* | singleTypeVarList+ VARIABLE*)
    ;

singleTypeVarList
    : (VARIABLE+ '-' t=type)
      -> ^(VARIABLE $t)+
    ;

constraints
	: '('! ':constraints'^ conGD ')'!
	;

structureDef
	: actionDef
	| durativeActionDef
	| derivedDef
	;


/************* ACTIONS ****************************/

actionDef
	: '(' ':action' actionSymbol
	      ':parameters' '(' typedVariableList ')'
           actionDefBody ')'
       -> ^(ACTION actionSymbol typedVariableList actionDefBody)
    ;

actionSymbol : NAME ;


// Should allow preGD instead of goalDesc for preconditions -
// but I can't get the LL(*) parsing to work
// This means 'preference' preconditions cannot be used
actionDefBody
	: ( ':precondition' (('(' ')') | goalDesc))?
	  ( ':effect' (('(' ')') | effect))?
	  -> ^(PRECONDITION goalDesc?) ^(EFFECT effect?)
	;

//preGD
//	: prefGD
//	| '(' 'and' preGD* ')'
//	| '(' 'forall' '(' typedVariableList ')' preGD ')'
//	;
//
//prefGD
//	: '(' 'preference' NAME? goalDesc ')'
//	| goalDesc
//	;

goalDesc
	: atomicTermFormula
	| '(' 'and' goalDesc* ')'
	          -> ^(AND_GD goalDesc*)
	| '(' 'or' goalDesc* ')'
	          -> ^(OR_GD goalDesc*)
	| '(' 'not' goalDesc ')'
	          -> ^(NOT_GD goalDesc)
	| '(' 'imply' goalDesc goalDesc ')'
	          -> ^(IMPLY_GD goalDesc goalDesc)
	| '(' 'exists' '(' typedVariableList ')' goalDesc ')'
	          -> ^(EXISTS_GD typedVariableList goalDesc)
	| '(' 'forall' '(' typedVariableList ')' goalDesc ')'
	          -> ^(FORALL_GD typedVariableList goalDesc)
    | fComp
              -> ^(COMPARISON_GD fComp)
    ;

fComp
	: '('! binaryComp fExp fExp ')'!
	;

atomicTermFormula
	: '(' predicate term* ')' -> ^(PRED_HEAD predicate term*)
	;

term : NAME | VARIABLE ;

/************* DURATIVE ACTIONS ****************************/

durativeActionDef
	: '(' ':durative-action' actionSymbol
	      ':parameters' '(' typedVariableList ')'
           daDefBody ')'
       -> ^(DURATIVE_ACTION actionSymbol typedVariableList daDefBody)
    ;

daDefBody
	: ':duration' durationConstraint
	| ':condition' (('(' ')') | daGD)
    | ':effect' (('(' ')') | daEffect)
    ;

daGD
	: prefTimedGD
	| '(' 'and' daGD* ')'
	| '(' 'forall' '(' typedVariableList ')' daGD ')'
	;

prefTimedGD
	: timedGD
	| '(' 'preference' NAME? timedGD ')'
	;

timedGD
	: '(' 'at' timeSpecifier goalDesc ')'
	| '(' 'over' interval goalDesc ')'
	;

timeSpecifier : 'start' | 'end' ;
interval : 'all' ;

/************* DERIVED DEFINITIONS ****************************/

derivedDef
	: '('! ':derived'^ typedVariableList goalDesc ')'!
	;

/************* EXPRESSIONS ****************************/

fExp
	: NUMBER
	| '(' binaryOp fExp fExp2 ')' -> ^(BINARY_OP binaryOp fExp fExp2)
	| '(' '-' fExp ')' -> ^(UNARY_MINUS fExp)
	| fHead
	;

// This is purely a workaround for an ANTLR bug in tree construction
// http://www.antlr.org/wiki/display/ANTLR3/multiple+occurences+of+a+token+mix+up+the+list+management+in+tree+rewrites
fExp2 : fExp ;

fHead
	: '(' functionSymbol term* ')' -> ^(FUNC_HEAD functionSymbol term*)
	| functionSymbol -> ^(FUNC_HEAD functionSymbol)
	;

effect
	: '(' 'and' cEffect* ')' -> ^(AND_EFFECT cEffect*)
	| cEffect
	;

cEffect
	: '(' 'forall' '(' typedVariableList ')' effect ')'
	  -> ^(FORALL_EFFECT typedVariableList effect)
	| '(' 'when' goalDesc condEffect ')'
	  -> ^(WHEN_EFFECT goalDesc condEffect)
	| pEffect
	;

pEffect
	: '(' assignOp fHead fExp ')'
	  -> ^(ASSIGN_EFFECT assignOp fHead fExp)
	| '(' 'not' atomicTermFormula ')'
	  -> ^(NOT_EFFECT atomicTermFormula)
	| atomicTermFormula
	;


// TODO: why is this different from the "and cEffect" above? Does it matter?
condEffect
	: '(' 'and' pEffect* ')' -> ^(AND_EFFECT pEffect*)
	| pEffect
	;

// TODO: should these be uppercase & lexer section?
binaryOp : '*' | '+' | '-' | '/' ;

binaryComp : '>' | '<' | '=' | '>=' | '<=' ;

assignOp : 'assign' | 'scale-up' | 'scale-down' | 'increase' | 'decrease' ;


/************* DURATIONS  ****************************/

durationConstraint
	: '(' 'and' simpleDurationConstraint+ ')'
	| '(' ')'
	| simpleDurationConstraint
	;

simpleDurationConstraint
	: '(' durOp '?duration' durValue ')'
	| '(' 'at' timeSpecifier simpleDurationConstraint ')'
	;

durOp : '<=' | '>=' | '=' ;

durValue : NUMBER | fExp ;

daEffect
	: '(' 'and' daEffect* ')'
	| timedEffect
	| '(' 'forall' '(' typedVariableList ')' daEffect ')'
	| '(' 'when' daGD timedEffect ')'
	| '(' assignOp fHead fExpDA ')'
	;

timedEffect
	: '(' 'at' timeSpecifier daEffect ')'     // BNF has a-effect here, but not defined anywhere
	| '(' 'at' timeSpecifier fAssignDA ')'
	| '(' assignOp fHead fExp ')'         // BNF has assign-op-t and f-exp-t here, but not defined anywhere
	;

fAssignDA
	: '(' assignOp fHead fExpDA ')'
	;

fExpDA
	: '(' ((binaryOp fExpDA fExpDA) | ('-' fExpDA)) ')'
	| '?duration'
	| fExp
	;

/************* PROBLEMS ****************************/

problem
	: '(' 'define' problemDecl
	  problemDomain
      requireDef?
      objectDecl?
      init
      goal
      probConstraints?
      metricSpec?
      // lengthSpec? This is not defined anywhere in the BNF spec
      ')'
      -> ^(PROBLEM problemDecl problemDomain requireDef? objectDecl?
      		init goal probConstraints? metricSpec?)
    ;

problemDecl
    : '(' 'problem' NAME ')'
    -> ^(PROBLEM_NAME NAME)
    ;

problemDomain
	: '(' ':domain' NAME ')'
	-> ^(PROBLEM_DOMAIN NAME)
	;

objectDecl
	: '(' ':objects' typedNameList ')'
	-> ^(OBJECTS typedNameList)
	;

init
	: '(' ':init' initEl* ')'
	-> ^(INIT initEl*)
	;

initEl
	: nameLiteral
	| '(' '=' fHead NUMBER ')'         -> ^(INIT_EQ fHead NUMBER)
	| '(' 'at' NUMBER nameLiteral ')'  -> ^(INIT_AT NUMBER nameLiteral)
	;

nameLiteral
	: atomicNameFormula
	| '(' 'not' atomicNameFormula ')' -> ^(NOT_PRED_INIT atomicNameFormula)
	;

atomicNameFormula
	: '(' predicate NAME* ')' -> ^(PRED_INST predicate NAME*)
	;

// Should allow preGD instead of goalDesc -
// but I can't get the LL(*) parsing to work
// This means 'preference' preconditions cannot be used
//goal : '(' ':goal' preGD ')'  -> ^(GOAL preGD);
goal : '(' ':goal' goalDesc ')' -> ^(GOAL goalDesc) ;

probConstraints
	: '(' ':constraints'  prefConGD ')'
	  -> ^(PROBLEM_CONSTRAINT prefConGD)
	;

prefConGD
	: '(' 'and' prefConGD* ')'
	| '(' 'forall' '(' typedVariableList ')' prefConGD ')'
	| '(' 'preference' NAME? conGD ')'
	| conGD
	;

metricSpec
	: '(' ':metric' optimization metricFExp ')'
	  -> ^(PROBLEM_METRIC optimization metricFExp)
	;

optimization : 'minimize' | 'maximize' ;

metricFExp
	: '(' binaryOp metricFExp metricFExp ')'
	| '(' ('*'|'/') metricFExp metricFExp+ ')'
	| '(' '-' metricFExp ')'
	| NUMBER
	| '(' functionSymbol NAME* ')'
	| functionSymbol
    | 'total-time'
	| '(' 'is-violated' NAME ')'
	;

/************* CONSTRAINTS ****************************/

conGD
	: '(' 'and' conGD* ')'
	| '(' 'forall' '(' typedVariableList ')' conGD ')'
	| '(' 'at' 'end' goalDesc ')'
    | '(' 'always' goalDesc ')'
	| '(' 'sometime' goalDesc ')'
 	| '(' 'within' NUMBER goalDesc ')'
	| '(' 'at-most-once' goalDesc ')'
	| '(' 'sometime-after' goalDesc goalDesc ')'
	| '(' 'sometime-before' goalDesc goalDesc ')'
	| '(' 'always-within' NUMBER goalDesc goalDesc ')'
	| '(' 'hold-during' NUMBER NUMBER goalDesc ')'
	| '(' 'hold-after' NUMBER goalDesc ')'
	;



/************* LEXER ****************************/


REQUIRE_KEY
    : ':strips'
    | ':typing'
    | ':negative-preconditions'
    | ':disjunctive-preconditions'
    | ':equality'
    | ':existential-preconditions'
    | ':universal-preconditions'
    | ':quantified-preconditions'
    | ':conditional-effects'
    | ':fluents'
    | ':adl'
    | ':durative-actions'
    | ':derived-predicates'
    | ':timed-initial-literals'
    | ':preferences'
    | ':constraints'
    ;


NAME:    LETTER ANY_CHAR* ;

fragment LETTER:	'a'..'z' | 'A'..'Z';

fragment ANY_CHAR: LETTER | '0'..'9' | '-' | '_';

VARIABLE : '?' LETTER ANY_CHAR* ;

NUMBER : DIGIT+ ('.' DIGIT+)? ;

fragment DIGIT: '0'..'9';

LINE_COMMENT
    : ';' ~('\n'|'\r')* '\r'? '\n' { $channel = HIDDEN; }
    ;

WHITESPACE
    :   (   ' '
        |   '\t'
        |   '\r'
        |   '\n'
        )+
        { $channel = HIDDEN; }
    ;
