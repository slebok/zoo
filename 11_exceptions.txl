% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 11_exceptions



% 11.1
% exception_declaration ::=
%     defining_identifier_list : exception;

define exception_declaration
    [defining_identifier_list] : exception ;
end define



% 11.2
% handled_sequence_of_statements ::=
%     sequence_of_statements
%  [exception
%     exception_handler
%    {exception_handler}]

define handled_sequence_of_statements
    [sequence_of_statements]
    [handled_sequence_of_statements_exception?]
end define

define handled_sequence_of_statements_exception
    exception
        [exception_handler+]
end define



% 11.2
% exception_handler ::=
%     when [choice_parameter_specification:] exception_choice {| exception_choice} =>
%     sequence_of_statements

define exception_handler
    when [exception_handler_specification?] [exception_handler_choice_list]
        [sequence_of_statements]
end define

define exception_handler_specification
    [choice_parameter_specification] :
end define

define exception_handler_choice_list
    [exception_choice]
    | [exception_choice] '| [exception_handler_choice_list]
end define



% 11.2
% choice_parameter_specification ::=
%     defining_identifier

define choice_parameter_specification
    [defining_identifier]
end define



% 11.2
% exception_choice ::=
%     exception_name | others

define exception_choice
    [name]
    | others 
end define



% 11.3
% raise_statement ::=
%     raise;
%      | raise exception_name [with string_expression];

define raise_statement
    raise ;
    | raise [name] [raise_statement_expression?] ; 
end define

define raise_statement_expression
    with [expression]
end define



