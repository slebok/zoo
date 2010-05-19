% Test of Ada 2005 grammar

include "ada.grm"

include "ada_commentoverrides.grm"`

function main
    match [program]	
	_ [program]
end function
