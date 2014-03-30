http://www.txl.ca/nresources.html:
 ↳  http://www.txl.ca/examples/Grammars/CSharp/README.txt

Validated TXL Basis Grammar for C# Edition 3
Version 2.1, Feb 2009

Copyright 2006-2009 James R. Cordy
Licensed under the MIT open source license, see source for details.

Description:
    Complete TXL transformation grammar for C# Edition 3 with optional comment 
    and newline preservation.  Validated on a range of open source C# software
    including VMukti-Chat, Linq Rev. 1712, Rss-Bandit 1.5.0.17, Castle 0.85, 
    SMC 5.1.0, db4o 7.4, and Nant 0.86b1.

    Handles both preprocessed and unpreprocessed C# code with with expanded or
    unexpanded macro calls.

    Handles Linq SQL query extensions and C# 3.0 object initializer expressions.

    Handles but does not interpret C# preprocesor directives, except #ifdefs 
    that violate syntactic boundaries.  #ifdefs can be handled using the 
    Antoniol et al. transformation that comments out the #else part.

    Optionally parses and preserves comments using the comment overrides,
    and optionally preserves newline boundaries from source using the 
    preserve newline overrides.

Authors:
    J.R. Cordy, Queen's University

See CSharp/README.txt for the original unchanged read me file.
Grammar extracted and added to the Grammar Zoo on 22 March 2013 by Vadim Zaytsev.
