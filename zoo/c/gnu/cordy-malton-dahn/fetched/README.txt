Validated TXL Basis Grammar for C with Macros and Gnu Extensions
Version 5.2, July 2011

Copyright 1994-2011 James R. Cordy, Andrew J. Malton and Christopher Dahn
Licensed under the MIT open source license, see source for details.

Description:
    Consolidated grammar for K+R and ANSI C with Gnu extensions
    designed for large scale C analysis tasks.  Validated on a large range 
    of open source C software including Bison, Cook, Gzip, Postgresql, SNNS, 
    Weltab, WGet, Apache HTTPD, the entire Linux 2.6 kernel, and the entire
    FreeBSD 8.0 kernel.

    Handles both preprocessed and unpreprocessed C code with with expanded or
    unexpanded C macro calls.  

    Handles but does not interpret C preprocesor directives, except #ifdefs 
    that violate syntactic boundaries.  #ifdefs can be handled using the 
    separate Antoniol et al. transformation that keeps only the #else parts
    and comments out the optional (#if, #elsif) parts (ifdef.txl).

    Ignores and does not preserve comments.

Authors:
    J.R. Cordy, Queen's University
    A.J. Malton, University of Waterloo
    C. Dahn, Drexel University

Example:
    txl program.c c.txl
    txl porogram.c ifdef.txl > program_ifdef.c;  txl program_ifdef.c c.txl
