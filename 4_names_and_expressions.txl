% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 4_names_and_expressions



% 4.1
% name ::=
%     direct_name | explicit_dereference
%   | indexed_component | slice
%   | selected_component | attribute_reference
%   | type_conversion | function_call
%   | character_literal



% 4.1
% direct_name ::=
%     identifier | operator_symbol



% 4.1
% prefix ::=
%     name | implicit_dereference



% 4.1
% explicit_dereference ::=
%     name.all



% 4.1
% implicit_dereference ::=
%     name



% 4.1.1
% indexed_component ::=
%     prefix(expression {, expression})



% 4.1.2
% slice ::=
%     prefix(discrete_range)



% 4.1.3
% selected_component ::=
%     prefix . selector_name



% 4.1.3
% selector_name ::=
%     identifier | character_literal | operator_symbol



% 4.1.4
% attribute_reference ::=
%     prefix'attribute_designator



% 4.1.4
% attribute_designator ::=
%     identifier[(static_expression)]
%  | Access | Delta | Digits



% 4.1.4
% range_attribute_reference ::=
%     prefix'range_attribute_designator



% 4.1.4
% range_attribute_designator ::=
%     Range[(static_expression)]



% 4.3
% aggregate ::=
%     record_aggregate | extension_aggregate | array_aggregate



% 4.3.1
% record_aggregate ::=
%     (record_component_association_list)



% 4.3.1
% record_component_association_list ::=
%     record_component_association {, record_component_association}
%  | null record



% 4.3.1
% record_component_association ::=
%     [component_choice_list =>] expression
%   | component_choice_list => <>



% 4.3.1
% component_choice_list ::=
%     component_selector_name {| component_selector_name}
%   | others



% 4.3.2
% extension_aggregate ::=
%     (ancestor_part with record_component_association_list)



% 4.3.2
% ancestor_part ::=
%     expression | subtype_mark



% 4.3.3
% array_aggregate ::=
%     positional_array_aggregate | named_array_aggregate



% 4.3.3
% positional_array_aggregate ::=
%     (expression, expression {, expression})
%  | (expression {, expression}, others => expression)
%  | (expression {, expression}, others => <>)



% 4.3.3
% named_array_aggregate ::=
%     (array_component_association {, array_component_association})



% 4.3.3
% array_component_association ::=
%     discrete_choice_list => expression
%  | discrete_choice_list => <>



% 4.4
% expression ::=
%     relation {and relation}  | relation {and then relation}
%   | relation {or relation}  | relation {or else relation}
%   | relation {xor relation}



% 4.4
% relation ::=
%     simple_expression [relational_operator simple_expression]
%   | simple_expression [not] in range
%   | simple_expression [not] in subtype_mark



% 4.4
% simple_expression ::=
%     [unary_adding_operator] term {binary_adding_operator term}



% 4.4
% term ::=
%     factor {multiplying_operator factor}



% 4.4
% factor ::=
%     primary [** primary] | abs primary | not primary



% 4.4
% primary ::=
%     numeric_literal | null | string_literal | aggregate
% | name | qualified_expression | allocator | (expression)



% 4.5
% logical_operator ::=
%     and | or  | xor



% 4.5
% relational_operator ::=
%     =   | /=  | <   | <= | > | >=



% 4.5
% binary_adding_operator ::=
%     +   | –   | &



% 4.5
% unary_adding_operator ::=
%     +   | –



% 4.5
% multiplying_operator ::=
%     *   | /   | mod | rem



% 4.5
% highest_precedence_operator ::=
%     **  | abs | not



% 4.6
% type_conversion ::=
%     subtype_mark(expression)
%  | subtype_mark(name)



% 4.7
% qualified_expression ::=
%     subtype_mark'(expression) | subtype_mark'aggregate



% 4.8
% allocator ::=
%     new subtype_indication | new qualified_expression



