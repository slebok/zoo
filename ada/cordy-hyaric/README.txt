http://www.txl.ca/nresources.html:
 ↳  http://www.txl.ca/examples/Grammars/Ada/README.txt
   ↳  https://github.com/bu2/ada-2005-txl-grammar/tree/master/txl

TXL Basis Grammar for Ada 2005
Version 1.5, July 2010

Grammar Copyright 2010 by Bruno Le Hyaric
Commenting overrides Copyright 2010 by James R. Cordy

Description:
    A complete Ada 2005 grammar based on the 
    Ada 2005 Language Reference Manual, ISO/IEC 8652:1995(E)

    Validated to handle all legal programs in the Ada 3.0 compiler 
    conformance test suite

    Comments may optionally be ignored (for analysis tasks)
    or preserved in the output using the commenting overrides and -comment

Files:
    ada.grm - Ada 2005 grammar based on the Ada 2005 LRM
    ada_commentoverrides.grm - Grammar overrides to parse and preserve comments
    ada.txl, adb.txl, ads.txl - TXL programs to parse .ada, .adb and .ads files

Authors:
    Bruno Le Hyaric, Thales Avionics
    Jim Cordy, Queen's University

Example:
    txl Examples/small.ada
    txl -comment Examples/small.ada

Notes:
    This is an ongoing project - you can find the latest version here:
    http://github.com/bu2/ada-2005-txl-grammar