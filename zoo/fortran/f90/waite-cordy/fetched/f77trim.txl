% Trim Fortran 77 lines to delete columns 73-80
% J.R. Cordy, Queen's University, Sept 2009

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

% This is a little silly, we could just use cut, sed or awk to do this.
% But by using TXL we can easily distinguish and avoid truncating comments.

#pragma -char 

tokens
  commentline   "[cC\*]#n*\n"
  codeline      "#n*\n"
end tokens

define program
  [repeat lines]
end define

% Gather groups of comments or code lines to avoid making one humungous
% repeat structure, which can cause deep stack problems on some machines

define lines
  [repeat commentline+]
| [repeat codeline+]
end define

% Find each code line that has more than 72 columns and truncate it

rule main
  % look at each line exactly once
  replace $ [codeline]
    CodeLine [codeline]

  % we're only interested if it has more than 72 columns (73 including the newline)
  construct LengthCodeLine [number]
    _ [# CodeLine]
  where 
    LengthCodeLine [> 73]

  % don't lose the trailing newline on it
  construct Newline [codeline]
    CodeLine [: LengthCodeLine LengthCodeLine]

  % trunacte to 72 columns
  by
   CodeLine [: 1 72] [+ Newline]
end rule
