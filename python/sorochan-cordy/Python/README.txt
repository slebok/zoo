TXL Basis Grammar for Python with INDENT/DEDENT formatting
Version 1.4, July 2010

Grammar Copyright 2008 Mykhaylo Sorochan and James R. Cordy, 
    after the standard Python 2.5 reference grammar, 
    Copyright 1990-2008 Python Software Foundation

INDENT/DEDENT Resolver Copyright 2008 James R. Cordy

Both licensed under the MIT open source license, see source for details.

Description:
    A complete Python 2.5 processing set for TXL, consisting of two parts: 

        - pyindent.txl, a standalone TXL program that explicates the 
          INDENT / DEDENT implicit symbols of Python, and 

        - python.grm, a Python 2.5 grammar that parses Python programs
	  with explicit INDENT / DEDENT smbols.

    The two can be used as a pipeline to process raw Python code using TXL:
	txl input.py pyindent.txl | txl stdin my_python_transform.txl > output.py

    When writing transformations using this grammar, patterns and replacements 
    involving INDENT / DEDENT must explicitly include them.  But because they
    are parsed as attributes, neither will appear in the final output. 
    (Although if you want them to be retained in the output for further processing, 
    the -attr command line flag will do that.)

    Validated against over 1,500 random Python programs, including the entire
    Python demo set.

Authors:
    Mykhaylo Sorochan
    Jim Cordy, Queen's University

Example:
    txl Calculator.py pyindent.txl | txl stdin py.txl 
