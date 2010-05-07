% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 4_names_and_expressions



% 4.1
% name ::=
%     direct_name | explicit_dereference
%   | indexed_component | slice
%   | selected_component | attribute_reference
%   | type_conversion | function_call
%   | character_literal

define name
    [direct_name]
    | [explicit_dereference]
    | [indexed_component]
    | [slice]
    | [selected_component]
    | [attribute_reference]
    | [type_conversion]
    | [function_call]
    | [character_literal]
end define



% 4.1
% direct_name ::=
%     identifier | operator_symbol

define direct_name
    [identifier]
    | [operator_symbol]
end define



% 4.1
% prefix ::=
%     name | implicit_dereference

define prefix
    [name]
    | [implicit_dereference]
end define



% 4.1
% explicit_dereference ::=
%     name.all

define explicit_dereference
    [name] . 'all
end define



% 4.1
% implicit_dereference ::=
%     name

define implicit_dereference
    [name]
end define



% 4.1.1
% indexed_component ::=
%     prefix(expression {, expression})

define indexed_component
    [prefix] ( [expression,+] )
end define



% 4.1.2
% slice ::=
%     prefix(discrete_range)

define slice
    [prefix] ( [discrete_range] )
end define



% 4.1.3
% selected_component ::=
%     prefix . selector_name

define selected_component
    [prefix] . [selector_name]
end define



% 4.1.3
% selector_name ::=
%     identifier | character_literal | operator_symbol

define selector_name
    [identifier]
    | [character_literal]
    | [operator_symbol]
end define



% 4.1.4
% attribute_reference ::=
%     prefix'attribute_designator

define attribute_reference
    [prefix] '' [attribute_designator]
end define



% 4.1.4
% attribute_designator ::=
%     identifier[(static_expression)]
%  | Access | Delta | Digits

define attribute_designator
    [identifier] [attribute_designator_expression?]
    | Access
    | Delta
    | Digits
end define

define attribute_designator_expression
    ( [expression] )
end define



% 4.1.4
% range_attribute_reference ::=
%     prefix'range_attribute_designator

define range_attribute_reference
    [prefix] '' [range_attribute_designator]
end define



% 4.1.4
% range_attribute_designator ::=
%     Range[(static_expression)]

define range_attribute_designator
    Range [range_attribute_designator_expression]
end define

define range_attribute_designator_expression
    ( [expression] )
end define



% 4.3
% aggregate ::=
%     record_aggregate | extension_aggregate | array_aggregate

define aggregate
    [record_aggregate]
    | [extension_aggregate]
    | [array_aggregate]
end define



% 4.3.1
% record_aggregate ::=
%     (record_component_association_list)

define record_aggregate
    ( [record_component_association_list] )
end define



% 4.3.1
% record_component_association_list ::=
%     record_component_association {, record_component_association}
%  | null record

define record_component_association_list
    [record_component_association,+]
    | null record
end define



% 4.3.1
% record_component_association ::=
%     [component_choice_list =>] expression
%   | component_choice_list => <>

define record_component_association
    [expression]
    | [component_choice_list] => [expression]
    | [component_choice_list] => <>
end define



% 4.3.1
% component_choice_list ::=
%     component_selector_name {| component_selector_name}
%   | others

define component_choice_list
    [selector_name]
    | [selector_name] | [component_choice_list]
    | others
end define



% 4.3.2
% extension_aggregate ::=
%     (ancestor_part with record_component_association_list)

define extension_aggregate
    ( [ancestor_part] with [record_component_association_list] )
end define



% 4.3.2
% ancestor_part ::=
%     expression | subtype_mark

define ancestor_part
    [expression]
    | [subtype_mark]
end define



% 4.3.3
% array_aggregate ::=
%     positional_array_aggregate | named_array_aggregate

define array_aggregate
    [positional_array_aggregate]
    | [named_array_aggregate]
end define



% 4.3.3
% positional_array_aggregate ::=
%     (expression, expression {, expression})
%  | (expression {, expression}, others => expression)
%  | (expression {, expression}, others => <>)

define positional_array_aggregate
    ( [expression] , [expression,+] )
    | ( [expression,+] , others => [expression] )
    | ( [expression,+] , others => <> )
end define



% 4.3.3
% named_array_aggregate ::=
%     (array_component_association {, array_component_association})

define named_array_aggregate
    ( [array_component_association,+] )
end define



% 4.3.3
% array_component_association ::=
%     discrete_choice_list => expression
%  | discrete_choice_list => <>

define array_component_association
    [discrete_choice_list] => [expression]
    | [discrete_choice_list] => <>
end define



% 4.4
% expression ::=
%     relation {and relation}  | relation {and then relation}
%   | relation {or relation}  | relation {or else relation}
%   | relation {xor relation}

define expression
    [relation] [expression_and?]
    | [relation] [expression_and_then?]
    | [relation] [expression_or?]
    | [relation] [expression_or_else?]
    | [relation] [expression_xor?]
end define

define expression_and
    and [expression]
end define

define expression_and_then
    and then [expression]
end define

define expression_or
    or [expression]
end define

define expression_or_else
    or else [expression]
end define

define expression_xor
    xor [expression]
end define



% 4.4
% relation ::=
%     simple_expression [relational_operator simple_expression?]
%   | simple_expression [not] in range
%   | simple_expression [not] in subtype_mark

define relation
    [simple_expression] [relational_operator_simple_expression?]
    | [simple_expression] ['not?] in [range]
    | [simple_expression] ['not?] in [subtype_mark]
end define

define relational_operator_simple_expression
    [relational_operator] [simple_expression]
end define



% 4.4
% simple_expression ::=
%     [unary_adding_operator] term {binary_adding_operator term}

define simple_expression
    [unary_adding_operator?] [term] [binary_adding_operator_term*]
end define

define binary_adding_operator_term
    [binary_adding_operator] [term]
end define



% 4.4
% term ::=
%     factor {multiplying_operator factor}

define term
    [factor] [multiplying_operator_factor*]
end define

define multiplying_operator_factor
    [multiplying_operator] [factor]
end define



% 4.4
% factor ::=
%     primary [** primary] | abs primary | not primary

define factor
    [factor_primary]
    | abs [primary]
    | 'not [primary]
end define

define factor_primary
    [primary]
    | [primary] ** [factor_primary]
end define



% 4.4
% primary ::=
%     numeric_literal | null | string_literal | aggregate
% | name | qualified_expression | allocator | (expression)

define primary
    [numeric_literal]
    | null
    | [string_literal]
    | [aggregate]
    | [name]
    | [qualified_expression]
    | [allocator]
    | ( [expression] )
end define



% 4.5
% logical_operator ::=
%     and | or  | xor

define logical_operator
    and
    | or
    | xor
end define



% 4.5
% relational_operator ::=
%     =   | /=  | <   | <= | > | >=

define relational_operator
    =
    | /=
    | <
    | <=
    | >
    | >=
end define



% 4.5
% binary_adding_operator ::=
%     +   | –   | &

define binary_adding_operator
    +
    | -
    | &
end define



% 4.5
% unary_adding_operator ::=
%     +   | –

define unary_adding_operator
    +
    | -
end define



% 4.5
% multiplying_operator ::=
%     *   | /   | mod | rem

define multiplying_operator
    *
    | /
    | mod
    | rem
end define



% 4.5
% highest_precedence_operator ::=
%     **  | abs | not

define highest_precedence_operator
    **
    | abs
    | 'not
end define



% 4.6
% type_conversion ::=
%     subtype_mark(expression)
%  | subtype_mark(name)

define type_conversion
    [subtype_mark] ( [expression] )
    | [subtype_mark] ( [name] )
end define



% 4.7
% qualified_expression ::=
%     subtype_mark'(expression) | subtype_mark'aggregate

define qualified_expression
    [subtype_mark] '' ( [expression] )
    | [subtype_mark] '' [aggregate]
end define



% 4.8
% allocator ::=
%     new subtype_indication | new qualified_expression

define allocator
    new [subtype_indication]
    | new [qualified_expression]
end define



