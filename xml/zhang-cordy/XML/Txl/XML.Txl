% Parse and Check Well-formedness of XML 1.0 Documents
% Hongyu Zhang & Jim Cordy
% Source Transformation Project
% Queen's University, June 2001

include "XML.Grammar"
include "XML_WellFormed.Rul"

% Uncomment this line if you'd like pure un-pretty-printed XML output
% #pragma -indent 0

function main
    replace [program]
        XMLdoc [program]
    by
        XMLdoc [checkWellFormed]
end function
    
