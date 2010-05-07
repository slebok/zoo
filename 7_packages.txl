% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 7_packages



% 7.1
% package_declaration ::=
%     package_specification;

define package_declaration
    [package_specification] ;
end define



% 7.1
% package_specification ::=
%     package defining_program_unit_name is
%      {basic_declarative_item}
%   [private
%      {basic_declarative_item}]
%    end [[parent_unit_name.]identifier]

define package_specification
    package [defining_program_unit_name] is
        [basic_declarative_item*]
        [package_specification_private?]
    'end [package_specification_identifier?]
end define

define package_specification_private
    private
        [basic_declarative_item*]
end define

define package_specification_identifier
    [identifier]
    | [parent_unit_name] . [identifier]
end define



% 7.2
% package_body ::=
%     package body defining_program_unit_name is
%       declarative_part
%   [begin
%        handled_sequence_of_statements]
%    end [[parent_unit_name.]identifier];

define package_body
    package 'body [defining_program_unit_name] is
        [declarative_part]
    [package_body_statements?]
    'end [package_body_identifier?] ;
end define

define package_body_statements
    begin
        [handled_sequence_of_statements]
end define

define package_body_identifier
    [identifier]
    | [parent_unit_name] . [identifier]
end define



% 7.3
% private_type_declaration ::=
%     type defining_identifier [discriminant_part] is [[abstract] tagged] [limited] private;

define private_type_declaration
    type [defining_identifier] [discriminant_part?] is [private_type_declaration_tagged?] ['limited?] private ;
end define

define private_type_declaration_tagged
    tagged
    | abstract tagged
end define



% 7.3
% private_extension_declaration ::=
%     type defining_identifier [discriminant_part] is
%     [abstract] [limited | synchronized] new ancestor_subtype_indication
%     [and interface_list] with private;

define private_extension_declaration
    type [defining_identifier] [discriminant_part?] is
    ['abstract?] [private_extension_declaration_modifier?] new [subtype_indication]
    [private_extension_declaration_interface_list?] with private ;
end define

define private_extension_declaration_modifier
    limited
    | synchronized
end define

define private_extension_declaration_interface_list
    and [interface_list]
end define



