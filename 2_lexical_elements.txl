% based on Ada 2005 LRM, ISO/IEC 8652:1995(E)
% 2_lexical_elements



% reset all predefined lexical types from TXL
tokens
%    id              ""     % can't reset [id] pattern because it's used by TXL while parsing this grammar
    number          ""
    stringlit       ""
    charlit         ""
    comment         ""
    floatnumber     ""
    decimalnumber   ""
    integernumber   ""
end tokens



% 2.3
% identifier ::=
%     identifier_start {identifier_start | identifier_extend}

% 2.3
% identifier_start ::=
%     letter_uppercase
%   | letter_lowercase
%   | letter_titlecase
%   | letter_modifier
%   | letter_other
%   | number_letter

% 2.3
% identifier_extend ::=
%     mark_non_spacing
%   | mark_spacing_combining
%   | number_decimal
%   | punctuation_connector
%   | other_format

% define 'id' lexical type (identifier)
tokens
    id          "\a\i*"
end tokens



% 2.4
% numeric_literal ::=
%     decimal_literal | based_literal

% 2.4.1
% decimal_literal ::=
%     numeral [.numeral] [exponent]

% 2.4.1
% numeral ::=
%     digit {[underline] digit}

% 2.4.1
% exponent ::=
%     E [+] numeral | E – numeral

% 2.4.1
% digit ::=
%     0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

% 2.4.2
% based_literal ::=
%     base # based_numeral [.based_numeral] # [exponent]

% 2.4.2
% base ::=
%     numeral

% 2.4.2
% based_numeral ::=
%     extended_digit {[underline] extended_digit}

% 2.4.2
% extended_digit ::=
%     digit | A | B | C | D | E | F

% define 'number' lexical type (numeric_literal),
% define also 'floatnumber' (decimal_literal with explicit exponent),
% 'decimalnumber' (decimal_literal with explicit decimal part),
% 'integernumber' (integer literal with optional positive exponent)
tokens
    number          "\d[_\d]*(.\d[_\d]*)?([eE][+-]?\d[_\d]*)?"
                    | "\d[_\d]*\#[\dABCDEFabcdef][_\dABCDEFabcdef]*\#([eE][+-]?\d[_\d]*)?"
    floatnumber     "\d[_\d]*(.\d[_\d]*)?[eE][+-]?\d[_\d]*"
    decimalnumber   "\d[_\d]*.\d[_\d]*([eE][+-]?\d[_\d]*)?"
    integernumber   "\d[_\d]*([eE][+]?\d[_\d]*)?"
end tokens



% 2.5
% character_literal ::=
%     'graphic_character'

% define 'charlit' lexical type (character_literal)
tokens
    charlit     "'#''"
end tokens



% 2.6
% string_literal ::=
%     "{string_element}"

% 2.6
% string_element ::=
%     "" | non_quotation_mark_graphic_character

% define 'stringlit' lexical type (string_literal)
tokens
    stringlit   "\"[(\\\c)(\"\")#\"]*\""
end tokens



% 2.7
% comment ::=
%     --{non_end_of_line_character}

% define Ada convention for comments
comments
    --
end comments



% 2.8
% pragma ::=
%     pragma identifier [(pragma_argument_association {, pragma_argument_association})];

define pragma
    'pragma [id] ;
    | 'pragma [id] ( [pragma_argument_association,+] ) ;
end define



% 2.8
% pragma_argument_association ::=
%     [pragma_argument_identifier =>] name
%   | [pragma_argument_identifier =>] expression

define pragma_argument_association
    [name]
    | [id] => [name]
    | [expression]
    | [id] => [expression]
end define



% define Ada 2005 keywords
keys
    abort abs abstract accept access aliased 'all and array at
    begin body
    case constant
    declare delay delta digits do
    else elsif 'end entry exception exit
    for 'function
    generic goto
    if in interface is
    limited loop
    mod
    new 'not null
    of or others out overriding
    package pragma private procedure protected
    raise range record rem renames requeue return reverse
    select separate subtype synchronized
    tagged task terminate then type
    until use
    when while with
    xor
end keys


