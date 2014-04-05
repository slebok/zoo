A complete TXL base grammar for Modula-3.

Adapted from the TXL-3 base grammar for Modula-3 by Michel Dagenais,
Copyright (C) 1997  Michel Dagenais (dagenais@vlsi.polymtl.ca)

Distributed under the GNU general public license (see the header 
comments in the grammar for complete details).

This grammar was tested on Modula-3's libm3 and ui, which together 
comprise almost 500 modules and interfaces.

It has the following known limitations:

  - Pragmas are treated as comments
  - The Modula-3 syntax allows for ExtendedChar in TextLiteral and CharLiteral
    but these were not entered in the corresponding TXL stringlit and charlit
    token statements.

Note that this grammar does not follow TXL naming conventions for nonterminals,
but rather uses the Modula-3 nonterminal naming conventions.

Note that this grammar does not allow for preserving comments in output.

Example: 
    txl Examples/Bootstrap.m3

Rev 21.3.01