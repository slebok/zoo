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

define basic_declaration
    [type_declaration]
    | [subtype_declaration]
    | [object_declaration]
    | [number_declaration]
    | [subprogram_declaration]
    | [abstract_subprogram_declaration]
    | [null_procedure_declaration]
    | [package_declaration]
    | [renaming_declaration]
    | [exception_declaration]
    | [generic_declaration]
    | [generic_instantiation]
end define



% 3.1
% defining_identifier ::=
%     identifier

define defining_identifier
    [identifier]
end define



% 3.2.1
% type_declaration ::=
%     full_type_declaration
%   | incomplete_type_declaration
%   | private_type_declaration
%   | private_extension_declaration

define type_declaration
    [full_type_declaration]
    | [incomplete_type_declaration]
    | [private_type_declaration]
    | [private_extension_declaration]
end define



% 3.2.1
% full_type_declaration ::=
%     type defining_identifier [known_discriminant_part] is type_definition;
%   | task_type_declaration
%   | protected_type_declaration

define full_type_declaration
    type [defining_identifier] [known_discriminant_part?] is [type_definition] ;
    | [task_type_declaration]
    | [protected_type_declaration]
end define



% 3.2.1
% type_definition ::=
%     enumeration_type_definition | integer_type_definition
%   | real_type_definition | array_type_definition
%   | record_type_definition | access_type_definition
%   | derived_type_definition | interface_type_definition

define type_definition
    [enumeration_type_definition]
    | [integer_type_definition]
    | [real_type_definition]
    | [array_type_definition]
    | [record_type_definition]
    | [access_type_definition]
    | [derived_type_definition]
    | [interface_type_definition]
end define



% 3.2.2
% subtype_declaration ::=
%     subtype defining_identifier is subtype_indication;

define subtype_declaration
    subtype [defining_identifier] is [subtype_indication] ;
end define



% 3.2.2
% subtype_indication ::=
%     [null_exclusion] subtype_mark [constraint]

define subtype_indication
    [null_exclusion?] [subtype_mark] [constraint?]
end define



% 3.2.2
% subtype_mark ::=
%     subtype_name

define subtype_mark
    [name]
end define



% 3.2.2
% constraint ::=
%     scalar_constraint | composite_constraint

define constraint
    [scalar_constraint]
    | [composite_constraint]
end define



% 3.2.2
% scalar_constraint ::=
%     range_constraint | digits_constraint | delta_constraint

define scalar_constraint
    [range_constraint]
    | [digits_constraint]
    | [delta_constraint]
end define



% 3.2.2
% composite_constraint ::=
%     index_constraint | discriminant_constraint

define composite_constraint
    [index_constraint]
    | [discriminant_constraint]
end define



% 3.3.1
% object_declaration ::=
%     defining_identifier_list : [aliased] [constant] subtype_indication [:= expression];
%  | defining_identifier_list : [aliased] [constant] access_definition [:= expression];
%  | defining_identifier_list : [aliased] [constant] array_type_definition [:= expression];
%  | single_task_declaration
%  | single_protected_declaration

define object_declaration
    [defining_identifier_list] : ['aliased?] ['constant?] [subtype_indication] [object_declaration_expression?]
    | [defining_identifier_list] : ['aliased?] ['constant?] [access_definition] [object_declaration_expression?]
    | [defining_identifier_list] : ['aliased?] ['constant?] [array_type_definition] [object_declaration_expression?]
    | [single_task_declaration]
    | [single_protected_declaration]
end define

define object_declaration_expression
    := [expression]
end define



% 3.3.1
% defining_identifier_list ::=
%     defining_identifier {, defining_identifier}

define defining_identifier_list
    [defining_identifier,+]
end define



% 3.3.2
% number_declaration ::=
%     defining_identifier_list : constant := static_expression;

define number_declaration
    [defining_identifier_list] : constant := [expression] ;
end define



% 3.4
% derived_type_definition ::=
%     [abstract] [limited] new parent_subtype_indication [[and interface_list] record_extension_part]

define derived_type_definition
    ['abstract?] ['limited?] new [subtype_indication] [interface_and_record_extension_specification?]
end define

define interface_and_record_extension_specification
    and [interface_list]
    | [record_extension_part]
    | and [interface_list] [record_extension_part]
end define



% 3.5
% range_constraint ::=
%     range range

define range_constraint
    'range [range]
end define



% 3.5
% range ::=
%     range_attribute_reference
%   | simple_expression .. simple_expression

define range
    [range_attribute_reference]
    | [simple_expression] .. [simple_expression]
end define



% 3.5.1
% enumeration_type_definition ::=
%     (enumeration_literal_specification {, enumeration_literal_specification})

define enumeration_type_definition
    ( [enumeration_literal_specification,+] )
end define



% 3.5.1
% enumeration_literal_specification ::=
%     defining_identifier | defining_character_literal

define enumeration_literal_specification
    [defining_identifier]
    | [defining_character_literal]
end define



% 3.5.1
% defining_character_literal ::=
%     character_literal

define defining_character_literal
    [character_literal]
end define



% 3.5.4
% integer_type_definition ::=
%     signed_integer_type_definition | modular_type_definition

define integer_type_definition
    [signed_integer_type_definition]
    | [modular_type_definition]
end define



% 3.5.4
% signed_integer_type_definition ::=
%     range static_simple_expression .. static_simple_expression

define signed_integer_type_definition
    'range [simple_expression] .. [simple_expression]
end define



% 3.5.4
% modular_type_definition ::=
%     mod static_expression

define modular_type_definition
    mod [expression]
end define



% 3.5.6
% real_type_definition ::=
%     floating_point_definition | fixed_point_definition

define real_type_definition
    [floating_point_definition]
    | [fixed_point_definition]
end define



% 3.5.7
% floating_point_definition ::=
%     digits static_expression [real_range_specification]

define floating_point_definition
    digits [expression] [real_range_specification?]
end define



% 3.5.7
% real_range_specification ::=
%     range static_simple_expression .. static_simple_expression

define real_range_specification
    'range [simple_expression] .. [simple_expression]
end define



% 3.5.9
% fixed_point_definition ::=
%     ordinary_fixed_point_definition | decimal_fixed_point_definition

define fixed_point_definition
    [ordinary_fixed_point_definition]
    | [decimal_fixed_point_definition]
end define



% 3.5.9
% ordinary_fixed_point_definition ::=
%     delta static_expression  real_range_specification

define ordinary_fixed_point_definition
    delta [expression] [real_range_specification]
end define



% 3.5.9
% decimal_fixed_point_definition ::=
%     delta static_expression digits static_expression [real_range_specification]

define decimal_fixed_point_definition
    delta [expression] digits [expression] [real_range_specification?]
end define



% 3.5.9
% digits_constraint ::=
%     digits static_expression [range_constraint]

define digits_constraint
    digits [expression] [range_constraint?]
end define



% 3.6
% array_type_definition ::=
%     unconstrained_array_definition | constrained_array_definition

define array_type_definition
    [unconstrained_array_definition]
    | [constrained_array_definition]
end define



% 3.6
% unconstrained_array_definition ::=
%     array(index_subtype_definition {, index_subtype_definition}) of component_definition

define unconstrained_array_definition
    array ( [index_subtype_definition,+] ) of [component_definition]
end define



% 3.6
% index_subtype_definition ::=
%     subtype_mark range <>

define index_subtype_definition
    [subtype_mark] 'range <>
end define



% 3.6
% constrained_array_definition ::=
%     array (discrete_subtype_definition {, discrete_subtype_definition}) of component_definition

define constrained_array_definition
    array ( [discrete_subtype_definition,+] ) of [component_definition]
end define



% 3.6
% discrete_subtype_definition ::=
%     discrete_subtype_indication | range

define discrete_subtype_definition
    [subtype_indication]
    | [range]
end define



% 3.6
% component_definition ::=
%     [aliased] subtype_indication
% | [aliased] access_definition

define component_definition
    ['aliased?] [subtype_indication]
    | ['aliased?] [access_definition]
end define



% 3.6.1
% index_constraint ::=
%     (discrete_range {, discrete_range})

define index_constraint
    ( [discrete_range,+] )
end define



% 3.6.1
% discrete_range ::=
%     discrete_subtype_indication | range

define discrete_range
    [subtype_indication]
    | [range]
end define



% 3.7
% discriminant_part ::=
%     unknown_discriminant_part | known_discriminant_part

define discriminant_part
    [unknown_discriminant_part]
    | [known_discriminant_part]
end define



% 3.7
% unknown_discriminant_part ::=
%     (<>)

define unknown_discriminant_part
    ( <> )
end define



% 3.7
% known_discriminant_part ::=
%     (discriminant_specification {; discriminant_specification})

define known_discriminant_part
    ( [discriminant_specification_list] )
end define

define discriminant_specification_list
    [discriminant_specification]
    | [discriminant_specification] ; [discriminant_specification_list]
end define



% 3.7
% discriminant_specification ::=
%     defining_identifier_list : [null_exclusion] subtype_mark [:= default_expression]
% | defining_identifier_list : access_definition [:= default_expression]

define discriminant_specification
    [defining_identifier_list] : [null_exclusion?] [subtype_mark] [discriminant_specification_default?]
    | [defining_identifier_list] : [access_definition] [discriminant_specification_default?]
end define

define discriminant_specification_default
    := [default_expression]
end define



% 3.7
% default_expression ::=
%     expression

define default_expression
    [expression]
end define



% 3.7.1
% discriminant_constraint ::=
%     (discriminant_association {, discriminant_association})

define discriminant_constraint
    ( [discriminant_association,] )
end define



% 3.7.1
% discriminant_association ::=
%     [discriminant_selector_name {| discriminant_selector_name} =>] expression

define discriminant_association
    [discriminant_selector_name_list?] [expression]
end define

define discriminant_selector_name_list
    [selector_name] =>
    | [selector_name] '| [discriminant_selector_name_list]
end define



% 3.8
% record_type_definition ::=
%     [[abstract] tagged] [limited] record_definition

define record_type_definition
    [record_type_definition_tagged?] ['limited?] [record_definition]
end define

define record_type_definition_tagged
    ['abstract?] tagged
end define



% 3.8
% record_definition ::=
%     record
%       component_list
%    end record
%  | null record

define record_definition
    record
        [component_list]
    'end record
    | null record
end define



% 3.8
% component_list ::=
%     component_item {component_item}
%   | {component_item} variant_part
%   |  null;

define component_list
    [component_item+]
    | [component_item*] [variant_part]
    | null ;
end define



% 3.8
% component_item ::=
%     component_declaration | aspect_clause

define component_item
    [component_declaration]
    | [aspect_clause]
end define



% 3.8
% component_declaration ::=
%     defining_identifier_list : component_definition [:= default_expression];

define component_declaration
    [defining_identifier_list] : [component_definition] [component_declaration_default?] ;
end define

define component_declaration_default
    := [default_expression]
end define



% 3.8.1
% variant_part ::=
%     case discriminant_direct_name is
%       variant
%      {variant}
%   end case;

define variant_part
    case [direct_name] is
        [variant+]
    'end case ;
end define



% 3.8.1
% variant ::=
%     when discrete_choice_list =>
%      component_list

define variant
    when [discrete_choice_list] =>
        [component_list]
end define



% 3.8.1
% discrete_choice_list ::=
%     discrete_choice {| discrete_choice}

define discrete_choice_list
    [discrete_choice]
    | [discrete_choice] '| [discrete_choice_list]
end define



% 3.8.1
% discrete_choice ::=
%     expression | discrete_range | others

define discrete_choice
    [expression]
    | [discrete_range]
    | others
end define



% 3.9.1
% record_extension_part ::=
%     with record_definition

define record_extension_part
    with [record_definition]
end define



% 3.9.3
% abstract_subprogram_declaration ::=
%     [overriding_indicator]
%    subprogram_specification is abstract;

define abstract_subprogram_declaration
    [overriding_indicator?]
    [subprogram_specification] is abstract ;
end define



% 3.9.4
% interface_type_definition ::=
%     [limited | task | protected | synchronized] interface [and interface_list]

define interface_type_definition
    [interface_type_definition_modifier?] interface [interface_type_definition_list?]
end define

define interface_type_definition_modifier
    limited
    | task
    | protected
    | synchronized
end define

define interface_type_definition_list
    and [interface_list]
end define



% 3.9.4
% interface_list ::=
%     interface_subtype_mark {and interface_subtype_mark}

define interface_list
    [subtype_mark]
    | [subtype_mark] and [interface_list]
end define



% 3.10
% access_type_definition ::=
%     [null_exclusion] access_to_object_definition
%  | [null_exclusion] access_to_subprogram_definition

define access_type_definition
    [null_exclusion?] [access_to_object_definition]
    | [null_exclusion?] [access_to_subprogram_definition]
end define



% 3.10
% access_to_object_definition ::=
%     access [general_access_modifier] subtype_indication

define access_to_object_definition
    access [general_access_modifier?] [subtype_indication]
end define



% 3.10
% general_access_modifier ::=
%     all | constant

define general_access_modifier
    'all
    | constant
end define



% 3.10
% access_to_subprogram_definition ::=
%     access [protected] procedure parameter_profile
%  | access [protected] 'function  parameter_and_result_profile

define access_to_subprogram_definition
    access ['protected?] procedure [parameter_profile]
    | access ['protected?] 'function [parameter_and_result_profile]
end define



% 3.10
% null_exclusion ::=
%     not null

define null_exclusion
    'not null
end define



% 3.10
% access_definition ::=
%     [null_exclusion] access [constant] subtype_mark
%  | [null_exclusion] access [protected] procedure parameter_profile
%  | [null_exclusion] access [protected] 'function parameter_and_result_profile

define access_definition
    [null_exclusion?] access ['constant?] [subtype_mark]
    | [null_exclusion?] access ['protected?] procedure [parameter_profile]
    | [null_exclusion?] access ['protected?] 'function [parameter_and_result_profile]
end define



% 3.10.1
% incomplete_type_declaration ::=
%     type defining_identifier [discriminant_part] [is tagged];

define incomplete_type_declaration
    type [defining_identifier] [discriminant_part?] [incomplete_type_declaration_modifier?] ;
end define

define incomplete_type_declaration_modifier
    is tagged
end define



% 3.11
% declarative_part ::=
%     {declarative_item}

define declarative_part
    [declarative_item*]
end define



% 3.11
% declarative_item ::=
%     basic_declarative_item | body

define declarative_item
    [basic_declarative_item]
    | [body]
end define



% 3.11
% basic_declarative_item ::=
%     basic_declaration | aspect_clause | use_clause

define basic_declarative_item
    [basic_declaration]
    | [aspect_clause]
    | [use_clause]
end define



% 3.11
% body ::=
%     proper_body | body_stub

define body
    [proper_body]
    | [body_stub]
end define



% 3.11
% proper_body ::=
%     subprogram_body | package_body | task_body | protected_body

define proper_body
    [subprogram_body]
    | [package_body]
    | [task_body]
    | [protected_body]
end define



