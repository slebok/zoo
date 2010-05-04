% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 11_exceptions



% 11.1
% exception_declaration ::=
%     defining_identifier_list : exception;



% 11.2
% handled_sequence_of_statements ::=
%     sequence_of_statements
%  [exception
%     exception_handler
%    {exception_handler}]



% 11.2
% exception_handler ::=
%     when [choice_parameter_specification:] exception_choice {| exception_choice} =>
%     sequence_of_statements



% 11.2
% choice_parameter_specification ::=
%     defining_identifier



% 11.2
% exception_choice ::=
%     exception_name | others



% 11.3
% raise_statement ::=
%     raise;
%      | raise exception_name [with string_expression];



