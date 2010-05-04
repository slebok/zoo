% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 5_statements



% 5.1
% sequence_of_statements ::=
%     statement {statement}



% 5.1
% statement ::=
%     {label} simple_statement | {label} compound_statement



% 5.1
% simple_statement ::=
%     null_statement
%   | assignment_statement | exit_statement
%   | goto_statement | procedure_call_statement
%   | simple_return_statement | entry_call_statement
%   | requeue_statement | delay_statement
%   | abort_statement | raise_statement
%   | code_statement



% 5.1
% compound_statement ::=
%     if_statement | case_statement
%   | loop_statement | block_statement
%   | extended_return_statement
%   | accept_statement | select_statement



% 5.1
% null_statement ::=
%     null;



% 5.1
% label ::=
%     <<label_statement_identifier>>



% 5.1
% statement_identifier ::=
%     direct_name



% 5.2
% assignment_statement ::=
%     variable_name := expression;



% 5.3
% if_statement ::=
%     if condition then
%      sequence_of_statements
%   {elsif condition then
%      sequence_of_statements}
%   [else
%      sequence_of_statements]
%    end if;



% 5.3
% condition ::=
%     boolean_expression



% 5.4
% case_statement ::=
%     case expression is
%       case_statement_alternative
%      {case_statement_alternative}
%   end case;



% 5.4
% case_statement_alternative ::=
%     when discrete_choice_list =>
%      sequence_of_statements



% 5.5
% loop_statement ::=
%     [loop_statement_identifier:]
%      [iteration_scheme] loop
%         sequence_of_statements
%       end loop [loop_identifier];



% 5.5
% iteration_scheme ::=
%     while condition
%   | for loop_parameter_specification



% 5.5
% loop_parameter_specification ::=
%     defining_identifier in [reverse] discrete_subtype_definition



% 5.6
% block_statement ::=
%     [block_statement_identifier:]
%       [declare
%            declarative_part]
%        begin
%            handled_sequence_of_statements
%        end [block_identifier];



% 5.7
% exit_statement ::=
%     exit [loop_name] [when condition];



% 5.8
% goto_statement ::=
%     goto label_name;



