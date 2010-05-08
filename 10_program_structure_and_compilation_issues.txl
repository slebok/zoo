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
% 10_program_structure_and_compilation_issues



% 10.1.1
% compilation ::=
%     {compilation_unit}

define compilation
    [compilation_unit*]
end define



% 10.1.1
% compilation_unit ::=
%     context_clause library_item
%  | context_clause subunit

define compilation_unit
    [context_clause] [library_item]
    | [context_clause] [subunit]
end define



% 10.1.1
% library_item ::=
%     [private] library_unit_declaration
%  | library_unit_body
%  | [private] library_unit_renaming_declaration

define library_item
    ['private?] [library_unit_declaration]
    | [library_unit_body]
    | ['private?] [library_unit_renaming_declaration]
end define



% 10.1.1
% library_unit_declaration ::=
%     subprogram_declaration | package_declaration
%   | generic_declaration | generic_instantiation

define library_unit_declaration
    [subprogram_declaration]
    | [package_declaration]
    | [generic_declaration]
    | [generic_instantiation]
end define



% 10.1.1
% library_unit_renaming_declaration ::=
%     package_renaming_declaration
% | generic_renaming_declaration
% | subprogram_renaming_declaration

define library_unit_renaming_declaration
    [package_renaming_declaration]
    | [generic_renaming_declaration]
    | [subprogram_renaming_declaration]
end define



% 10.1.1
% library_unit_body ::=
%     subprogram_body | package_body

define library_unit_body
    [subprogram_body]
    | [package_body]
end define



% 10.1.1
% parent_unit_name ::=
%     name

define parent_unit_name
    [name]
end define



% 10.1.2
% context_clause ::=
%     {context_item}

define context_clause
    [context_item*]
end define



% 10.1.2
% context_item ::=
%     with_clause | use_clause

define context_item
    [with_clause]
    | [use_clause]
end define



% 10.1.2
% with_clause ::=
%     limited_with_clause | nonlimited_with_clause

define with_clause
    [limited_with_clause]
    | [nonlimited_with_clause]
end define



% 10.1.2
% limited_with_clause ::=
%     limited [private] with library_unit_name {, library_unit_name};

define limited_with_clause
    ['limited?] ['private?] with [name,+] ;
end define



% 10.1.2
% nonlimited_with_clause ::=
%     [private] with library_unit_name {, library_unit_name};

define nonlimited_with_clause
    ['private?] with [name,+] ;
end define



% 10.1.3
% body_stub ::=
%     subprogram_body_stub | package_body_stub | task_body_stub | protected_body_stub

define body_stub
    [subprogram_body_stub]
    | [package_body_stub]
    | [task_body_stub]
    | [protected_body_stub]
end define



% 10.1.3
% subprogram_body_stub ::=
%     [overriding_indicator]
%   subprogram_specification is separate;

define subprogram_body_stub
    [overriding_indicator?]
    [subprogram_specification] is separate ;
end define



% 10.1.3
% package_body_stub ::=
%     package body defining_identifier is separate;

define package_body_stub
    package 'body [defining_identifier] is separate ;
end define



% 10.1.3
% task_body_stub ::=
%     task body defining_identifier is separate;

define task_body_stub
    task 'body [defining_identifier] is separate ;
end define



% 10.1.3
% protected_body_stub ::=
%     protected body defining_identifier is separate;

define protected_body_stub
    protected 'body [defining_identifier] is separate ;
end define



% 10.1.3
% subunit ::=
%     separate (parent_unit_name) proper_body

define subunit
    separate ( [parent_unit_name] ) [proper_body]
end define



