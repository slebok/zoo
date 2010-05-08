% Test of the full Ada 2005 grammar



% define the root grammar rule
define program
    [compilation]
end define



function main
    replace [program]
        P [program]
    by
        P
end function



include "../2_lexical_elements.txl"
include "../3_declarations_and_types.txl"
include "../4_names_and_expressions.txl"
include "../5_statements.txl"
include "../6_subprograms.txl"
include "../7_packages.txl"
include "../8_visibility_rules.txl"
include "../9_tasks_and_synchronization.txl"
include "../10_program_structure_and_compilation_issues.txl"
include "../11_exceptions.txl"
include "../12_generic_units.txl"
include "../13_representation_issues.txl"
include "../J_obsolescent_features.txl"


