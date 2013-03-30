% Keyword normalizer for PHP 3,4,5 source
% J.R. Cordy, Queen's University, July 2011

% This program normalizes all keywords in a PHP source program
% to lower case.  The result can be processed case-sensitive
% using -nocase to simulate PHP case-sensitivity rules for
% variable names when necessary.

#pragma -case 

include "php.grm"

rule main
    skipping [IdOrKey]
    replace $ [key]
	K [key]
    by
	K [tolower]
end rule
