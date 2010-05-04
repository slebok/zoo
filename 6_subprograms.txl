% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 6_subprograms



% 6.1
% subprogram_declaration ::=
%     [overriding_indicator]
%    subprogram_specification;



% 6.1
% subprogram_specification ::=
%     procedure_specification
%  | function_specification



% 6.1
% procedure_specification ::=
%     procedure defining_program_unit_name parameter_profile



% 6.1
% function_specification ::=
%     function defining_designator parameter_and_result_profile



% 6.1
% designator ::=
%     [parent_unit_name . ]identifier | operator_symbol



% 6.1
% defining_designator ::=
%     defining_program_unit_name | defining_operator_symbol



% 6.1
% defining_program_unit_name ::=
%     [parent_unit_name . ]defining_identifier



% 6.1
% operator_symbol ::=
%     string_literal



% 6.1
% defining_operator_symbol ::=
%     operator_symbol



% 6.1
% parameter_profile ::=
%     [formal_part]



% 6.1
% parameter_and_result_profile ::=
%     [formal_part] return [null_exclusion] subtype_mark
%  | [formal_part] return access_definition



% 6.1
% formal_part ::=
%     (parameter_specification {; parameter_specification})



% 6.1
% parameter_specification ::=
%     defining_identifier_list : mode [null_exclusion] subtype_mark [:= default_expression]
%  | defining_identifier_list : access_definition [:= default_expression]



% 6.1
% mode ::=
%     [in] | in out | out



% 6.3
% subprogram_body ::=
%     [overriding_indicator]
%    subprogram_specification is
%       declarative_part
%    begin
%        handled_sequence_of_statements
%    end [designator];



% 6.4
% procedure_call_statement ::=
%     procedure_name;
%  | procedure_prefix actual_parameter_part;



% 6.4
% function_call ::=
%     function_name
%  | function_prefix actual_parameter_part



% 6.4
% actual_parameter_part ::=
%     (parameter_association {, parameter_association})



% 6.4
% parameter_association ::=
%     [formal_parameter_selector_name =>] explicit_actual_parameter



% 6.4
% explicit_actual_parameter ::=
%     expression | variable_name



% 6.5
% simple_return_statement ::=
%     return [expression];



% 6.5
% extended_return_statement ::=
%     return defining_identifier : [aliased] return_subtype_indication [:= expression] [do
%        handled_sequence_of_statements
%    end return];



% 6.5
% return_subtype_indication ::=
%     subtype_indication | access_definition



% 6.7
% null_procedure_declaration ::=
%     [overriding_indicator]
%   procedure_specification is null;



