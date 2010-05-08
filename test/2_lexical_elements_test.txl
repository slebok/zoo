% Test of 2_lexical_elements.txl



% define the root grammar rule
define program
    [lexical_element*]
end define



function main
    replace [program]
        P [program]
    by
        P
end function



% define all lexical elements of Ada 2005
define lexical_element
    [id]
    | [key]
    | [number]
    | [floatnumber]
    | [decimalnumber]
    | [integernumber]
    | [charlit]
    | [stringlit]
    | [comment]
    | =>
    | ..
    | **
    | :=
    | /=
    | >=
    | <=
    | <<
    | >>
    | <>
    | &
    | ''
    | (
    | )
    | *
    | +
    | ,
    | -
    | .
    | /
    | :
    | ;
    | <
    | =
    | >
    | '|
end define



define name
    [empty]
end define



define expression
    [expression]
end define



include "../2_lexical_elements.txl"


