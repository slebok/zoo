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
    | [library_unit_name]
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
%     component_local_name at position range first_bit .. last_bit;

define component_clause
    [local_name] at [position] range [first_bit] ** [last_bit] ;
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



