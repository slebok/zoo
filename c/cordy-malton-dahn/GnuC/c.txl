% Parser for C programs
% Jim Cordy, January 2008

% Using Gnu C grammar
include "c.grm"

% Main function 
function main
    match [program]
	P [program]
end function
