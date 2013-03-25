TXL Basis Grammar for Fortan 77 and Fortran 90
Version 1.0, September 2009

Grammar Copyright 1998, 2009 by W.M. Waite and J.R. Cordy

    Fortran 77 DO loop converter Copyright 2009 James R. Cordy
    Fortran 77 column trimmer Copyright 2009 James R. Cordy

    Licensed under the MIT open source license, see source for details.

    Adapted from the Eli grammar for Fortran by W.M. Waite, 
        University of Colorado, January 1998
    For more information on Eli and the grammar, see 
       http://eli-project.sourceforge.net/EliExamples.html

    Adaptation by J.R. Cordy, Queen's Univerity, September 2009

Description:
    A complete Fortan 77 and Fortran 90 grammar for TXL, with example
    transformation converting F77 DO loops to F90

    Comments may optionally be ignored, or preserved in the output

Files:
    fortran.grm - an F77 / F90 grammar validated on hundreds of examples

    f77convertdo.txl - a TXL program using the grammar to convert F77
	end-label DO loops to F90 ENDDO form

    Testd on over 200 random example Fortran programs.

Authors:
    William Waite, University of Colorado
    Jim Cordy, Queen's University

Examples:
    (parse only:)
    txl Examples/F77/adapt.f
    txl Examples/F90/cortesa.f90

    (convert do loops:)
    txl Examples/F77/cortesa.f Txl/f77convertdo.txl
