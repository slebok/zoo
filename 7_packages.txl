% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 7_packages



% 7.1
% package_declaration ::=
%     package_specification;



% 7.1
% package_specification ::=
%     package defining_program_unit_name is
%      {basic_declarative_item}
%   [private
%      {basic_declarative_item}]
%    end [[parent_unit_name.]identifier]



% 7.2
% package_body ::=
%     package body defining_program_unit_name is
%       declarative_part
%   [begin
%        handled_sequence_of_statements]
%    end [[parent_unit_name.]identifier];



% 7.3
% private_type_declaration ::=
%     type defining_identifier [discriminant_part] is [[abstract] tagged] [limited] private;



% 7.3
% private_extension_declaration ::=
%     type defining_identifier [discriminant_part] is
%     [abstract] [limited | synchronized] new ancestor_subtype_indication
%     [and interface_list] with private;



