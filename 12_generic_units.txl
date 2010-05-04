% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 12_generic_units



% 12.1
% generic_declaration ::=
%     generic_subprogram_declaration | generic_package_declaration



% 12.1
% generic_subprogram_declaration ::=
%     generic_formal_part  subprogram_specification;



% 12.1
% generic_package_declaration ::=
%     generic_formal_part  package_specification;



% 12.1
% generic_formal_part ::=
%     generic {generic_formal_parameter_declaration | use_clause}



% 12.1
% generic_formal_parameter_declaration ::=
%     formal_object_declaration
%    | formal_type_declaration
%    | formal_subprogram_declaration
%    | formal_package_declaration



% 12.3
% generic_instantiation ::=
%     package defining_program_unit_name is
%         new generic_package_name [generic_actual_part];
%   | [overriding_indicator]
%     procedure defining_program_unit_name is
%         new generic_procedure_name [generic_actual_part];
%   | [overriding_indicator]
%     function defining_designator is
%         new generic_function_name [generic_actual_part];



% 12.3
% generic_actual_part ::=
%     (generic_association {, generic_association})



% 12.3
% generic_association ::=
%     [generic_formal_parameter_selector_name =>] explicit_generic_actual_parameter



% 12.3
% explicit_generic_actual_parameter ::=
%     expression | variable_name
%   | subprogram_name | entry_name | subtype_mark
%   | package_instance_name



% 12.4
% formal_object_declaration ::=
%     defining_identifier_list : mode [null_exclusion] subtype_mark [:= default_expression];
%    defining_identifier_list : mode access_definition [:= default_expression];



% 12.5
% formal_type_declaration ::=
%     type defining_identifier[discriminant_part] is formal_type_definition;



% 12.5
% formal_type_definition ::=
%     formal_private_type_definition
%    | formal_derived_type_definition
%    | formal_discrete_type_definition
%    | formal_signed_integer_type_definition
%    | formal_modular_type_definition
%    | formal_floating_point_definition
%    | formal_ordinary_fixed_point_definition
%    | formal_decimal_fixed_point_definition
%    | formal_array_type_definition
%    | formal_access_type_definition
%    | formal_interface_type_definition



% 12.5.1
% formal_private_type_definition ::=
%     [[abstract] tagged] [limited] private



% 12.5.1
% formal_derived_type_definition ::=
%     [abstract] [limited | synchronized] new subtype_mark [[and interface_list]with private]



% 12.5.2
% formal_discrete_type_definition ::=
%     (<>)



% 12.5.2
% formal_signed_integer_type_definition ::=
%     range <>



% 12.5.2
% formal_modular_type_definition ::=
%     mod <>



% 12.5.2
% formal_floating_point_definition ::=
%     digits <>



% 12.5.2
% formal_ordinary_fixed_point_definition ::=
%     delta <>



% 12.5.2
% formal_decimal_fixed_point_definition ::=
%     delta <> digits <>



% 12.5.3
% formal_array_type_definition ::=
%     array_type_definition



% 12.5.4
% formal_access_type_definition ::=
%     access_type_definition



% 12.5.5
% formal_interface_type_definition ::=
%     interface_type_definition



% 12.6
% formal_subprogram_declaration ::=
%     formal_concrete_subprogram_declaration
%    | formal_abstract_subprogram_declaration



% 12.6
% formal_concrete_subprogram_declaration ::=
%     with subprogram_specification [is subprogram_default];



% 12.6
% formal_abstract_subprogram_declaration ::=
%     with subprogram_specification is abstract [subprogram_default];



% 12.6
% subprogram_default ::=
%     default_name | <> | null



% 12.6
% default_name ::=
%     name



% 12.7
% formal_package_declaration ::=
%     with package defining_identifier is new generic_package_name  formal_package_actual_part;



% 12.7
% formal_package_actual_part ::=
%     ([others =>] <>)
%  | [generic_actual_part]
%  | (formal_package_association {, formal_package_association} [, others => <>])



% 12.7
% formal_package_association ::=
%     generic_association
%  | generic_formal_parameter_selector_name => <>



