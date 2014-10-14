IBM VS COBOL II
The SLPS copy of GRK

Two deliverables are derived from IBM's standard for VS Cobol II: a
re-engineered Cobol reference and a Cobol prototype parser. This will
involve a number of steps that are reported on the standard output.
See the Makefile in grammars/vscobolii for an detailed overview of the
steps. The final step is to parse a simple Cobol program. For legal
reasons, we cannot distribute actual Cobol projects with this
distribution.

The test deals with the following files:

- grammars/vscobolii/ibm.html
  This is IBM's standard which serves as input for grammar recovery.

- grammars/vscobolii/ibm-transformed.html
  This is the improved document adapted by commented grammar
  transformations for grammar recovery.

- grammars/vscobolii/ibm-transformed.pl
  This is a DCG (Prolog) serving as prototype parser. It has derived
  by applying some further grammar transformations for deployment to
  the recovered grammar.

- grammars/vscobolii/recovery/*.fst
  These are transformation scripts for grammar recovery.

- grammars/vscobolii/deployment/*.fst
  These are transformation scripts for grammar deployment.

GRK is based on library functionality for Prological language
processing and tools that automate certain aspects of grammar
engineering; see the subdirectories lib and tools.

Copyright (c) 2003 Ralf Laemmel, Vrije Universiteit Amsterdam, CWI (To
the extent possible: this work reverse and re-engineers IBM's VS Cobol
II application programming reference which is (C) IBM.  The
transformation scripts and the method for recovery and deployment are
Copyright (c) 2003 Ralf Laemmel, Vrije Universiteit Amsterdam, CWI.)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

