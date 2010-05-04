% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 9_tasks_and_synchronization



% 9.1
% task_type_declaration ::=
%     task type defining_identifier [known_discriminant_part] [is
%     [new interface_list with]
%     task_definition];



% 9.1
% single_task_declaration ::=
%     task defining_identifier [is
%     [new interface_list with]
%     task_definition];



% 9.1
% task_definition ::=
%     {task_item}
%  [ private
%     {task_item}]
%  end [task_identifier]



% 9.1
% task_item ::=
%     entry_declaration | aspect_clause



% 9.1
% task_body ::=
%     task body defining_identifier is
%     declarative_part
%   begin
%     handled_sequence_of_statements
%   end [task_identifier];



% 9.4
% protected_type_declaration ::=
%     protected type defining_identifier [known_discriminant_part] is
%     [new interface_list with]
%     protected_definition;



% 9.4
% single_protected_declaration ::=
%     protected defining_identifier is
%     [new interface_list with]
%     protected_definition;



% 9.4
% protected_definition ::=
%     { protected_operation_declaration }
%[ private
%    { protected_element_declaration } ]
%  end [protected_identifier]



% 9.4
% protected_operation_declaration ::=
%     subprogram_declaration
%     | entry_declaration
%     | aspect_clause



% 9.4
% protected_element_declaration ::=
%     protected_operation_declaration
%     | component_declaration



% 9.4
% protected_body ::=
%     protected body defining_identifier is
%   { protected_operation_item }
%  end [protected_identifier];



% 9.4
% protected_operation_item ::=
%     subprogram_declaration
%     | subprogram_body
%     | entry_body
%     | aspect_clause



% 9.5.2
% entry_declaration ::=
%     [overriding_indicator]
%   entry defining_identifier [(discrete_subtype_definition)] parameter_profile;



% 9.5.2
% accept_statement ::=
%     accept entry_direct_name [(entry_index)] parameter_profile [do
%     handled_sequence_of_statements
%   end [entry_identifier]];



% 9.5.2
% entry_index ::=
%     expression



% 9.5.2
% entry_body ::=
%     entry defining_identifier  entry_body_formal_part  entry_barrier is
%    declarative_part
%  begin
%    handled_sequence_of_statements
%  end [entry_identifier];



% 9.5.2
% entry_body_formal_part ::=
%     [(entry_index_specification)] parameter_profile



% 9.5.2
% entry_barrier ::=
%     when condition



% 9.5.2
% entry_index_specification ::=
%     for defining_identifier in discrete_subtype_definition



% 9.5.3
% entry_call_statement ::=
%     entry_name [actual_parameter_part];



% 9.5.4
% requeue_statement ::=
%     requeue entry_name [with abort];



% 9.6
% delay_statement ::=
%     delay_until_statement | delay_relative_statement



% 9.6
% delay_until_statement ::=
%     delay until delay_expression;



% 9.6
% delay_relative_statement ::=
%     delay delay_expression;



% 9.7
% select_statement ::=
%     selective_accept
%  | timed_entry_call
%  | conditional_entry_call
%  | asynchronous_select



% 9.7.1
% selective_accept ::=
%     select
%   [guard]
%     select_alternative
%{ or
%   [guard]
%     select_alternative }
%[ else
%   sequence_of_statements ]
%  end select;



% 9.7.1
% guard ::=
%     when condition =>



% 9.7.1
% select_alternative ::=
%     accept_alternative
%  | delay_alternative
%  | terminate_alternative



% 9.7.1
% accept_alternative ::=
%     accept_statement [sequence_of_statements]



% 9.7.1
% delay_alternative ::=
%     delay_statement [sequence_of_statements]



% 9.7.1
% terminate_alternative ::=
%     terminate;



% 9.7.2
% timed_entry_call ::=
%     select
%   entry_call_alternative
%  or
%   delay_alternative
%  end select;



% 9.7.2
% entry_call_alternative ::=
%     procedure_or_entry_call [sequence_of_statements]



% 9.7.2
% procedure_or_entry_call ::=
%     procedure_call_statement | entry_call_statement



% 9.7.3
% conditional_entry_call ::=
%     select
%   entry_call_alternative
%  else
%   sequence_of_statements
%  end select;



% 9.7.4
% asynchronous_select ::=
%     select
%   triggering_alternative
%  then abort
%   abortable_part
%  end select;



% 9.7.4
% triggering_alternative ::=
%     triggering_statement [sequence_of_statements]



% 9.7.4
% triggering_statement ::=
%     procedure_or_entry_call | delay_statement



% 9.7.4
% abortable_part ::=
%     sequence_of_statements



% 9.8
% abort_statement ::=
%     abort task_name {, task_name};



