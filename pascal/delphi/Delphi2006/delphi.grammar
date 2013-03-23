% Name:   delphi.grammar
% Purpose:  TXL Grammar for Borland Delphi Language
% Author:   Jorge L. Cangas

#if not _delphi_grammar_ then
#define _delphi_grammar_

#pragma -case
#pragma -w 256

compounds
    :=  >=  <=  <>  {$  (*$  (*   *)  //
end compounds

tokens
    charlit "[(\#\d+)(\#$[\dABCDEFabcdef]+)('[('')#']*')]+"
    hexnumber "$[\dABCDEFabcdef]+" | "0[\dABCDEFabcdef]+H"
end tokens

comments
     //

     { }
     (* *)
     {$ }
     (*$ *)
end comments

keys
% type
      'label 'array  'record    'file  'set  'string
      'class 'object 'interface 'dispinterface 'helper
% members
      'property  'constructor  'destructor  'procedure  'function
% operators
      'and 'or 'not 'xor 'div 'mod 'shl 'shr
      'nil 'is 'as 'in
%sections
      'program 'unit 'library
      'uses 'interface 'implementation 'initialization 'finalization
      'type  'const 'var 'threadvar 'asm 'resourcestring
% control 
      'begin  'end
      'case   'of
      'for 'to  'downto
      'if 'then 'else
      'until  'repeat
      'while 'do
      'try  'finally 'except
      'goto 'raise
      'with
%modifiers
      'packed  'inherited 'out 'exports 'inline 
end keys

%------------------------------ common definitions  ------------------------------------------------------

redefine anynumber
        [hexnumber]
    |   [number]
end define

define label_id
    [anynumber] | [id]
end define

define builtinid %valid id that is a keyword
    'string | 'file | 'set
end define

define name
        [builtinid]
    |   [id]
end define

define namespace
    %[SPOFF]
	[id] '.
end define

define qualified_id
    [repeat namespace] [name] [SPON]
end define

define filenamelit
    [charlit] | [stringlit] | [qualified_id]
end define

define colon
    [SPOFF]
	':
	[SPON]
end define

define equal
    '=
end define

define end_struct
    'end
end define

define semi_calling_spec
        [opt ';] [calling_spec]
end define

define calling_spec
    'pascal | 'safecall | 'stdcall | 'cdecl | 'register | 'local
end define

define hint_directive
     'platform | 'deprecated | 'library
end define

define ctrlchar
        '^'A    |   '^'B    |   '^'C  |   '^'D    |   '^'E   |   '^'F
    |   '^'G    |   '^'H    |   '^'I  |   '^'J    |   '^'K   |   '^'L
    |   '^'M    |   '^'N    |   '^'O  |   '^'P    |   '^'Q   |   '^'R
    |   '^'S    |   '^'T    |   '^'U  |   '^'V    |   '^'W   |   '^'X
    |   '^'Y    |   '^'Z
end define

%----------------------------------    top level - file types  --------------------------------------------

define delphi_file
      [program_file]
    | [package_file]
    | [unit_file]
end define

define file_end
    '.
end define

define program_file % (*.dpr)
    [program_decl]
    [opt uses_clause]
    [impldecl_block]
    [procedure_body]
    [file_end]
end define

define package_file % (*.dpk)
    [package_decl]
    [opt requires_clause]
    [opt contains_clause]
    [end_struct]
    [file_end]
end define

define unit_file % (*.pas)
    [unit_decl]
    [interface_section]
    [implementation_section]
    [opt initialization_section]
    [opt finalization_section]
    [end_struct]
    [file_end]
end define

define program_decl
        'program [qualified_id] [opt program_file_list] '; [NL]
    |   'library [qualified_id] '; [NL]
end define

define package_decl
    'package [qualified_id] ';  [NL]
end define

define unit_decl
    'unit [qualified_id] [opt hint_directive] '; [NL]
end define

define program_file_list
   '( [list id] ')
end define

define requires_clause
    'requires [list qualified_id] '; [NL]
end define

define contains_clause
    'contains [list uses_item] '; [NL]
end define

define uses_clause
     'uses [NL] [IN][list uses_item] '; [EX][NL]
end define

define uses_item
   [qualified_id] [opt in_filename]
end define

define in_filename
    'in [filenamelit]
end define

define initialization_kw
    'initialization | 'begin
end define

define implementation_kw
    'implementation [NL]
end define

define finalization_kw
    'finalization  
end define

define interface_kw
    'interface [NL]                 
end define

define interface_section
    [interface_kw]
    [opt uses_clause]
    [intfdecl_block]
end define

define implementation_section
    [implementation_kw]
    [opt uses_clause]
    [impldecl_block]
end define

define initialization_section
   [initialization_kw] [NL]
   [statement_list]
end define

define finalization_section
    [finalization_kw]
    [statement_list]
end define

define intfdecl_block
    [repeat intfdecl_section]
end define

define impldecl_block
    [repeat impldecl_section]
end define

define nested_decl_block
    [repeat nested_decl_section]
end define

%--------------------------   declarations ------------------------------------------------

define identlist
    [id][repeat colon_id]
end define

define colon_id
    ', [NL] 
    [id]
end define

define intfdecl_section
        [const_section]
    |   [type_section]
    |   [var_section]
    |   [label_decl]

    |   [procedure_intf_decl]

    |   [procedure_external_decl]     
    |   [resource_section]
    |   [exports_section]
end define

define impldecl_section
        [const_section]
    |   [type_section]
    |   [var_section]
    |   [label_decl]

    |   [procedure_impl_decl]         
    
    |   [procedure_external_decl]     
    |   [resource_section]
    |   [exports_section]

end define

define nested_decl_section
        [const_section]
    |   [type_section]
    |   [var_section]
    |   [label_decl]

    |   [procedure_impl_decl]
end define


define label_decl
    'label [list label_id] '; [NL]
end define

define exports_section
    'exports [list exports_entry] '; [NL]
end define

define exports_entry
    [procedure_id][opt formal_parameters][opt external_name]
end define

define resource_section
    'resourcestring                     
        [repeat constant_decl+]          
end define

define const_section
     'const [NL]                           
    [IN][repeat constant_decl+][EX]
end define

define constant_decl
      [identlist][constant_spec][opt hint_directive]'; [NL]
end define

define constant_spec
    [equal][expr]   |  [colon_type][const_init]
end define

define const_init
    [equal][typed_const]
end define

define typed_const
    [array_constant]    |   [record_constant]  |   [expr]
end define

define array_constant
    '( [list typed_const]  ')
end define

define record_field_constant
     [id][colon][typed_const]
end define

define record_constant
    '( [repeat record_field_constant_semi] [opt record_field_constant] ')
end define

define record_field_constant_semi
    [record_field_constant] '; [NL]
end define

define var_section
    [var_keyword][NL]
    [IN][repeat var_decl+][EX]
end define

define var_keyword
    'var   | 'threadvar
end define

define var_decl
    [identlist][colon_type][opt hint_directive] [opt var_init] '; [NL]
end define

define var_init
      [absolute_init]
    | [const_init]
end define

define absolute_init
    'absolute [expr]
end define

%-----------------------------  Type Declarations   ---------------------------------

define type_section
    'type [NL]
       [IN][repeat type_decl+][EX]
end define

define type_decl
    [identlist][equal][opt 'type][type_spec][opt hint_directive] '; [NL]
end define

define type_spec
        [simple_type]
    |   [string_type]
    |   [struct_type]
    |   [pointer_type]
    |   [procedural_type]
    |   [variant_type]
    |   [class_reference_type]
    |   [class_type]
    |   [interface_type]
    |   [qualified_id]
end define

define real_type
       'real | 'real48 |  'single | 'double | 'extended | 'comp | 'currency
end define

define integer_type
      'shortint | 'smallint | 'longint | 'int64 | 'word | 'byte | 'longword
      | 'integer | 'cardinal
end define

define char_type
    'char | 'ansichar | 'widechar
end define

define boolean_type
    'boolean | 'bytebool | 'wordbool | 'longbool
end define

define variant_type
        'variant | 'olevariant
end define

define string_type
    'string | 'shortstring | 'ansistring | 'widestring | 'string '[ [expression] ']
end define

define enumerated_type
    '( [list enum_spec+] ')
end define

define enum_spec
    [id][opt param_init]
end define

define subrange_type
    [expression] [SPOFF] [dotdot_expr] [SPON]
end define

define dotdot_expr
    '.. [expression]
end define

define ordinal_type
        [integer_type] | [char_type]    | [enumerated_type] 
    |   [boolean_type] | [subrange_type]
end define

define simple_type
      [ordinal_type]  | [real_type]
end define

define struct_type
        [set_type]
    |   [array_type]
    |   [file_type]
end define

define of_basetype
    'of [type_spec]
end define

define of_object
    'of 'object
end define

define of_const
    'of 'const
end define

define set_type
    'set [of_basetype]
end define

define file_type
   'file [opt of_basetype]
end define

define pointer_type
    '^ [SPOFF] [qualified_id][SPON]
end define

define procedural_type
    [procedure_intf_decl][opt of_object][repeat semi_calling_spec]
end define

define colon_type
    [colon][type_spec]
end define

define array_type
        'array [of_const]
    |   [opt 'packed]'array [repeat array_index_list] [of_basetype]
end define

define array_index_list
    '[ [list array_index] ']
end define

define array_index
    [ordinal_type] | [qualified_id]
end define

define procedure_id
    [opt namespace][id]
end define

define procedure_impl_decl
    [NL]
    [procedure_intf_decl]
    [nested_decl_block]
    [procedure_body_semi]
end define

define external_directive
    'external [opt expr] [opt external_name]
end define

define external_name
     'name [expr]
   | 'index [expr]
end define

define semi_directive
    [opt ';][directive]
end define

define directive
      'dynamic | 'virtual | 'abstract | 'message [opt qualified_id] 
    | 'dispid [opt sign][anynumber]
    | 'override | 'overload | 'reintroduce | 'static
    | 'assembler | 'far | 'export
    | [hint_directive]
    | [calling_spec]
end define

define procedure_intf_decl
    [procedure_signature][repeat semi_directive][opt ';] [NL]
end define

define procedure_signature
    [opt 'class][procedure_keyword][opt procedure_id][opt formal_parameters][opt colon_type]
end define

define procedure_external_decl
    [procedure_intf_decl][external_directive][opt semi_calling_spec][opt ';] [NL]
end define

define procedure_keyword
        'function 
    |   'procedure
    |   'constructor
    |   'destructor
end define

define formal_parameters
    '( [formal_parameter][repeat semi_formal_parameter] ')
end define

define semi_formal_parameter
    '; [formal_parameter]
end define

define formal_parameter
    [opt parm_qual] [parameter]
end define

define parm_qual
    'var | 'const | 'out
end define

define parameter
    [list id] [opt parameter_type]
end define

define parameter_type
    [colon_type] [opt param_init]
end define

define param_init
   [equal][expr]
end define

define procedure_body_semi
   [procedure_body] '; [NL]
end define

define procedure_body
        [sequence_stm]
    |   'forward %forward replaces the body: see Delphi Language Grammar in Help
end define

%---------------------------    class declarations  ------------------------------------

define heritage_list
    '( [list qualified_id] ')
    | 'helper 'for [id]
end define

define class_keyword
    'class | 'record | 'object % object is legacy
end define

define interface_keyword
    'interface | 'dispinterface
end define

define guid_decl
    '[ [expr] ']
end define

define class_reference_type
    'class 'of [qualified_id]
end define

define class_type
    [opt 'packed] % support record
    [class_keyword] [opt heritage_list]
    [NL][opt class_body] % end can be omited if no members: TDerived = class(TComponent);
end define

define class_body
    [visibility_default]
    [repeat visibility_block]
    [end_struct]
end define

define interface_body
    [visibility_default]
    [end_struct]
end define

define interface_type
    [interface_keyword] [opt heritage_list] [opt guid_decl]
    [opt interface_body]
end define

define visibility_default
    [IN][repeat class_member][EX]
end define

define visibility_block
    [visibility][NL]
    [IN][repeat class_member][EX]
end define

define method_decl
        [procedure_signature][method_deleg]
    |   [procedure_signature] '; [dispid_spec] ';
    |   [procedure_intf_decl] 
end define

define method_deleg
    [equal][qualified_id] '; [NL]
end define

define visibility
        'public
    |   'protected
    |   [opt 'strict] 'private
    |   'published
    |   'automated
end define

define variant_section
    'case [opt id_colon] [type_spec] 'of [repeat record_variant+]
end define

define id_colon
    [id] [colon]
end define

define record_variant
    [list expr+] [colon] '( [visibility_default] ') [opt ';]  [NL]
end define

define class_member
      [var_decl]
    | [method_decl]
    | [property_decl]
    | [variant_section] %to support record variant type
end define

define property_decl
   'property [id] [opt prop_indexes] [opt colon_type] [repeat prop_specifier] [opt defaultarray_spec] '; [NL]
end define

define defaultarray_spec
    '; 'default 
end define

define prop_indexes
    '[ [repeat prop_index_decl+] ']
end define

define prop_index_decl
    [list prop_index_name+][colon_type][opt ';] 
end define

define prop_index_modifier
        'const   |   'var
end define

define prop_index_name
        [opt prop_index_modifier][qualified_id]
end define

define prop_specifier
      [index_spec]
    | [accessor_spec]
    | [stored_spec]
    | [default_spec]
    | [implements_spec]
    | [dispid_spec]
end define

define dispid_spec
     'dispid[SP][expr]
end define

define index_spec
    'index[SP][expr]
end define

define accessor_spec
        'readonly %in dispinterface
    |   'writeonly %in dispinterface
    |   [accessor_verb] [qualified_id]
end define

define accessor_verb
        'read | 'write
end define

define stored_spec
        'stored[SP][expr]
end define

define default_spec
        'default[SP][expr]    |   'nodefault
end define

define implements_spec
        'implements [list qualified_id]
end define

%----------------------------   Expressions ----------------------------------------

define expr
 	[SP][SPOFF]	[expression] [SPON]
end define

define expression
    [term] [repeat infix_expr]
end define

define term
    [repeat prefix_opr][atom_expr][repeat postfix_opr]
end define

define infix_expr
    [SP][infix_opr][SP][term]        
end define

define atom_expr
        [charlit]
    |   [anynumber]
    |   [ctrlchar]
    |   'nil
    |   '([expression]')
    |   [set_constructor]
    |   [qualified_id] 
end define

define sign
    '+ | '-
end define

define prefix_opr
       'not [SP]
    | 'inherited [SP]
    |  '@
    | [sign]
end define

define postfix_opr        
        [arguments]
    |   [array_subscript]
    |   '.[id]  % for member access: prec^.fields[2]
    |   '^
end define

define infix_opr
        % relation
        '> |  '< | '<= | '>= | '<> | '= | 'in |'is | 'as
        % add
    |   '+ | '- | 'or | 'xor
        % mul
    |   '* | '/ | 'div | 'mod | 'and | 'shl | 'shr | '^
end define

define set_constructor
    '[ [opt set_element][repeat semi_set_element] '] %don't use list: allow pretty format
end define

define arguments
   '( [opt argm][repeat semi_argm] ') %don't use list: allow pretty format
end define

define array_subscript
   '[ [opt expression][repeat semi_expression] '] %don't use list: allow pretty format
end define

define semi_argm
    ', [SP][argm]
end define

define semi_set_element
    ', [SP][set_element]
end define

define semi_expression
    ', [SP][expression]
end define

define set_element
    [expression] [opt dotdot_expr]
end define

define argm
    [expression][opt argmfmt][opt argmfmt] %width & precision
end define

define argmfmt
  ': [anynumber]
end define

%-----------------------    Statements  ---------------------------------------------

define labelid_colon
    [label_id] [colon]
end define

define statement_list
    [IN]
    [repeat statement_semi]
    [opt statement][!]
    [EX]
end define

define statement_semi
    [opt statement] '; [NL]
end define

define statement
    [opt labelid_colon] [unlabeled_stm]
end define

define unlabeled_stm
        [sequence_stm]
    |   [loop_stm]
    |   [with_stm]
    |   [try_finally_stm]
    |   [try_except_stm]
    |   [selection_stm]
    |   [jump_stm]
    |   [assign_stm]
    |   [call_stm]
end define

define assign_stm
     [expr]':= [expr]
end define

define call_stm
        [expr]   
    |   'inherited
end define

define jump_stm
     [goto_stm]   |   [raise_stm]
end define

define goto_stm
     'goto [label_id]
end define

define sequence_stm
    'begin [NL]
         [statement_list]
    [end_struct]
end define

define loop_stm
        'repeat [statement_list] 'until [expr]
    |   'while [expr] 'do [nested_stm]
        % for variable always local declared!
    |   'for [id]':=[expr] [to_or_downto] [expr] 'do [nested_stm]
    |   'for [id] in [id] 'do [nested_stm]
end define

define selection_stm
        'if [expr] 'then [nested_stm][opt else_stm]
    |   'case [expr] 'of 
            [repeat case_selector]
            [opt case_else]
        [end_struct]
end define

define with_stm
    'with [list expr+] 'do [nested_stm]
end define

define try_finally_stm
    'try [NL]
      [statement_list]
    'finally[NL]
      [statement_list]
    [end_struct]
end define

define try_except_stm
    'try [NL]
      [statement_list]
    'except[NL]
      [exception_block] 
    [end_struct]
end define

define nested_stm
    [sequence_stm] | 
    [NL][IN][opt statement][EX]
end define

define else_stm
     [NL]'else [nested_stm]
end define

define case_selector
    [list case_label][colon][nested_stm][opt ';] %last branch don't requires ';
end define

define case_label
    [expr] [opt dotdot_expr]
end define

define case_else
    'else
        [statement_list]
end define

define to_or_downto
    'to | 'downto
end define

define exception_block
        [exception_handler_list]
        [opt case_else]
    |   [statement_list]
end define

define exception_handler_list
       [repeat exception_handler_semi]
       [opt exception_handler]
end define

define exception_handler_semi
    [exception_handler] '; [NL]
end define

define exception_handler
    'on [opt exception_var] [type_spec] 'do [nested_stm]                           
end define

define exception_var
    [id][colon]
end define

define raise_stm
    'raise [opt expr] [opt at_address]
end define

define at_address
    'at [expr]
end define

#end if