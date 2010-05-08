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
% 11_exceptions



% 11.1
% exception_declaration ::=
%     defining_identifier_list : exception;

define exception_declaration
    [defining_identifier_list] : exception ;
end define



% 11.2
% handled_sequence_of_statements ::=
%     sequence_of_statements
%  [exception
%     exception_handler
%    {exception_handler}]

define handled_sequence_of_statements
    [sequence_of_statements]
    [handled_sequence_of_statements_exception?]
end define

define handled_sequence_of_statements_exception
    exception
        [exception_handler+]
end define



% 11.2
% exception_handler ::=
%     when [choice_parameter_specification:] exception_choice {| exception_choice} =>
%     sequence_of_statements

define exception_handler
    when [exception_handler_specification?] [exception_handler_choice_list]
        [sequence_of_statements]
end define

define exception_handler_specification
    [choice_parameter_specification] :
end define

define exception_handler_choice_list
    [exception_choice]
    | [exception_choice] '| [exception_handler_choice_list]
end define



% 11.2
% choice_parameter_specification ::=
%     defining_identifier

define choice_parameter_specification
    [defining_identifier]
end define



% 11.2
% exception_choice ::=
%     exception_name | others

define exception_choice
    [name]
    | others 
end define



% 11.3
% raise_statement ::=
%     raise;
%      | raise exception_name [with string_expression];

define raise_statement
    raise ;
    | raise [name] [raise_statement_expression?] ; 
end define

define raise_statement_expression
    with [expression]
end define



