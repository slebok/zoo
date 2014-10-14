statement_verb -->
  (@("ACCEPT") ; @("ADD") ; @("ALTER") ; @("CALL") ; @("CANCEL") ; @("CLOSE") ; @("COMPUTE") ; @("CONTINUE") ; @("DELETE") ; @("DISPLAY") ; @("DIVIDE") ; @("ENTRY") ; @("EVALUATE") ; @("EXIT") ; @("GOBACK") ; @("GO") ; @("IF") ; @("INITIALIZE") ; @("INSPECT") ; @("MERGE") ; @("MOVE") ; @("MULTIPLY") ; @("OPEN") ; @("PERFORM") ; @("READ") ; @("RELEASE") ; @("RETURN") ; @("REWRITE") ; @("SEARCH") ; @("SET") ; @("SORT") ; @("START") ; @("STOP") ; @("STRING") ; @("SUBTRACT") ; @("UNSTRING") ; @("WRITE") ; @("EXAMINE") ; @("COPY"))
  .

copy_directive_without_period -->
  @("COPY"), (text_name ; literal), ((@("OF") ; @("IN")), (library_name ; literal) ; true), 
  (@("SUPPRESS") ; true), 
  (@("REPLACING"), (copy_operand, @("BY"), copy_operand)+ ; true)
  .

statements -->
  (accept_statement, (statement_verb#, !, statements ; true) ; add_statement, ((statement_verb#, !, statements ; @("END-ADD"), (statement_verb#, !, statements ; true) ; size_error_phrases, (@("END-ADD"), (statement_verb#, !, statements ; true) ; true)) ; true) ; alter_statement, (statement_verb#, !, statements ; true) ; call_statement_format_i, ((statement_verb#, !, statements ; @("END-CALL"), (statement_verb#, !, statements ; true) ; on_overflow, (@("END-CALL"), (statement_verb#, !, statements ; true) ; true)) ; true) ; call_statement_format_ii, ((statement_verb#, !, statements ; @("END-CALL"), (statement_verb#, !, statements ; true) ; exception_phrases, (@("END-CALL"), (statement_verb#, !, statements ; true) ; true)) ; true) ; cancel_statement, (statement_verb#, !, statements ; true) ; close_statement, (statement_verb#, !, statements ; true) ; compute_statement, ((statement_verb#, !, statements ; @("END-COMPUTE"), (statement_verb#, !, statements ; true) ; size_error_phrases, (@("END-COMPUTE"), (statement_verb#, !, statements ; true) ; true)) ; true) ; continue_statement, (statement_verb#, !, statements ; true) ; delete_statement, ((statement_verb#, !, statements ; @("END-DELETE"), (statement_verb#, !, statements ; true) ; invalid_key_phrases, (@("END-DELETE"), (statement_verb#, !, statements ; true) ; true)) ; true) ; display_statement, (statement_verb#, !, statements ; true) ; divide_statement, ((statement_verb#, !, statements ; @("END-DIVIDE"), (statement_verb#, !, statements ; true) ; size_error_phrases, (@("END-DIVIDE"), (statement_verb#, !, statements ; true) ; true)) ; true) ; entry_statement, (statement_verb#, !, statements ; true) ; evaluate_statement, (@("END-EVALUATE"), (statement_verb#, !, statements ; true) ; true) ; exit_statement, (statement_verb#, !, statements ; true) ; exit_program_statement, (statement_verb#, !, statements ; true) ; goback_statement, (statement_verb#, !, statements ; true) ; go_to_statement, (statement_verb#, !, statements ; true) ; if_statement, (@("END-IF"), (statement_verb#, !, statements ; true) ; true) ; initialize_statement, (statement_verb#, !, statements ; true) ; inspect_statement, (statement_verb#, !, statements ; true) ; merge_statement, (statement_verb#, !, statements ; true) ; move_statement, (statement_verb#, !, statements ; true) ; multiply_statement, ((statement_verb#, !, statements ; @("END-MULTIPLY"), (statement_verb#, !, statements ; true) ; size_error_phrases, (@("END-MULTIPLY"), (statement_verb#, !, statements ; true) ; true)) ; true) ; open_statement, (statement_verb#, !, statements ; true) ; perform_statement, (statement_verb#, !, statements ; true) ; read_statement_format_i, ((statement_verb#, !, statements ; @("END-READ"), (statement_verb#, !, statements ; true) ; at_end_phrases, (@("END-READ"), (statement_verb#, !, statements ; true) ; true)) ; true) ; read_statement_format_ii, ((statement_verb#, !, statements ; @("END-READ"), (statement_verb#, !, statements ; true) ; invalid_key_phrases, (@("END-READ"), (statement_verb#, !, statements ; true) ; true)) ; true) ; release_statement, (statement_verb#, !, statements ; true) ; return_statement, (@("END-RETURN"), (statement_verb#, !, statements ; true) ; true) ; rewrite_statement, ((statement_verb#, !, statements ; @("END-REWRITE"), (statement_verb#, !, statements ; true) ; invalid_key_phrases, (@("END-REWRITE"), (statement_verb#, !, statements ; true) ; true)) ; true) ; search_statement, (@("END-SEARCH"), (statement_verb#, !, statements ; true) ; true) ; set_statement, (statement_verb#, !, statements ; true) ; sort_statement, (statement_verb#, !, statements ; true) ; start_statement, ((statement_verb#, !, statements ; @("END-START"), (statement_verb#, !, statements ; true) ; invalid_key_phrases, (@("END-START"), (statement_verb#, !, statements ; true) ; true)) ; true) ; stop_statement, (statement_verb#, !, statements ; true) ; string_statement, ((statement_verb#, !, statements ; @("END-STRING"), (statement_verb#, !, statements ; true) ; overflow_phrases, (@("END-STRING"), (statement_verb#, !, statements ; true) ; true)) ; true) ; subtract_statement, ((statement_verb#, !, statements ; @("END-SUBTRACT"), (statement_verb#, !, statements ; true) ; size_error_phrases, (@("END-SUBTRACT"), (statement_verb#, !, statements ; true) ; true)) ; true) ; unstring_statement, ((statement_verb#, !, statements ; @("END-UNSTRING"), (statement_verb#, !, statements ; true) ; overflow_phrases, (@("END-UNSTRING"), (statement_verb#, !, statements ; true) ; true)) ; true) ; write_statement_format_i, ((statement_verb#, !, statements ; @("END-WRITE"), (statement_verb#, !, statements ; true) ; write_before_after, ((statement_verb#, !, statements ; @("END-WRITE"), (statement_verb#, !, statements ; true) ; w_phrase, (@("END-WRITE"), (statement_verb#, !, statements ; true) ; true)) ; true) ; invalid_key_phrases, (@("END-WRITE"), (statement_verb#, !, statements ; true) ; true)) ; true) ; examine_statement, (statement_verb#, !, statements ; true) ; copy_directive, (statement_verb#, !, statements ; true))
  .

overflow_phrases -->
  (on_overflow ; true), (not_on_overflow ; true)
  .

invalid_key_phrases -->
  (invalid_key ; not_invalid_key ; invalid_key, not_invalid_key)
  .

at_end_phrases -->
  (at_end ; not_at_end ; at_end, not_at_end)
  .

exception_phrases -->
  (on_exception ; not_on_exception ; on_exception, not_on_exception)
  .

size_error_phrases -->
  (on_size_error ; not_on_size_error ; on_size_error, not_on_size_error)
  .

examine_statement -->
  @("EXAMINE"), identifier, @("TALLYING"), (@("ALL") ; @("LEADING")), literal
  .

not_at_eop -->
  @("NOT"), (@("AT") ; true), (@("END-OF-PAGE") ; @("EOP")), series_of_imperative_statements
  .

at_eop -->
  (@("AT") ; true), (@("END-OF-PAGE") ; @("EOP")), series_of_imperative_statements
  .

write_before_after -->
  ((@("BEFORE") ; @("AFTER")), (@("ADVANCING") ; true), ((identifier ; integer), ((@("LINE") ; @("LINES")) ; true) ; mnemonic_name ; @("PAGE")) ; true)
  .

not_at_end -->
  @("NOT"), (@("AT") ; true), @("END"), series_of_imperative_statements
  .

at_end -->
  (@("AT") ; true), @("END"), series_of_imperative_statements
  .

inspect_replacing_phrase -->
  @("REPLACING"), 
  (@("CHARACTERS"), @("BY"), (identifier ; literal), before_after_phrase* ; (@("ALL") ; @("LEADING") ; @("FIRST")), ((identifier ; literal), @("BY"), (identifier ; literal), before_after_phrase*)+)+
  .

inspect_tallying_phrase -->
  @("TALLYING"), 
  (identifier, @("FOR"), (@("CHARACTERS"), before_after_phrase* ; (@("ALL") ; @("LEADING")), ((identifier ; literal), before_after_phrase*)+)+)+
  .

before_after_phrase -->
  (@("BEFORE") ; @("AFTER")), (@("INITIAL") ; true), (identifier ; literal)
  .

when_other_phrase -->
  @("WHEN"), @("OTHER"), series_of_imperative_statements
  .

when_phrase -->
  (@("WHEN"), e_phrase, (@("ALSO"), e_phrase)*)+, series_of_imperative_statements
  .

e_phrase -->
  (@("ANY") ; condition ; @("TRUE") ; @("FALSE") ; (@("NOT") ; true), (identifier ; literal ; arithmetic_expression), ((@("THROUGH") ; @("THRU")), (identifier ; literal ; arithmetic_expression) ; true))
  .

invalid_key -->
  @("INVALID"), (@("KEY") ; true), series_of_imperative_statements
  .

not_invalid_key -->
  @("NOT"), @("INVALID"), (@("KEY") ; true), series_of_imperative_statements
  .

not_on_exception -->
  @("NOT"), (@("ON") ; true), @("EXCEPTION"), series_of_imperative_statements
  .

on_exception -->
  (@("ON") ; true), @("EXCEPTION"), series_of_imperative_statements
  .

not_on_overflow -->
  @("NOT"), (@("ON") ; true), @("OVERFLOW"), series_of_imperative_statements
  .

on_overflow -->
  (@("ON") ; true), @("OVERFLOW"), series_of_imperative_statements
  .

not_on_size_error -->
  @("NOT"), (@("ON") ; true), @("SIZE"), @("ERROR"), series_of_imperative_statements
  .

on_size_error -->
  (@("ON") ; true), @("SIZE"), @("ERROR"), series_of_imperative_statements
  .

use_directive -->
  (use_directive_format_i ; use_directive_format_ii ; use_directive_format_iii)
  .

subtract_statement -->
  (subtract_statement_format_i ; subtract_statement_format_ii ; subtract_statement_format_iii)
  .

set_statement -->
  (set_statement_format_i ; set_statement_format_ii ; set_statement_format_iii ; set_statement_format_iv ; set_statement_format_v)
  .

search_statement -->
  (search_statement_format_i ; search_statement_format_ii)
  .

perform_statement -->
  (perform_statement_format_i ; perform_statement_format_ii ; perform_statement_format_iii ; perform_statement_format_iv)
  .

open_statement -->
  (open_statement_format_i ; open_statement_format_ii)
  .

multiply_statement -->
  (multiply_statement_format_i ; multiply_statement_format_ii)
  .

move_statement -->
  (move_statement_format_i ; move_statement_format_ii)
  .

inspect_statement -->
  (inspect_statement_format_i ; inspect_statement_format_ii ; inspect_statement_format_iii ; inspect_statement_format_iv)
  .

go_to_statement -->
  (go_to_statement_format_i ; go_to_statement_format_ii ; altered_go_to ; go_to_statement_format_iv)
  .

divide_statement -->
  (divide_statement_format_i ; divide_statement_format_ii ; divide_statement_format_iii ; divide_statement_format_iv ; divide_statement_format_v)
  .

close_statement -->
  (close_statement_format_i ; close_statement_format_ii)
  .

add_statement -->
  (add_statement_format_i ; add_statement_format_ii ; add_statement_format_iii)
  .

accept_statement -->
  (accept_statement_format_i ; accept_statement_format_ii)
  .

call_using_phrase -->
  @("USING"), (((@("BY") ; true), @("REFERENCE") ; true), (identifier ; @("ADDRESS"), @("OF"), identifier ; file_name)+ ; (@("BY") ; true), @("CONTENT"), ((@("LENGTH"), @("OF") ; true), identifier ; @("ADDRESS"), @("OF"), identifier ; literal)+)+
  .

altered_go_to -->
  @("GO"), (@("TO") ; true)
  .

occurs_clause -->
  (occurs_clause_format_ii ; occurs_clause_format_i)
  .

data_clauses -->
  (blank_when_zero_clause ; external_clause ; global_clause ; justified_clause ; occurs_clause ; picture_clause ; sign_clause ; synchronized_clause ; usage_clause ; value_clause_format_i)*
  .

data_description_entry -->
  (data_description_entry_format_i ; data_description_entry_format_ii ; data_description_entry_format_iii ; copy_directive)
  .

code_set_clause -->
  @("CODE-SET"), (@("IS") ; true), alphabet_name
  .

recording_mode_clause -->
  @("RECORDING"), (@("MODE") ; true), (@("IS") ; true), mode
  .

linage_area_clause -->
  ((@("WITH") ; true), @("FOOTING"), (@("AT") ; true), (data_name ; integer) ; true), 
  ((@("LINES") ; true), (@("AT") ; true), @("TOP"), (data_name ; integer) ; true), 
  ((@("LINES") ; true), (@("AT") ; true), @("BOTTOM"), (data_name ; integer) ; true)
  .

linage_clause -->
  @("LINAGE"), (@("IS") ; true), (qualified_data_name ; integer), (@("LINES") ; true), linage_area_clause
  .

data_records_clause -->
  @("DATA"), (@("RECORD") ; @("RECORDS")), ((@("IS") ; @("ARE")) ; true), qualified_data_name+
  .

value_of_clause -->
  @("VALUE"), @("OF"), (system_name, (@("IS") ; true), (qualified_data_name ; literal))+
  .

label_records_clause -->
  @("LABEL"), (@("RECORD") ; @("RECORDS")), ((@("IS") ; @("ARE")) ; true), (@("STANDARD") ; @("OMITTED") ; qualified_data_name+)
  .

record_varying_clause -->
  (@("IS") ; true), @("VARYING"), (@("IN") ; true), (@("SIZE") ; true), 
  ((@("FROM") ; true), integer ; true), (@("TO"), integer ; true), (@("CHARACTERS") ; true)
  .

record_clause -->
  @("RECORD"), ((@("CONTAINS") ; true), integer, (@("CHARACTERS") ; true) ; (@("CONTAINS") ; true), integer, @("TO"), integer, (@("CHARACTERS") ; true) ; record_varying_clause, (@("DEPENDING"), (@("ON") ; true), qualified_data_name ; true))
  .

block_contains_clause -->
  @("BLOCK"), (@("CONTAINS") ; true), (integer, @("TO") ; true), integer, ((@("CHARACTERS") ; @("RECORDS") ; @("RECORD")) ; true)
  .

global_clause -->
  (@("IS") ; true), @("GLOBAL")
  .

external_clause -->
  (@("IS") ; true), @("EXTERNAL")
  .

file_clauses -->
  (external_clause ; global_clause ; block_contains_clause ; record_clause ; label_records_clause ; value_of_clause ; data_records_clause ; linage_clause ; recording_mode_clause ; code_set_clause)*
  .

file_description_entry -->
  (@("FD") ; @("SD")), file_name, file_clauses, @("."), !
  .

status_clause -->
  (@("FILE") ; true), @("STATUS"), (@("IS") ; true), qualified_data_name, (qualified_data_name ; true)
  .

relative_key -->
  @("RELATIVE"), (@("KEY") ; true), (@("IS") ; true), qualified_data_name
  .

record_key -->
  @("RECORD"), (@("KEY") ; true), 
  (@("IS") ; true), qualified_data_name, (password_clause ; true), 
  idx_entry*
  .

password_clause -->
  @("PASSWORD"), (@("IS") ; true), qualified_data_name
  .

key_clause -->
  (record_key ; relative_key)
  .

access_mode_clause -->
  (@("ACCESS"), (@("MODE") ; true), (@("IS") ; true) ; true), (@("SEQUENTIAL") ; @("RANDOM") ; @("DYNAMIC"))
  .

record_delimiter_clause -->
  @("RECORD"), @("DELIMITER"), (@("IS") ; true), (@("STANDARD-1") ; assignment_name)
  .

padding_character_clause -->
  @("PADDING"), (@("CHARACTER") ; true), (@("IS") ; true), (qualified_data_name ; literal)
  .

organisation_clause -->
  (@("ORGANIZATION"), (@("IS") ; true) ; true), (@("SEQUENTIAL") ; @("INDEXED") ; @("RELATIVE"))
  .

reserve_clause -->
  @("RESERVE"), integer, ((@("AREA") ; @("AREAS")) ; true)
  .

file_control_clauses -->
  (reserve_clause ; organisation_clause ; padding_character_clause ; record_delimiter_clause ; access_mode_clause ; key_clause ; password_clause ; status_clause)*
  .

assign_clause -->
  @("ASSIGN"), (@("TO") ; true), (assignment_name ; literal)+
  .

select_clause -->
  @("SELECT"), (@("OPTIONAL") ; true), file_name
  .

file_control_entry -->
  select_clause, assign_clause, file_control_clauses, @(".")
  .

special_names_clauses -->
  (environment_clause ; alphabet_clause ; symbolic_clause ; class_clause ; currency_clause)*
  .

currency_clause -->
  (@("CURRENCY"), (@("SIGN") ; true), (@("IS") ; true), literal ; @("DECIMAL-POINT"), (@("IS") ; true), @("COMMA") ; @("CURRENCY"), (@("SIGN") ; true), (@("IS") ; true), literal, @("DECIMAL-POINT"), (@("IS") ; true), @("COMMA"))
  .

class_clause -->
  @("CLASS"), class_name, (@("IS") ; true), (literal, ((@("THROUGH") ; @("THRU")), literal ; true))+
  .

symbolic_clause -->
  @("SYMBOLIC"), (@("CHARACTERS") ; true), (symbolic_character+, ((@("ARE") ; @("IS")) ; true), integer+)+, (@("IN"), alphabet_name ; true)
  .

alphabet_clause -->
  @("ALPHABET"), alphabet_name, (@("IS") ; true), (@("STANDARD-1") ; @("STANDARD-2") ; @("NATIVE") ; @("EBCDIC") ; (literal, (((@("THROUGH") ; @("THRU")), literal ; (@("ALSO"), literal)+) ; true))+)
  .

environment_clause -->
  (environment_name, (@("IS") ; true), mnemonic_name ; environment_name, ((@("IS") ; true), mnemonic_name, (snp_entry ; true) ; snp_entry))
  .

computer_paragraphs -->
  (source_computer_paragraph ; object_computer_paragraph)*
  .

sentence -->
  statements, @("."), !
  .

series_of_imperative_statements -->
  statements
  .

procedure_division_content -->
  (@("DECLARATIVES"), @("."), (sect, @("."), use_directive, @("."), para)+, @("END"), @("DECLARATIVES"), @(".") ; true), 
  (para ; true), section*
  .

section -->
  section_name, @("SECTION"), (priority_number ; true), @("."), para
  .

using_phrase -->
  @("USING"), data_name+
  .

record_description_entry -->
  data_description_entry
  .

data_division_content -->
  (@("FILE"), @("SECTION"), @("."), (file_description_entry, record_description_entry+)* ; true), 
  (@("WORKING-STORAGE"), @("SECTION"), @("."), data_description_entry* ; true), 
  (@("LINKAGE"), @("SECTION"), @("."), data_description_entry* ; true)
  .

environment_division_content -->
  (configuration_section ; true), (input_output_section ; true)
  .

identification_division_content -->
  (@("AUTHOR"), (@(".") ; true), comment_entry* ; @("INSTALLATION"), (@(".") ; true), comment_entry* ; @("DATE-WRITTEN"), (@(".") ; true), comment_entry* ; @("DATE-COMPILED"), (@(".") ; true), comment_entry* ; @("SECURITY"), (@(".") ; true), comment_entry* ; @("REMARKS"), @("."), comment_entry*)*
  .

copy_operand -->
  (quoted_pseudo_text ; identifier ; literal ; cobol_word)
  .

abbreviation_rest -->
  ((@("AND") ; @("OR")), (@("NOT") ; true), (relational_operator ; true), (object ; @("("), object, abbreviation_rest, @(")")))+
  .

object -->
  arithmetic_expression
  .

relational_operator -->
  ((@("IS") ; @("NOT") ; @("IS"), @("NOT") ; @("NOT"), @("IS")) ; true), (@("GREATER"), (@("THAN") ; true) ; @(">") ; @("LESS"), (@("THAN") ; true) ; @("<") ; @("EQUAL"), (@("TO") ; true) ; @("=") ; @("GREATER"), (@("THAN") ; true), @("OR"), @("EQUAL"), (@("TO") ; true) ; @(">=") ; @("LESS"), (@("THAN") ; true), @("OR"), @("EQUAL"), (@("TO") ; true) ; @("<="))
  .

operand -->
  arithmetic_expression
  .

simple_condition -->
  (class_condition ; condition_name_condition ; relation_condition ; sign_condition ; switch_status_condition ; @("("), condition, @(")"))
  .

combinable_condition -->
  (simple_condition ; negated_simple_condition ; abbreviated_combined_relation_condition)
  .

condition -->
  (combinable_condition ; combined_condition)
  .

basis -->
  (identifier ; literal ; @("("), arithmetic_expression, @(")"))
  .

power -->
  ((@("+") ; @("-")) ; true), basis, (@("**"), basis)*
  .

times_div -->
  power, ((@("*") ; @("/")), power)*
  .

arithmetic_expression -->
  times_div, ((@("+") ; @("-")), times_div)*
  .

mode -->
  (@("F") ; @("V") ; @("U") ; @("S"))
  .

special_register -->
  (@("ADDRESS"), @("OF"), data_name ; @("DEBUG-ITEM") ; @("LENGTH"), @("OF"), identifier ; @("RETURN-CODE") ; @("SHIFT-OUT") ; @("SHIFT-IN") ; @("SORT-CONTROL") ; @("SORT-CORE-SIZE") ; @("SORT-FILE-SIZE") ; @("SORT-MESSAGE") ; @("SORT-MODE-SIZE") ; @("SORT-RETURN") ; @("TALLY") ; @("WHEN-COMPILED"))
  .

literal -->
  (nonnumeric ; numeric ; dbcs ; figurative_constant)
  .

figurative_constant -->
  (@("ZERO") ; @("ZEROS") ; @("ZEROES") ; @("SPACE") ; @("SPACES") ; @("HIGH-VALUE") ; @("HIGH-VALUES") ; @("LOW-VALUE") ; @("LOW-VALUES") ; @("QUOTE") ; @("QUOTES") ; @("ALL"), literal ; @("NULL") ; @("NULLS"))
  .

assignment_name -->
  system_name
  .

environment_name -->
  system_name
  .

computer_name -->
  system_name
  .

section_name -->
  user_defined_word
  .

paragraph_name -->
  user_defined_word
  .

text_name -->
  user_defined_word
  .

program_name -->
  user_defined_word
  .

library_name -->
  user_defined_word
  .

symbolic_character -->
  alphabetic_user_defined_word
  .

record_name -->
  qualified_data_name
  .

mnemonic_name -->
  alphabetic_user_defined_word
  .

index_name -->
  alphabetic_user_defined_word
  .

file_name -->
  alphabetic_user_defined_word
  .

data_name -->
  alphabetic_user_defined_word
  .

condition_name -->
  alphabetic_user_defined_word
  .

class_name -->
  alphabetic_user_defined_word
  .

alphabet_name -->
  alphabetic_user_defined_word
  .

mod_length -->
  arithmetic_expression
  .

leftmost_character_position -->
  arithmetic_expression
  .

condition_name_reference -->
  (condition_name_in_data_division ; condition_name_in_special_names_paragraph)
  .

subscript -->
  (integer ; identifier, ((@("+") ; @("-")), integer ; true) ; index_name, ((@("+") ; @("-")), integer ; true) ; (@("+") ; @("-")), integer)
  .

qualified_data_name -->
  data_name, ((@("IN") ; @("OF")), data_name)*, ((@("IN") ; @("OF")), file_name ; true)
  .

identifier -->
  (identifier_format_i ; identifier_format_ii ; special_register)
  .

procedure_name -->
  (reference_to_procedure_division_name_format_i ; reference_to_procedure_division_name_format_ii)
  .

abbreviated_combined_relation_condition -->
  (relation_condition, abbreviation_rest ; arithmetic_expression, relational_operator, @("("), (@("NOT") ; true), arithmetic_expression, abbreviation_rest, @(")") ; arithmetic_expression, @("("), (@("NOT") ; true), (relational_operator ; true), arithmetic_expression, abbreviation_rest, @(")"))
  .

accept_statement_format_i -->
  @("ACCEPT"), identifier, (@("FROM"), (mnemonic_name ; environment_name) ; true)
  .

accept_statement_format_ii -->
  @("ACCEPT"), identifier, @("FROM"), (@("DATE") ; @("DAY") ; @("DAY-OF-WEEK") ; @("TIME"))
  .

add_statement_format_i -->
  @("ADD"), (identifier ; literal)+, @("TO"), (identifier, (@("ROUNDED") ; true))+
  .

add_statement_format_ii -->
  @("ADD"), (identifier ; literal)+, (@("TO") ; true), (identifier ; literal), 
  @("GIVING"), (identifier, (@("ROUNDED") ; true))+
  .

add_statement_format_iii -->
  @("ADD"), (@("CORRESPONDING") ; @("CORR")), identifier, @("TO"), identifier, 
  (@("ROUNDED") ; true)
  .

after_phrase -->
  (@("AFTER"), (identifier ; index_name), @("FROM"), (identifier ; index_name ; literal), @("BY"), (identifier ; literal), @("UNTIL"), condition)*
  .

alter_statement -->
  @("ALTER"), 
  (procedure_name, @("TO"), (@("PROCEED"), @("TO") ; true), procedure_name)+
  .

blank_when_zero_clause -->
  @("BLANK"), (@("WHEN") ; true), (@("ZERO") ; @("ZEROS") ; @("ZEROES"))
  .

call_statement_format_i -->
  @("CALL"), (identifier ; literal), 
  (call_using_phrase, (copy_directive_without_period ; true) ; true)
  .

call_statement_format_ii -->
  @("CALL"), (identifier ; literal), 
  (call_using_phrase, (copy_directive_without_period ; true) ; true)
  .

cancel_statement -->
  @("CANCEL"), (identifier ; literal)+
  .

class_condition -->
  identifier, ((@("IS") ; @("NOT") ; @("IS"), @("NOT") ; @("NOT"), @("IS")) ; true), (@("NUMERIC") ; @("ALPHABETIC") ; @("ALPHABETIC-LOWER") ; @("ALPHABETIC-UPPER") ; class_name ; @("DBCS") ; @("KANJI"))
  .

close_statement_format_i -->
  @("CLOSE"), 
  (file_name, (((@("REEL") ; @("UNIT")), (((@("FOR") ; true), @("REMOVAL") ; (@("WITH") ; true), @("NO"), @("REWIND")) ; true) ; (@("WITH") ; true), (@("NO"), @("REWIND") ; @("LOCK"))) ; true))+
  .

close_statement_format_ii -->
  @("CLOSE"), (file_name, ((@("WITH") ; true), @("LOCK") ; true))+
  .

cobol_source_program -->
  (@("IDENTIFICATION") ; @("ID")), @("DIVISION"), @("."), !, @("PROGRAM-ID"), (@("."), ! ; true), program_name, 
  ((@("IS") ; true), @("INITIAL"), (@("PROGRAM") ; true) ; true), (@("."), ! ; true), 
  (identification_division_content ; true), 
  (@("ENVIRONMENT"), @("DIVISION"), @("."), !, environment_division_content ; true), 
  (@("DATA"), @("DIVISION"), @("."), !, data_division_content ; true), 
  (@("PROCEDURE"), @("DIVISION"), ((using_phrase ; true), @("."), ! ; copy_directive ; @("USING"), data_name*, copy_directive), procedure_division_content ; true), 
  (nested_source_program*, @("END"), @("PROGRAM"), program_name, @("."), ! ; true)
  .

combined_condition -->
  combinable_condition, ((@("AND") ; @("OR")), combinable_condition)+
  .

compute_statement -->
  @("COMPUTE"), (identifier, (@("ROUNDED") ; true))+, (@("=") ; @("EQUAL")), 
  arithmetic_expression
  .

condition_name_condition -->
  condition_name_reference
  .

condition_name_in_data_division -->
  condition_name, ((@("IN") ; @("OF")), data_name)*, 
  ((@("IN") ; @("OF")), file_name ; true), (@("("), subscript, @(")"))*
  .

condition_name_in_special_names_paragraph -->
  condition_name, ((@("IN") ; @("OF")), mnemonic_name)*
  .

configuration_section -->
  @("CONFIGURATION"), @("SECTION"), @("."), computer_paragraphs, (special_names_paragraph ; true)
  .

continue_statement -->
  @("CONTINUE")
  .

copy_directive -->
  copy_directive_without_period, @(".")
  .

data_description_entry_format_i -->
  level_number, ((data_name ; @("FILLER")) ; true), (redefines_clause ; true), 
  data_clauses, (@("."), ! ; true)
  .

data_description_entry_format_ii -->
  @("66"), data_name, renames_clause, (@("."), ! ; true)
  .

data_description_entry_format_iii -->
  @("88"), condition_name, value_clause_format_ii, (@("."), ! ; true)
  .

delete_statement -->
  @("DELETE"), file_name, (@("RECORD") ; true)
  .

display_statement -->
  @("DISPLAY"), (identifier ; literal)+, 
  (@("UPON"), (mnemonic_name ; environment_name) ; true), 
  ((@("WITH") ; true), @("NO"), @("ADVANCING") ; true)
  .

divide_statement_format_i -->
  @("DIVIDE"), (identifier ; literal), @("INTO"), (identifier, (@("ROUNDED") ; true))+
  .

divide_statement_format_ii -->
  @("DIVIDE"), (identifier ; literal), @("INTO"), (identifier ; literal), 
  @("GIVING"), (identifier, (@("ROUNDED") ; true))+
  .

divide_statement_format_iii -->
  @("DIVIDE"), (identifier ; literal), @("BY"), (identifier ; literal), 
  @("GIVING"), (identifier, (@("ROUNDED") ; true))+
  .

divide_statement_format_iv -->
  @("DIVIDE"), (identifier ; literal), @("INTO"), (identifier ; literal), 
  @("GIVING"), identifier, (@("ROUNDED") ; true), @("REMAINDER"), identifier
  .

divide_statement_format_v -->
  @("DIVIDE"), (identifier ; literal), @("BY"), (identifier ; literal), 
  @("GIVING"), identifier, (@("ROUNDED") ; true), @("REMAINDER"), identifier
  .

entry_statement -->
  @("ENTRY"), literal, (@("USING"), data_name+ ; true)
  .

evaluate_statement -->
  @("EVALUATE"), (identifier ; literal ; arithmetic_expression ; condition ; @("TRUE") ; @("FALSE")), (@("ALSO"), (identifier ; literal ; arithmetic_expression ; condition ; @("TRUE") ; @("FALSE")))*, 
  when_phrase+, 
  (when_other_phrase ; true)
  .

exit_program_statement -->
  @("EXIT"), @("PROGRAM")
  .

exit_statement -->
  @("EXIT")
  .

file_control_paragraph -->
  @("FILE-CONTROL"), @("."), 
  file_control_entry*
  .

go_to_statement_format_i -->
  @("GO"), (@("TO") ; true), procedure_name
  .

go_to_statement_format_ii -->
  @("GO"), (@("TO") ; true), procedure_name+, @("DEPENDING"), (@("ON") ; true), 
  identifier
  .

go_to_statement_format_iv -->
  @("GO"), (@("TO") ; true), @("MORE-LABELS")
  .

goback_statement -->
  @("GOBACK")
  .

i_o_control_paragraph -->
  @("I-O-CONTROL"), @("."), ((qsam_or_sam_i_o_control_entries ; vsam_i_o_control_entries)+, @(".") ; true), 
  (sort_merge_i_o_control_entries, @(".") ; true)
  .

identifier_format_i -->
  
  qualified_data_name, (@("("), subscript+, @(")") ; true), 
  (@("("), leftmost_character_position, @(":"), (mod_length ; true), @(")") ; true)
  .

identifier_format_ii -->
  @("LINAGE-COUNTER"), ((@("IN") ; @("OF")), file_name ; true)
  .

idx_entry -->
  @("ALTERNATE"), (@("RECORD") ; true), (@("KEY") ; true), (@("IS") ; true), qualified_data_name, 
  (@("PASSWORD"), (@("IS") ; true), qualified_data_name ; true), ((@("WITH") ; true), @("DUPLICATES") ; true)
  .

if_statement -->
  @("IF"), condition, (@("THEN") ; true), (statement_verb ; @("NEXT"), @("SENTENCE"))#, !, (statements ; @("NEXT"), @("SENTENCE")), 
  (@("ELSE"), (statements ; @("NEXT"), @("SENTENCE")) ; true)
  .

initialize_statement -->
  @("INITIALIZE"), identifier+, 
  (@("REPLACING"), ((@("ALPHABETIC") ; @("ALPHANUMERIC") ; @("NUMERIC") ; @("ALPHANUMERIC-EDITED") ; @("NUMERIC-EDITED") ; @("DBCS") ; @("EGCS")), (@("DATA") ; true), @("BY"), (identifier ; literal))+ ; true)
  .

input_output_section -->
  @("INPUT-OUTPUT"), @("SECTION"), @("."), (file_control_paragraph ; true), 
  (i_o_control_paragraph ; true)
  .

inspect_statement_format_i -->
  @("INSPECT"), identifier, inspect_tallying_phrase
  .

inspect_statement_format_ii -->
  @("INSPECT"), identifier, inspect_replacing_phrase
  .

inspect_statement_format_iii -->
  @("INSPECT"), identifier, inspect_tallying_phrase, inspect_replacing_phrase
  .

inspect_statement_format_iv -->
  @("INSPECT"), identifier, @("CONVERTING"), (identifier ; literal), @("TO"), 
  (identifier ; literal), before_after_phrase*
  .

justified_clause -->
  (@("JUSTIFIED") ; @("JUST")), (@("RIGHT") ; true)
  .

merge_statement -->
  @("MERGE"), file_name, ((@("ON") ; true), (@("ASCENDING") ; @("DESCENDING")), (@("KEY") ; true), qualified_data_name+)+, 
  ((@("COLLATING") ; true), @("SEQUENCE"), (@("IS") ; true), alphabet_name ; true), @("USING"), file_name, file_name+, 
  (@("OUTPUT"), @("PROCEDURE"), (@("IS") ; true), procedure_name, ((@("THROUGH") ; @("THRU")), procedure_name ; true) ; @("GIVING"), file_name+)
  .

move_statement_format_i -->
  @("MOVE"), (identifier ; literal), @("TO"), identifier+
  .

move_statement_format_ii -->
  @("MOVE"), (@("CORRESPONDING") ; @("CORR")), identifier, @("TO"), identifier+
  .

multiply_statement_format_i -->
  @("MULTIPLY"), (identifier ; literal), @("BY"), (identifier, (@("ROUNDED") ; true))+
  .

multiply_statement_format_ii -->
  @("MULTIPLY"), (identifier ; literal), @("BY"), (identifier ; literal), 
  @("GIVING"), (identifier, (@("ROUNDED") ; true))+
  .

negated_simple_condition -->
  @("NOT"), condition
  .

nested_source_program -->
  (@("IDENTIFICATION") ; @("ID")), @("DIVISION"), @("."), @("PROGRAM-ID"), (@(".") ; true), program_name, 
  ((@("IS") ; true), (@("COMMON"), (@("INITIAL") ; true) ; @("INITIAL"), (@("COMMON") ; true)), (@("PROGRAM") ; true) ; true), (@(".") ; true), 
  (identification_division_content ; true), 
  (@("ENVIRONMENT"), @("DIVISION"), @("."), environment_division_content ; true), 
  (@("DATA"), @("DIVISION"), @("."), data_division_content ; true), 
  (@("PROCEDURE"), @("DIVISION"), ((using_phrase ; true), @(".") ; copy_directive ; @("USING"), data_name*, copy_directive), procedure_division_content ; true), 
  nested_source_program*, @("END"), @("PROGRAM"), program_name, @(".")
  .

object_computer_paragraph -->
  @("OBJECT-COMPUTER"), @("."), 
  (computer_name, (@("MEMORY"), (@("SIZE") ; true), integer, (@("WORDS") ; @("CHARACTERS") ; @("MODULES")) ; true), ocp_entry, @(".") ; true)
  .

occurs_clause_format_i -->
  @("OCCURS"), integer, (@("TIMES") ; true), 
  ((@("ASCENDING") ; @("DESCENDING")), (@("KEY") ; true), (@("IS") ; true), data_name+)*, 
  (@("INDEXED"), (@("BY") ; true), index_name+ ; true)
  .

occurs_clause_format_ii -->
  @("OCCURS"), (integer, @("TO") ; true), integer, (@("TIMES") ; true), @("DEPENDING"), 
  (@("ON") ; true), qualified_data_name, 
  ((@("ASCENDING") ; @("DESCENDING")), (@("KEY") ; true), (@("IS") ; true), data_name+)*, 
  (@("INDEXED"), (@("BY") ; true), index_name+ ; true)
  .

ocp_entry -->
  ((@("PROGRAM") ; true), (@("COLLATING") ; true), @("SEQUENCE"), (@("IS") ; true), alphabet_name ; true), 
  (@("SEGMENT-LIMIT"), (@("IS") ; true), priority_number ; true)
  .

open_statement_format_i -->
  @("OPEN"), (@("INPUT"), (file_name, ((@("REVERSED") ; (@("WITH") ; true), @("NO"), @("REWIND")) ; true))+ ; @("OUTPUT"), (file_name, ((@("WITH") ; true), @("NO"), @("REWIND") ; true))+ ; @("I-O"), file_name+ ; @("EXTEND"), file_name+)+
  .

open_statement_format_ii -->
  @("OPEN"), (@("INPUT"), file_name+ ; @("OUTPUT"), file_name+ ; @("I-O"), file_name+ ; @("EXTEND"), file_name+)+
  .

para -->
  (sentence*, (paragraph_name, @("."), sentence*)* ; true)
  .

perform_statement_format_i -->
  @("PERFORM"), 
  (procedure_name, ((@("THROUGH") ; @("THRU")), procedure_name ; true) ; (series_of_imperative_statements ; true), @("END-PERFORM"))
  .

perform_statement_format_ii -->
  @("PERFORM"), (procedure_name, ((@("THROUGH") ; @("THRU")), procedure_name ; true), (identifier ; integer), @("TIMES") ; (identifier ; integer), @("TIMES"), (series_of_imperative_statements ; true), @("END-PERFORM"))
  .

perform_statement_format_iii -->
  @("PERFORM"), 
  (procedure_name, ((@("THROUGH") ; @("THRU")), procedure_name ; true), test_phrase ; test_phrase, (series_of_imperative_statements ; true), @("END-PERFORM"))
  .

perform_statement_format_iv -->
  @("PERFORM"), (procedure_name, ((@("THROUGH") ; @("THRU")), procedure_name ; true), varying_phrase, after_phrase ; varying_phrase, (series_of_imperative_statements ; true), @("END-PERFORM"))
  .

picture_clause -->
  (@("PICTURE") ; @("PIC")), (@("IS") ; true), character_string
  .

qsam_or_sam_i_o_control_entries -->
  (@("RERUN"), (@("ON") ; true), (assignment_name ; file_name), (@("EVERY") ; true), (integer, @("RECORDS") ; @("END"), (@("OF") ; true), (@("REEL") ; @("UNIT"))), (@("OF") ; true), file_name ; @("SAME"), (@("RECORD") ; true), (@("AREA") ; true), (@("FOR") ; true), file_name, (file_name)* ; @("MULTIPLE"), @("FILE"), (@("TAPE") ; true), (@("CONTAINS") ; true), (file_name, (@("POSITION"), integer ; true))+ ; @("APPLY"), @("WRITE-ONLY"), (@("ON") ; true), file_name+)
  .

read_statement_format_i -->
  @("READ"), file_name, (@("NEXT") ; true), (@("RECORD") ; true), 
  (@("INTO"), identifier ; true)
  .

read_statement_format_ii -->
  @("READ"), file_name, (@("RECORD") ; true), (@("INTO"), identifier ; true), 
  (@("KEY"), (@("IS") ; true), qualified_data_name ; true)
  .

redefines_clause -->
  @("REDEFINES"), data_name
  .

reference_to_procedure_division_name_format_i -->
  paragraph_name, ((@("IN") ; @("OF")), section_name ; true)
  .

reference_to_procedure_division_name_format_ii -->
  section_name
  .

relation_condition -->
  operand, relational_operator, 
  operand
  .

release_statement -->
  @("RELEASE"), record_name, (@("FROM"), identifier ; true)
  .

renames_clause -->
  @("RENAMES"), qualified_data_name, 
  ((@("THROUGH") ; @("THRU")), qualified_data_name ; true)
  .

return_statement -->
  @("RETURN"), file_name, (@("RECORD") ; true), (@("INTO"), identifier ; true), 
  at_end, 
  (not_at_end ; true)
  .

rewrite_statement -->
  @("REWRITE"), record_name, (@("FROM"), identifier ; true)
  .

search_statement_format_i -->
  @("SEARCH"), identifier, (@("VARYING"), (identifier ; index_name) ; true), 
  (at_end ; true), 
  (@("WHEN"), condition, (series_of_imperative_statements ; @("NEXT"), @("SENTENCE")))+
  .

search_statement_format_ii -->
  @("SEARCH"), @("ALL"), identifier, (at_end ; true), 
  @("WHEN"), (identifier, (@("IS") ; true), (@("EQUAL"), (@("TO") ; true) ; @("=")), (identifier ; literal ; arithmetic_expression) ; condition_name_reference), 
  (@("AND"), (identifier, (@("IS") ; true), (@("EQUAL"), (@("TO") ; true) ; @("=")), (identifier ; literal ; arithmetic_expression) ; condition_name_reference))*, 
  ((series_of_imperative_statements ; @("NEXT"), @("SENTENCE")) ; true)
  .

sect -->
  section_name, @("SECTION"), (priority_number ; true)
  .

set_statement_format_i -->
  @("SET"), (index_name ; identifier)+, @("TO"), (index_name ; identifier ; integer)
  .

set_statement_format_ii -->
  @("SET"), index_name+, (@("UP"), @("BY") ; @("DOWN"), @("BY")), (identifier ; integer)
  .

set_statement_format_iii -->
  @("SET"), (mnemonic_name+, @("TO"), (@("ON") ; @("OFF")))+
  .

set_statement_format_iv -->
  @("SET"), condition_name_reference+, @("TO"), @("TRUE")
  .

set_statement_format_v -->
  @("SET"), (identifier ; @("ADDRESS"), @("OF"), identifier)+, 
  @("TO"), (identifier ; @("ADDRESS"), @("OF"), identifier ; @("NULL") ; @("NULLS"))
  .

sign_clause -->
  (@("SIGN"), (@("IS") ; true) ; true), (@("LEADING") ; @("TRAILING")), (@("SEPARATE"), (@("CHARACTER") ; true) ; true)
  .

sign_condition -->
  operand, ((@("IS") ; @("NOT") ; @("IS"), @("NOT") ; @("NOT"), @("IS")) ; true), (@("POSITIVE") ; @("NEGATIVE") ; @("ZERO"))
  .

snp_entry -->
  (@("ON"), (@("STATUS") ; true), (@("IS") ; true), condition, (@("OFF"), (@("STATUS") ; true), (@("IS") ; true), condition ; true) ; @("OFF"), (@("STATUS") ; true), (@("IS") ; true), condition, (@("ON"), (@("STATUS") ; true), (@("IS") ; true), condition ; true))
  .

sort_merge_i_o_control_entries -->
  (@("RERUN"), @("ON"), assignment_name ; true), 
  (@("SAME"), (@("RECORD") ; @("SORT") ; @("SORT-MERGE")), (@("AREA") ; true), (@("FOR") ; true), file_name, (file_name)*)+
  .

sort_statement -->
  @("SORT"), file_name, ((@("ON") ; true), (@("ASCENDING") ; @("DESCENDING")), (@("KEY") ; true), qualified_data_name+)+, 
  ((@("WITH") ; true), @("DUPLICATES"), (@("IN") ; true), (@("ORDER") ; true) ; true), 
  ((@("COLLATING") ; true), @("SEQUENCE"), (@("IS") ; true), alphabet_name ; true), 
  (@("USING"), file_name+ ; @("INPUT"), @("PROCEDURE"), (@("IS") ; true), procedure_name, ((@("THROUGH") ; @("THRU")), procedure_name ; true)), 
  (@("GIVING"), file_name+ ; @("OUTPUT"), @("PROCEDURE"), (@("IS") ; true), procedure_name, ((@("THROUGH") ; @("THRU")), procedure_name ; true))
  .

source_computer_paragraph -->
  @("SOURCE-COMPUTER"), @("."), 
  (computer_name, ((@("WITH") ; true), @("DEBUGGING"), @("MODE") ; true), @(".") ; true)
  .

special_names_paragraph -->
  @("SPECIAL-NAMES"), @("."), special_names_clauses, (@(".") ; true)
  .

start_statement -->
  @("START"), file_name, 
  (@("KEY"), (@("IS") ; true), (@("EQUAL"), (@("TO") ; true) ; @("=") ; @("GREATER"), (@("THAN") ; true) ; @(">") ; @("NOT"), @("LESS"), (@("THAN") ; true) ; @("NOT"), @("<") ; @("GREATER"), (@("THAN") ; true), @("OR"), @("EQUAL"), (@("TO") ; true) ; @(">=")), qualified_data_name ; true)
  .

stop_statement -->
  @("STOP"), (@("RUN") ; literal)
  .

string_statement -->
  @("STRING"), 
  ((identifier ; literal)+, @("DELIMITED"), (@("BY") ; true), (identifier ; literal ; @("SIZE")))+, 
  @("INTO"), identifier, ((@("WITH") ; true), @("POINTER"), identifier ; true)
  .

subtract_statement_format_i -->
  @("SUBTRACT"), (identifier ; literal)+, @("FROM"), 
  (identifier, (@("ROUNDED") ; true))+
  .

subtract_statement_format_ii -->
  @("SUBTRACT"), (identifier ; literal)+, @("FROM"), (identifier ; literal), 
  @("GIVING"), (identifier, (@("ROUNDED") ; true))+
  .

subtract_statement_format_iii -->
  @("SUBTRACT"), (@("CORRESPONDING") ; @("CORR")), identifier, @("FROM"), 
  identifier, (@("ROUNDED") ; true)
  .

switch_status_condition -->
  condition_name_reference
  .

synchronized_clause -->
  (@("SYNCHRONIZED") ; @("SYNC")), ((@("LEFT") ; @("RIGHT")) ; true)
  .

test_phrase -->
  ((@("WITH") ; true), @("TEST"), (@("BEFORE") ; @("AFTER")) ; true), @("UNTIL"), condition
  .

unstring_statement -->
  @("UNSTRING"), identifier, 
  (@("DELIMITED"), (@("BY") ; true), (@("ALL") ; true), (identifier ; literal), (@("OR"), (@("ALL") ; true), (identifier ; literal))* ; true), @("INTO"), 
  (identifier, (@("DELIMITER"), (@("IN") ; true), identifier ; true), (@("COUNT"), (@("IN") ; true), identifier ; true))+, 
  ((@("WITH") ; true), @("POINTER"), identifier ; true), (@("TALLYING"), (@("IN") ; true), identifier ; true)
  .

usage_clause -->
  (@("USAGE"), (@("IS") ; true) ; true), (@("BINARY") ; @("COMP") ; @("COMP-1") ; @("COMP-2") ; @("COMP-3") ; @("COMP-4") ; @("COMPUTATIONAL") ; @("COMPUTATIONAL-1") ; @("COMPUTATIONAL-2") ; @("COMPUTATIONAL-3") ; @("COMPUTATIONAL-4") ; @("DISPLAY") ; @("DISPLAY-1") ; @("INDEX") ; @("PACKED-DECIMAL") ; @("POINTER"))
  .

use_directive_format_i -->
  @("USE"), (@("GLOBAL") ; true), @("AFTER"), (@("STANDARD") ; true), (@("EXCEPTION") ; @("ERROR")), @("PROCEDURE"), 
  (@("ON") ; true), (file_name+ ; @("INPUT") ; @("OUTPUT") ; @("I-O") ; @("EXTEND"))
  .

use_directive_format_ii -->
  @("USE"), (@("GLOBAL") ; true), @("AFTER"), (@("STANDARD") ; true), ((@("BEGINNING") ; @("ENDING")) ; true), 
  ((@("FILE") ; @("REEL") ; @("UNIT")) ; true), @("LABEL"), @("PROCEDURE"), (@("ON") ; true), (file_name+ ; @("INPUT") ; @("OUTPUT") ; @("I-O") ; @("EXTEND"))
  .

use_directive_format_iii -->
  @("USE"), (@("FOR") ; true), @("DEBUGGING"), (@("ON") ; true), (procedure_name+ ; @("ALL"), @("PROCEDURES"))
  .

value_clause_format_i -->
  @("VALUE"), (@("IS") ; true), literal
  .

value_clause_format_ii -->
  (@("VALUE"), (@("IS") ; true) ; @("VALUES"), (@("ARE") ; true)), 
  (literal, ((@("THROUGH") ; @("THRU")), literal ; true))+
  .

varying_phrase -->
  ((@("WITH") ; true), @("TEST"), (@("BEFORE") ; @("AFTER")) ; true), @("VARYING"), (identifier ; index_name), @("FROM"), (identifier ; index_name ; literal), @("BY"), (identifier ; literal), @("UNTIL"), 
  condition
  .

vsam_i_o_control_entries -->
  (@("RERUN"), (@("ON") ; true), (assignment_name ; file_name), (@("EVERY") ; true), integer, @("RECORDS"), (@("OF") ; true), file_name ; @("SAME"), (@("RECORD") ; true), (@("AREA") ; true), (@("FOR") ; true), file_name, (file_name)*)
  .

w_phrase -->
  (at_eop ; not_at_eop ; at_eop, not_at_eop)
  .

write_statement_format_i -->
  @("WRITE"), record_name, (@("FROM"), identifier ; true)
  .

terminal("COPY").
terminal("SUPPRESS").
terminal("END-ADD").
terminal("END-CALL").
terminal("END-COMPUTE").
terminal("END-DELETE").
terminal("END-DIVIDE").
terminal("END-EVALUATE").
terminal("END-IF").
terminal("END-MULTIPLY").
terminal("END-READ").
terminal("END-RETURN").
terminal("END-REWRITE").
terminal("END-SEARCH").
terminal("END-START").
terminal("END-STRING").
terminal("END-SUBTRACT").
terminal("END-UNSTRING").
terminal("END-WRITE").
terminal("EXAMINE").
terminal("END-OF-PAGE").
terminal("EOP").
terminal("LINE").
terminal("PAGE").
terminal("FIRST").
terminal("OTHER").
terminal("ANY").
terminal("INVALID").
terminal("OVERFLOW").
terminal("REFERENCE").
terminal("CONTENT").
terminal("CODE-SET").
terminal("RECORDING").
terminal("FOOTING").
terminal("TOP").
terminal("AT").
terminal("BOTTOM").
terminal("LINAGE").
terminal("LINES").
terminal("OMITTED").
terminal("BLOCK").
terminal("EXTERNAL").
terminal("FD").
terminal("SD").
terminal("ACCESS").
terminal("RANDOM").
terminal("DYNAMIC").
terminal("PADDING").
terminal("ORGANIZATION").
terminal("SEQUENTIAL").
terminal("RELATIVE").
terminal("RESERVE").
terminal("AREAS").
terminal("ASSIGN").
terminal("SELECT").
terminal("OPTIONAL").
terminal("CURRENCY").
terminal("DECIMAL-POINT").
terminal("COMMA").
terminal("CLASS").
terminal("SYMBOLIC").
terminal("ALPHABET").
terminal("STANDARD-1").
terminal("STANDARD-2").
terminal("NATIVE").
terminal("EBCDIC").
terminal("DECLARATIVES").
terminal("WORKING-STORAGE").
terminal("LINKAGE").
terminal("AUTHOR").
terminal("INSTALLATION").
terminal("DATE-WRITTEN").
terminal("DATE-COMPILED").
terminal("SECURITY").
terminal("REMARKS").
terminal("<=").
terminal("**").
terminal("*").
terminal("/").
terminal("F").
terminal("V").
terminal("U").
terminal("S").
terminal("DEBUG-ITEM").
terminal("LENGTH").
terminal("RETURN-CODE").
terminal("SHIFT-OUT").
terminal("SHIFT-IN").
terminal("SORT-CONTROL").
terminal("SORT-CORE-SIZE").
terminal("SORT-FILE-SIZE").
terminal("SORT-MESSAGE").
terminal("SORT-MODE-SIZE").
terminal("SORT-RETURN").
terminal("TALLY").
terminal("WHEN-COMPILED").
terminal("SPACE").
terminal("SPACES").
terminal("HIGH-VALUE").
terminal("HIGH-VALUES").
terminal("LOW-VALUE").
terminal("LOW-VALUES").
terminal("QUOTE").
terminal("QUOTES").
terminal("+").
terminal("-").
terminal("ACCEPT").
terminal("DATE").
terminal("DAY").
terminal("DAY-OF-WEEK").
terminal("TIME").
terminal("ADD").
terminal("ALTER").
terminal("PROCEED").
terminal("BLANK").
terminal("ZEROS").
terminal("ZEROES").
terminal("CALL").
terminal("CANCEL").
terminal("ALPHABETIC-LOWER").
terminal("ALPHABETIC-UPPER").
terminal("KANJI").
terminal("REMOVAL").
terminal("CLOSE").
terminal("LOCK").
terminal("COMPUTE").
terminal("CONFIGURATION").
terminal("CONTINUE").
terminal("FILLER").
terminal("66").
terminal("88").
terminal("DELETE").
terminal("UPON").
terminal("ADVANCING").
terminal("DIVIDE").
terminal("REMAINDER").
terminal("ENTRY").
terminal("EVALUATE").
terminal("ALSO").
terminal("FALSE").
terminal("EXIT").
terminal("FILE-CONTROL").
terminal("GO").
terminal("MORE-LABELS").
terminal("GOBACK").
terminal("I-O-CONTROL").
terminal("(").
terminal(":").
terminal(")").
terminal("LINAGE-COUNTER").
terminal("ALTERNATE").
terminal("PASSWORD").
terminal("IF").
terminal("THEN").
terminal("ELSE").
terminal("INITIALIZE").
terminal("REPLACING").
terminal("ALPHABETIC").
terminal("ALPHANUMERIC").
terminal("NUMERIC").
terminal("ALPHANUMERIC-EDITED").
terminal("NUMERIC-EDITED").
terminal("DBCS").
terminal("EGCS").
terminal("INPUT-OUTPUT").
terminal("INSPECT").
terminal("CONVERTING").
terminal("JUSTIFIED").
terminal("JUST").
terminal("MERGE").
terminal("MOVE").
terminal("MULTIPLY").
terminal("IDENTIFICATION").
terminal("ID").
terminal("PROGRAM-ID").
terminal("INITIAL").
terminal("COMMON").
terminal("ENVIRONMENT").
terminal("DATA").
terminal("DIVISION").
terminal("OBJECT-COMPUTER").
terminal("MEMORY").
terminal("WORDS").
terminal("CHARACTERS").
terminal("MODULES").
terminal("OCCURS").
terminal("DEPENDING").
terminal("INDEXED").
terminal("PROGRAM").
terminal("SEGMENT-LIMIT").
terminal("REVERSED").
terminal("NO").
terminal("REWIND").
terminal("OPEN").
terminal("TIMES").
terminal("PERFORM").
terminal("END-PERFORM").
terminal("PICTURE").
terminal("PIC").
terminal("END").
terminal("MULTIPLE").
terminal("TAPE").
terminal("CONTAINS").
terminal("POSITION").
terminal("APPLY").
terminal("WRITE-ONLY").
terminal("READ").
terminal("REDEFINES").
terminal("RELEASE").
terminal("RENAMES").
terminal("RETURN").
terminal("REWRITE").
terminal("SEARCH").
terminal("WHEN").
terminal("AND").
terminal("NEXT").
terminal("SENTENCE").
terminal("SECTION").
terminal("UP").
terminal("DOWN").
terminal("TRUE").
terminal("SET").
terminal("ADDRESS").
terminal("NULL").
terminal("NULLS").
terminal("SIGN").
terminal("LEADING").
terminal("TRAILING").
terminal("SEPARATE").
terminal("CHARACTER").
terminal("POSITIVE").
terminal("NEGATIVE").
terminal("ZERO").
terminal("OFF").
terminal("STATUS").
terminal("SORT-MERGE").
terminal("SORT").
terminal("ASCENDING").
terminal("DESCENDING").
terminal("DUPLICATES").
terminal("ORDER").
terminal("COLLATING").
terminal("SEQUENCE").
terminal("USING").
terminal("SOURCE-COMPUTER").
terminal("MODE").
terminal("SPECIAL-NAMES").
terminal(".").
terminal("START").
terminal("KEY").
terminal("=").
terminal(">").
terminal("LESS").
terminal("NOT").
terminal("<").
terminal("GREATER").
terminal("THAN").
terminal("EQUAL").
terminal("TO").
terminal(">=").
terminal("STOP").
terminal("RUN").
terminal("STRING").
terminal("SIZE").
terminal("GIVING").
terminal("SUBTRACT").
terminal("CORRESPONDING").
terminal("CORR").
terminal("ROUNDED").
terminal("SYNCHRONIZED").
terminal("SYNC").
terminal("LEFT").
terminal("RIGHT").
terminal("UNSTRING").
terminal("DELIMITED").
terminal("OR").
terminal("INTO").
terminal("DELIMITER").
terminal("COUNT").
terminal("TALLYING").
terminal("IN").
terminal("USAGE").
terminal("BINARY").
terminal("COMP").
terminal("COMP-1").
terminal("COMP-2").
terminal("COMP-3").
terminal("COMP-4").
terminal("COMPUTATIONAL").
terminal("COMPUTATIONAL-1").
terminal("COMPUTATIONAL-2").
terminal("COMPUTATIONAL-3").
terminal("COMPUTATIONAL-4").
terminal("DISPLAY").
terminal("DISPLAY-1").
terminal("INDEX").
terminal("PACKED-DECIMAL").
terminal("POINTER").
terminal("EXCEPTION").
terminal("ERROR").
terminal("GLOBAL").
terminal("STANDARD").
terminal("BEGINNING").
terminal("ENDING").
terminal("FILE").
terminal("REEL").
terminal("UNIT").
terminal("LABEL").
terminal("PROCEDURE").
terminal("INPUT").
terminal("OUTPUT").
terminal("I-O").
terminal("EXTEND").
terminal("USE").
terminal("DEBUGGING").
terminal("ALL").
terminal("PROCEDURES").
terminal("VALUE").
terminal("IS").
terminal("VALUES").
terminal("ARE").
terminal("THROUGH").
terminal("THRU").
terminal("WITH").
terminal("TEST").
terminal("BEFORE").
terminal("AFTER").
terminal("VARYING").
terminal("BY").
terminal("UNTIL").
terminal("RERUN").
terminal("ON").
terminal("EVERY").
terminal("RECORDS").
terminal("OF").
terminal("SAME").
terminal("RECORD").
terminal("AREA").
terminal("FOR").
terminal("WRITE").
terminal("FROM").
