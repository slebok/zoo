% Calculator.Txl - simple numerical expression evaluator

% Part 1: Lexical conventions
#pragma -newline
compounds
        ==
end compounds

% Part 2: Syntax specification
define program
        [fun+]
end define

define fun
        [id] [id+] = [expression] [newline]
end define

define expression
        [expression] [op] [expression]
    |   [id] [expression+]
    |   if [expression] then [expression] else [expression]
    |   ( [expression] )
    |   [id]    
    |   [number]
end define

define op
        +
    |   -
    |   ==
end define

% Part 3: id transformation rule
function main match [program] _ [program] end function

