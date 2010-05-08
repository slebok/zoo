% Copyright 2010 Bruno LE HYARIC (http://bruno-lehyaric.com). All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without modification, are
% permitted provided that the following conditions are met:
% 
%    1. Redistributions of source code must retain the above copyright notice, this list of
%       conditions and the following disclaimer.
% 
%    2. Redistributions in binary form must reproduce the above copyright notice, this list
%       of conditions and the following disclaimer in the documentation and/or other materials
%       provided with the distribution.
% 
% THIS SOFTWARE IS PROVIDED BY Bruno LE HYARIC ``AS IS'' AND ANY EXPRESS OR IMPLIED
% WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
% FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Bruno LE HYARIC OR
% CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
% ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
% NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
% ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
% 
% The views and conclusions contained in the software and documentation are those of the
% authors and should not be interpreted as representing official policies, either expressed
% or implied, of Bruno LE HYARIC.



% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 9_tasks_and_synchronization



% 9.1
% task_type_declaration ::=
%     task type defining_identifier [known_discriminant_part] [is
%     [new interface_list with]
%     task_definition];

define task_type_declaration
    task type [defining_identifier] [known_discriminant_part?]
    [task_type_declaration_definition?] ;
end define

define task_type_declaration_definition
    is
        [task_type_declaration_definition_interface_list?]
        [task_definition]
end define

define task_type_declaration_definition_interface_list
    new [interface_list] with
end define



% 9.1
% single_task_declaration ::=
%     task defining_identifier [is
%     [new interface_list with]
%     task_definition];

define single_task_declaration
    task [defining_identifier]
    [single_task_declaration_definition?] ;
end define

define single_task_declaration_definition
    is 
        [single_task_declaration_definition_interface_list?]
        [task_definition]
end define

define single_task_declaration_definition_interface_list
    new [interface_list] with
end define



% 9.1
% task_definition ::=
%     {task_item}
%  [ private
%     {task_item}]
%  end [task_identifier]

define task_definition
    [task_item*]
    [task_definition_private?]
    'end [identifier?]
end define

define task_definition_private
    private
        [task_item*]
end define



% 9.1
% task_item ::=
%     entry_declaration | aspect_clause

define task_item
    [entry_declaration]
    | [aspect_clause]
end define



% 9.1
% task_body ::=
%     task body defining_identifier is
%     declarative_part
%   begin
%     handled_sequence_of_statements
%   end [task_identifier];

define task_body
    task 'body [defining_identifier] is
        [declarative_part]
    begin
        [handled_sequence_of_statements]
    'end [identifier?];
end define



% 9.4
% protected_type_declaration ::=
%     protected type defining_identifier [known_discriminant_part] is
%     [new interface_list with]
%     protected_definition;

define protected_type_declaration
    protected type [defining_identifier] [known_discriminant_part?] is
    [protected_type_declaration_interface_list?]
    [protected_definition] ;    
end define

define protected_type_declaration_interface_list
    new [interface_list] with
end define



% 9.4
% single_protected_declaration ::=
%     protected defining_identifier is
%     [new interface_list with]
%     protected_definition;

define single_protected_declaration
    protected [defining_identifier] is
    [single_protected_declaration_interface_list?]
    [protected_definition] ;
end define

define single_protected_declaration_interface_list
    new [interface_list] with
end define



% 9.4
% protected_definition ::=
%     { protected_operation_declaration }
%   [ private
%    { protected_element_declaration } ]
%  end [protected_identifier]

define protected_definition
    [protected_operation_declaration*]
        [protected_definition_private?]
    'end [identifier?]
end define

define protected_definition_private
    private
        [protected_element_declaration*]
end define



% 9.4
% protected_operation_declaration ::=
%     subprogram_declaration
%     | entry_declaration
%     | aspect_clause

define protected_operation_declaration
    [subprogram_declaration]
    | [entry_declaration]
    | [aspect_clause]
end define



% 9.4
% protected_element_declaration ::=
%     protected_operation_declaration
%     | component_declaration

define protected_element_declaration
    [protected_operation_declaration]
    | [component_declaration]
end define



% 9.4
% protected_body ::=
%     protected body defining_identifier is
%   { protected_operation_item }
%  end [protected_identifier];

define protected_body
    protected 'body [defining_identifier] is
        [protected_operation_item*]
    'end [identifier?] ;
end define



% 9.4
% protected_operation_item ::=
%     subprogram_declaration
%     | subprogram_body
%     | entry_body
%     | aspect_clause

define protected_operation_item
    [subprogram_declaration]
    | [subprogram_body]
    | [entry_body]
    | [aspect_clause]
end define



% 9.5.2
% entry_declaration ::=
%     [overriding_indicator]
%   entry defining_identifier [(discrete_subtype_definition)] parameter_profile;

define entry_declaration
    [overriding_indicator?]
    entry [defining_identifier] [entry_declaration_subtype?] [parameter_profile] ;
end define

define entry_declaration_subtype
    ( [discrete_subtype_definition] )
end define



% 9.5.2
% accept_statement ::=
%     accept entry_direct_name [(entry_index)] parameter_profile [do
%     handled_sequence_of_statements
%   end [entry_identifier]];

define accept_statement
    accept [direct_name] [accept_statement_entry_index?] [parameter_profile]
    [accept_statement_statements?] ;
end define

define accept_statement_entry_index
    ( [entry_index] )
end define

define accept_statement_statements
    do
        [handled_sequence_of_statements]
    'end [identifier?]
end define



% 9.5.2
% entry_index ::=
%     expression

define entry_index
    [expression]
end define



% 9.5.2
% entry_body ::=
%     entry defining_identifier  entry_body_formal_part  entry_barrier is
%    declarative_part
%  begin
%    handled_sequence_of_statements
%  end [entry_identifier];

define entry_body
    entry [defining_identifier] [entry_body_formal_part] [entry_barrier] is
        [declarative_part]
    begin
        [handled_sequence_of_statements]
    'end [identifier?] ;
end define



% 9.5.2
% entry_body_formal_part ::=
%     [(entry_index_specification)] parameter_profile

define entry_body_formal_part
    [entry_body_formal_part_specification?] [parameter_profile]
end define

define entry_body_formal_part_specification
    ( [entry_index_specification] )
end define



% 9.5.2
% entry_barrier ::=
%     when condition

define entry_barrier
    when [condition]
end define



% 9.5.2
% entry_index_specification ::=
%     for defining_identifier in discrete_subtype_definition

define entry_index_specification
    for [defining_identifier] in [discrete_subtype_definition]
end define



% 9.5.3
% entry_call_statement ::=
%     entry_name [actual_parameter_part];

define entry_call_statement
    [name] [actual_parameter_part?] ;
end define



% 9.5.4
% requeue_statement ::=
%     requeue entry_name [with abort];

define requeue_statement
    requeue [name] [requeue_statement_with_abort?] ;
end define

define requeue_statement_with_abort
    with abort
end define



% 9.6
% delay_statement ::=
%     delay_until_statement | delay_relative_statement

define delay_statement
    [delay_until_statement]
    | [delay_relative_statement]
end define



% 9.6
% delay_until_statement ::=
%     delay until delay_expression;

define delay_until_statement
    delay until [expression] ;
end define



% 9.6
% delay_relative_statement ::=
%     delay delay_expression;

define delay_relative_statement
    delay [expression] ;
end define



% 9.7
% select_statement ::=
%     selective_accept
%  | timed_entry_call
%  | conditional_entry_call
%  | asynchronous_select

define select_statement
    [selective_accept]
    | [timed_entry_call]
    | [conditional_entry_call]
    | [asynchronous_select]
end define



% 9.7.1
% selective_accept ::=
%     select
%   [guard]
%     select_alternative
%  { or
%   [guard]
%     select_alternative }
%  [ else
%   sequence_of_statements ]
%  end select;

define selective_accept
    select
        [guard?]
        [select_alternative]
    [selective_accept_or_alternative*]
    [selective_accept_else_alternative?]
    'end select ;
end define

define selective_accept_or_alternative
    or
        [guard?]
        [select_alternative]
end define

define selective_accept_else_alternative
    else
        [sequence_of_statements]
end define



% 9.7.1
% guard ::=
%     when condition =>

define guard
    when [condition] =>
end define



% 9.7.1
% select_alternative ::=
%     accept_alternative
%  | delay_alternative
%  | terminate_alternative

define select_alternative
    [accept_alternative]
    | [delay_alternative]
    | [terminate_alternative]
end define



% 9.7.1
% accept_alternative ::=
%     accept_statement [sequence_of_statements]

define accept_alternative
    [accept_statement] [sequence_of_statements?]
end define



% 9.7.1
% delay_alternative ::=
%     delay_statement [sequence_of_statements]

define delay_alternative
    [delay_statement] [sequence_of_statements?]
end define



% 9.7.1
% terminate_alternative ::=
%     terminate;

define terminate_alternative
    terminate ;
end define



% 9.7.2
% timed_entry_call ::=
%     select
%   entry_call_alternative
%  or
%   delay_alternative
%  end select;

define timed_entry_call
    select
        [entry_call_alternative]
    or
        [delay_alternative]
    'end select ;
end define



% 9.7.2
% entry_call_alternative ::=
%     procedure_or_entry_call [sequence_of_statements]

define entry_call_alternative
    [procedure_or_entry_call] [sequence_of_statements?]
end define



% 9.7.2
% procedure_or_entry_call ::=
%     procedure_call_statement | entry_call_statement

define procedure_or_entry_call
    [procedure_call_statement]
    | [entry_call_statement]
end define



% 9.7.3
% conditional_entry_call ::=
%     select
%   entry_call_alternative
%  else
%   sequence_of_statements
%  end select;

define conditional_entry_call
    select
        [entry_call_alternative]
    else
        [sequence_of_statements]
    'end select ;
end define



% 9.7.4
% asynchronous_select ::=
%     select
%   triggering_alternative
%  then abort
%   abortable_part
%  end select;

define asynchronous_select
    select
        [triggering_alternative]
    then abort
        [abortable_part]
    'end select ;
end define



% 9.7.4
% triggering_alternative ::=
%     triggering_statement [sequence_of_statements]

define triggering_alternative
    [triggering_statement] [sequence_of_statements?]
end define



% 9.7.4
% triggering_statement ::=
%     procedure_or_entry_call | delay_statement

define triggering_statement
    [procedure_or_entry_call]
    | [delay_statement]
end define



% 9.7.4
% abortable_part ::=
%     sequence_of_statements

define abortable_part
    [sequence_of_statements]
end define



% 9.8
% abort_statement ::=
%     abort task_name {, task_name};

define abort_statement
    abort [name,+] ;
end define



