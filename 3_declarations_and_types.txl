% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 3_declarations_and_types



% 3.1
% basic_declaration ::=
%     type_declaration | subtype_declaration
%   | object_declaration | number_declaration
%   | subprogram_declaration | abstract_subprogram_declaration
%   | null_procedure_declaration | package_declaration
%   | renaming_declaration | exception_declaration
%   | generic_declaration | generic_instantiation



% 3.1
% defining_identifier ::=
%     identifier



% 3.2.1
% type_declaration ::=
%     full_type_declaration
%   | incomplete_type_declaration
%   | private_type_declaration
%   | private_extension_declaration



% 3.2.1
% full_type_declaration ::=
%     type defining_identifier [known_discriminant_part] is type_definition;
%   | task_type_declaration
%   | protected_type_declaration



% 3.2.1
% type_definition ::=
%     enumeration_type_definition | integer_type_definition
%   | real_type_definition | array_type_definition
%   | record_type_definition | access_type_definition
%   | derived_type_definition | interface_type_definition



% 3.2.2
% subtype_declaration ::=
%     subtype defining_identifier is subtype_indication;



% 3.2.2
% subtype_indication ::=
%     [null_exclusion] subtype_mark [constraint]



% 3.2.2
% subtype_mark ::=
%     subtype_name



% 3.2.2
% constraint ::=
%     scalar_constraint | composite_constraint



% 3.2.2
% scalar_constraint ::=
%     range_constraint | digits_constraint | delta_constraint



% 3.2.2
% composite_constraint ::=
%     index_constraint | discriminant_constraint



% 3.3.1
% object_declaration ::=
%     defining_identifier_list : [aliased] [constant] subtype_indication [:= expression];
%  | defining_identifier_list : [aliased] [constant] access_definition [:= expression];
%  | defining_identifier_list : [aliased] [constant] array_type_definition [:= expression];
%  | single_task_declaration
%  | single_protected_declaration



% 3.3.1
% defining_identifier_list ::=
%     defining_identifier {, defining_identifier}



% 3.3.2
% number_declaration ::=
%     defining_identifier_list : constant := static_expression;



% 3.4
% derived_type_definition ::=
%     [abstract] [limited] new parent_subtype_indication [[and interface_list] record_extension_part]



% 3.5
% range_constraint ::=
%     range range



% 3.5
% range ::=
%     range_attribute_reference
%   | simple_expression .. simple_expression



% 3.5.1
% enumeration_type_definition ::=
%     (enumeration_literal_specification {, enumeration_literal_specification})



% 3.5.1
% enumeration_literal_specification ::=
%     defining_identifier | defining_character_literal



% 3.5.1
% defining_character_literal ::=
%     character_literal



% 3.5.4
% integer_type_definition ::=
%     signed_integer_type_definition | modular_type_definition



% 3.5.4
% signed_integer_type_definition ::=
%     range static_simple_expression .. static_simple_expression



% 3.5.4
% modular_type_definition ::=
%     mod static_expression



% 3.5.6
% real_type_definition ::=
%     floating_point_definition | fixed_point_definition



% 3.5.7
% floating_point_definition ::=
%     digits static_expression [real_range_specification]



% 3.5.7
% real_range_specification ::=
%     range static_simple_expression .. static_simple_expression



% 3.5.9
% fixed_point_definition ::=
%     ordinary_fixed_point_definition | decimal_fixed_point_definition



% 3.5.9
% ordinary_fixed_point_definition ::=
%     delta static_expression  real_range_specification



% 3.5.9
% decimal_fixed_point_definition ::=
%     delta static_expression digits static_expression [real_range_specification]



% 3.5.9
% digits_constraint ::=
%     digits static_expression [range_constraint]



% 3.6
% array_type_definition ::=
%     unconstrained_array_definition | constrained_array_definition



% 3.6
% unconstrained_array_definition ::=
%     array(index_subtype_definition {, index_subtype_definition}) of component_definition



% 3.6
% index_subtype_definition ::=
%     subtype_mark range <>



% 3.6
% constrained_array_definition ::=
%     array (discrete_subtype_definition {, discrete_subtype_definition}) of component_definition



% 3.6
% discrete_subtype_definition ::=
%     discrete_subtype_indication | range



% 3.6
% component_definition ::=
%     [aliased] subtype_indication
% | [aliased] access_definition



% 3.6.1
% index_constraint ::=
%     (discrete_range {, discrete_range})



% 3.6.1
% discrete_range ::=
%     discrete_subtype_indication | range



% 3.7
% discriminant_part ::=
%     unknown_discriminant_part | known_discriminant_part



% 3.7
% unknown_discriminant_part ::=
%     (<>)



% 3.7
% known_discriminant_part ::=
%     (discriminant_specification {; discriminant_specification})



% 3.7
% discriminant_specification ::=
%     defining_identifier_list : [null_exclusion] subtype_mark [:= default_expression]
% | defining_identifier_list : access_definition [:= default_expression]



% 3.7
% default_expression ::=
%     expression



% 3.7.1
% discriminant_constraint ::=
%     (discriminant_association {, discriminant_association})



% 3.7.1
% discriminant_association ::=
%     [discriminant_selector_name {| discriminant_selector_name} =>] expression



% 3.8
% record_type_definition ::=
%     [[abstract] tagged] [limited] record_definition



% 3.8
% record_definition ::=
%     record
%       component_list
%    end record
%  | null record



% 3.8
% component_list ::=
%     component_item {component_item}
%   | {component_item} variant_part
%   |  null;



% 3.8
% component_item ::=
%     component_declaration | aspect_clause



% 3.8
% component_declaration ::=
%     defining_identifier_list : component_definition [:= default_expression];



% 3.8.1
% variant_part ::=
%     case discriminant_direct_name is
%       variant
%      {variant}
%   end case;



% 3.8.1
% variant ::=
%     when discrete_choice_list =>
%      component_list



% 3.8.1
% discrete_choice_list ::=
%     discrete_choice {| discrete_choice}



% 3.8.1
% discrete_choice ::=
%     expression | discrete_range | others



% 3.9.1
% record_extension_part ::=
%     with record_definition



% 3.9.3
% abstract_subprogram_declaration ::=
%     [overriding_indicator]
%    subprogram_specification is abstract;



% 3.9.4
% interface_type_definition ::=
%     [limited | task | protected | synchronized] interface [and interface_list]



% 3.9.4
% interface_list ::=
%     interface_subtype_mark {and interface_subtype_mark}



% 3.10
% access_type_definition ::=
%     [null_exclusion] access_to_object_definition
%  | [null_exclusion] access_to_subprogram_definition



% 3.10
% access_to_object_definition ::=
%     access [general_access_modifier] subtype_indication



% 3.10
% general_access_modifier ::=
%     all | constant



% 3.10
% access_to_subprogram_definition ::=
%     access [protected] procedure parameter_profile
%  | access [protected] function  parameter_and_result_profile



% 3.10
% null_exclusion ::=
%     not null



% 3.10
% access_definition ::=
%     [null_exclusion] access [constant] subtype_mark
%  | [null_exclusion] access [protected] procedure parameter_profile
%  | [null_exclusion] access [protected] function parameter_and_result_profile



% 3.10.1
% incomplete_type_declaration ::=
%     type defining_identifier [discriminant_part] [is tagged];



% 3.11
% declarative_part ::=
%     {declarative_item}



% 3.11
% declarative_item ::=
%     basic_declarative_item | body



% 3.11
% basic_declarative_item ::=
%     basic_declaration | aspect_clause | use_clause



% 3.11
% body ::=
%     proper_body | body_stub



% 3.11
% proper_body ::=
%     subprogram_body | package_body | task_body | protected_body



