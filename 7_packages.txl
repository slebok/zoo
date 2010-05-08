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



