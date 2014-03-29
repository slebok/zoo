Visual Basic 6.0 Grammar 
Version 1.3, Sept 2010

J.R. Cordy, Queen's University, April 2006 

Reference: http://www.int.gu.edu.au/courses/3008int/m03/FYI/Command_Syntax.htm
Thanks to the HCI teaching team at Griffith University.

Example:
	txl Examples/Module1.bas

This is an approximate grammar for Visual Basic 6.0, drawn from the reference
above, old MS web pages and updated to handle many undocumented features 
by experience with parsing a number of open and closed source applications.  

This is a work in progress.

Known limitations and bugs:

1. This grammar processes VB is line-based but otherwise free-format in order to
   be convenient for transformation.  However it is not quite true that VB
   is free-format, for example:
       .picEdit.PaintPicture .picHidden1.Picture, 0, 0, , , Val(stCmd4), Val(stCmd5)
   which this grammar will mistake for:
       .picEdit.PaintPicture.picHidden1.Picture , 0, 0, , , Val (stCmd4), Val (stCmd5)
   This case is rare, but short of parsing all spacing, I don't know how to solve it.

2. As with all real languages, many features and forms are implemented but not 
   properly documented.  I've added these to the grammar as I've run across them,
   but it's not always clear what the feature's syntax is in general so these
   are approximations.

3. Comments [vbcomment] are handled and preserved, but not always well formatted
   in output.  This needs tuning in future.

4. Continuations are handled by treating the continuation symbol (_) and newline as
   ignored comments.  Thus they are not preserved in output, but rather removed
   to yield (valid) long lines instead.  If a real VB comment has a continuation, 
   this strategy fails.

5. There seems to be no definitive list of which words are keywords and which
   reserved words, or whether there is any meaningful distinction in VB.
   The keyword list below has been honed by experience.

6. Preprocessor statements only handle #if so far.

---
Rev 24.9.10
