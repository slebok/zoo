% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 8_visibility_rules



% 8.3.1
% overriding_indicator ::=
%     [not] overriding

define overriding_indicator
    ['not?] overriding
end define



% 8.4
% use_clause ::=
%     use_package_clause | use_type_clause

define use_clause
    [use_package_clause]
    | [use_type_clause]
end define



% 8.4
% use_package_clause ::=
%     use package_name {, package_name};

define use_package_clause
    use [name,+] ;
end define



% 8.4
% use_type_clause ::=
%     use type subtype_mark {, subtype_mark};

define use_type_clause
    use type [subtype_mark,+] ;
end define



% 8.5
% renaming_declaration ::=
%     object_renaming_declaration
%    | exception_renaming_declaration
%    | package_renaming_declaration
%    | subprogram_renaming_declaration
%    | generic_renaming_declaration

define renaming_declaration
    [object_renaming_declaration]
    | [exception_renaming_declaration]
    | [package_renaming_declaration]
    | [subprogram_renaming_declaration]
    | [generic_renaming_declaration]
end define



% 8.5.1
% object_renaming_declaration ::=
%     defining_identifier : [null_exclusion] subtype_mark renames object_name;
%  | defining_identifier : access_definition renames object_name;

define object_renaming_declaration
    [defining_identifier] : [null_exclusion?] [subtype_mark] renames [name] ;
    | [defining_identifier] : [access_definition] renames [name] ;
end define



% 8.5.2
% exception_renaming_declaration ::=
%     defining_identifier : exception renames exception_name;

define exception_renaming_declaration
    [defining_identifier] : exception renames [name] ;
end define



% 8.5.3
% package_renaming_declaration ::=
%     package defining_program_unit_name renames package_name;

define package_renaming_declaration
    package [defining_program_unit_name] renames [name];
end define



% 8.5.4
% subprogram_renaming_declaration ::=
%     [overriding_indicator]
%    subprogram_specification renames callable_entity_name;

define subprogram_renaming_declaration
    [overriding_indicator?]
    [subprogram_specification] renames [name] ;
end define



% 8.5.5
% generic_renaming_declaration ::=
%     generic package defining_program_unit_name renames generic_package_name;
%  | generic procedure defining_program_unit_name renames generic_procedure_name;
%  | generic function defining_program_unit_name renames generic_function_name;

define generic_renaming_declaration
    generic package [defining_program_unit_name] renames [name] ;
    | generic procedure [defining_program_unit_name] renames [name] ;
    | generic 'function [defining_program_unit_name] renames [name] ;
end define



