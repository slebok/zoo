% Yacc to TXL grammar converter
% C. Xie, Software Technology Laboratory, Queen's University
% April 1994 (Rev July 2010)

% This program creates a rough skeleton of a TXL grammar from a Yacc grammar

#pragma -raw 

compounds
    '%% '%{ '%} /* */
end compounds

comments
    /* */
    '%{ '%}
end comments

tokens
    yac_keyword "%\a\i*"
end tokens

define yac_id
    [id] [repeat dot_id]
end define

define dot_id
    '. [id]
end define


% Yacc grammar syntax

compounds
    '%% 
end compounds

define yac_tokenDefinition
    [yac_keyword] [yac_tokdef+] [NL]
end define

define yac_tokdef
    [id] | [charlit]
end define

define endSection
    '%% [NL] [NL]
end define

define yac_literal
      [yac_id]
    | [charlit]
end define

define bar_yac_literals
    '| [SP] [repeat yac_literal] [NL]
end define


define productionDefinition
    [yac_id] ': [NL] [IN]
	[SP] [SP] [literalsAndTypes]
	[repeat barLiteralsAndTypes] [opt ';] [NL] [EX]
 | 
    'define [yac_id] [NL] [IN]
	[SP] [SP] [literalsAndTypes] [NL]
	[repeat barLiteralsAndTypes] [EX]
    'end 'define [NL] [NL]
end define

define literalsAndTypes
    [repeat literalOrType]
end define


% TXL subset syntax

define barLiteralsAndTypes
      '| [SP] [literalsAndTypes] [NL] 
    | [SP] [bar_yac_literals] [NL] 
end define

define literalOrType
      [literal] | [type] 
    | [attr prec] | [attr Ccode]	% deleted in output
end define

define prec
    [yac_keyword] [yac_id]
end define

define Ccode
    '{ [repeat Ccode_or_token] '}
end define

define Ccode_or_token
      [Ccode]
    | [not '{] [not '}] [token]
end define

define type
      [SP] '[ [yac_id] ']
    | [SP] '[ 'opt [yac_idOrQuotedLiteral] ']
    | [SP] '[ 'repeat [yac_idOrQuotedLiteral] [opt plusOrStar] ']
    | [SP] '[ 'list [yac_idOrQuotedLiteral] [opt plusOrStar] ']
end define

define plusOrStar
    '+ | '*
end define

define yac_idOrQuotedLiteral
      [yac_id]
    | [quotedLiteral]
end define

define literal
    [quotedLiteral] | [unquotedLiteral]
end define

define quotedLiteral
    [SP] '' [unquotedLiteral] [SP]
end define

define unquotedLiteral
      [yac_id]
    | [charlit]
    | [stringlit]
    | [number]
    | [key]
end define

define program
    [Yacc_Txl_Grammar]
end define


% Transformation grammar

define Yacc_Txl_Grammar
    [attr tokenDefinitions] 	% deleted in output
    [productionDefinitions]
    [attr Cdefinitions]		% deleted in output
end define

define Cdefinitions
    [endSection]
    [repeat token]
end define

define tokenDefinitions
    [repeat tokenDefinition]
    [opt endSection]
end define

define tokenDefinition
    [yac_tokenDefinition]
 | 	
    'define [yac_id] [NL] [IN]
	[yac_tokenDefinition] [EX]
    'end 'define [NL] [NL]
end define

define productionDefinitions 
    [repeat productionDefinition]
end define


% YACC productions are converted to TXL defines, with three optimizations:
% sequences, lists and direct left recursions.

function main
    replace [program]
	P [program]
    by 
	P [convertYacIds]
	  [convertListProductions]
	  [convertSequenceProductions]
	  [convertDirectLeftRecursions]
	  [convertOtherProductions] 
	  [convertEmptyAlternatives]
end function

rule convertYacIds
    replace [yac_id]
	Id [id] '. Id2 [id] More [repeat dot_id]
    by
	Id [_ Id2] More 
end rule

rule convertDirectLeftRecursions
    replace [repeat productionDefinition]
	ProdId [id] ': 
	    FirstAlternative [repeat literalOrType]
	    RestOfAlternatives [repeat barLiteralsAndTypes] _ [opt ';]
	    RestOfProductions [repeat productionDefinition]
    deconstruct RestOfAlternatives
	'| ProdId TailOfSecondAlternative [repeat literalOrType]
    construct NewId [id]
	ProdId [_ ProdId]
    construct NewIdType [literalOrType]
	NewId
    by
	ProdId ': 
	    FirstAlternative [. NewIdType]
	NewId ': 
	    TailOfSecondAlternative [. NewIdType]
	    '| '[ 'empty ']
	RestOfProductions 
end rule


rule convertListProductions
    replace [productionDefinition]
	ProdId [id] ': 
	    FirstAlternative [repeat literalOrType]
	    RestOfAlternatives [repeat barLiteralsAndTypes] _ [opt ';]
    deconstruct FirstAlternative
	ElementId [id]
    deconstruct RestOfAlternatives
	'| ProdId '',' ElementId
    by
	'define ProdId 
	    '[ 'list ElementId '] 
	'end 'define
end rule 


rule convertSequenceProductions
    replace [productionDefinition]
	ProdId [id] ': 
	    ElementId [id]
	    '|	ProdId ElementId  _ [opt ';]
    by
	'define ProdId 
	    '[ 'repeat ElementId '] 
	'end 'define
end rule  


rule convertOtherProductions
    replace [productionDefinition]
	ProdId [id] ': FirstAlternative [repeat literalOrType] 
	    RestOfAlternatives [repeat barLiteralsAndTypes] _ [opt ';]
    by 
	'define ProdId  
	    FirstAlternative [convert_charlit] [convert_type] 
	    RestOfAlternatives [convert_charlit] [convert_type] 
	'end 'define
end rule

rule convert_charlit
    replace [literalOrType]
	CharLit [charlit]
    construct CharLitAsId [id]
	_ [unquote CharLit]
    by
	'' CharLitAsId
end rule 

rule convert_type
    replace [literalOrType]
	ProdId [id]
    by
	'[ ProdId ']
end rule


rule convertEmptyAlternatives
    replace [literalsAndTypes]
	_ [Ccode]
    by
	'[ 'empty ']
end rule
