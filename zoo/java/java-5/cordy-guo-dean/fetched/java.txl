% Parser for Java programs
% Jim Cordy, January 2008

% Using Java 5 grammar
include "java.grm"

% Uncomment to parse and preserve comments
% #define COMMENTS

#ifdef COMMENTS
    include "javaCommentOverrides.grm"
#endif

function main
    match [program]
	P [program]
end function
