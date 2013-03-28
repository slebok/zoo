% Parse and pretty print Java code 

include "Java.Grm"
include "JavaCommentOverrides.Grm"

function main
	replace [program] 
        P [program]
    by
        P    % Add your transformation rules here
end function
