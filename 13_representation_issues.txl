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
% 13_representation_issues



% 13.1
% aspect_clause ::=
%     attribute_definition_clause
%      | enumeration_representation_clause
%      | record_representation_clause
%      | at_clause

define aspect_clause
    [attribute_definition_clause]
    | [enumeration_representation_clause]
    | [record_representation_clause]
    | [at_clause]
end define



% 13.1
% local_name ::=
%     direct_name
%      | direct_name'attribute_designator
%      | library_unit_name

define local_name
    [direct_name]
    | [direct_name] '' [attribute_designator]
    | [name]
end define



% 13.3
% attribute_definition_clause ::=
%     for local_name'attribute_designator use expression;
%    | for local_name'attribute_designator use name;

define attribute_definition_clause
    for [local_name] '' [attribute_designator] use [expression] ;
    | for [local_name] '' [attribute_designator] use [name] ;
end define



% 13.4
% enumeration_representation_clause ::=
%     for first_subtype_local_name use enumeration_aggregate;

define enumeration_representation_clause
    for [local_name] use [enumeration_aggregate] ;
end define



% 13.4
% enumeration_aggregate ::=
%     array_aggregate

define enumeration_aggregate
    [array_aggregate]
end define



% 13.5.1
% record_representation_clause ::=
%     for first_subtype_local_name use
%      record [mod_clause]
%        {component_clause}
%      end record;

define record_representation_clause
    for [local_name] use
        record [mod_clause]
        [component_clause*]
    'end record ;
end define



% 13.5.1
% component_clause ::=
%     component_local_name at position 'range first_bit .. last_bit;

define component_clause
    [local_name] at [position] 'range [first_bit] ** [last_bit] ;
end define



% 13.5.1
% position ::=
%     static_expression

define position
    [expression]
end define



% 13.5.1
% first_bit ::=
%     static_simple_expression

define first_bit
    [simple_expression]
end define



% 13.5.1
% last_bit ::=
%     static_simple_expression

define last_bit
    [simple_expression]
end define



% 13.8
% code_statement ::=
%     qualified_expression;

define code_statement
    [qualified_expression] ;
end define



% 13.12
% restriction ::=
%     restriction_identifier
%    | restriction_parameter_identifier => restriction_parameter_argument

define restriction
    [identifier]
    | [identifier] => [restriction_parameter_argument]
end define



% 13.12
% restriction_parameter_argument ::=
%     name | expression

define restriction_parameter_argument
    [name]
    | [expression]
end define



