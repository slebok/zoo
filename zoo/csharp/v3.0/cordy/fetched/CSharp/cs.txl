% C# parser based on the TXL C# grammar
% March 2006 (Revised Oct 2010)

% Simple null program to test the C# grammar

% TXL ECMA-334 C# Grammar
include "CSharp.grm"

% Comment out this line to use grammar without preserving comments
% #define COMMENTS

% Experimental overrides to allow for comment preservation
#ifdef COMMENTS
    include "CSharpCommentOverrides.grm"
#endif

% Comment out this line to use grammar without preserving intentional extra newlines
% #define NEWLINES

% Experimental overrides to allow for preservation of intentional extra newlines
#ifdef NEWLINES
    include "CSharpPreserveNewlines.grm"
#endif

% Temporary handling of designated Linq extensions
redefine invocation_operator
	...
    |	'(( [repeat argument_list_or_key] '))
end redefine

define argument_list_or_key
	[argument_list]
    |	'in
end define

% Just parse
function main
    replace [program] 
        P [program]
    by
	P
	#ifdef NEWLINES
	    [preserveNewlines]
	#endif
end function

