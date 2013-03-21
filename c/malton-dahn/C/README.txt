Improved TXL Basis Grammar for C with GNU Extensions

Description:
    An improved TXL base grammar and pretty printer for ANSI, K+R and GNU C.
    Intended as a basis for creating TXL analyses and transformations of C programs.  

    Can handle preprocessor directives (or not).
    Can handle Gnu gcc extensions (or not).
    Can preserve comments (or not).

Author:
    A. Malton
    C. Dahn

Affiliation:
    University of Waterloo, Canada
    Drexel University, USA

Date:
    February 2002
    June 2004

Example:
    txl Examples/user.c			(no comments preserved)
    txl -comment Examples/user.c	(comments preserved)
