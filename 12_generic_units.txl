% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 12_generic_units



% 12.1
% generic_declaration ::=
%     generic_subprogram_declaration | generic_package_declaration

define generic_declaration
    [generic_subprogram_declaration]
    | [generic_package_declaration]
end define



% 12.1
% generic_subprogram_declaration ::=
%     generic_formal_part  subprogram_specification;

define generic_subprogram_declaration
    [generic_formal_part] [subprogram_specification] ;
end define



% 12.1
% generic_package_declaration ::=
%     generic_formal_part  package_specification;

define generic_package_declaration
    [generic_formal_part] [package_specification] ;
end define



% 12.1
% generic_formal_part ::=
%     generic {generic_formal_parameter_declaration | use_clause}

define generic_formal_part
    generic [generic_formal_parameter_declaration]
    | generic [use_clause]
end define



% 12.1
% generic_formal_parameter_declaration ::=
%     formal_object_declaration
%    | formal_type_declaration
%    | formal_subprogram_declaration
%    | formal_package_declaration

define generic_formal_parameter_declaration
    [formal_object_declaration]
    | [formal_type_declaration]
    | [formal_subprogram_declaration]
    | [formal_package_declaration]
end define



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

define generic_instantiation
    package [defining_program_unit_name] is
        new [name] [generic_actual_part?] ;
    | [overriding_indicator?]
      procedure [defining_program_unit_name] is
        new [name] [generic_actual_part?] ;
    | [overriding_indicator?]
      'function [defining_designator] is
        new [name] [generic_actual_part?] ;
end define



% 12.3
% generic_actual_part ::=
%     (generic_association {, generic_association})

define generic_actual_part
    ( [generic_association,+] )
end define



% 12.3
% generic_association ::=
%     [generic_formal_parameter_selector_name =>] explicit_generic_actual_parameter

define generic_association
    [generic_association_selector_name?] [explicit_generic_actual_parameter]
end define

define generic_association_selector_name
    [selector_name] =>
end define



% 12.3
% explicit_generic_actual_parameter ::=
%     expression | variable_name
%   | subprogram_name | entry_name | subtype_mark
%   | package_instance_name

define explicit_generic_actual_parameter
    [expression]
    | [name]
    | [subtype_mark]
end define



% 12.4
% formal_object_declaration ::=
%     defining_identifier_list : mode [null_exclusion] subtype_mark [:= default_expression];
%    defining_identifier_list : mode access_definition [:= default_expression];

define formal_object_declaration
    [defining_identifier_list] : mode [null_exclusion?] [subtype_mark] [formal_object_declaration_default?] ;
    | [defining_identifier_list] : mode [access_definition] [formal_object_declaration_default?] ;
end define

define formal_object_declaration_default
    := [default_expression]
end define



% 12.5
% formal_type_declaration ::=
%     type defining_identifier[discriminant_part] is formal_type_definition;

define formal_type_declaration
    type [defining_identifier] [discriminant_part?] is [formal_type_definition] ;
end define



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

define formal_type_definition
    [formal_private_type_definition]
    | [formal_derived_type_definition]
    | [formal_discrete_type_definition]
    | [formal_signed_integer_type_definition]
    | [formal_modular_type_definition]
    | [formal_floating_point_definition]
    | [formal_ordinary_fixed_point_definition]
    | [formal_decimal_fixed_point_definition]
    | [formal_array_type_definition]
    | [formal_access_type_definition]
    | [formal_interface_type_definition]
end define



% 12.5.1
% formal_private_type_definition ::=
%     [[abstract] tagged] [limited] private

define formal_private_type_definition
    [formal_private_type_definition_tagged?] ['limited?] private
end define

define formal_private_type_definition_tagged
    ['abstract?] tagged
end define



% 12.5.1
% formal_derived_type_definition ::=
%     [abstract] [limited | synchronized] new subtype_mark [[and interface_list]with private]

define formal_derived_type_definition
    ['abstract?] [formal_derived_type_definition_modifier?] new [subtype_mark] [formal_derived_type_definition_interface_list?]
end define

define formal_derived_type_definition_modifier
    limited
    | synchronized
end define

define formal_derived_type_definition_interface_list
    with private
    | and [interface_list] with private
end define



% 12.5.2
% formal_discrete_type_definition ::=
%     (<>)

define formal_discrete_type_definition
    ( <> )
end define



% 12.5.2
% formal_signed_integer_type_definition ::=
%     range <>

define formal_signed_integer_type_definition
    range <>
end define



% 12.5.2
% formal_modular_type_definition ::=
%     mod <>

define formal_modular_type_definition
    mod <>
end define



% 12.5.2
% formal_floating_point_definition ::=
%     digits <>

define formal_floating_point_definition
    digits <>
end define



% 12.5.2
% formal_ordinary_fixed_point_definition ::=
%     delta <>

define formal_ordinary_fixed_point_definition
    delta <>
end define



% 12.5.2
% formal_decimal_fixed_point_definition ::=
%     delta <> digits <>

define formal_decimal_fixed_point_definition
    delta <> digits <>
end define



% 12.5.3
% formal_array_type_definition ::=
%     array_type_definition

define formal_array_type_definition
    [array_type_definition]
end define



% 12.5.4
% formal_access_type_definition ::=
%     access_type_definition

define formal_access_type_definition
    [access_type_definition]
end define



% 12.5.5
% formal_interface_type_definition ::=
%     interface_type_definition

define formal_interface_type_definition
    [interface_type_definition]
end define



% 12.6
% formal_subprogram_declaration ::=
%     formal_concrete_subprogram_declaration
%    | formal_abstract_subprogram_declaration

define formal_subprogram_declaration
    [formal_concrete_subprogram_declaration]
    | [formal_abstract_subprogram_declaration]
end define



% 12.6
% formal_concrete_subprogram_declaration ::=
%     with subprogram_specification [is subprogram_default];

define formal_concrete_subprogram_declaration
    with [subprogram_specification] [formal_concrete_subprogram_declaration_default?] ;
end define

define formal_concrete_subprogram_declaration_default
    is [subprogram_default]
end define



% 12.6
% formal_abstract_subprogram_declaration ::=
%     with subprogram_specification is abstract [subprogram_default];

define formal_abstract_subprogram_declaration
    with [subprogram_specification] is abstract [subprogram_default?] ;
end define



% 12.6
% subprogram_default ::=
%     default_name | <> | null

define subprogram_default
    [default_name]
    | <>
    | null
end define



% 12.6
% default_name ::=
%     name

define default_name
    name
end define



% 12.7
% formal_package_declaration ::=
%     with package defining_identifier is new generic_package_name  formal_package_actual_part;

define formal_package_declaration
    with package [defining_identifier] is new [name] [formal_package_actual_part] ;
end define



% 12.7
% formal_package_actual_part ::=
%     ([others =>] <>)
%  | [generic_actual_part]
%  | (formal_package_association {, formal_package_association} [, others => <>])

define formal_package_actual_part
    ( [formal_package_actual_part_others?] <> )
    | [generic_actual_part?]
    | ( [formal_package_association,+] [formal_package_actual_part_others?] ) 
end define

define formal_package_actual_part_others
    others =>
    | , others => <>
end define



% 12.7
% formal_package_association ::=
%     generic_association
%  | generic_formal_parameter_selector_name => <>

define formal_package_association
    [generic_association]
    | [selector_name] => <>
end define



