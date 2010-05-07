% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 6_subprograms



% 6.1
% subprogram_declaration ::=
%     [overriding_indicator]
%    subprogram_specification;

define subprogram_declaration
    [overriding_indicator?] [subprogram_specification] ;
end define



% 6.1
% subprogram_specification ::=
%     procedure_specification
%  | function_specification

define subprogram_specification
    [procedure_specification]
    | [function_specification]
end define



% 6.1
% procedure_specification ::=
%     procedure defining_program_unit_name parameter_profile

define procedure_specification
    procedure [defining_program_unit_name] [parameter_profile]
end define



% 6.1
% function_specification ::=
%     function defining_designator parameter_and_result_profile

define function_specification
    'function [defining_designator] [parameter_and_result_profile]
end define



% 6.1
% designator ::=
%     [parent_unit_name . ]identifier | operator_symbol

define designator
    [designator_parent_unit_name?] [identifier]
    | [designator_parent_unit_name?] [operator_symbol]
end define

define designator_parent_unit_name
    [parent_unit_name] .
end define



% 6.1
% defining_designator ::=
%     defining_program_unit_name | defining_operator_symbol

define defining_designator
    [defining_program_unit_name]
    | [defining_operator_symbol]
end define



% 6.1
% defining_program_unit_name ::=
%     [parent_unit_name . ]defining_identifier

define defining_program_unit_name
    [defining_program_unit_name_parent?] [defining_identifier]
end define

define defining_program_unit_name_parent
    [parent_unit_name] .
end define



% 6.1
% operator_symbol ::=
%     string_literal

define operator_symbol
    [string_literal]
end define



% 6.1
% defining_operator_symbol ::=
%     operator_symbol

define defining_operator_symbol
    [operator_symbol]
end define



% 6.1
% parameter_profile ::=
%     [formal_part]

define parameter_profile
    [formal_part?]
end define



% 6.1
% parameter_and_result_profile ::=
%     [formal_part] return [null_exclusion] subtype_mark
%  | [formal_part] return access_definition

define parameter_and_result_profile
    [formal_part?] return [null_exclusion?] [subtype_mark]
    | [formal_part?] return [access_definition]
end define



% 6.1
% formal_part ::=
%     (parameter_specification {; parameter_specification})

define formal_part
    ( [formal_part_parameter_specification_list] )
end define

define formal_part_parameter_specification_list
    [parameter_specification]
    | [parameter_specification] ; [formal_part_parameter_specification_list]
end define



% 6.1
% parameter_specification ::=
%     defining_identifier_list : mode [null_exclusion] subtype_mark [:= default_expression]
%  | defining_identifier_list : access_definition [:= default_expression]

define parameter_specification
    [defining_identifier_list] : [mode] [null_exclusion?] [subtype_mark] [parameter_specification_default?]
    | [defining_identifier_list] : [access_definition] [parameter_specification_default?]
end define

define parameter_specification_default
    := [default_expression]
end define



% 6.1
% mode ::=
%     [in] | in out | out

define mode
    ['in?]
    | in out
    | out
end define



% 6.3
% subprogram_body ::=
%     [overriding_indicator]
%    subprogram_specification is
%       declarative_part
%    begin
%        handled_sequence_of_statements
%    end [designator];

define subprogram_body
    [overriding_indicator?]
    [subprogram_specification] is
        [declarative_part]
    begin
        [handled_sequence_of_statements]
    'end [designator?] ;
end define



% 6.4
% procedure_call_statement ::=
%     procedure_name;
%  | procedure_prefix actual_parameter_part;

define procedure_call_statement
    [name] ;
    | [prefix] [actual_parameter_part] ;
end define



% 6.4
% function_call ::=
%     function_name
%  | function_prefix actual_parameter_part

define function_call
    [name]
    | [prefix] [actual_parameter_part]
end define



% 6.4
% actual_parameter_part ::=
%     (parameter_association {, parameter_association})

define actual_parameter_part
    ( [parameter_association,+] )
end define



% 6.4
% parameter_association ::=
%     [formal_parameter_selector_name =>] explicit_actual_parameter

define parameter_association
    [parameter_association_selector_name?] [explicit_actual_parameter]
end define

define parameter_association_selector_name
    [selector_name] =>
end define



% 6.4
% explicit_actual_parameter ::=
%     expression | variable_name

define explicit_actual_parameter
    [expression]
    | [name]
end define



% 6.5
% simple_return_statement ::=
%     return [expression];

define simple_return_statement
    return [expression] ;
end define



% 6.5
% extended_return_statement ::=
%     return defining_identifier : [aliased] return_subtype_indication [:= expression] [do
%        handled_sequence_of_statements
%    end return];

define extended_return_statement
    return [defining_identifier] : ['aliased?] [return_subtype_indication] [extended_return_statement_expression?] [extended_return_statement_do?] ;
end define

define extended_return_statement_expression
    := [expression]
end define

define extended_return_statement_do
    do
        [handled_sequence_of_statements]
    'end return
end define



% 6.5
% return_subtype_indication ::=
%     subtype_indication | access_definition

define return_subtype_indication
    [subtype_indication]
    | [access_definition]
end define



% 6.7
% null_procedure_declaration ::=
%     [overriding_indicator]
%   procedure_specification is null;

define null_procedure_declaration
    [overriding_indicator]
    [procedure_specification] is null ;
end define



