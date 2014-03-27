
#pragma -in 2
 
include "delphi.grammar"

include "delphi_comment_overr.grammar"


define program
    [delphi_file]
end define

function main
    replace [program]
        P [delphi_file]
    by
        P
end function