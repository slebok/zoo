% Antoniol et al heuristic to resolve all #ifs in C programs
% Jim Cordy, Feb 2008
% Version 2.0, November 2010

% Comments out all preprocessor statements, and all #if and #elsif parts
% to leave the body of the #else part of all #ifs only

% Change Log:
% v2.0
% 	Inverted to keep #else instead of #if part - JRC 16.11.10
% v1.0
%	Refined patterns for commenting out #if 0 - JRC 19.10.09
%	Refined token patterns for #if and preprocessor lines - JRC 6.5.08
% 	Corrected token pattern for #elif - JRC 29.1.10
% 	Corrected commenting out #elif - JRC 12.11.10

#pragma -char -comment -esc '\\' -width 32767

comments
	//
end comments

tokens
    % Long comments need to be handled specially
    comment	"/\*#[(\*/)]*\*/"
end tokens

compounds
	//
end compounds

tokens
    % A preprocessor line is one beginning with a # and then anything to end of line (\n#n*)
    % If the line ends in backslash, then it continues on the next line (\\\n)
    % Comments are assumed to be part of the preprocessor line (/\*#[(\*/)]*\*/)
    ifdef_line  	  	"[ \t]*\# *ifn?(def)?[ \t\(][(\\\n)(/\*#[(\*/)]*\*/)#n]*"
    elsedef_line  	  	"[ \t]*\# *else[(\\\n)(/\*#[(\*/)]*\*/)#n]*"
    elsifdef_line  	  	"[ \t]*\# *els?ifn?(def)?[ \t][(\\\n)(/\*#[(\*/)]*\*/)#n]*"
    endifdef_line  	  	"[ \t]*\# *endif[(\\\n)(/\*#[(\*/)]*\*/)#n]*"
    other_preprocessor_line	"[ \t]*\#[(\\\n)(\"#[\"\n]*\")(/\*#[(\*/)]*\*/)#n]*"
    % Anything else, including line comments, is just a text line to us
    other_line			"#[(/\*)\n]+"
end tokens

define program
    [repeat line]
end define

define line
	[ifdef]
    | 	[opt //] [other_preprocessor_line] [newline]
    | 	[opt //] [any_other_line] [newline]
end define

define ifdef
	[opt //] [ifdef_line] [newline]
	    [repeat line]
	[repeat elsif_part]
	[opt else_part]
	[opt //] [endifdef_line] [newline]
end define

define elsif_part
	[opt //] [elsifdef_line]  [newline]
	    [repeat line]
end define

define else_part
	[opt //] [elsedef_line]  [newline]
	    [repeat line]
end define

define any_other_line
	[repeat not_newline] 
end define

define not_newline
	[long_comment]
    | 	[not ifdef_token] [not newline] [token]
end define

define long_comment
	[repeat comment+]
end define

define ifdef_token
	[ifdef_line]   
    | 	[elsedef_line]   
    | 	[elsifdef_line]   
    | 	[endifdef_line]
end define

function main
	replace [program]
		P [program]
	deconstruct * [newline] P
		NewlineToken [newline]
	construct Newline [stringlit]
		_ [quote NewlineToken]
	export Newline
	by
		P [commentOutPreprocessors]
		  [resolveIfdefs]
		  [resolveIfndefs]
		  [fixStrangeComments]
end function

rule resolveIfdefs
	replace [ifdef]
	    IfDef [ifdef_line] NL [newline]
		ThenLines [repeat line]
	    Elsifs [repeat elsif_part]
	    Else [opt else_part]
	    EndIf [endifdef_line] _ [newline]
	where not
	    IfDef [grep "ifndef "]
	by
	    // IfDef [commentContinuationsIfDef] NL 
		ThenLines [commentOutLines] 
	    Elsifs [commentOutElsifs] 
		[commentOutLines]
	    Else [commentOutFirst] [commentContinuationsElseDef] 
		% Leave these lines in
	    // EndIf [commentContinuationsEndIfDef] NL
end rule

rule resolveIfndefs
	replace [ifdef]
	    IfDef [ifdef_line] NL [newline]
		ThenLines [repeat line]
	    Elsifs [repeat elsif_part]
	    Else [opt else_part]
	    EndIf [endifdef_line] _ [newline]
	where
	    IfDef [grep "ifndef "]
	by
	    // IfDef [commentContinuationsIfDef] NL 
		% Leave these lines in
		ThenLines 	
	    Elsifs 
		[commentOutLines]
	    Else [commentOutFirst] [commentContinuationsElseDef] 
		[commentOutLines]
	    // EndIf [commentContinuationsEndIfDef] NL
end rule

function commentOutFirst
	replace * [opt //]
	by
		//
end function

rule commentOutPreprocessors
	replace [line]
	    PrepLine [other_preprocessor_line] NL [newline]
	by
	    // PrepLine [commentContinuationsPrepLine] NL
end rule

rule commentOutElsifs
	replace [elsif_part]
	    ElsifLine [elsifdef_line] NL [newline]
	        Lines [repeat line]
	by
	    // ElsifLine NL
		Lines
end rule

rule commentOutLines
	replace $ [line]
	    Line [line]
	by
	    Line [commentOut]
 		 [commentContinuationsIfDef]
 		 [commentContinuationsElseDef]
 		 [commentContinuationsEndIfDef]
 		 [commentContinuationsPrepLine]
 		 [commentContinuationsCommentLine]
end rule

rule commentOut
	replace [opt //]
	by
	    //
end rule

rule commentContinuationsIfDef
	import Newline [stringlit]
	replace $ [ifdef_line]
		IfDef [ifdef_line]
	construct NewlineIndex [number]
		_ [index IfDef Newline]
	deconstruct not NewlineIndex
		0
	construct PreNewline [ifdef_line]
		IfDef [: 1 NewlineIndex]
	construct NewlinePlus1 [number]
		NewlineIndex [+1]
	construct PostNewline [ifdef_line]
		IfDef [: NewlinePlus1 9999] [commentContinuationsIfDef]
	by
		PreNewline [+ "//"] [+ PostNewline] 
end rule

rule commentContinuationsElseDef
	import Newline [stringlit]
	replace $ [elsedef_line]
		ElseDef [elsedef_line]
	construct NewlineIndex [number]
		_ [index ElseDef Newline]
	deconstruct not NewlineIndex
		0
	construct PreNewline [elsedef_line]
		ElseDef [: 1 NewlineIndex]
	construct NewlinePlus1 [number]
		NewlineIndex [+1]
	construct PostNewline [elsedef_line]
		ElseDef [: NewlinePlus1 9999] [commentContinuationsElseDef]
	by
		PreNewline [+ "//"] [+ PostNewline] 
end rule

rule commentContinuationsEndIfDef
	import Newline [stringlit]
	replace $ [endifdef_line]
		EndIfDef [endifdef_line]
	construct NewlineIndex [number]
		_ [index EndIfDef Newline]
	deconstruct not NewlineIndex
		0
	construct PreNewline [endifdef_line]
		EndIfDef [: 1 NewlineIndex]
	construct NewlinePlus1 [number]
		NewlineIndex [+1]
	construct PostNewline [endifdef_line]
		EndIfDef [: NewlinePlus1 9999] [commentContinuationsEndIfDef]
	by
		PreNewline [+ "//"] [+ PostNewline] 
end rule

rule commentContinuationsPrepLine
	import Newline [stringlit]
	replace $ [other_preprocessor_line]
		PrepLine [other_preprocessor_line]
	construct NewlineIndex [number]
		_ [index PrepLine Newline]
	deconstruct not NewlineIndex
		0
	construct PreNewline [other_preprocessor_line]
		PrepLine [: 1 NewlineIndex]
	construct NewlinePlus1 [number]
		NewlineIndex [+1]
	construct PostNewline [other_preprocessor_line]
		PrepLine [: NewlinePlus1 9999] [commentContinuationsPrepLine]
	by
		PreNewline [+ "//"] [+ PostNewline] 
end rule

rule commentContinuationsCommentLine
	import Newline [stringlit]
	replace $ [comment]
		Comment [comment]
	construct NewlineIndex [number]
		_ [index Comment Newline]
	deconstruct not NewlineIndex
		0
	construct PreNewline [comment]
		Comment [: 1 NewlineIndex]
	construct NewlinePlus1 [number]
		NewlineIndex [+1]
	construct PostNewline [comment]
		Comment [: NewlinePlus1 9999] [commentContinuationsCommentLine]
	by
		PreNewline [+ "//"] [+ PostNewline] 
end rule

rule fixStrangeComments
	replace $ [other_line]
		Line [other_line]
	construct StrangeIndex [number]
		_ [index Line "/*/"]
	deconstruct not StrangeIndex
		0
	construct PreStrange [other_line]
		Line [: 1 StrangeIndex]
	construct StrangePlus1 [number]
		StrangeIndex [+1]
	construct PostStrange [other_line]
		Line [: StrangePlus1 9999] 
	by
		PreStrange [+ "//"] [+ PostStrange] 
end rule
