% Eiffel Version 3 (June/July 1995) Grammar
% Adapted directly from 
% Eiffel: The Reference, ISE Technical Report TR-EI-41/ER, version 3, June/July 1995
% by Jim Cordy (cordy@cs.queensu.ca)
% March 2006

% Simple null program to test the Eiffel grammar

% TXL Eiffel Version 3 Grammar
include "Eiffel.Grm"

% Just parse
function main
    match [program] 
        _ [program]
end function
