TXL Grammar for Borland Delphi 2006 

Jorge L. Cangas, December 2007

delphi.grammar : 
    Main grammar file. Contains support for Delphi 2006 features.
    - class helpers.
    - for in enunerator oriented loops.

    Then the grammar allow things that not will compile. Of course we have yet a Delphi compiler:
    The grammar is oriented to allow TXL transformations, so some things are 'unified' in any way.
    The idea is: "if it compile, it pass the txl grammar: then can be transformed easy"

delphi_comment_overr.grammar: 
    Grammar overrides for comments. The block comments are managed in 
    the grammar (not in comments section), in order to diferentiate 'pure' comments from preprocessor
    instructions.

delphidfm.grammar: 
    Grammar to parse .dfm Delphi Form files. Of course the .dfm need saved 
    in text format (Editor context menu) o with the convert tool (in $(Delphi)/bin)

delphipp.grammar: 
    Grammar to parse preprocessor code

asm.grammmar: 
    You can include this in your TXL prpogramm if you use assembler in your delphi code.
    I don't understand asm very good: I extracted this grammar from Delphi documentation.

I tested these grammars with Delphi VCL & RTL source code.
If you enhance something, please let me know at jorge.cangas@gmail.com
