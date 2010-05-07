% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 5_statements



% 5.1
% sequence_of_statements ::=
%     statement {statement}

define sequence_of_statements
    [statement+]
end define



% 5.1
% statement ::=
%     {label} simple_statement | {label} compound_statement

define statement
    [label*] [simple_statement]
    | [label*] [compound_statement]
end define



% 5.1
% simple_statement ::=
%     null_statement
%   | assignment_statement | exit_statement
%   | goto_statement | procedure_call_statement
%   | simple_return_statement | entry_call_statement
%   | requeue_statement | delay_statement
%   | abort_statement | raise_statement
%   | code_statement

define simple_statement
    [null_statement]
    | [assignment_statement]
    | [exit_statement]
    | [goto_statement]
    | [procedure_call_statement]
    | [simple_return_statement]
    | [entry_call_statement]
    | [requeue_statement]
    | [delay_statement]
    | [abort_statement]
    | [raise_statement]
    | [code_statement]
end define



% 5.1
% compound_statement ::=
%     if_statement | case_statement
%   | loop_statement | block_statement
%   | extended_return_statement
%   | accept_statement | select_statement

define compound_statement
    [if_statement]
    | [case_statement]
    | [loop_statement]
    | [block_statement]
    | [extended_return_statement]
    | [accept_statement]
    | [select_statement]
end define



% 5.1
% null_statement ::=
%     null;

define null_statement
    null ;
end define



% 5.1
% label ::=
%     <<label_statement_identifier>>

define label
    << [statement_identifier] >>
end define



% 5.1
% statement_identifier ::=
%     direct_name

define statement_identifier
    [direct_name]
end define



% 5.2
% assignment_statement ::=
%     variable_name := expression;

define assignment_statement
    [name] := [expression] ;
end define



% 5.3
% if_statement ::=
%     if condition then
%      sequence_of_statements
%   {elsif condition then
%      sequence_of_statements}
%   [else
%      sequence_of_statements]
%    end if;

define if_statement
    if [condition] then
        [sequence_of_statements]
    [if_statement_elsif*]
    [if_statement_else?]
    'end if ;
end define

define if_statement_elsif
    elsif [condition] then
        [sequence_of_statements]
end define

define if_statement_else
    else
        [sequence_of_statements]
end define



% 5.3
% condition ::=
%     boolean_expression

define condition
    [expression]
end define



% 5.4
% case_statement ::=
%     case expression is
%       case_statement_alternative
%      {case_statement_alternative}
%   end case;

define case_statement
    case [expression] is
        [case_statement_alternative+]
    'end case ;
end define



% 5.4
% case_statement_alternative ::=
%     when discrete_choice_list =>
%      sequence_of_statements

define case_statement_alternative
    when [discrete_choice_list] =>
        [sequence_of_statements]
end define



% 5.5
% loop_statement ::=
%     [loop_statement_identifier:]
%      [iteration_scheme] loop
%         sequence_of_statements
%       end loop [loop_identifier];

define loop_statement
    [loop_statement_identifier?]
    [iteration_scheme?] loop
        [sequence_of_statements]
    'end loop [identifier?] ;
end define

define loop_statement_identifier
    [statement_identifier] :
end define



% 5.5
% iteration_scheme ::=
%     while condition
%   | for loop_parameter_specification

define iteration_scheme
    while [condition]
    | for [loop_parameter_specification]
end define



% 5.5
% loop_parameter_specification ::=
%     defining_identifier in [reverse] discrete_subtype_definition

define loop_parameter_specification
    [defining_identifier] in ['reverse?] [discrete_subtype_definition]
end define



% 5.6
% block_statement ::=
%     [block_statement_identifier:]
%       [declare
%            declarative_part]
%        begin
%            handled_sequence_of_statements
%        end [block_identifier];

define block_statement
    [block_statement_identifier?]
    [block_statement_declare?]
    begin
        [handled_sequence_of_statements]
    'end [identifier?] ;
end define

define block_statement_identifier
    [statement_identifier] :
end define

define block_statement_declare
    declare
        [declarative_part]
end define



% 5.7
% exit_statement ::=
%     exit [loop_name] [when condition];

define exit_statement
    exit [name?] [exit_statement_when_condition?] ;
end define

define exit_statement_when_condition
    when [condition]
end define



% 5.8
% goto_statement ::=
%     goto label_name;

define goto_statement
    goto [name] ;
end define



