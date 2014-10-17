http://github.com/BNFC/bnfc
	https://github.com/BNFC/bnfc/blob/930e53606bcebd985b5fc3fa7ebb807c59c45575/examples/OCL/OCL.cf

OCL grammar
The Object Constraint Language (OCL) is a declarative language for describing rules that apply to Unified Modeling Language (UML) models developed at IBM and now part of the UML standard.

OCL.cf
Grammar for the language. Updated to OCL 2.

Based on EBNF grammar for OCL 1.4
with some help from the grammar from the Dresden OCL compiler.

problems with lexer: OCL strings are delimited by single quotes, not double. 
  Also, for floating point numbers, OCL allows both 3e7 as well as 3E7.  
  Escaped string constants (e.g. "\\n") do not seem to work

notes: 
  no nested let-expressions according to OCL 1.4

Grammar in a broad sense fetched automatically by Vadim Zaytsev, http://grammarware.net