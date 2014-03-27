% Convert Fortran 77 end-label DO statements to Fortran 90 ENDDO statements
% J.R. Cordy, Queen's University
% September 2009

% Copyright 2009 James R. Cordy

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

% The unified Fortran grammar
include "fortran.grm"

% Convert every F77 DO statement in the program

rule main
    % FInd an F77 end-label DO statement
    replace [DoConstruct]
	  Lbl [LblDef] 'do DoLbl [DoLblRef] Control [CommaLoopControl] EOS [EOS] 
	      DoStmts [repeat ExecutionPartConstruct] 
  	  EndDoLbl [DoLblDef] EndDoLabelStmt [ActionStmt]  

    % Transfer the DO end-label to the ending statement itself,
    % and add it to the statements in the DO loop
    construct LastStmt [ExecutionPartConstruct]
	 EndDoLabelStmt [addLabelIfReferenced DoLbl DoStmts]
    construct NewStmts [repeat ExecutionPartConstruct]
	 DoStmts [appendIfNotContinue LastStmt] 

    % Reparse the statements in the DO loop in case there was an inner loop using
    % the same end-label.  Reparsing will now expose it as its own end-label DO loop,
    % giving us another opportunity to convert
    construct NewBody [repeat ExecutionPartConstruct] 
	_ [reparse NewStmts]

    % The result is the original DO statement in F90 form,
    % with the reparsed body including the original end-label statement
    by
	Lbl 'do Control EOS
	    NewBody
	'enddo EOS
end rule

% Transfer the end-label of the original DO statement
% to the new inner copy of the original end-label stsatement,
% if the label is still referenced in the statments of the loop

function addLabelIfReferenced DoLbl [DoLblRef] DoStmts [repeat ExecutionPartConstruct]
    % Get the DO end-label
    deconstruct * [Icon] DoLbl
	LabelIcon [Icon]

    % Make it a statement label
    construct Label [Label]
	LabelIcon 

    % Check if it is still used inside the loop 
    % (if not, we don't need to preserve it since it is illegal to refer to 
    % and F77 DO end-label from outside the loop)
    deconstruct * [Label] DoStmts
	LabelIcon

    % And add it to the statement
    replace * [LblDef]
    by
	Label
end function

% The end-label statement needs to be appended to the statments inside the loop,
% but we can simply delete it if it is an unlablled CONTINUE

function appendIfNotContinue LastStmt [ExecutionPartConstruct]
    % Check that it is not an unlabelled CONTINUE statement
    deconstruct not LastStmt
	'continue _ [EOS]

    % If not, then append it to the inner statements
    replace [repeat ExecutionPartConstruct]
        InnerStmts [repeat ExecutionPartConstruct]
    by
	InnerStmts [. LastStmt]
end function
