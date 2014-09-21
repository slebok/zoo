% Program to explicate standard Python INDENT/DEDENT symbols
% J.R. Cordy, Queen's University, November 2008

% Copyright 2008 James R. Cordy

% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
%    Redistributions of source code must retain the above copyright notice, 
%    this list of conditions and the following disclaimer.
%    Redistributions in binary form must reproduce the above copyright notice,
%    this list of conditions and the following disclaimer in the documentation
%    and/or other materials provided with the distribution.
%
%    THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
%    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
%    AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
%    AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
%    OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
%    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
%    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
%    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
%    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%    POSSIBILITY OF SUCH DAMAGE.

% Modification Log:

% v1.3, Jim Cordy, 13 November 2008.
%    Validated against 1,500 random Python programs, 
%    including the entire Python demo set
%
% v1.2, Jim Cordy, 12 November 2008.
%    Changed to Python INDENT / DEDENT syntax rather than { }
%    Added proper handling of long strings 
%    Added proper handling of Python { }, [ ] and ( ) compound structures 
%    Added proper handling of comments and blank lines
%
% v1.1, Jim Cordy, November 2008.
%    Fixed problem caused by empty lines.
%
% v1.0, Jim Cordy, November 2008.
%    Initial revision.

% This is a character-level transformation
#pragma -char -comment -w 32000

% We need to expand tabs and count spaces, so override [space] to be a single blank
% and define a [tab] token for a single tab character
tokens
    space 	" "
    tab		"	"	% ASCII TAB (ctrl-i) character
end tokens

% Python long tokens
tokens 
    longstringlit	"\"\"\"#[(\"\"\")]*\"\"\""
    longcharlit		"'''#[(''')]*'''"
end tokens

% Python comemnts
comments
    '#
end comments

% For this transformation, the input is a sequence of lines
define program
    [repeat line]
end define

% Each input line consists of spacing indentation followed by the contents of the line
% the [opt indent] and [repeat dedent] allow us to insert { } as needed
define line
    [repeat tab_space] [repeat linetoken] [opt indent] [repeat endofline+] [repeat dedent]
end define

% End of line handles trailing comments and trailing blank and comment lines
define endofline
    [repeat tab_space] [opt comment] [newline]
end define

% We infer the standard Python implcit INDENT / DEDENT symbols from
% the indentation in the program using the Python offside rules
define indent
    [SP] 'INDENT
end define

define dedent
    'DEDENT [SP]  
end define

define tab_space
    [tab] | [space]
end define

define linetoken
	[tab_space]
    |   [nonblank_token]
end define

define nonblank_token
        [compound]
    | 	[not newline] [not comment] [token]
end define

% We need to be careful to treat Python atomic structures specially,
% so that we don't mistake the newlines and indentations in them as
% meaningful
define compound
	'{ [repeat compoundtoken] '}
    | 	'[ [repeat compoundtokensquare] ']
    | 	'( [repeat compoundtokenround] ')
end define

define compoundtoken
	[not '}] [linetoken]
    |	[newline]
    |	[comment]
end define

define compoundtokensquare
	[not ']] [linetoken]
    |	[newline]
    |	[comment]
end define

define compoundtokenround
	[not ')] [linetoken]
    |	[newline]
    |	[comment]
end define

% The main program - expands tabs to spaces, then infers where INDENT / DEDENT
% go using Python offside rules
function main
    replace [program]
        Lines [repeat line]
    by
	Lines [markEOF]
	      [deleteRedundantSpaces]
	      [expandTabs]
	      [insertIndents]
	      [unmarkEOF]
end function

% Leading spaces before a tab are assumed meaningless
rule deleteRedundantSpaces
    replace [repeat tab_space]
        _ [space] Tab [tab]
    by
        Tab
end rule

% According to the Python spec, each leading tab expands to exactly 8 spaces
rule expandTabs
    construct Space [space]
        _ [unquote " "]
    replace [repeat tab_space]
        Tab [tab] Rest [repeat tab_space]
    by
        Space Space Space Space Space Space Space Space Rest
end rule

% Insert a { before each new indentation level ...
rule insertIndents
    replace [repeat line]
        Space1 [repeat tab_space] Content1 [repeat linetoken] NL [repeat endofline+] Dedents1 [repeat dedent] 
	Rest [repeat line]
    deconstruct * [nonblank_token] Content1
    	_ [nonblank_token]
    deconstruct not * [nonblank_token] Content1
    	'\
    deconstruct Rest
        Space2 [repeat tab_space] Content2 [repeat linetoken] _ [opt indent] _ [repeat endofline+] _ [repeat dedent]
	_ [repeat line]
    deconstruct * [nonblank_token] Content2
    	_ [nonblank_token]
    construct LengthSpace1 [number]
        _ [length Space1]
    construct LengthSpace2 [number]
        _ [length Space2]
    where
        LengthSpace2 [> LengthSpace1]
    by
        Space1 Content1 'INDENT NL Dedents1 
	Rest [insertDedent Space1]
end rule

% ... and a } before the corresponding dedent from that level
function insertDedent Space [repeat tab_space]
    replace * [repeat line]
	Space1 [repeat tab_space] Content1 [repeat linetoken] Indent1 [opt indent] NL [repeat
	endofline+] Dedents1 [repeat dedent]  
        Space2 [repeat tab_space] Content2 [repeat linetoken] Indent2 [opt indent] NL2 [repeat
	endofline+]  Dedents2 [repeat dedent]  
	Rest [repeat line]
    deconstruct * [nonblank_token] Content2
    	_ [nonblank_token]
    construct LengthSpace [number]
        _ [length Space]
    construct LengthSpace2 [number]
        _ [length Space2]
    where
        LengthSpace2 [<= LengthSpace]
    by
        Space1 Content1 Indent1 NL 'DEDENT Dedents1  
        Space2 Content2 Indent2 NL2 Dedents2 
	Rest
end function

function markEOF
    construct OptNL [opt newline]
        _ [parse ""]
    deconstruct OptNL
	NL [newline]
    replace [repeat line]
        Lines [repeat line]
    construct EOFline [line]
        'EOF NL
    by
        Lines [. EOFline]
end function

function unmarkEOF
    replace * [repeat line]
        'EOF NL [newline]
    by
end function
