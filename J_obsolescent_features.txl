% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% J_obsolescent_features



% J.3
% delta_constraint ::=
%     delta static_expression [range_constraint]

define delta_constraint
    delta [expression] [range_constraint]
end define



% J.7
% at_clause ::=
%     for direct_name use at expression;

define at_clause
    for [direct_name] use at [expression] ;
end define



% J.8
% mod_clause ::=
%     at mod static_expression;

define mod_clause
    at mod [expression] ;
end define



